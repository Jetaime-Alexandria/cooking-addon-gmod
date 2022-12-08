AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("imgui.lua")

include("shared.lua")

util.AddNetworkString("removeDough")
util.AddNetworkString("startStove")

function ENT:Initialize() 

    self:SetModel("models/props_interiors/stove02.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()

    if(phys:IsValid()) then 

        phys:Wake()

    end

    self.isBaking = false
    self.dough = false

end

function ENT:StartTouch(ent)

    -- When dough touches the Stove
    if self.dough == false then
        if ent:GetClass() == "jet_stove_dough" then

            ent:Remove()
            sound.Play("tools/ifm/beep.wav", ent:GetPos())
            self.dough = true

            

        else
            sound.Play("tools/ifm/ifm_denyundo.wav", ent:GetPos())  
        end
      
    else 
        sound.Play("tools/ifm/ifm_denyundo.wav", ent:GetPos())  
    end

end


net.Receive("removeDough", function(len, ply)
   local netEnt = net.ReadEntity(ent)
   if netEnt.dough == false then
    sound.Play("tools/ifm/ifm_denyundo.wav", netEnt:GetPos())  
    ply:PrintMessage(HUD_PRINTCENTER, "There's nothing to eject.")
   else
    if netEnt.isBaking == true then
        sound.Play("tools/ifm/ifm_denyundo.wav", netEnt:GetPos())  
        ply:PrintMessage(HUD_PRINTCENTER, "Can't eject while stove is on.")       

    else
        netEnt.dough = false

        local ejectedDough = ents.Create("jet_stove_dough")
        ejectedDough:SetPos(netEnt:GetPos() + (netEnt:GetForward()*25))
        ejectedDough:Spawn()
    end
   end
end)

net.Receive("startStove", function(len, ply)
    local netEnt = net.ReadEntity(ent)

    if netEnt.dough == false then
     netEnt:EmitSound("tools/ifm/ifm_denyundo.wav", 75, 100, 1, CHAN_AUTO)
     ply:PrintMessage(HUD_PRINTCENTER, "You don't have anything in the stove.")
    else
        if netEnt.isBaking == true then
            netEnt:EmitSound("tools/ifm/ifm_denyundo.wav", 75, 100, 1, CHAN_AUTO)
            ply:PrintMessage(HUD_PRINTCENTER, "Stove is already running..")       
        else
            netEnt.isBaking = true
            netEnt:EmitSound("ambient/machines/refrigerator.wav", 75, 100, 1, CHAN_AUTO)
            timer.Simple( 10, function()
                netEnt.isBaking = false
                netEnt.dough = false
                ply:PrintMessage(HUD_PRINTCENTER, "Stove is finished.")  
                netEnt:StopSound("ambient/machines/refrigerator.wav")   
                
                local bakedBread = ents.Create("bread3")
                bakedBread:SetPos(netEnt:GetPos() + (netEnt:GetForward()*25))
                bakedBread:Spawn()
            end)  
        end
    end
 end)