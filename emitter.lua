ENT = {}
ENT.Printname = 'particle_emitter'
ENT.Type = 'anim'
ENT.Base = 'base_gmodentity'
ENT.Editable = false
ENT.AdminOnly = false
ENT.Spawnable = true


if SERVER then
	util.AddNetworkString('particle_start')
	function ENT:Initialize()
		self:SetModel('models/hunter/blocks/cube025x025x025.mdl')
		self:SetMaterial('models/debug/debugwhite')
		self:SetColor(Color(0,0,0))
		self:PhysicsInit(6)
		self.Entity:SetMoveType(6)
		self:SetSolid(6)
		self:PhysWake()
	end
	function ENT:Think()
		net.Start('particle_start')
		net.WriteEntity(self)
		net.Broadcast()
	end
end
if CLIENT then
	function ENT:Draw() self:DrawModel() end
end

scripted_ents.Register(ENT,'particle_emitter')

net.Receive('particle_start',function(len)
	local ent = net.ReadEntity()
		if IsValid(ent) then
		local effects = {
			'particle/particle_smokegrenade','particle/particle_smoke_dust',
			'particle/particle_smokegrenade1'
			}
		 for i=1,25,1 do
			local Emitter = ParticleEmitter(ent:GetPos())
			local Particle = Emitter:Add(table.Random(effects),ent:LocalToWorld(Vector(0,0,15)))
			if Particle then
				Particle:SetDieTime(8)
				Particle:SetStartAlpha(255)
				Particle:SetEndAlpha(1)
				Particle:SetColor(color_black)
				
				Particle:SetStartSize(10-i/2)
				Particle:SetEndSize(75)
				Particle:SetGravity(Vector(0,0,75))
				Particle:SetVelocity(VectorRand() * 6)
			end
			Emitter:Finish()
		end
	end
end)	
