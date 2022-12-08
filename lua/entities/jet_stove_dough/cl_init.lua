AddCSLuaFile("imgui.lua")

local imgui = include("imgui.lua")
include("shared.lua")

function ENT:Draw() 

    self:DrawModel()

    if imgui.Entity3D2D(self, Vector(0, -15, 12), Angle(0, 90, 90), 0.1) then
        surface.SetDrawColor(0, 0, 0, 181)
        surface.DrawRect(0, 0, 270, 75)

        draw.SimpleText("Insert me into a stove!", imgui.xFont("!Roboto@30"), 10, 10, Color(0, 255, 0))
        draw.SimpleText("Bread Dough", imgui.xFont("!Roboto@24"), 10, 40, Color(255, 255, 255))

        imgui.End3D2D()
    end
    
end