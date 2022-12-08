AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize() 

    self:SetModel("models/props_junk/garbage_bag001a.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()

    if(phys:IsValid()) then 

        phys:Wake()

    end

end

function ENT:Use(a, c)

        sound.Play("ambient/voices/cough1.wav", c:GetPos())
        c:SetHealth(c:Health() - 25)
        self:Remove()

end

