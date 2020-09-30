AddCSLuaFile()

	SWEP.PrintName		= "OCD Admin Weapon"
	SWEP.Base           = "weapon_base"
	SWEP.Author			= "ONX"
	SWEP.Slot			= 0
	SWEP.SlotPos		= 10
	SWEP.Instructions   = [[First select npc with left click. Then select the pos of spawner.]]
	
SWEP.Category				= "ONX's Car Dealer"
SWEP.ViewModelFlip			= false
SWEP.ViewModelFOV			= 70
SWEP.SetHoldType  			= "pistol"
SWEP.Spawnable				= true
SWEP.AdminOnly				= true
SWEP.UseHands				= true
SWEP.DrawCrosshair 		= false

SWEP.ViewModel				= "models/weapons/c_pistol.mdl"
SWEP.WorldModel				= "models/weapons/w_pistol.mdl"

SWEP.Weight			  		= 1
SWEP.AutoSwitchTo			= true
SWEP.AutoSwitchFrom			= true

SWEP.Primary.Recoil			= 0
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo		    = "none"
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

if CLIENT then
	function SWEP:onxclientstart()
	hook.Add("HUDPaint","onxdeneme",function()
	surface.SetDrawColor(255,255,255)
	surface.DrawCircle(ScrW()/2,ScrH()/2,1,Color(255,255,255))
if LocalPlayer():GetEyeTrace().Entity then
	if (LocalPlayer():GetEyeTrace().Entity:GetClass() == "ocardealer_npc") and (LocalPlayer():GetEyeTrace().Entity:GetPos():Distance(LocalPlayer():GetPos()) < 1000) then
	surface.SetFont( "Default" )
	surface.SetTextColor( 255, 255, 255 )
	surface.SetTextPos( ScrW()/2-3, ScrH()/2+5 )
	surface.DrawText( "A car dealer. Press LEFT mouse button to configure this. ID = "..LocalPlayer():GetEyeTrace().Entity:ReturnID() )
	surface.SetTextPos( ScrW()/2-3, ScrH()/2+15 )
	surface.DrawText( "Right mouse button to delete this." )
end
end
end)
end

function SWEP:stopclienthud()
	hook.Remove("HUDPaint","onxdeneme")
end
end

function SWEP:PrimaryAttack()
	if !(timer.Exists("ezmanchillout") ) then 
	if self.Owner:IsSuperAdmin() then
			local ent = self.Owner:GetEyeTrace().Entity
	if ent:GetClass() == "ocardealer_npc" then
if SERVER then
	ent:OpenPanel(self.Owner)
end
	if CLIENT then
		timer.Simple(0.1, function()	OCarDealer.StoreMainPanel:VisiblePanel(4)
		OCarDealer.Settingsmainpanel:EditNPCPanel(LocalPlayer():GetEyeTrace().Entity:ReturnID()) end)

	timer.Create("ezmanchillout", 2, 0,function() timer.Remove("ezmanchillout") end)
end
end
end
end
end

--
function SWEP:SecondaryAttack()
		if !(timer.Exists("ezmanchillout") ) then 
	if self.Owner:IsSuperAdmin() then
if CLIENT then

	local ent = LocalPlayer():GetEyeTrace().Entity
	if ent:GetClass() == "ocardealer_npc" then
		local id = ent:ReturnID()
	net.Start("OCCDealer-DeleteNPC")
	net.WriteInt(id,8)
	net.SendToServer()
timer.Create("ezmanchillout", 2, 0,function() timer.Remove("ezmanchillout") end)
end
end
end
end
end

function SWEP:Think()
	if self.Owner:IsSuperAdmin() then
if CLIENT then 
self:onxclientstart()
end
end
end

function SWEP:Holster( wep )
	if CLIENT then
		self:stopclienthud()
end
return true
end