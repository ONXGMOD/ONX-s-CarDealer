ENT.Type = "ai"
ENT.Base = "base_ai"
ENT.AutomaticFrameAdvance = true
ENT.Author = "ØNX"
ENT.PrintName = "ØNX's Car Dealer"
ENT.Spawnable = false
ENT.AdminOnly = false

function ENT:GetDealerName()
return self:GetNW2String("dealername")
end

function ENT:ReturnID()
    return self:GetNW2Int("NPCID")
end
function ENT:SetAutomaticFrameAdvance( bUsingAnim ) -- This is called by the game to tell the entity if it should animate itself.
	self.AutomaticFrameAdvance = bUsingAnim
end