SETTINGSPANEL = {}

function SETTINGSPANEL:Init()
		self:SetPos(ScrH()/15+ScrH()/12)
		self:SetSize(ScrW(),ScrH()-(ScrH()/15+ScrH()/12) )
		self:SetVisible(true)


	OCarDealer.Settingsmainpanel = self
	local px,py,wp,hp = self:GetBounds() 

local name,languages= OCarDealer:Language() 
local renktema = OCarDealer:GetSetting("Theme Mode")

local renkpaketleri = {
	["Dark"] = {
		["Background"] = Color(32,32,32),
		["Panel"] = Color(78,78,78),
		["Yazi"] = Color(255,255,255)
	},
	["White"] = {
		["Panel"] = Color(210,210,210),
		["Background"] = Color(255,255,255),
		["Yazi"] = Color(0,0,0)
	}
}


setpanel = vgui.Create("DPanel",self)
setpanel:SetPos( 0, 0 )
setpanel:SetSize( wp, hp ) 
function setpanel:Paint(w,h)
surface.SetDrawColor( renkpaketleri[renktema]["Background"] )  
surface.DrawRect( 0, 0, w, h )
end

clientsettingspanel =  vgui.Create("OCCD:CSettingsPanel",setpanel)
clientsettingspanel:SetPos(0,0)
clientsettingspanel:SetVisible(true)


end
function SETTINGSPANEL:Paint(w, h)
	surface.SetDrawColor( 32, 32, 32, 150 )
	surface.DrawRect(0,0,w,h)

	end
function SETTINGSPANEL:Think()
		local px,py,wp,hp = self:GetBounds() 

			net.Receive("OCCDealer-SendVehicleData",function()
serversettingspanel = vgui.Create("OCCD:VehicleEditPanel",setpanel)
serversettingspanel:SetPos(0,0)
serversettingspanel:InvalidateLayout(true)
end)

			net.Receive("OCCDealer-SendDealerInformation",function()
dealerSettingsPanel = vgui.Create("OCCD:DealerSettingsPanel",setpanel)
dealerSettingsPanel:SetPos(0,0)
dealerSettingsPanel:InvalidateLayout(true)
				end)
		end
function SETTINGSPANEL:EditNPCPanel(id)
		if LocalPlayer():IsSuperAdmin() then
setpanel:Clear()

net.Start("OCCDealer-GetDealerInformation")
net.WriteInt(id,32)
net.SendToServer()

end
end
function SETTINGSPANEL:SHOWPANEL(panelname)
if panelname == "clientsettingspanel" then

	setpanel:Clear()

clientsettingspanel =  vgui.Create("OCCD:CSettingsPanel",setpanel)
clientsettingspanel:SetPos(0,0)
clientsettingspanel:SetVisible(true)
elseif panelname == "serversettingspanel" then
	if LocalPlayer():IsSuperAdmin() then
setpanel:Clear()

net.Start("OCCDealer-VehicleData")
net.SendToServer()

end


end

end


function SETTINGSPANEL:PerformLayout(w,h)
childrens = self:GetChildren()
for k,v in pairs(childrens) do
v:InvalidateLayout(true)
end
end	

function SETTINGSPANEL:OnRemove()
	OCarDealer.Settingsmainpanel = nil
local parentya = self:GetParent()
if parentya then
	parentya:Remove()
end
end	
vgui.Register("OCCD:AllInOneSet", SETTINGSPANEL,"EditablePanel")