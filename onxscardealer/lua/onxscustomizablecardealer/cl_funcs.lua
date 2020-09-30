function OCarDealer.OpenMenu()
			if OCarDealer.StoreMainPanel == nil then 
				OCarDealer.StoreMainPanel = vgui.Create("onxcdmenu")
				OCarDealer.StoreMainPanel:SetVisible(true)

			end
		end
net.Receive("OCCDealer-OpenPanel",OCarDealer.OpenMenu)


function OCarDealer:GetSetting(definitionname)
	local stfile = file.Read("OcardealerSettings/settingsnew.txt")
	local Settings = util.JSONToTable(stfile)
	return Settings[definitionname][1]
end

function OCarDealer:Language()
local settingsl = OCarDealer:GetSetting("Language")
return settingsl,OCarDealer.LANGUAGES[settingsl]
end

function OCarDealer:NotifyC(code,patterns)

if notpanel then return timer.Simple(3, function() OCarDealer:NotifyC(code,patterns) end) end

local setname, ltab =OCarDealer:Language()
if ltab.notifymessage[code] then

thenotify = ltab.notifymessage[code]

if (patterns != "") then
	thenotify = string.format(thenotify, patterns)
end

local codes = ltab.notifymessage
notpanel = vgui.Create( "DPanel" )
notpanel:RequestFocus()
notpanel:SetPos(ScrW(),ScrH()/6*5)
notpanel:SetSize(0, 50)
if OCarDealer.StoreMainPanel then
notpanel:MakePopup()
end
function notpanel:Think()
	notpanel:MoveToFront()
end




function notpanel:Paint(w,h)
draw.RoundedBox(1,0 ,0,20,h,OCarDealer:GetSetting("Theme"))
draw.RoundedBox(1, 0, 0, w,h,Color(32,32,32,200))

end	
local yazi = vgui.Create("DLabel",notpanel)
yazi:SetFont("notifyfont")
yazi:SetText(thenotify)
yazi:SetColor(Color(255,255,255))
yazi:SizeToContents()


local newsizew,newsizeh = yazi:GetTextSize()

function notpanel:Think()
	yazi:SetPos(22,2)
	yazi:CenterVertical( 0.5)
	yazi:SizeToContents()
end

local function removewithanimation()
notpanel:MoveTo( ScrW(), ScrH()/6*5, 0.5, 0,-1,function() end)
notpanel:SizeTo( 0, 0, 0.5, 0,-1,function()if (notpanel) then  notpanel:Remove() notpanel = nil if OCarDealer.StoreMainPanel then OCarDealer.StoreMainPanel:SetPopupStayAtBack(false) end end end)
end

notpanel:MoveTo( ScrW()-(newsizew+25), ScrH()/6*5, 0.5, 0,-1,function() end)
notpanel:SizeTo(newsizew+25,70,0.5,0,-1,function()timer.Create("timer",2,1,function() removewithanimation()  end)end)
else
	    error("[OCarDealer Notify Function] argument are not specified.")
end
end


function notifyalgilayici(ply,len)
	local code = net.ReadString()
	local patternstring = net.ReadString()
OCarDealer:NotifyC(code,patternstring)
end
net.Receive("OCCDealer-Notify",notifyalgilayici)


local function logininitializer()
	for iid,ifilelink in pairs(OCarDealer.CONFIG.SpecialButtons) do
	ONX:DownloadImage(ifilelink.Imagelink)
end
	ONX:DownloadImage("https://cdn4.iconfinder.com/data/icons/forgen-phone-settings/48/setting-512.png")
	if !(file.Exists("OcardealerSettings", "DATA")) then
		file.CreateDir("OcardealerSettings")
	end	
		if !(file.Exists("OcardealerSettings/settingsnew.txt", "DATA")) then
		file.Write("OcardealerSettings/settingsnew.txt")
	end	
	local stfile = file.Read("OcardealerSettings/settingsnew.txt")
	if (stfile == "") then
	local Settings = {}
	Settings["Theme"] = {Color(0, 255, 255),"ColorChooser"}
	Settings["Theme Mode"] = {"Dark","Mode"} 
	Settings["Language"] = {"English","Language"}
	local tbltojs = util.TableToJSON(Settings,true)
	file.Write("OcardealerSettings/settingsnew.txt",tbltojs)
	end
end
hook.Add("Initialize","ocardealerplyloginhook",logininitializer)
