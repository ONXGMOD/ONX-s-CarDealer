--Serverside Vehicle Settings
ADMINPANEL = {}

function ADMINPANEL:Init()
		self:SetPos(ScrH()/15+ScrH()/12)
		self:SetSize(ScrW(),ScrH()-(ScrH()/15+ScrH()/12) )
		self:SetVisible(true)


local hasvehicles = net.ReadTable()
local adaylar = net.ReadTable()
local dealers = {}
for k,v in pairs(adaylar) do
	local bum = {v.ID,v.Name}
	table.insert(dealers, bum)
end
local px,py,pw,ph = self:GetBounds()
allvehicles = list.Get("Vehicles")
local list = list.Get("simfphys_vehicles")
for k,v in pairs(list) do
	allvehicles[k] = v
end

local notthisvehicles = {"Seat_Airboat","Chair_Office2","phx_seat","phx_seat2","phx_seat3","Chair_Plastic","Seat_Jeep","Chair_Office1","Chair_Wood","Airboat","Jeep","Pod"}

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

if  !(hasvehicles == nil) then
		for k,v in pairs(hasvehicles) do
			if allvehicles[v.Entityname] then
			allvehicles[v.Entityname].serverhas = true
			allvehicles[v.Entityname].vname = v.Vehiclename
			allvehicles[v.Entityname].price = v.Price
			allvehicles[v.Entityname].desc = v.Description
			allvehicles[v.Entityname].rank = v.Onlythisusergroups
			allvehicles[v.Entityname].job = v.OnlythisJobs
			allvehicles[v.Entityname].Dealers = v.Dealers
			allvehicles[v.Entityname].ID = v.ID
			end
		end
	end


for k,v in pairs(allvehicles) do
				if table.HasValue(notthisvehicles, k) then
			allvehicles[k] = nil 
		end
	end

local usergrouptable = OCarDealer:GetUserGroups()


local scrollpanel = vgui.Create("DScrollPanel",self)
scrollpanel:SetPos( 0, 0 ) 
scrollpanel:SetSize(pw,ph )
scrollpanel:SetVerticalScrollbarEnabled( false )
scrollpanel:GetVBar():SetHideButtons(true)
function scrollpanel:Paint(w,h)
surface.SetDrawColor( ColorAlpha(renkpaketleri[renktema]["Background"],100) )  
surface.DrawRect( 0, 0, w, h )
end

local sx,sy,sw,sh = scrollpanel:GetBounds()

local function localpanel(entityname)


local veh = allvehicles[entityname]

local realentityname = entityname

local px,py,pw,ph = self:GetBounds()
local vehiclepanel = vgui.Create("DPanel",self)
vehiclepanel:SetSize(pw,ph)
local vx,vy,vwx,vh = vehiclepanel:GetBounds()
function vehiclepanel:Paint(w,h)
surface.SetDrawColor( ColorAlpha(renkpaketleri[renktema]["Background"],150) )  
surface.DrawRect( 0, 0, w, h )
	local color = ColorAlpha(OCarDealer:GetSetting("Theme"), 200 )
draw.RoundedBoxEx(0,0,0,w,20,color,true,true,true,true)
end

local modelpanel = vgui.Create("DModelPanel",vehiclepanel)
modelpanel:SetPos(0,0)
modelpanel:SetSize(vwx/5,vh)
modelpanel:SetFOV(80)
modelpanel:SetModel(veh.Model)
modelpanel:SetCamPos(Vector(30,210,80))

local grouplittle = vgui.Create("DScrollPanel",vehiclepanel)
grouplittle:SetPos(vwx/5,21)
grouplittle:SetSize(vwx/5,vh)
grouplittle:SetVerticalScrollbarEnabled( false )
grouplittle:GetVBar():SetHideButtons(true)
function grouplittle:Paint(w,h)
surface.SetDrawColor( ColorAlpha(renkpaketleri[renktema]["Background"],100) )  
surface.DrawRect( 0, 0, w, h )
end
local bar = grouplittle:GetVBar()
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
	draw.RoundedBox( 0, 0, 0, w, h, ColorAlpha( OCarDealer:GetSetting("Theme"), 150 ) )
end

local glabel = vgui.Create("OLabelwb",vehiclepanel)
glabel:SetPos(vwx/5,0)
glabel:SetSize(vwx/5, 20)
glabel:SetText("RANKS")
glabel:SetTextColor(renkpaketleri[renktema]["Yazi"])
function glabel:Paint(w,h)
	local color = ColorAlpha(OCarDealer:GetSetting("Theme"), 200 )
draw.RoundedBoxEx(4,0,0,w,h,color,true,true,true,true)
end

local ilabel = vgui.Create("OLabelwb",vehiclepanel)
ilabel:SetPos(vwx/5*3,0)
ilabel:SetSize(vwx/5, 20)
ilabel:SetText("DEALERS")
ilabel:SetTextColor(renkpaketleri[renktema]["Yazi"])
function ilabel:Paint(w,h)
	local color = ColorAlpha(OCarDealer:GetSetting("Theme"), 200 )
draw.RoundedBoxEx(4,0,0,w,h,color,true,true,true,true)
end
local jLabel = vgui.Create("OLabelwb", vehiclepanel)
jLabel:SetPos(vwx/5*2,0)
jLabel:SetSize(vwx/5, 20)
jLabel:SetText("JOBS")
jLabel:SetTextColor(renkpaketleri[renktema]["Yazi"])
function jLabel:Paint(w,h)
	local color = ColorAlpha(OCarDealer:GetSetting("Theme"), 200 )
draw.RoundedBoxEx(4,0,0,w,h,color,true,true,true,true)
end

local idchecker = vgui.Create("DScrollPanel",vehiclepanel)
idchecker:SetPos(vwx/5*3,21)
idchecker:SetSize(vwx/5,vh)
idchecker:SetVerticalScrollbarEnabled( false )
idchecker:GetVBar():SetHideButtons(true)
function idchecker:Paint(w,h)
surface.SetDrawColor( ColorAlpha(renkpaketleri[renktema]["Background"],100) )  
surface.DrawRect( 0, 0, w, h )
end
local bar = idchecker:GetVBar()
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
	draw.RoundedBox( 0, 0, 0, w, h, ColorAlpha( OCarDealer:GetSetting("Theme"), 150 ) )
end



 veh.chosensjob = {}
if DarkRP then
	local joblittle = vgui.Create("DScrollPanel",vehiclepanel)
joblittle:SetPos(vwx/5*2,21)
joblittle:SetSize(vwx/5,vh)
joblittle:SetVerticalScrollbarEnabled( false )
joblittle:GetVBar():SetHideButtons(true)
function joblittle:Paint(w,h)
surface.SetDrawColor( ColorAlpha(renkpaketleri[renktema]["Background"],100) )  
surface.DrawRect( 0, 0, w, h )
end
local bar = joblittle:GetVBar()
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
	draw.RoundedBox( 0, 0, 0, w, h, ColorAlpha( OCarDealer:GetSetting("Theme"), 150 ) )
end




for k1,v1 in pairs(OCarDealer:GetJobs()) do
	local jobbox = joblittle:Add("DCheckBoxLabel")
jobbox:Dock(TOP)
jobbox:DockMargin(1, 1, 1, 3)
if (veh.job) then
if table.HasValue(veh.job, v1.team) then
jobbox:SetValue( 1 )
table.insert(veh.chosensjob,v1.team)
else 
	jobbox:SetValue( 0 )
end
else
	jobbox:SetValue( 0 )
end
jobbox:SetText( v1.name )
jobbox:SetTextColor(renkpaketleri[renktema]["Yazi"])
function jobbox:OnChange(val)
	if val then
		if !(table.HasValue(veh.chosensjob, v1.team)) then
			table.insert(veh.chosensjob,v1.team)
		end
	else
		if (table.HasValue(veh.chosensjob, v1.team)) then
			table.RemoveByValue(veh.chosensjob,v1.team)
		end
	end
end
end

end --- End of Job Checks.

veh.willdeal = {}
for k1,v1 in pairs(dealers) do
		local dealbox = idchecker:Add("DCheckBoxLabel")
dealbox:Dock(TOP)
dealbox:DockMargin(1, 1, 1, 3)
if (veh.Dealers) then
if table.HasValue(veh.Dealers, v1[1]) then
dealbox:SetValue( 1 )
table.insert(veh.willdeal,v1[1])
else 
	dealbox:SetValue( 0 )
end
else
	dealbox:SetValue( 0 )
end
dealbox:SetText( v1[2].. " - "..v1[1] )
dealbox:SetTextColor(renkpaketleri[renktema]["Yazi"])
function dealbox:OnChange(val)
	if (val) then
		if !(table.HasValue(veh.willdeal, v1[1])) then
			table.insert(veh.willdeal,v1[1])

		end
	else
		if (table.HasValue(veh.willdeal, v1[1])) then
			table.RemoveByValue(veh.willdeal,v1[1])
		end
	end
end


end

if (veh.price) then
veh.para = veh.price
else
	veh.para = 0 
end 
local pricelabel = vgui.Create("DLabel",vehiclepanel)
pricelabel:SetPos(vwx/5*4+3, 30 )
pricelabel:SetText("Price : ")
pricelabel:SetTextColor(renkpaketleri[renktema]["Yazi"])
pricelabel:SizeToContents()

local plw,ply = pricelabel:GetTextSize()

local priceentry = vgui.Create( "DTextEntry", vehiclepanel )
priceentry:SetPos( vwx/5*4+8+plw, 20 )
priceentry:SetSize( vwx/6-20-plw,(vwx/5-10)/10)
priceentry:SetText( tostring(veh.para) )
priceentry:SetNumeric( true )
priceentry.OnTextChanged = function()
 veh.para = tonumber(priceentry:GetValue())
end

if (veh.vname) then 
veh.nameolacak = veh.vname
else
veh.nameolacak = veh.Name
end
local namelabel = vgui.Create("DLabel",vehiclepanel)
namelabel:SetPos(vwx/5*4+3, 22+((vwx/5-10)/6.6)+10 )
namelabel:SetText("Name : ")
namelabel:SetTextColor(renkpaketleri[renktema]["Yazi"])
namelabel:SizeToContents()

local plw,ply = namelabel:GetTextSize()
local nameentry = vgui.Create( "DTextEntry", vehiclepanel )
nameentry:SetPos( vwx/5*4+8+plw, 22+((vwx/5-10)/7) )
nameentry:SetSize( vwx/6-20-plw,(vwx/5-10)/10 )
nameentry:SetText( veh.nameolacak )
nameentry.OnTextChanged = function(  )
 veh.nameolacak = nameentry:GetValue()
end

if veh.desc then
veh.description = veh.desc
else
veh.description = "Description"
end

local desclabel = vgui.Create("DLabel",vehiclepanel)
desclabel:SetPos(vwx/5*4+3, 22+((vwx/5-10)/7*2)+10 )
desclabel:SetText("Desc : ")
desclabel:SetTextColor(renkpaketleri[renktema]["Yazi"])
desclabel:SizeToContents()

local plw,ply = desclabel:GetTextSize()
local descentry = vgui.Create( "DTextEntry", vehiclepanel )
descentry:SetPos( vwx/5*4+8+plw, 24+((vwx/5-10)/7*2)  )
descentry:SetSize( vwx/6-20-plw,(vwx/5-10)/10 )
descentry:SetText( veh.description )
descentry.OnTextChanged = function( )
 veh.description = descentry:GetValue()
end

 veh.chosens = {}
for k1,v1 in pairs(usergrouptable) do
	local groupbox = grouplittle:Add("DCheckBoxLabel")
groupbox:Dock(TOP)
groupbox:DockMargin(1, 1, 1, 3)
if (veh.rank) then
if table.HasValue(veh.rank, v1) then
groupbox:SetValue( 1 )
table.insert(veh.chosens,v1)
else 
	groupbox:SetValue( 0 )
end
else
	groupbox:SetValue( 0 )
end
groupbox:SetText( v1 )
groupbox:SetTextColor(renkpaketleri[renktema]["Yazi"])
function groupbox:OnChange(val)
	if val then
		if !(table.HasValue(veh.chosens, v1)) then
			table.insert(veh.chosens,v1)
		end
	else
		if (table.HasValue(veh.chosens, v1)) then
			table.RemoveByValue(veh.chosens,v1)
		end
	end
end
end


if !(veh.serverhas) then
local openbutton = vgui.Create( "DButton", vehiclepanel )
openbutton:SetText( "Add" )
openbutton:SetTextColor(Color(255,255,255))
openbutton:SetPos(vwx/5*4+(vwx/15),vh-((vwx/5-10)/10))
openbutton:SetSize(vwx/5/2,(vwx/5-10)/10)
openbutton.DoClick = function()
if (veh.para and veh.description and veh.nameolacak) and !(ONX:IsTableNil(veh.willdeal)) then
net.Start("OCCDealer-AddNewVehicle")
net.WriteString(realentityname)
net.WriteString(veh.nameolacak)
net.WriteString(veh.description)
net.WriteUInt( veh.para, 32 )
net.WriteTable(veh.chosens)
net.WriteTable(veh.chosensjob)
net.WriteTable(veh.willdeal)
net.SendToServer()
OCarDealer.Settingsmainpanel:Remove()
else
	OCarDealer:NotifyC("uleftsomethingwrong")
end
end
    function openbutton:Paint(w,h)
	draw.RoundedBoxEx(4, 0,0,w,h,ColorAlpha(OCarDealer:GetSetting("Theme",200)), true,true,true,true)
    	end
else
	local savebutton = vgui.Create( "DButton", vehiclepanel )
savebutton:SetText( "Save" )
savebutton:SetTextColor(Color(255,255,255))
savebutton:SetPos(vwx/5*4+(vwx/15),vh-((vwx/5-10)/10))
savebutton:SetSize(vwx/5/2,(vwx/5-10)/10)
savebutton.DoClick = function()
if (veh.para and veh.description and veh.nameolacak) then
net.Start("OCCDealer-SaveVehicleData")
net.WriteString(realentityname)
net.WriteString(veh.nameolacak)
net.WriteString(veh.description)
net.WriteUInt( veh.para, 32 )
net.WriteTable(veh.chosens)
net.WriteTable(veh.chosensjob)
net.WriteTable(veh.willdeal)
net.SendToServer()
OCarDealer.Settingsmainpanel:Remove()
else
	chat.AddText(Color(255,255,255),"Olmadı.")
end
end
    function savebutton:Paint(w,h)
	draw.RoundedBoxEx(4, 0,0,w,h,ColorAlpha(OCarDealer:GetSetting("Theme",200)), true,true,true,true)
    	end
	local deletebutton = vgui.Create( "DButton", vehiclepanel )
deletebutton:SetText( "Delete" )
deletebutton:SetTextColor(Color(255,255,255))
deletebutton:SetPos(vwx/5*3+(vwx/15),vh-((vwx/5-10)/10))
deletebutton:SetSize(vwx/5/2,(vwx/5-10)/10)
deletebutton.DoClick = function()
net.Start("OCCDealer-DeleteVehicle")
net.WriteString(realentityname)
net.WriteUInt( allvehicles[entityname].ID, 32 )
net.SendToServer()
OCarDealer.Settingsmainpanel:Remove()

end
    function deletebutton:Paint(w,h)
	draw.RoundedBoxEx(4, 0,0,w,h,ColorAlpha(OCarDealer:GetSetting("Theme",200)), true,true,true,true)
    	end
end
end

local alt = 0
for k,v in SortedPairs(allvehicles) do 
	if (v.Model) and (v.Name) then
xpanel = ONX:CreateDividedPanels(scrollpanel,3,3)
	function xpanel:Paint(w,h)
surface.SetDrawColor( ColorAlpha( OCarDealer:GetSetting("Theme"), 100 ) )
surface.DrawOutlinedRect( 0, 0, w, h )
	end

		local xsx,xsy,xsw,xsh = xpanel:GetBounds()
		
		local modelpanelss = vgui.Create("DModelPanel",xpanel)
	modelpanelss:SetPos(3,2)
	modelpanelss:SetSize(xsw-6,xsh-(xsh/5))
	modelpanelss:SetFOV(80)
	modelpanelss:SetModel(v.Model)
	modelpanelss:SetCamPos(Vector(30,210,80))

	local stbutton = vgui.Create("DButton",xpanel)
		stbutton:SetPos(3,xsh/5*4+10)
	stbutton:SetSize(80,30)
	stbutton:CenterHorizontal(0.5)
	stbutton:SetText("Configure")
	stbutton:SetTextColor(Color(255,255,255))
	stbutton.DoClick = function()
	scrollpanel:Clear()
		localpanel(k)
end
    function stbutton:Paint(w,h)
	draw.RoundedBoxEx(4, 0,0,w,h,ColorAlpha(OCarDealer:GetSetting("Theme",200)), true,true,true,true)
    	end

	end


end
self:InvalidateLayout(true)
end
function ADMINPANEL:Paint(w, h)
	surface.SetDrawColor( 32, 32, 32, 0 )
	surface.DrawRect(0,0,w,h)
	end
vgui.Register("OCCD:VehicleEditPanel", ADMINPANEL,"EditablePanel")


----Client Settings
SETTINGSPANEL = {}

function SETTINGSPANEL:Init()
		self:SetPos(ScrH()/15+ScrH()/12)
		self:SetSize(ScrW(),ScrH()-(ScrH()/15+ScrH()/12) )
		self:SetVisible(true)


	local stfile = file.Read("OcardealerSettings/settingsnew.txt")
	Settings = util.JSONToTable(stfile)

	mainx,mainy,mainw,mainh = self:GetBounds()

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

local mainpanel = vgui.Create("DScrollPanel", self)
mainpanel:SetSize(mainw, mainh)
mainpanel:SetPos(0,0)
local function savesettings()
	local newsettings = {}
	for k,v in pairs(Settings) do
		newsettings[k] = {}
		newsettings[k][1] = v[1]
		newsettings[k][2] = v[2]
	end
	local jsonm = util.TableToJSON(newsettings,true)
	file.Write("OcardealerSettings/settingsnew.txt", jsonm)
end	
function mainpanel:Paint(w,h)
surface.SetDrawColor( renkpaketleri[renktema]["Background"] )  
surface.DrawRect( 0, 0, w, h )
	end

local function createcolorpicker(definitonname,ourpanel)

local respraypanel = vgui.Create("DFrame",self)
local opx,opy,opw,oph = ourpanel:GetBounds()
respraypanel:Center()
respraypanel:SetSize( 250,300 ) 
respraypanel:SetVisible(true)
respraypanel:SetDraggable( true )
respraypanel:RequestFocus()
respraypanel:MakePopup()
respraypanel.btnMinim:SetVisible( false )
respraypanel.btnMaxim:SetVisible( false )
	function respraypanel:Paint(w,h)
	surface.SetDrawColor( 32, 32, 32, 200 )
	surface.DrawRect( 0, 0, w, h )
	end

local respray = vgui.Create( "DColorMixer", respraypanel )
respray:SetPos(5,25)
respray:SetSize(250,250)		
respray:SetPalette( true ) 		
respray:SetAlphaBar( true ) 		
respray:SetWangs( true )			
respray:SetColor( Settings[definitonname][1] )
function respray:ValueChanged(color)
	newcolor = color
end

local acceptbutton = vgui.Create("DButton",respraypanel)
acceptbutton:SetPos(125,280)
acceptbutton:SetSize(40,20)
acceptbutton:SetText("Accept")
acceptbutton.DoClick = function()
Settings[definitonname][1] = newcolor
savesettings()
respraypanel:Remove()
end



end


local function createpanel(ptype,curcolor,definitionname,ppanel)


function ppanel:Paint(w,h)
surface.SetDrawColor( ColorAlpha(OCarDealer:GetSetting("Theme"), 200 ) )
surface.DrawOutlinedRect( 0, 0, w, h )
end

local text = vgui.Create("DLabel",ppanel)

text:SetText(definitionname.." : ")
text:SizeToContents()
text:SetTextColor(renkpaketleri[renktema]["Yazi"])
function text:Think()
	lpx,lpy,lpw,lph = ppanel:GetBounds()
	text:SetPos(5,lph/2)
end

tx,ty = text:GetTextSize()
	local openbutton = vgui.Create("DButton", ppanel)
	openbutton:SetSize(90,30)
		openbutton:SetFont("OCarDealerFont-ID4")
	openbutton:SetTextColor(Color(255,255,255))
	openbutton:SetText("Configure")

	openbutton.DoClick = function()
	createcolorpicker(definitionname,mainpanel)
end
function openbutton:Paint(w,h)
draw.RoundedBoxEx(4, 0,0,w,h,ColorAlpha(OCarDealer:GetSetting("Theme",200)), true,true,true,true)
end
function openbutton:Think()
openbutton:Center()
end


end

for k,v in pairs(Settings) do
	if  k == "Language" then
		local ppanel = ONX:CreateDividedPanels(mainpanel,2,8)
function ppanel:Paint(w,h)
surface.SetDrawColor( ColorAlpha( OCarDealer:GetSetting("Theme"), 255 ) )
surface.DrawOutlinedRect( 0, 0, w, h )
end
local text = vgui.Create("DLabel",ppanel)

text:SetText("Language : ")
text:SizeToContents()
text:SetTextColor(renkpaketleri[renktema]["Yazi"])
function text:Think()
	lpx,lpy,lpw,lph = ppanel:GetBounds()
	text:SetPos(5,lph/2)
end

tx,ty = text:GetTextSize()

local lcombobox = vgui.Create( "DComboBox",ppanel )
lcombobox:Center()
lcombobox:SetSize( 90, 30 )
lcombobox:SetValue( v[1] )
lcombobox:SetTextColor(Color(255,255,255))
for k,v in pairs (OCarDealer.LANGUAGES) do
lcombobox:AddChoice(k)
end	
lcombobox.OnSelect = function( self, index, value )
Settings[k][1] = value
savesettings()
end
function lcombobox:Paint(w,h)
draw.RoundedBoxEx(4, 0,0,w,h,ColorAlpha(OCarDealer:GetSetting("Theme",200)), true,true,true,true)
end
function lcombobox:Think()
lcombobox:Center()
end

elseif k == "Theme Mode" then
			local ppanel = ONX:CreateDividedPanels(mainpanel,2,8)
function ppanel:Paint(w,h)
surface.SetDrawColor( ColorAlpha( OCarDealer:GetSetting("Theme"), 255 ) )
surface.DrawOutlinedRect( 0, 0, w, h )
end
local text = vgui.Create("DLabel",ppanel)

text:SetText("Mode : ")
text:SizeToContents()
text:SetTextColor(renkpaketleri[renktema]["Yazi"])
function text:Think()
	lpx,lpy,lpw,lph = ppanel:GetBounds()
	text:SetPos(5,lph/2)
end

tx,ty = text:GetTextSize()

local lcombobox = vgui.Create( "DComboBox",ppanel )
lcombobox:Center()
lcombobox:SetSize( 90, 30 )
lcombobox:SetValue( v[1] )
lcombobox:SetTextColor(Color(255,255,255))
lcombobox:AddChoice("White")
lcombobox:AddChoice("Dark")

lcombobox.OnSelect = function( self, index, value )
Settings[k][1] = value
savesettings()
end
function lcombobox:Paint(w,h)
draw.RoundedBoxEx(4, 0,0,w,h,ColorAlpha(OCarDealer:GetSetting("Theme",200)), true,true,true,true)
end
function lcombobox:Think()
lcombobox:Center()
end
else
	local ppanel = ONX:CreateDividedPanels(mainpanel,2,8)
	 createpanel(v[2],v[1],k,ppanel)
end
end

end
function SETTINGSPANEL:Paint(w, h)
	surface.SetDrawColor( 32, 32, 32, 150 )
	surface.DrawRect(0,0,w,h)

	end
vgui.Register("OCCD:CSettingsPanel", SETTINGSPANEL,"EditablePanel")


---- NPC Edit Panel

NPCEDITPANEL = {}

function NPCEDITPANEL:Init()
			self:SetPos(ScrH()/15+ScrH()/12)
		self:SetSize(ScrW(),ScrH()-(ScrH()/15+ScrH()/12) )
		self:SetVisible(true)


local uzx,uzy,uzw,uzh = self:GetBounds()

local npcinformation = net.ReadTable()
withparkstuff = false

local modelshower = vgui.Create("DModelPanel", self)
modelshower:SetPos(0,0)
modelshower:SetSize(uzw/4,uzh)
modelshower:SetModel(npcinformation.Model)
modelshower:SetFOV( 36 )

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

local yazi = vgui.Create("OLabelwb",self)
yazi:SetFont("buttonfont")
yazi:SetText("CHOOSE MODEL")
yazi:SetTextColor(Color(255,255,255))
yazi:SetPos(uzw/4,0)
yazi:SetSize(uzw/4,20)
function yazi:Paint(w,h)
	local color = ColorAlpha(OCarDealer:GetSetting("Theme"), 200 )
draw.RoundedBoxEx(4,0,0,w,h,color,true,true,true,true)
end

local scrollpanel = vgui.Create("DScrollPanel", self)
scrollpanel:SetPos(uzw/4,21)
scrollpanel:SetSize(uzw/4,uzh-21)
local bar = scrollpanel:GetVBar()
bar:SetVisible(false)
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
	local color = ColorAlpha(OCarDealer:GetSetting("Theme"), 100 )
	draw.RoundedBox( 0, 0, 0, w, h, color )
end

local mods = {}
for k,v in pairs(player_manager.AllValidModels()) do
	if (string.find(v,"Group01")) or (string.find(v,"Group02")) or (string.find(v,"Group03")) then
denemodel = string.Replace( v, "player/", "humans/" ) 
else
denemodel = string.Replace( v, "player/", "" )
end
if file.Exists(denemodel, "GAME") then
table.insert(mods,v)
end
end	
local tab = ONX:ListKeystoNumber(mods)
for k,v in SortedPairs(tab) do
	local sayi = v.ONumber
	local xpanel = ONX:CreateDividedPanels(scrollpanel,4,6)

	function xpanel:Paint(w,h)
surface.SetDrawColor( ColorAlpha( OCarDealer:GetSetting("Theme"), 100 ) )
surface.DrawOutlinedRect( 0, 0, w, h )
	end

local xx,xy,xw,xh = xpanel:GetBounds()

local ModelToGet = vgui.Create( "SpawnIcon" , xpanel ) 
ModelToGet:SetSize( xw, xh )
ModelToGet:SetModel( v[1] )
ModelToGet.DoClick = function()
modelshower:SetModel(v[1])
end

end

local otherstuffpanel = vgui.Create("DPanel",self)
otherstuffpanel:SetPos(uzw/4*2,0)
otherstuffpanel:SetSize(uzw/4*2,uzh)
	function otherstuffpanel:Paint(w,h)
surface.SetDrawColor( ColorAlpha(renkpaketleri[renktema]["Background"],150) )  
surface.DrawRect( 0, 0, w, h )
	end
local otx,oty,otw,oth = otherstuffpanel:GetBounds()
Dealername = npcinformation.DealerName

local namelabel = vgui.Create("DLabel",otherstuffpanel)
namelabel:SetPos(otw/4, 30 )
namelabel:SetFont("descfont")
namelabel:SetText("Name : ")
namelabel:SetTextColor(renkpaketleri[renktema]["Yazi"])
namelabel:SizeToContents()

local plw,ply = namelabel:GetTextSize()

local namesentry = vgui.Create( "DTextEntry", otherstuffpanel )
namesentry:SetPos( otw/4+plw+5, 20 )
namesentry:SetSize( otw/5,oth/25)
namesentry:SetText( npcinformation.DealerName )
namesentry.OnTextChanged = function(text)
Dealername = namesentry:GetText()
end

local editpark = vgui.Create( "DButton", otherstuffpanel )
editpark:SetPos( otw/8*1.5, 70 )
editpark:SetSize( otw/8,otw/30)
editpark:SetText("Edit Parks")
editpark:SetTextColor(renkpaketleri[renktema]["Yazi"])
editpark.DoClick = function()
net.Start("OCCDealer-CreatePark")
net.WriteBool(true)
net.SendToServer()
withparkstuff = true
OCarDealer.Settingsmainpanel:Remove()
end
function editpark:Paint(w,h)
draw.RoundedBoxEx(5,0,0,w,h,renkpaketleri[renktema]["Panel"],true,true,true,true)
end
local editparkc = vgui.Create( "DButton", otherstuffpanel )
editparkc:SetPos( otw/8*4, 70 )
editparkc:SetSize( otw/8,otw/30)
editparkc:SetText("Create Park")
editparkc:SetTextColor(renkpaketleri[renktema]["Yazi"])
editparkc.DoClick = function()
net.Start("OCCDealer-CreatePark")
net.WriteBool(false)
net.SendToServer()
withparkstuff = true
OCarDealer.Settingsmainpanel:Remove()
end
function editparkc:Paint(w,h)
draw.RoundedBoxEx(5,0,0,w,h,renkpaketleri[renktema]["Panel"],true,true,true,true)
end


local savebut = vgui.Create( "DButton", otherstuffpanel )
savebut:SetPos( otw/5*4-10, oth-(otw/30)-10 )
savebut:SetSize( otw/5,otw/30)
savebut:SetText("Save")
savebut:SetTextColor(Color(255,255,255))
savebut.DoClick = function()
local informatss = {}
local mdl = modelshower:GetModel() string.Replace( modelshower:GetModel(), "player/", "" )
if (string.find(mdl,"group01")) or (string.find(mdl,"group02")) or (string.find(mdl,"group03")) then
informatss.Model = string.Replace( mdl, "player/", "humans/" ) 
else
informatss.Model = string.Replace( mdl, "player/", "" )
end

informatss.DName = Dealername
net.Start("OCCDealer-SaveDealerData")
net.WriteTable(informatss)
net.SendToServer()
net.Start("OCCDealer-SavePark")
net.SendToServer()
withparkstuff = false
OCarDealer.Settingsmainpanel:Remove()
end
function savebut:Paint(w,h)
draw.RoundedBoxEx(4,0,0,w,h,ColorAlpha( OCarDealer:GetSetting("Theme"), 255 ),true,true,true,true)
end

local deletebut = vgui.Create( "DButton", otherstuffpanel )
deletebut:SetPos( otw/5*3-10, oth-(otw/30)-10 )
deletebut:SetSize( otw/5-10,otw/30)
deletebut:SetText("Delete")
deletebut:SetTextColor(Color(255,255,255))
deletebut.DoClick = function()
net.Start("OCCDealer-DeleteNPC")
net.SendToServer()
OCarDealer.Settingsmainpanel:Remove()
end
function deletebut:Paint(w,h)
draw.RoundedBoxEx(4,0,0,w,h,ColorAlpha( OCarDealer:GetSetting("Theme"), 255 ),true,true,true,true)
end

end
function NPCEDITPANEL:Paint(w, h)
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
surface.SetDrawColor( ColorAlpha(renkpaketleri[renktema]["Background"],200) )  
surface.DrawRect( 0, 0, w, h )

	end
	function NPCEDITPANEL:OnRemove()
		if (withparkstuff == false ) then
		net.Start("OCCDealer-ClosePanel")
		net.WriteString("DealerSettings")
		net.SendToServer()
	end
	end
vgui.Register("OCCD:DealerSettingsPanel", NPCEDITPANEL,"EditablePanel")