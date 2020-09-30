include( "shared.lua" ) 

function ENT:Draw()
	self:DrawModel()
		surface.SetFont( "DermaDefault" )
		local id = self:ReturnID()
	if LocalPlayer():IsSuperAdmin() or LocalPlayer():IsAdmin() then
		text = self:GetDealerName().." - "..tostring(id)
	else
		text =  self:GetDealerName()
	end
	local aci = self:GetAngles()
	aci:RotateAroundAxis( aci:Forward(), 90)
	aci:RotateAroundAxis( aci:Right(), -90)
	local up2 = self:OBBMaxs().z
	local up = up2+20
	local vector = Vector(self:GetPos().x,self:GetPos().y,self:GetPos().z+up) 
	cam.Start3D2D( vector, aci, 0.50 )
draw.SimpleTextOutlined(text,"TitleFont", 0, 0, OCarDealer.CONFIG.NPCTITLECOLOR, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, OCarDealer.CONFIG.NPCTITLEOUTLINECOLOR )
	cam.End3D2D()
		local aci = self:GetAngles()
	aci:RotateAroundAxis( aci:Forward(), 90)
	aci:RotateAroundAxis( aci:Right(), 90)
	cam.Start3D2D( vector, aci, 0.50 )
draw.SimpleTextOutlined(text,"TitleFont", 0, 0, OCarDealer.CONFIG.NPCTITLECOLOR, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, OCarDealer.CONFIG.NPCTITLEOUTLINECOLOR )
	cam.End3D2D()
end




