ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.AutomaticFrameAdvance = true
ENT.Author = "ØNX"
ENT.PrintName = "ØNX's Car Park"
ENT.Spawnable = false
ENT.AdminOnly = false

function ENT:SetAutomaticFrameAdvance( bUsingAnim )
	self.AutomaticFrameAdvance = bUsingAnim;
end

