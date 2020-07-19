local base = {
    Vector(2221.670898,1818.095581,-4.152794),
    Vector(6265.631836,1382.393799,748.197632),
    Vector(10255.364258,-298.912476,208.224823),
}
ENT = {}
ENT.Printname = 'boxofssex'
ENT.Type = 'anim'
ENT.Base = 'base_gmodentity'
ENT.Editable = false
ENT.AdminOnly = false
ENT.Spawnable = true

if SERVER then
    function ENT:Initialize()
        self:SetModel('models/props_junk/cardboard_box001a.mdl')
        self:SetMaterial('models/debug/debugwhite')
        self:SetColor(Color(0,0,0))
        self:PhysicsInit(6)
        self.Entity:SetMoveType(6)
        self:SetSolid(6)
        self:PhysWake()
        self:SetUseType( SIMPLE_USE )
    end
    function ENT:Use(ply) 
        ply:SetHealth(ply:Health()+math.random(25,50))
        ply:EmitSound('UI/achievement_earned.wav')
        PrintMessage(HUD_PRINTCENTER,'Игрок '..ply:Nick()..' нашел луткейс')
        self:Remove()
    end
end
if CLIENT then
	local c_box = ClientsideModel('models/props_junk/cardboard_box001a.mdl')
	c_box:SetModelScale(-1.02)
	c_box:SetNoDraw( true )
    function ENT:Draw()
    	self:DrawModel()
    	render.SetColorModulation(255,255,255)
    	c_box:SetPos(self:GetPos())
        c_box:SetAngles(self:GetAngles())
        c_box:DrawModel()
    end
end

scripted_ents.Register(ENT,'boxofsex')

if SERVER then
    local valid = nil
    timer.Create('boxofsex.timer1',6,0,function()
        if not IsValid(valid) then
            local box = ents.Create('boxofsex')
            box:SetPos(Vector(6265.631836,1382.393799,748.197632))
            box:Spawn()
            box:GetPhysicsObject():EnableGravity(false)
            box:GetPhysicsObject():SetVelocity(Vector(0,0,-10)*48)
            valid = box;
        	PrintMessage(HUD_PRINTCENTER,'На карте появился луткейс')
  
            timer.Simple(7.2,function()
                for _,tr in pairs(ents.FindByClass('boxofsex')) do tr:GetPhysicsObject():EnableGravity(true) end
            end)
        end
    end)
end
                                                                
