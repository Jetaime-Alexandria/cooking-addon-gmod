AddCSLuaFile("imgui.lua")

local imgui = include("imgui.lua")
include("shared.lua")

local anything_in_stove = false

function ENT:Draw() 

    self:DrawModel()

    -- if imgui.Entity3D2D(self, Vector(-10, -18, 60), Angle(0, 90, 90), 0.1) then
    --     surface.SetDrawColor(20, 19, 19, 230)
    --     surface.DrawRect(0, 0, 360, 100)

    --     draw.SimpleText("Stove is ready for use!", imgui.xFont("!Roboto@30"), 10, 5)
    --     imgui.End3D2D()
    -- end

    if imgui.Entity3D2D(self, Vector(13.3, -18, 36.5), Angle(0, 90, 90), 0.1) then
        surface.SetDrawColor(0, 0, 0, 255)
        surface.DrawRect(0, 0, 360, 40)

        if imgui.xTextButton("Start", "!Roboto@24", 5, 8, 100, 25, 1, Color(55,255,0), Color(124,245,117), Color(247,247,247)) then
            self:EmitSound("zerolib/inv_add.wav", 75, 100, 1, CHAN_AUTO)

            net.Start("startStove")
            net.WriteEntity(self)
            net.SendToServer()
        end

        if imgui.xTextButton("Eject", "!Roboto@24", 290, 8, 65, 25, 1, Color(252,174,18), Color(245,202,117), Color(247,247,247)) then
            self:EmitSound("zerolib/inv_add.wav", 75, 100, 1, CHAN_AUTO)

            net.Start("removeDough")
            net.WriteEntity(self)
            net.SendToServer()
        end

        imgui.End3D2D()
    end
    
end

-- net.Receive("doughAdded", function() 
--    status:Remove()
-- end)
