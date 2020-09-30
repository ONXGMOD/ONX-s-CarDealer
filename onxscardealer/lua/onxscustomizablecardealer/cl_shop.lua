AddCSLuaFile()


VEHICLESPANEL = {}
function VEHICLESPANEL:Init()
		self:SetSize(ScrW(),ScrH())
		self:Center()
		self:SetVisible(true)
		self:MakePopup()
		self:SetKeyboardInputEnabled(true)
		self:RequestFocus()




local px,py,wp,hp = self:GetBounds()
playerinventory = net.ReadTable()
servervehicles = net.ReadTable()
activevehicle = net.ReadString()

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

local webpanel = vgui.Create("DPanel",self)
webpanel:SetPos(0,0)
webpanel:SetSize(wp,hp/15)
function webpanel:Paint(w,h)
surface.SetDrawColor( renkpaketleri[renktema]["Background"] )  
surface.DrawRect( 0, 0, w, h )
end



local buttonpanel = vgui.Create("DPanel",self)
buttonpanel:SetPos( 0, hp/15 )
buttonpanel:SetSize( wp, hp/12 ) 
function buttonpanel:Paint(w,h)
surface.SetDrawColor( ColorAlpha( OCarDealer:GetSetting("Theme"), 255 ) )  
surface.DrawRect( 0, 0, w, h )

end
local bx,by,bw,bh = buttonpanel:GetBounds()

local carsidepanel = vgui.Create("DScrollPanel",self)
carsidepanel:SetPos( 0, bh+by ) 
carsidepanel:SetSize(wp , hp-bh-by )
carsidepanel:SetVerticalScrollbarEnabled( false )
carsidepanel:GetVBar():SetHideButtons(true)
function carsidepanel:Paint(w,h)
surface.SetDrawColor( renkpaketleri[renktema]["Background"] )
surface.DrawRect( 0, 0, w, h )
end
local bar = carsidepanel:GetVBar()
function bar:Paint( w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 32, 32, 32, 100 ) )
end
function bar.btnUp:Paint( w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 200, 100, 0,0 ) )
end
function bar.btnDown:Paint( w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 200, 100, 0,0 ) )
end
function bar.btnGrip:Paint( w, h )
	draw.RoundedBox( 5, 0, 0, w, h, ColorAlpha( renkpaketleri[renktema]["Background"], 255 ) )
end



local csw,csh = carsidepanel:GetSize()

local carshowpanel = vgui.Create("DPanel",self)
carshowpanel:SetPos( 0, bh+by ) 
carshowpanel:SetSize(wp , hp-bh-by)
carshowpanel:SetVisible(false)
function carshowpanel:Paint(w,h)
surface.SetDrawColor( renkpaketleri[renktema]["Background"] )
surface.DrawRect( 0, 0, w, h )
end
local cpxx,cpyy,cpw,cph = carshowpanel:GetBounds()

local inventorypanel = vgui.Create("DPanel",self)
inventorypanel:SetPos( 0, bh+by ) 
inventorypanel:SetSize(wp , hp-bh-by )
inventorypanel:SetVisible(false)
function inventorypanel:Paint(w,h)
surface.SetDrawColor( renkpaketleri[renktema]["Background"] )
surface.DrawRect( 0, 0, w, h )
end
settingspanel = vgui.Create("OCCD:AllInOneSet",self)
settingspanel:SetPos(0,bh+by)
settingspanel:SetSize(wp,hp-bh)
settingspanel:SetVisible(false)
settingspanel:InvalidateChildren(true)

function visiblepanel(panel)
		local panellist = {inventorypanel,carshowpanel,carsidepanel,settingspanel}
	if isnumber(panel) then
		panel = panellist[panel]
	end

	for k,v in pairs(panellist) do
		v:SetVisible(false)
		carshowpanel:Clear()
			panel:SetVisible(true)
			panel:RequestFocus()

	end
	if self.setpanel then
		self.setpanel:Remove()
	end
		if settingspanelxdd != nil then
		settingspanelxdd:Remove()
		settingspanelxdd = nil
	end
end

local ux,uy,uw,uh = webpanel:GetBounds()

local urlpanel =vgui.Create("DPanel",webpanel)
urlpanel:SetSize(uw/2,uh/2)
urlpanel:Center()
function urlpanel:Paint(w,h)
draw.RoundedBoxEx(10,0,0,w,h,renkpaketleri[renktema]["Panel"],true,true,true,true)
end

URL = vgui.Create("DLabel",urlpanel,"URLLink")
URL:Dock(LEFT)
URL:DockMargin(20,10,30,10)
URL:SetFont("OCarDealerFont-ID6")
URL:SetText("https://onxscustomizablecardealer.com/shop")
URL:SetTextColor(renkpaketleri[renktema]["Yazi"] )
URL:SizeToContents()




local nameLabel = vgui.Create("DLabel",buttonpanel)
nameLabel:Dock(LEFT)
nameLabel:DockMargin(20,10,50,10)
nameLabel:SetFont("TitleFont")
nameLabel:SetText(OCarDealer.CONFIG.ClientTitle)
nameLabel:SetTextColor(Color(255,255,255))
nameLabel:SetMouseInputEnabled( true )
nameLabel:SizeToContents()
nameLabel.DragMouseRelease = function()
visiblepanel(carsidepanel)
self:SetLink("shop")
	if settingspanelxdd != nil then
		settingspanelxdd:Remove()
		settingspanelxdd = nil
	end
end


local shopbutton = vgui.Create("DButton",buttonpanel)
shopbutton:Dock(LEFT)
shopbutton:DockMargin(10,10,30,10)
shopbutton:SetSize(70,hp/8)
shopbutton:SetText("")
shopbutton:SetTextColor(Color(255,255,255))
function shopbutton:Paint(w,h)
		draw.RoundedBoxEx(5,0,0,w,h,ColorAlpha( OCarDealer:GetSetting("Theme"), 100 ),true,true,true,true)
	surface.SetFont( "buttonfont" )
	surface.SetTextColor( 255, 255, 255 )
	surface.SetTextPos( 0, h/3 )
	surface.DrawText( languages.shop )



end
shopbutton.DoClick = function()
	if settingspanelxdd != nil then
		settingspanelxdd:Remove()
		settingspanelxdd = nil
	end
visiblepanel(carsidepanel)
self:SetLink("shop")
end



local inventorybutton = vgui.Create("DButton",buttonpanel)
inventorybutton:Dock(LEFT)
inventorybutton:DockMargin(10,10,30,10)
inventorybutton:SetSize(70,30)
inventorybutton:SetText("")
inventorybutton:SetTextColor(Color(255,255,255))
function inventorybutton:Paint(w,h)
	draw.RoundedBoxEx(5,0,0,w,h,ColorAlpha( OCarDealer:GetSetting("Theme"), 100 ),true,true,true,true)
	surface.SetFont( "buttonfont" )
	surface.SetTextColor( 255, 255, 255 )
	surface.SetTextPos( 0, h/3 )
	surface.DrawText( languages.garage )
	surface.SetFont( "descfont" )

end
inventorybutton.DoClick = function()
self:SetLink("garage")
visiblepanel(inventorypanel)
	if settingspanelxdd != nil then
		settingspanelxdd:Remove()
		settingspanelxdd = nil
	end
end


local settingsbutton = vgui.Create("DButton",buttonpanel)
settingsbutton:Dock(LEFT)
settingsbutton:DockMargin(10,10,30,10)
settingsbutton:SetSize(80,30)
settingsbutton:SetText("")
settingsbutton:SetTextColor(Color(255,255,255))
function settingsbutton:Paint(w,h)
	draw.RoundedBoxEx(5,0,0,w,h,ColorAlpha( OCarDealer:GetSetting("Theme"), 100 ),true,true,true,true)
	surface.SetFont( "buttonfont" )
	surface.SetTextColor( 255, 255, 255 )
	surface.SetTextPos( 0, h/3 )
	surface.DrawText( languages.settings )
	surface.SetFont( "descfont" )

end
settingsbutton.DoClick = function()
self:SetLink("settings")

local spx,spy,spw,sph = settingsbutton:GetBounds()

if settingspanelxdd == nil then
settingspanelxdd = vgui.Create("DPanel", self)
settingspanelxdd:SetPos(spx,spy+by+sph)
settingspanelxdd:SetSize(100,55)
function settingspanelxdd:Paint(w,h)
draw.RoundedBoxEx(0,0,0,w,h,ColorAlpha( OCarDealer:GetSetting("Theme"), 200),true,true,true,true)
end	

local clientsettingsbutton = vgui.Create("DButton",settingspanelxdd)
clientsettingsbutton:Dock(TOP)
clientsettingsbutton:DockMargin(2, 1, 2, 2)
clientsettingsbutton:SetSize(50,25)
clientsettingsbutton:SetText(languages.clientset)
clientsettingsbutton:SetTextColor(Color(255,255,255))
clientsettingsbutton.DoClick = function()
	settingspanelxdd:Remove()
settingspanelxdd = nil
visiblepanel(settingspanel)
settingspanel:SHOWPANEL("clientsettingspanel")
self:SetLink("clientsettings")

end
function clientsettingsbutton:Paint(w,h)
draw.RoundedBoxEx(0,0,0,w,h,ColorAlpha( renkpaketleri[renktema]["Background"], 150),true,true,true,true)
end	

local serversettingsbutton = vgui.Create("DButton",settingspanelxdd)
serversettingsbutton:Dock(TOP)
serversettingsbutton:DockMargin(2, 0, 2, 2)
serversettingsbutton:SetSize(50,25)
serversettingsbutton:SetText(languages.serverset)
serversettingsbutton:SetTextColor(Color(255,255,255))
serversettingsbutton.DoClick = function()
	settingspanelxdd:Remove()
settingspanelxdd = nil
visiblepanel(settingspanel)
settingspanel:SHOWPANEL("serversettingspanel")
self:SetLink("serversettings")

end
function serversettingsbutton:Paint(w,h)
draw.RoundedBoxEx(0,0,0,w,h,ColorAlpha( renkpaketleri[renktema]["Background"], 150),true,true,true,true)
end	

end
end



for count,buttons in pairs(OCarDealer.CONFIG.SpecialButtons) do
	local addbutton = vgui.Create("DButton",buttonpanel)
addbutton:Dock(LEFT)
addbutton:DockMargin(10,10,30,10)
addbutton:SetSize(100,hp/8)
addbutton:SetText("")
addbutton:SetTextColor(Color(255,255,255))
addbutton.image = ONX:DownloadImage(buttons.Imagelink)
function addbutton:Paint(w,h)
	draw.RoundedBoxEx(5,0,0,w,h,ColorAlpha( OCarDealer:GetSetting("Theme"), 100 ),true,true,true,true)
	surface.SetFont( "buttonfont" )
	surface.SetTextColor( 255, 255, 255 )
	surface.SetTextPos( 0, h/3 )
	surface.DrawText( buttons.Name )


end
addbutton.DoClick = function()
	self:SetLink(buttons.Name)
buttons.Func()
	if settingspanelxdd != nil then
		settingspanelxdd:Remove()
		settingspanelxdd = nil
	end
end
end




local closebutton = vgui.Create("DButton",webpanel)
closebutton:SetPos(wp-50,10)
closebutton:SetSize(20,20)
closebutton:DockMargin(3,0,bw/3*2.35,0)
closebutton:SetText("")
closebutton:SetTextColor(Color(255,255,255))
function closebutton:Paint( w,h )
	surface.SetDrawColor( 255, 0,0, 255)
	draw.NoTexture()
	ONX:Circle( w / 2, h / 2, w/2, math.sin( CurTime() ) * 20 + 25 )
end
closebutton.DoClick = function()
	self:Remove()
end

local infobutton = vgui.Create("DButton",webpanel)
infobutton:SetPos(wp-80,10)
infobutton:SetSize(20,20)
infobutton:SetText("")
infobutton:SetTextColor(Color(255,255,255))
function infobutton:Paint( w,h ) 
			surface.SetDrawColor( renkpaketleri[renktema]["Yazi"] )
	surface.SetMaterial( Material("onxcdmaterial/information.png")	)
	surface.DrawTexturedRect( 0, 0, w, h )
end
infobutton.DoClick = function()
gui.OpenURL("https://steamcommunity.com/profiles/76561198244677428/")
end



local function createbackground(entityname,carid,ccarmodel,carname,price,ismodify,color,bodygrouppanel,skinowned,ddesc,usg,jobs)

	if not (carid == nil ) then

shopbutton.pressedo = false
visiblepanel(carshowpanel)
local cpw,cph = carshowpanel:GetSize()
local dpaneloftuning = vgui.Create("DPanel",carshowpanel)
dpaneloftuning:SetPos( cpw-200, 20 )
dpaneloftuning:SetSize( 195, cph-20 ) 
dpaneloftuning:RequestFocus()
function dpaneloftuning:Paint(w,h)
surface.SetDrawColor( renkpaketleri[renktema]["Background"] )
surface.DrawOutlinedRect( 0, 0, w, h )
end


local carnamepanel = vgui.Create("DPanel",carshowpanel)
carnamepanel:SetPos( cpw/4, 20 )
carnamepanel:SetSize( cpw/3, 40 )
carnamepanel:CenterHorizontal() 
function carnamepanel:Paint(w,h)
draw.RoundedBoxEx(10,0,0,w,h,ColorAlpha(OCarDealer:GetSetting("Theme"),255),true,true,true,true)
end

local carinfo = vgui.Create("DPanel",carshowpanel)
carinfo:SetPos( 10, cph/2 )
carinfo:SetSize( cpw/8, cph/4 ) 
function carinfo:Paint(w,h)
draw.RoundedBoxEx(10,0,0,w,h,ColorAlpha(OCarDealer:GetSetting("Theme"),255),true,true,true,true)
end

local cnmpw,cnmpy = carnamepanel:GetSize()
local ciw,cih = carinfo:GetSize()

local yazilacakname = string.Replace(carname, " ", "_")
self:SetLink("view="..yazilacakname)

local carnamelabel = vgui.Create("DLabel",carnamepanel)
carnamelabel:SetFont("OCarDealerFont-ID5")
carnamelabel:SetText(carname)
carnamelabel:SetColor(Color(255,255,255,255))
carnamelabel:SizeToContents()
carnamelabel:Center()


local cardes = vgui.Create("DLabel",carinfo)
cardes:SetPos(5,0)
cardes:SetSize(ciw-5,cih/4)
cardes:SetFont("OCarDealerFont-ID5")
cardes:SetColor(Color(255,255,255,255))
if ddesc then
cardes:SetText(languages.description..": "..ddesc)
else
	cardes:SetText(languages.nodescription)
end
cardes:SetWrap(true)



local carprice = vgui.Create("DLabel",carinfo)
carprice:SetPos(5,cih/4)
carprice:SetSize(ciw-5,cih/4)
carprice:SetFont("OCarDealerFont-ID5")
carprice:SetText(languages.price..": "..OCarDealer:CurrencyMoney(price))
carprice:SetWrap(true)
carprice:SetColor(Color(255,255,255,255))



if !(ONX:IsTableNil(usg)) then
local usergrouplabel = vgui.Create("DLabel",carinfo)
usergrouplabel:SetPos(5,cih/4*2)
usergrouplabel:SetSize(ciw,cih/4)
usergrouplabel:SetFont("OCarDealerFont-ID5")
usergrouplabel:SetText(languages.onlythisug..table.concat(usg,", "))
usergrouplabel:SetColor(Color(255,255,255,255))
usergrouplabel:SetWrap(true)

end
if !(ONX:IsTableNil(jobs)) then
local jobnames = {}
for k1,v1 in pairs(jobs) do
 table.insert(jobnames,team.GetName(v1))
end
if !(ONX:IsTableNil(jobnames)) then
local usergrouplabel = vgui.Create("DLabel",carinfo)
usergrouplabel:SetPos(5,cih/4*3)
usergrouplabel:SetSize(ciw-5,cih/4)
usergrouplabel:SetFont("OCarDealerFont-ID5")
usergrouplabel:SetText(languages.onlythisjbs..table.concat(jobnames,", "))
usergrouplabel:SetColor(Color(255,255,255,255))
usergrouplabel:SetWrap(true)

end
end


local cpw,cph = carshowpanel:GetSize()
local partspanel = vgui.Create("DPanel",dpaneloftuning)
partspanel:SetPos( 0, 40 )
partspanel:SetSize( 185, cph-60 ) 
function partspanel:Paint(w,h)
surface.SetDrawColor( ColorAlpha(OCarDealer:GetSetting("Theme"),200) )
surface.DrawLine(5,0,w,0)
end




local modelshowerb = vgui.Create( "DModelPanel", carshowpanel )
modelshowerb:SetPos(0,0)
modelshowerb:SetSize(cpw, cph)
modelshowerb:SetFOV(100)
modelshowerb:SetModel(ccarmodel)
modelshowerb:SetCamPos(Vector(30,210,80))
if color then
modelshowerb:SetColor(Color(color.r,color.g,color.b,255))
end
if bodygrouppanel then 
for c,d in pairs(bodygrouppanel) do
	modelshowerb.Entity:SetBodygroup(d.Idbodygroup,d.hasbody)
end
end
if skinowned then
modelshowerb.Entity:SetSkin(skinowned)
end
function modelshowerb:DragMousePress()
            self.PressX, self.PressY = gui.MousePos()
            self.Pressed = true 
            dpaneloftuning:SetVisible(false)
            carnamepanel:SetVisible(false)
        end 
function modelshowerb:DragMouseRelease() 
            	self.Pressed = false
            	dpaneloftuning:SetVisible(true)
            	carnamepanel:SetVisible(true)
            	 end
            	  function modelshowerb:OnMouseWheeled(scrollDelta)
 	if not (modelshowerb:GetFOV()-scrollDelta > 150 ) then
 modelshowerb:SetFOV(modelshowerb:GetFOV()-scrollDelta)
end
end
	 
         local ydeger = 0

function modelshowerb:Think()
	local ent = self:GetEntity()
	if (!self.Pressed == true) then
		ydeger= ydeger+0.05
		ent:SetAngles(Angle(0,ydeger,0))
	end
end
function modelshowerb:LayoutEntity( Entity )
            	if ( self.bAnimated ) then 
            		self:RunAnimation() 
            	end
            		if ( self.Pressed ) then 
            			local mx, my = gui.MousePos()
                self.Angles = Entity:GetAngles() - Angle( 0, ( self.PressX or mx ) - mx, (self.PressY or my ) - my)
                
                self.PressX, self.PressY = gui.MousePos()
                Entity:SetAngles( self.Angles )

                ydeger = self.Angles.y


            end
end




local bodypartsscroll = vgui.Create("DScrollPanel",partspanel)
bodypartsscroll:SetPos( 0, 0 ) 
bodypartsscroll:SetSize( 188, 200 )
bodypartsscroll:SetVerticalScrollbarEnabled( false )
function bodypartsscroll:Paint(w,h)
draw.RoundedBoxEx(10,0,0,w,h,ColorAlpha(OCarDealer:GetSetting("Theme"),200),true,true,true,true)
end

local resprayscroll =  vgui.Create("DScrollPanel",partspanel)
resprayscroll:SetPos( 0, 0 ) 
resprayscroll:SetSize( 188, hp/6 )
resprayscroll:SetVisible(false)
resprayscroll:SetVerticalScrollbarEnabled( false )
function resprayscroll:Paint(w,h)
draw.RoundedBoxEx(10,0,0,w,h,ColorAlpha(OCarDealer:GetSetting("Theme"),200),true,true,true,true)
end



local rsx,rsy = dpaneloftuning:GetPos()
local respraypanel = vgui.Create("DPanel",carshowpanel)
respraypanel:SetPos( rsx-355, rsy )
respraypanel:SetSize( 350, 300  ) 
respraypanel:SetVisible(false)
function respraypanel:Paint(w,h)
surface.SetDrawColor( ColorAlpha(OCarDealer:GetSetting("Theme"),100) )
surface.DrawRect( 0, 0, w, h )
end
local respray = vgui.Create( "DColorMixer", respraypanel )
respray:Dock( FILL )
respray:DockMargin(10,10,10,10)			
respray:SetPalette( true ) 		
respray:SetAlphaBar( true ) 		
respray:SetWangs( true )			
respray:SetColor( modelshowerb:GetEntity():GetColor() )
function respray:ValueChanged(color)
	newcolor = ColorAlpha( color, 255 )
	modelshowerb:SetColor(newcolor)
end

local skins = vgui.Create( "DComboBox", respraypanel )
skins:SetSize( 350, 30  ) 
for i=0,modelshowerb:GetEntity():SkinCount() do
skins:AddChoice(i)
end				
skins.OnSelect = function( self, index, value )
	modelshowerb:GetEntity():SetSkin(tonumber(value))
end
function skins:Paint( w,h )
draw.RoundedBoxEx(5,0,0,w,h,ColorAlpha(OCarDealer:GetSetting("Theme"),255),true,true,true,true)
end

local paintbutton = resprayscroll:Add("DButton")
paintbutton:SetSize(175,45)
paintbutton:Dock(TOP)
paintbutton:DockMargin(5,5,5,5) 
paintbutton:SetText(languages.paint)
paintbutton:SetTextColor(Color(255,255,255))
function paintbutton:Paint( w,h )
draw.RoundedBoxEx(5,0,0,w,h,ColorAlpha(OCarDealer:GetSetting("Theme"),255),true,true,true,true)
end
paintbutton.DoClick = function()
	local olacak = !respraypanel:IsVisible()
respraypanel:SetVisible(olacak)
skins:SetVisible(false)
respray:SetVisible(olacak)
end

local skinbutton = resprayscroll:Add("DButton")
skinbutton:SetSize(175,45)
skinbutton:Dock(TOP)
skinbutton:DockMargin(5,5,5,5) 
skinbutton:SetText(languages.skin)
skinbutton:SetTextColor(Color(255,255,255))
function skinbutton:Paint( w,h )
draw.RoundedBoxEx(5,0,0,w,h,ColorAlpha(OCarDealer:GetSetting("Theme"),255),true,true,true,true)
end
skinbutton.DoClick = function()
	local olacak = !respraypanel:IsVisible()
respraypanel:SetVisible(olacak)
respray:SetVisible(false)
skins:SetVisible(olacak)
end

local bodypartsbutton = vgui.Create("DButton",dpaneloftuning)
bodypartsbutton:SetPos(5,0)
bodypartsbutton:SetSize(85,40)
bodypartsbutton:SetText(languages.tuning)
bodypartsbutton:SetTextColor(Color(255,255,255))
bodypartsbutton.pressedo = true
function bodypartsbutton:Paint( w,h )
	if not bodypartsbutton.pressedo == true then 
	draw.RoundedBoxEx(5,0,0,w,h,ColorAlpha(OCarDealer:GetSetting("Theme"),255),true,true,false,false)
else
	draw.RoundedBoxEx(5,0,0,w,h,ColorAlpha(OCarDealer:GetSetting("Theme"),50),true,true,false,false)
end
end
bodypartsbutton.DoClick = function()
if not bodypartsbutton.pressedo == true then 
	bodypartsbutton.pressedo = true
	bodypartsscroll:SetVisible(true)
	resprayscroll:SetVisible(false)
	respraypanel:SetVisible(false)
else
	bodypartsbutton.pressedo = false
	bodypartsscroll:SetVisible(false)
	resprayscroll:SetVisible(true)
end
end




local respraybutton = vgui.Create("DButton",dpaneloftuning)
respraybutton:SetPos(90,0)
respraybutton:SetSize(85,40)
respraybutton:SetText(languages.respray)
respraybutton:SetTextColor(Color(255,255,255))
function respraybutton:Paint( w,h )
	if not bodypartsbutton.pressedo == false then 
	draw.RoundedBoxEx(5,0,0,w,h,ColorAlpha(OCarDealer:GetSetting("Theme"),255),true,true,false,false)
else
	draw.RoundedBoxEx(5,0,0,w,h,ColorAlpha(OCarDealer:GetSetting("Theme"),50),true,true,false,false)
end
end
respraybutton.DoClick = function()
if not bodypartsbutton.pressedo == false then 
	resprayscroll:SetVisible(true)
	bodypartsbutton.pressedo = false
	bodypartsscroll:SetVisible(false)
else
	resprayscroll:SetVisible(false)
	bodypartsbutton.pressedo = true
	bodypartsscroll:SetVisible(true)
	respraypanel:SetVisible(false)
end
end


if ismodify == true then
	local smthx,smthy = dpaneloftuning:GetSize()
	local modifyaccept = vgui.Create("DButton",dpaneloftuning)
modifyaccept:SetPos(5,smthy-50)
modifyaccept:SetSize(160,40)
modifyaccept:SetText(languages.accept)
modifyaccept:SetTextColor(Color(255,255,255))
function modifyaccept:Paint( w,h )
draw.RoundedBoxEx(5,0,0,w,h,OCarDealer:GetSetting("Theme"),true,true,true,true) 
end
modifyaccept.DoClick = function()
local thentity = modelshowerb:GetEntity()
tablemd = {}
tablemd.Entityname = entityname
tablemd.ID = carid
tablemd.Color = modelshowerb:GetColor()
tablemd.Skin = modelshowerb:GetEntity():GetSkin()
tablemd.Vehiclename = carname
tablemd.Bodygroup = {}
local getbodygroup = modelshowerb.Entity:GetBodyGroups()
for a,b in pairs(getbodygroup) do
local littletable = {}
littletable.Idbodygroup = b.id
littletable.hasbody = modelshowerb.Entity:GetBodygroup( b.id )
table.insert(tablemd.Bodygroup,littletable)
end
net.Start("OCCDealer-ModifyVeh")
net.WriteTable(tablemd)
net.SendToServer()
self:Remove()
end
else
		local smthx,smthy = dpaneloftuning:GetSize()
	local buyaccept = vgui.Create("DButton",dpaneloftuning)
buyaccept:SetPos(5,smthy-50)
buyaccept:SetSize(160,40)
buyaccept:SetFont("descfont")
buyaccept:SetText(languages.buy)
buyaccept:SetTextColor(Color(255,255,255))
function buyaccept:Paint( w,h )
	draw.RoundedBoxEx(5,0,0,w,h,OCarDealer:GetSetting("Theme"),true,true,true,true) 
end
buyaccept.DoClick = function()
local thentity = modelshowerb:GetEntity()
tablebuy = {}
tablebuy.Entityname = entityname
tablebuy.ID = carid
tablebuy.Color = modelshowerb:GetColor()
tablebuy.Skin = modelshowerb:GetEntity():GetSkin()
tablebuy.Vehiclename = carname
tablebuy.Bodygroup = {}
local getbodygroup = modelshowerb.Entity:GetBodyGroups()
for a,b in pairs(getbodygroup) do
local littletable = {}
littletable.Idbodygroup = b.id
littletable.hasbody = modelshowerb.Entity:GetBodygroup( b.id )
table.insert(tablebuy.Bodygroup,littletable)
end
net.Start("OCCDealer-BuyCar")
net.WriteTable(tablebuy)
net.SendToServer()
self:Remove()
end
end




local cargroupentity = modelshowerb:GetEntity()
local cbodygroups = cargroupentity:GetBodyGroups()

for k,v in pairs(cbodygroups) do
	if v.num >= 2 then 
		local newidb = v.id
		local bppanel =  bodypartsscroll:Add("DPanel")
	bppanel:SetSize(175,45)
	bppanel:Dock(TOP)
	bppanel:DockMargin(0,0,0,5)
	function bppanel:Paint(w,h)
surface.SetDrawColor( Color( 32, 32, 32, 0 ) )
surface.DrawOutlinedRect( 0, 0, w, h )
	end



local bodyname = vgui.Create("DLabel",bppanel)
bodyname:SetPos( 0, 10)
bodyname:SetText(v.name.." : ")
bodyname:SetColor(Color(255,255,255,255))
bodyname:SizeToContents()

local onxparts = vgui.Create( "DComboBox", bppanel )
onxparts:SetPos( 70, 5 )
onxparts:SetSize( 100, 25 )
onxparts:SetValue( v.name )
for a,b in pairs(v.submodels) do 
  local newstring = string.Explode(".smd",b)
  if newstring[1] == "" then
  	onxparts:AddChoice("None")
  else
  onxparts:AddChoice(newstring[1])
end
end

if bodygrouppanel then
	for a1,b1 in pairs(bodygrouppanel) do
		for a2,b2 in pairs(v.submodels) do
			if b1.hasbody == a2 then
				yazi = b2
			end
		end
	local newstring = string.Explode(".smd",yazi)
  	if newstring[1] == "" then
  	onxparts:SetValue("None")
  	else
  	onxparts:SetValue(newstring[1])
	end
end
end




function onxparts:Paint(w,h)
draw.RoundedBox(10, 0, 0, w, h, Color(255,255,255,255))
end
onxparts.OnSelect = function( self, index, value )
for n,m in pairs(v.submodels) do
if value..".smd" == m then
submodelo = n
elseif value == "None" then
submodelo = 0 
end
end
	modelshowerb.Entity:SetBodygroup(newidb,submodelo)
	modelshowerb:InvalidateLayout(true)
end
end
end
end
end--- End of the function.















----------- VEHICLE LIST


local function addcarshop(v)

for o,p in pairs(playerinventory) do
if (v.Entityname == p.Entityname) and (v.ID == p.ID) then 
	v.ownedcar = true
	v.ownedcolor = p.Color
	v.ownedbodygroup = p.Bodygroup
	v.skin = p.Skin
end
end


if !( list.Get( "Vehicles" )[ v.Entityname ] or list.Get("simfphys_vehicles")[v.Entityname])  then return end
if  list.Get("Vehicles")[v.Entityname]  then
t = list.Get( "Vehicles" )[ v.Entityname ]
model = t.Model
elseif list.Get("simfphys_vehicles")[v.Entityname] then
t = list.Get( "simfphys_vehicles" )[ v.Entityname ]
model = t.Model
end

	local csw,csh = carsidepanel:GetSize()
	local carpanel =  ONX:CreateDividedPanels(carsidepanel,3,3,40,20)
	carpanel.vehicleid = k
	carpanel:SetCursor("hand")
	function carpanel:Paint(w,h)
	draw.RoundedBoxEx(10,0,0,w,h,ColorAlpha( renkpaketleri[renktema]["Panel"], 200),true,true,true,true)
	end

local pw,ph = carpanel:GetSize()



local modelshower = vgui.Create( "DModelPanel", carpanel )
modelshower:SetPos(0,0)
modelshower:SetSize(pw, ph/4*3)
modelshower:SetFOV(100)
modelshower:SetModel( model )
modelshower:SetCamPos(Vector(30,210,80))
if v.ownedcolor then
modelshower:SetColor(Color(v.ownedcolor.r,v.ownedcolor.g,v.ownedcolor.b,255))
end
if v.ownedbodygroup then
	for c,d in pairs(v.ownedbodygroup) do
	modelshower.Entity:SetBodygroup(d.Idbodygroup,d.hasbody)
end
end
if v.skin then
modelshower.Entity:SetSkin(v.skin)
	end
function modelshower:DragMousePress()
            self.PressX, self.PressY = gui.MousePos()
            self.Pressed = true 
        end 
function modelshower:DragMouseRelease() 
            	self.Pressed = false
            	 end 
         local ydeger = 0

function modelshower:Think()
	local ent = self:GetEntity()
	if (!self.Pressed == true) then
		ydeger= ydeger+0.05
		ent:SetAngles(Angle(0,ydeger,0))
	end
end
function modelshower:LayoutEntity( Entity )
            	if ( self.bAnimated ) then 
            		self:RunAnimation() 
            	end
            		if ( self.Pressed ) then 
            			local mx, my = gui.MousePos()
                self.Angles = Entity:GetAngles() - Angle( 0, ( self.PressX or mx ) - mx, (self.PressY or my ) - my)
                
                self.PressX, self.PressY = gui.MousePos()
                Entity:SetAngles( self.Angles )

                ydeger = self.Angles.y


            end
end



local carname = vgui.Create("DLabel",carpanel)
carname:SetFont("OCarDealerFont-ID5")
carname:SetPos(0,ph/4*3+10)

carname:SetTextColor(renkpaketleri[renktema]["Yazi"])
carname:SetMouseInputEnabled( true )
if v.Vehiclename then
carname:SetText(v.Vehiclename)
else 
	carname:SetText(t.Name)
end
carname:SizeToContents()
carname:CenterHorizontal()

	function carpanel:DragMouseRelease()
if carpanel.ownit == true then
carid = v.ID
ccarmodel = modelshower:GetModel()
createbackground(v.Entityname,carid,ccarmodel,carname:GetText(),v.Price,true,v.ownedcolor ,v.ownedbodygroup,v.skin,v.Description,v.Onlythisusergroups,v.OnlythisJobs)
elseif carpanel.ownit == false then
carid = v.ID
ccarmodel = modelshower:GetModel()

createbackground(v.Entityname,carid,ccarmodel,carname:GetText(),v.Price,false,nil,nil,nil,v.Description,v.Onlythisusergroups,v.OnlythisJobs)
elseif carpanel.ownit == "Break" then
	OCarDealer:NotifyC("cantmodify")
end
end


if not v.ownedcar == true then
carpanel.ownit = false 	
local len,leny = ONX:IsFontBig(30,20,languages.buy,"descfont")
local buybutton = vgui.Create("DButton", carpanel)
buybutton:SetPos(0,ph/4*3+30)
buybutton:SetSize(pw/4,ph/4-32)
buybutton:CenterHorizontal()
buybutton:SetFont("descfont")
buybutton:SetText(languages.buy)
buybutton:SetTextColor(renkpaketleri[renktema]["Yazi"])
function buybutton:Paint(w,h)
draw.RoundedBoxEx(5,0,0,w,h,renkpaketleri[renktema]["Background"],true,true,true,true)
	end

buybutton.DoClick = function()

local TABLEo = {}
TABLEo.Entityname = v.Entityname
TABLEo.Price = v.Price
TABLEo.ID = v.ID
TABLEo.Bodygroup = {}
TABLEo.Vehiclename = v.Vehiclename
TABLEo.Color = modelshower:GetEntity():GetColor()
TABLEo.Skin = 0
local getbodygroup = modelshower.Entity:GetBodyGroups()
for a,b in pairs(getbodygroup) do
local littletable = {}
littletable.Idbodygroup = b.id
littletable.hasbody = modelshower.Entity:GetBodygroup( b.id )
table.insert(TABLEo.Bodygroup,littletable)
end
net.Start("OCCDealer-BuyCar")
net.WriteTable(TABLEo)
net.SendToServer()
self:Remove()
	net.Start("OCCDealer-ClosePanel")
	net.SendToServer()
end

elseif !(activevehicle == v.Entityname) then
carpanel.ownit = true
local len,leny = ONX:IsFontBig(30,20,languages.spawn,"descfont")
	local spawnbutton = vgui.Create("DButton", carpanel)
spawnbutton:SetPos(pw/4*3-8,ph/4*3+30)
spawnbutton:SetSize(pw/4,ph/4-32)
spawnbutton:SetFont("descfont")
spawnbutton:SetText(languages.spawn)
spawnbutton:SetTextColor(renkpaketleri[renktema]["Yazi"])
function spawnbutton:Paint(w,h)
draw.RoundedBoxEx(5,0,0,w,h,renkpaketleri[renktema]["Background"],true,true,true,true)
	end
spawnbutton.DoClick = function()
local tablesp = {}
tablesp.Entityname = v.Entityname
tablesp.ID = v.ID
tablesp.Bodygroup = v.ownedbodygroup
tablesp.Color = v.ownedcolor
tablesp.Skin = v.skin
net.Start("OCCDealer-SpawnVehicle")
net.WriteTable(tablesp)
net.SendToServer()
self:Remove()
end
	local sellbutton = vgui.Create("DButton", carpanel)
sellbutton:SetPos(8,ph/4*3+30)
sellbutton:SetSize(pw/4,ph/4-32)
sellbutton:SetFont("descfont")
sellbutton:SetText(languages.sell)
sellbutton:SetTextColor(renkpaketleri[renktema]["Yazi"])
function sellbutton:Paint(w,h)
draw.RoundedBoxEx(5,0,0,w,h,renkpaketleri[renktema]["Background"],true,true,true,true)
	end
sellbutton.DoClick = function()
local tablesp = {}
tablesp.Entityname = v.Entityname
tablesp.ID = v.ID
tablesp.Bodygroup = v.ownedbodygroup
tablesp.Color = v.ownedcolor
tablesp.Skin = v.skin
net.Start("OCCDealer-SellCar")
net.WriteTable(tablesp)
net.SendToServer()
self:Remove()
end
elseif (activevehicle == v.Entityname ) then
carpanel.ownit = "Break"
local len,leny = ONX:IsFontBig(30,20,languages.recall,"descfont")
	local recallbutton = vgui.Create("DButton", carpanel)
recallbutton:SetPos(0,ph/4*3+30)
recallbutton:SetSize(pw/4,ph/4-32)
recallbutton:CenterHorizontal()
recallbutton:SetFont("descfont")
recallbutton:SetText(languages.recall)
recallbutton:SetTextColor(Color(255,255,255))
function recallbutton:Paint(w,h)
draw.RoundedBoxEx(5,0,0,w,h,renkpaketleri[renktema]["Background"],true,true,true,true)
	end
recallbutton.DoClick = function()
net.Start("OCCDealer-ParkVehicle")
net.SendToServer()
self:Remove()
end
end
end

local function addallcars()
	self:SetLink("shop")
if !(ONX:IsTableNil(servervehicles)) then
for k,v in pairs(servervehicles) do
	if (v.Price) and (v.Price >-1) and ( list.Get( "Vehicles" )[ v.Entityname ] or list.Get("simfphys_vehicles")[v.Entityname] ) then
	addcarshop(v)
end
end
else
	local novehiclelabel = vgui.Create("DLabel", carsidepanel)
	novehiclelabel:Center()
	novehiclelabel:SetFont("notifyfont")
	novehiclelabel:SetText(languages.novehicleserver)
	novehiclelabel:SizeToContents()
	function novehiclelabel:Think()
		novehiclelabel:Center()
	end
end
end
addallcars()
--- End of the shop list.




------------- Search Bar ---------------------


local function searchcar(textvalue)
carsidepanel:Clear()
ONX:ClearDividedPanels(carsidepanel)
self:SetLink("search="..textvalue)
if !(ONX:IsTableNil(servervehicles)) then
for k,v in pairs(servervehicles) do
if (v.Price) and (v.Price >-1) and ( list.Get( "Vehicles" )[ v.Entityname ] or list.Get("simfphys_vehicles")[v.Entityname] ) and (string.find(string.lower(v.Vehiclename), string.lower(textvalue)) ) then
addcarshop(v)
end
end
end
visiblepanel(carsidepanel)
end

local bx,by,bw,bh = buttonpanel:GetBounds()
self.SearchBar = vgui.Create( "DTextEntry", buttonpanel ) 
self.SearchBar:Dock(RIGHT)
self.SearchBar:SetSize( 160, 80 )
self.SearchBar:DockMargin(20,bh/3,30,bh/3)
self.SearchBar:SetValue( languages.search )
self.SearchBar.OnGetFocus = function()
if self.SearchBar:GetValue() == languages.search then
self.SearchBar:SetValue("")
end
	end
self.SearchBar.OnLoseFocus = function( panelvar )
	local value = panelvar:GetValue()
if (value=="") or ( value == nil ) or (( value == " " )) then
 	panelvar:SetValue( languages.search )
	end
end	
function self.SearchBar:OnValueChange(value)
	if !(value=="") and !( value == nil ) and (!( value == " " )) then
searchcar(value)
	else
			carsidepanel:Clear()
ONX:ClearDividedPanels(carsidepanel)
	addallcars()
	end 
end




-------- End of the Search bar.


------------- INVENTORY LIST -----------------
if !(ONX:IsTableNil(playerinventory))  then
local inx,iny = inventorypanel:GetSize()
local horitzonscroll = vgui.Create( "DScrollPanel", inventorypanel )
horitzonscroll:SetPos((inx/3)*2,0)
horitzonscroll:SetSize(inx-(inx/3)*2,iny)
function horitzonscroll:Paint(w,h)
surface.SetDrawColor( Color( 32, 32, 32, 100 ) )
surface.DrawRect( 0, 0, w, h )
end
local bar = horitzonscroll:GetVBar()
function bar:Paint( w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 100 ) )
end
function bar.btnUp:Paint( w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 200, 100, 0,0 ) )
end
function bar.btnDown:Paint( w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 200, 100, 0,0 ) )
end
function bar.btnGrip:Paint( w, h )
	draw.RoundedBox( 5, 0, 0, w, h, ColorAlpha( OCarDealer:GetSetting("Theme"), 255 ) )
end


local hoxx,hoyy,hox,hoy = horitzonscroll:GetBounds()

local modelshowerc = vgui.Create( "DModelPanel", inventorypanel )
modelshowerc:SetPos(0,0)
modelshowerc:SetSize(inx-hox, iny)
modelshowerc:SetFOV(100)
modelshowerc:SetCamPos(Vector(30,210,80))
function modelshowerc:DragMousePress()
            self.PressX, self.PressY = gui.MousePos()
            self.Pressed = true 
        end 
function modelshowerc:DragMouseRelease() 
            	self.Pressed = false
            	 end 	
  function modelshowerc:OnMouseWheeled(scrollDelta)
 	if not (modelshowerc:GetFOV()-scrollDelta > 150 ) then
 modelshowerc:SetFOV(modelshowerc:GetFOV()-scrollDelta)
end
end
         local ydeger = 0
function modelshowerc:Think()
	local ent = self:GetEntity()
	if (!self.Pressed == true) then
		ydeger= ydeger+0.05
		ent:SetAngles(Angle(0,ydeger,0))
	end
end
function modelshowerc:LayoutEntity( Entity )
            	if ( self.bAnimated ) then 
            		self:RunAnimation() 
            	end
            		if ( self.Pressed ) then 
            			local mx, my = gui.MousePos()
                self.Angles = Entity:GetAngles() - Angle( 0, ( self.PressX or mx ) - mx, (self.PressY or my ) - my)
                
                self.PressX, self.PressY = gui.MousePos()
                Entity:SetAngles( self.Angles )
               
                ydeger = self.Angles.y
               

            end
end

local sccbutton = vgui.Create("DButton",inventorypanel)
sccbutton:SetPos(hoxx-20,hoy/2-(hoy/8))
sccbutton:SetSize(20,hoy/4)
sccbutton:SetText(">>")
sccbutton:SetTextColor(Color(255,255,255))
sccbutton.kapali = false
function sccbutton:Paint(w,h)
draw.RoundedBoxEx(5,0,0,w,h,ColorAlpha(OCarDealer:GetSetting("Theme",100)),true,false,true,false)
	end
sccbutton.DoClick = function()
if sccbutton.kapali == false then
horitzonscroll:MoveTo(inx,0,1,0)
sccbutton:MoveTo(inx-20,hoy/2-(hoy/8),1,0)
modelshowerc:SizeTo(inx-22,iny,1,0)
sccbutton:SetText("<<")
sccbutton.kapali = true
else

horitzonscroll:MoveTo(inx-(inx/3),0,1,0)
sccbutton:MoveTo(hoxx-20,hoy/2-(hoy/8),1,0)
modelshowerc:SizeTo(inx-hox,iny,1,0)
sccbutton:SetText(">>")
sccbutton.kapali = false
end
end	

local function showcar(ctable)
	if ctable then
if !( list.Get( "Vehicles" )[ ctable.Entityname ] or list.Get("simfphys_vehicles")[ctable.Entityname])  then return end
if  list.Get("Vehicles")[ctable.Entityname]  then
t = list.Get( "Vehicles" )[ ctable.Entityname ]
model = t.Model
elseif list.Get("simfphys_vehicles")[ctable.Entityname] then
t = list.Get( "simfphys_vehicles" )[ ctable.Entityname ]
model = t.Model
end


modelshowerc:SetModel(model)
modelshowerc:SetColor(Color(ctable.Color.r,ctable.Color.g,ctable.Color.b,255))
if ctable.Skin then 
modelshowerc:GetEntity():SetSkin(ctable.Skin)
end
for c,d in pairs(ctable.Bodygroup) do
	modelshowerc.Entity:SetBodygroup(d.Idbodygroup,d.hasbody)
end
end
end 
showcar(playerinventory[1])
local function addcartoinventory(cartable)
for k,v in pairs(cartable) do
if !( list.Get( "Vehicles" )[ v.Entityname ] or list.Get("simfphys_vehicles")[v.Entityname])  then return end
if  list.Get("Vehicles")[v.Entityname]  then
t = list.Get( "Vehicles" )[ v.Entityname ]
model = t.Model
elseif list.Get("simfphys_vehicles")[v.Entityname] then
t = list.Get( "simfphys_vehicles" )[ v.Entityname ]
model = t.Model
end
local invpanel = horitzonscroll:Add("DPanel")
invpanel:SetSize(hox-20,hoy/6)
invpanel:Dock(TOP)
invpanel:DockMargin(10,4,0,4)
invpanel:SetCursor("hand")
function invpanel:Paint(w,h)
surface.SetDrawColor( Color( 64, 64, 64, 100 ) )
surface.DrawRect( 0, 0, w, h )
end
function invpanel:Think()
		if (self:IsHovered() == true) and !(self.sized == true)  then
		self:SizeTo(hox,hoy/6+1,0.05,0)
		self.sized = true 
	elseif (self:IsHovered() == false) and !(self.sized==false) then  
		self:SizeTo(hox,hoy/6,0.05,0)
		self.sized = false 
	end
	end
invpanel.DragMouseRelease = function()
local yazilacakname = string.Replace(v.Vehiclename, " ", "_")
self:SetLink("garage/view="..yazilacakname)
showcar(v)
end

local ivx,ivy = invpanel:GetSize()



local modelshowerd = vgui.Create( "DModelPanel", invpanel )
modelshowerd:SetPos(0,0)
modelshowerd:SetSize(ivx/6*2, ivy)
modelshowerd:SetFOV(100)
modelshowerd:SetModel( model )
modelshowerd:SetCamPos(Vector(30,210,80))
modelshowerd:SetColor(Color(v.Color.r,v.Color.g,v.Color.b,255))
if v.Skin then 
modelshowerd:GetEntity():SetSkin(v.Skin)
end
for c,d in pairs(v.Bodygroup) do
	modelshowerd.Entity:SetBodygroup(d.Idbodygroup,d.hasbody)
end
         local ydeger = 0
function modelshowerd:Think()
	local ent = self:GetEntity()
	if (!self.Pressed == true) then
		ydeger= ydeger+0.05
		ent:SetAngles(Angle(0,ydeger,0))
	end
end


local carname = vgui.Create("DLabel",invpanel)
carname:SetPos(ivx/6*2+ivx/10,20)
carname:SetColor(Color(255,255,255,255))
carname:SetFont("descfont")
carname:SetText(v.Vehiclename)
carname:SizeToContents()
if v.Vehiclename then
len,leny = ONX:IsFontBig(0,0,v.Vehiclename,"descfont")
end
local carpricelabel = vgui.Create("DLabel",invpanel)
carpricelabel:SetPos(ivx/6*2+ivx/10,leny+20)
carpricelabel:SetFont("descfont")
carpricelabel:SetText(languages.price.." : "..OCarDealer:CurrencyMoney(v.Price))
carpricelabel:SetColor(Color(255,255,255,255))
carpricelabel:SizeToContents() 


if !(activevehicle == v.Entityname) then
local len,leny = ONX:IsFontBig(30,20,languages.spawn,"descfont")
	local spawnbutton = vgui.Create("DButton", invpanel)
spawnbutton:SetPos(ivx-(20+len+5),ivy/2-leny-5)
spawnbutton:SetSize(len+5,leny+5)
spawnbutton:SetFont("descfont")
spawnbutton:SetText(languages.spawn)
spawnbutton:SetTextColor(renkpaketleri[renktema]["Yazi"])
function spawnbutton:Paint(w,h)
draw.RoundedBoxEx(5,0,0,w,h,renkpaketleri[renktema]["Background"],true,true,true,true)
	end
spawnbutton.DoClick = function()
local tablesp = {}
tablesp.Entityname = v.Entityname
tablesp.ID = v.ID
tablesp.Bodygroup = v.ownedbodygroup
tablesp.Color = v.ownedcolor
tablesp.skin = v.skin
net.Start("OCCDealer-SpawnVehicle")
net.WriteTable(tablesp)
net.SendToServer()
self:Remove()
end
function spawnbutton:Think()
	if (self:IsHovered() == true) and !(self.sized == true)  then
		self:SizeTo(len+9,leny+7,0.05,0)
		self:MoveTo(ivx-(20+len+9),ivy/2-leny-9,0.05,0)
		self.sized = true 
	elseif (self:IsHovered() == false) and !(self.sized==false) then  
		self:SizeTo(len+5,leny+5,0.05,0)
		self:MoveTo(ivx-(20+len+5),ivy/2-leny-5,0.05,0)
		self.sized = false 
	end
	end
elseif (activevehicle == v.Entityname) then
local len,leny = ONX:IsFontBig(30,20,languages.recall,"descfont")
	local recallbutton = vgui.Create("DButton", invpanel)
recallbutton:SetPos(ivx-(20+len+5),ivy/2-leny-5)
recallbutton:SetSize(len+5,leny+5)
recallbutton:SetFont("descfont")
recallbutton:SetText(languages.recall)
recallbutton:SetTextColor(renkpaketleri[renktema]["Yazi"])
function recallbutton:Paint(w,h)
draw.RoundedBoxEx(5,0,0,w,h,renkpaketleri[renktema]["Background"],true,true,true,true)
	end
function recallbutton:Think()
	if (self:IsHovered() == true) and !(self.sized == true)  then
		self:SizeTo(len+9,leny+7,0.05,0)
		self:MoveTo(ivx-(20+len+7),ivy/2-leny-7,0.05,0)
		self.sized = true 
	elseif (self:IsHovered() == false) and !(self.sized==false) then  
		self:SizeTo(len+5,leny+5,0.05,0)
		self:MoveTo(ivx-(20+len+5),ivy/2-leny-5,0.05,0)
		self.sized = false 
	end
end
recallbutton.DoClick = function()
net.Start("OCCDealer-ParkVehicle")
net.SendToServer()
self:Remove()
end
end


local len,leny = ONX:IsFontBig(30,20,languages.modify,"descfont")
local modifybuttonhave = vgui.Create("DButton", invpanel)
modifybuttonhave:SetPos(ivx-(len+5)-20,ivy/2+10)
modifybuttonhave:SetSize((len+5),leny+5)
modifybuttonhave:SetFont("descfont")
modifybuttonhave:SetText(languages.modify)
modifybuttonhave:SetTextColor(renkpaketleri[renktema]["Yazi"])
function modifybuttonhave:Paint(w,h)
draw.RoundedBoxEx(5,0,0,w,h,renkpaketleri[renktema]["Background"],true,true,true,true)
	end
modifybuttonhave.DoClick = function()
carid = v.ID
ccarmodel = modelshowerd:GetModel()
createbackground(v.Entityname,carid,ccarmodel,carname:GetText(),v.Price,true,v.Color ,v.Bodygroup,v.Skin,v.Description,v.Onlythisusergroups,servervehicles[k].OnlythisJobs)
end	
function modifybuttonhave:Think()
	if (self:IsHovered() == true) and !(self.sized == true)  then
		self:SizeTo((len+8),leny+7,0.05,0)
		self:MoveTo(ivx-(len+7)-20,ivy/2+8,0.05,0)
		self.sized = true 
	elseif (self:IsHovered() == false) and !(self.sized==false) then  
		self:SizeTo((len+5),leny+5,0.05,0)
		self:MoveTo(ivx-(len+5)-20,ivy/2+10,0.05,0)
		self.sized = false 
	end
	end
invpanel:InvalidateLayout( true )
invpanel:SizeToChildren(true,false)

end
end

addcartoinventory(playerinventory)
horitzonscroll:Rebuild()
else
local donthave = vgui.Create("DLabel",inventorypanel)
donthave:SetFont("notifyfont")
donthave:SetColor(renkpaketleri[renktema]["Yazi"])
donthave:SetText(languages.donthave)
donthave:SizeToContents()
donthave:Center()

end
------- INVENTORY END

end
function VEHICLESPANEL:Paint(w, h)
		Derma_DrawBackgroundBlur( self, self.startTime )
	surface.SetDrawColor( 32, 32, 32, 150 )
	surface.DrawRect(0,0,w,h)

	end
function  VEHICLESPANEL:SetLink(link)
URL:SetText("https://onxscustomizablecardealer.com/"..link)
URL:SizeToContents()
end	
function VEHICLESPANEL:VisiblePanel(id)
visiblepanel(id)
	end
	function VEHICLESPANEL:OnRemove()
		settingspanelxdd = nil
		ccarmodel = nil
		carid = nil
		OCarDealer.StoreMainPanel = nil
		net.Start("OCCDealer-ClosePanel")
		net.WriteString("ShopPanel")
	net.SendToServer()
	end
vgui.Register("onxcdmenu", VEHICLESPANEL,"EditablePanel")	