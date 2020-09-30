include( "shared.lua" ) 

function ENT:Draw()
	local parkbelongs = self:GetNW2Entity("Parkbelongs")
	if LocalPlayer():CanSee(parkbelongs) then
	self:DrawModel()
	self:DrawShadow( true )
		local vector = self:GetPos()
		local aci = self:GetAngles()
	local maxp = self:OBBMaxs()
	local minp = self:OBBMins()

render.DrawWireframeBox( vector, aci, Vector(minp.x,maxp.y-50,minp.z),Vector(maxp.x,maxp.y,maxp.z*65), Color( 0, 0, 0 ),false )	
render.SetMaterial( Material( "color" ) )
render.DrawBox( vector, aci, Vector(minp.x,maxp.y-49,minp.z), Vector(maxp.x,maxp.y,maxp.z*65-1), Color( 0,255, 0,150 ) )
render.DrawBox( vector, aci, Vector(minp.x,minp.y,minp.z), Vector(maxp.x,maxp.y-49,maxp.z*65-1), Color( 0,0, 255,150 ) )

end
	self:DrawShadow( false )
	if (parkbelongs.GetDealerName) and (OCarDealer.CONFIG.SHOWPARKTITLE == true) then
		local textx,texty =	surface.GetTextSize(parkbelongs:GetDealerName().."'s PARKING SPOT")
		local text = parkbelongs:GetDealerName().."'s PARKING SPOT"
	local aci = self:GetAngles()
	aci:RotateAroundAxis( aci:Forward(), 90)
	aci:RotateAroundAxis( aci:Right(), 0)
	local up2 = self:OBBMaxs().z
	local up = up2+50
	local vector = Vector(self:GetPos().x,self:GetPos().y,self:GetPos().z+up) 

	cam.Start3D2D( vector, aci, 1 )
draw.SimpleTextOutlined(text,"buttonfont", 0, 0, OCarDealer.CONFIG.NPCTITLECOLOR, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, OCarDealer.CONFIG.NPCTITLEOUTLINECOLOR )
	cam.End3D2D()
			local aci = self:GetAngles()
	aci:RotateAroundAxis( aci:Forward(), 90)
	aci:RotateAroundAxis( aci:Right(), 180)
	cam.Start3D2D( vector, aci, 1 )
draw.SimpleTextOutlined(text,"buttonfont", 0, 0, OCarDealer.CONFIG.NPCTITLECOLOR, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, OCarDealer.CONFIG.NPCTITLEOUTLINECOLOR )
	cam.End3D2D()
end
end

