---Dealer
function OCarDealer:Notify(code,ply,patterb)
    if (code) and (ply:IsPlayer()) then
        local patn = ""
        if patterb then
            patn = tostring(patterb)
        end
        net.Start("OCCDealer-Notify")
        net.WriteString(code)
        net.WriteString(patn)
        net.Send(ply)
end
end

function OCarDealer:ConsolePrint(prints)
    MsgC(Color(255,255,0),"[OCarDealer]",Color(255,255,255),prints.."\n") 
end


function OCarDealer:GetPlayerGarage(ply)
local char = ply:SteamID64()
if nut then
chars = ply:getChar()
if not chars then return {} end
char = chars:getID()
end

    local playertabjso = file.Read("ocardealer/playerdatas/"..char..".txt","DATA")
    if playertabjso then
        playertab = util.JSONToTable(playertabjso)
        if (ONX:IsTableNil(playertab)) then
            playertab = {}
        end
return playertab
else
	return nil
end
 end

local function SavePlayerData(ply,jsoncontent)
	local char = ply:SteamID64()
if nut then
chars = ply:getChar()
if not chars then
timer.Simple(15,function()OCarDealer:ConsolePrint("Can't saved "..ply:Name().."'s files, will retry in 15 seconds.") SavePlayerData(ply,jsoncontent) end)
else
    char = chars:getID()
end
end
file.Write("ocardealer/playerdatas/"..char..".txt", jsoncontent)
OCarDealer:ConsolePrint("Saved "..char.." ID content.")
end

 function OCarDealer:PlayerHas(vehicle,ply)
 	local playertablet = OCarDealer:GetPlayerGarage(ply)
 	local servervehicles = OCarDealer:GetServerVehicles()
 	local hadcar = nil
        for k,v in pairs(playertablet) do
            if (v.ID == vehicle.ID) and (v.Entityname == vehicle.Entityname) then
                hadcar = v
            end
        end
if (hadcar == nil) then
return false
else
	return true,hadcar
end
end 	

function OCarDealer:GetServerVehicles()
        local ownedvehicless = file.Read("ocardealer/servervehicles/vehicles.txt")
        if ownedvehicless then       	
	ownedvehicles = util.JSONToTable(ownedvehicless)
else
	file.Write("ocardealer/servervehicles/vehicles.txt")
ownedvehicles = {}
	end
    if !(ONX:IsTableNil(ownedvehicles)) then 
        serveraraclar = ownedvehicles
    else
        serveraraclar = {}
    end
return serveraraclar
end    
 
 function OCarDealer:GetServerVehicle(tables)
local araclar = OCarDealer:GetServerVehicles()
        for k,v in pairs(araclar) do
            if (v.ID == tables.ID) and (v.Entityname == tables.Entityname) then
                return v
            end
        end
    end



 function logindatacheck(ply)
	if not OCarDealer:GetPlayerGarage(ply) then
		SavePlayerData(ply,"")
	end
OCarDealer:InitializePlayer(ply)
end

hook.Add("PlayerInitialSpawn","ocardealerplayercreatedata",logindatacheck) 


   

function OCarDealer:serverchecker()
	if not file.Exists("ocardealer","DATA") then 
		file.CreateDir("ocardealer")
	end
	if not file.Exists("ocardealer/playerdatas","DATA") then 
		file.CreateDir("ocardealer/playerdatas")
	end
		if not file.Exists("ocardealer/servervehicles","DATA") then 
		file.CreateDir("ocardealer/servervehicles")
	end
		if not file.Exists("ocardealer/servervehicles/vehicles.txt","DATA") then 
		file.Write("ocardealer/servervehicles/vehicles.txt",tosafejs)
	end


end
hook.Add("Initialize","serverdatacreator",OCarDealer.serverchecker)

function OCarDealer:BuyCar(cartable,v,price,ply)
 				if (DarkRP) then  
 				if not (ply:getDarkRPVar("money") >= v.Price) then return OCarDealer:Notify("nomoney",ply) end
 				elseif nut then
				local char = ply:getChar()
				if not  char:hasMoney(v.Price) then return OCarDealer:Notify("nomoney",ply) end end

    	local nottable = OCarDealer:GetPlayerGarage(ply)
    	if !nottable then 
    		SavePlayerData(ply,"")
    		nottable = OCarDealer:GetPlayerGarage(ply)
    	end
        local jisontotable = nottable
        local newstable = {
            ["Vehiclename"] = v.Vehiclename,
            ["ID"] = v.ID,
            ["Entityname"] = v.Entityname,
            ["Onlythisusergroups"] = v.Onlythisusergroups,
            ["Price"] = v.Price,
            ["Dealers"] = v.Dealers,
            ["Description"] = v.Description,
            ["Color"] = cartable.Color,
            ["Bodygroup"] = cartable.Bodygroup,
            ["Skin"] = cartable.Skin,
        }
        if !(ONX:IsTableNil(jisontotable)) then 
        	    	   local new = table.maxn( jisontotable ) + 1

        table.insert(jisontotable,newstable)

    else
    	    	jisontotable = {}
        table.insert(jisontotable,newstable)
    end
        local newtable = util.TableToJSON(jisontotable,true)
        SavePlayerData(ply,newtable)
        if DarkRP then
        ply:addMoney(-price)
    elseif nut then
    	local char = ply:getChar()
    	char:takeMoney(price)
    end
     OCarDealer:Notify("boughtcar",ply,price)

end

local function buycarnet(len,ply)
	if ONX:NetSpamCheck("OCCDealer-BuyCar") == false then return ply:ChatPrint("Stop spamming net messages!") end
local playertablet = OCarDealer:GetPlayerGarage(ply)
local cartable = net.ReadTable()
local hadcar = nil
local saraclar = OCarDealer:GetServerVehicles()
local dealer = ply:GetUsingDealer()
local jobok = true
for k,v in pairs(OCarDealer.ServerVehicles) do 
    if (cartable.Entityname == v.Entityname) and (cartable.ID == v.ID) and (cartable.Vehiclename == v.Vehiclename)  and (dealer:IsExistsShop(cartable.Entityname,cartable.ID)) then
	hadcar = OCarDealer:PlayerHas(cartable,ply)
        if not (hadcar == true) then 
       if  !(ONX:IsTableNil(v.OnlythisJobs))  then
        if (table.HasValue(v.OnlythisJobs,ply:Team())) then
            jobok = true
        else
            jobok = false
        end
    end
    if jobok == true then
            cartable.Price = v.Price

    		local entity = ply:GetUsingDealer()
    		if (entity:IsValid()) and (OCarDealer:IsDealer(entity)) and (entity:HasVehicle(cartable.Entityname,cartable.ID)) then
    		if !(ONX:IsTableNil(v.Onlythisusergroups)) then
                 if (table.HasValue(v.Onlythisusergroups,ply:GetUserGroup())) or (ply:IsSuperAdmin()) then

 				if (DarkRP) then  
 				if (ply:getDarkRPVar("money") >= v.Price) then          	
				OCarDealer:BuyCar(cartable,v,v.Price,ply)
				else
			OCarDealer:Notify("nomoney",ply)
				end
			elseif nut then
				local char = ply:getChar()
				if char:hasMoney(v.Price) then
				OCarDealer:BuyCar(cartable,v,v.Price,ply)
				else
			OCarDealer:Notify("nomoney",ply)
				end
			else
				OCarDealer:BuyCar(cartable,v,v.Price,ply)
			end

else
	OCarDealer:Notify("cantuseplygroup",ply)
end
else
OCarDealer:BuyCar(cartable,v,v.Price,ply)
end
else
	ply:ChatPrint("This car doesn't exists at your shop!")
end

else
    OCarDealer:Notify("cantusejob",ply)
end
else 
    ply:ChatPrint("You can't buy cause u have it.")
end
end
    end
end
net.Receive("OCCDealer-BuyCar",buycarnet)
 
local function sellcars(len,ply)
if ONX:NetSpamCheck("OCCDealer-SellCar") == false then return ply:ChatPrint("Stop spamming net messages!") end
if OCarDealer.CONFIG.SellCars == true then

local playertablet = OCarDealer:GetPlayerGarage(ply)
local cartable = net.ReadTable()
local saraclar = OCarDealer:GetServerVehicles()
local dealer = ply:GetUsingDealer()
if !dealer then return ply:ChatPrint("You are not using a dealer!") end
for k,v in pairs(OCarDealer.ServerVehicles) do 
    if (cartable.Entityname == v.Entityname) and (cartable.ID == v.ID)  and (dealer:IsExistsShop(cartable.Entityname,cartable.ID)) then
        if OCarDealer:PlayerHas(cartable,ply) then
           for a,b in pairs(playertablet) do
            if (cartable.Entityname == b.Entityname) and (cartable.ID == b.ID) then
                table.remove(playertablet,a)
    SavePlayerData(ply,util.TableToJSON(playertablet,true))
        if DarkRP then
        ply:addMoney(v.Price*OCarDealer.CONFIG.SellingPercentage)
    elseif nut then
        local char = ply:getChar()
        char:giveMoney(v.Price*OCarDealer.CONFIG.SellingPercentage)
    end
    local price = v.Price*OCarDealer.CONFIG.SellingPercentage
    OCarDealer:Notify("selledvehicle",ply,price)
            end
           end
        end
end
end
end
end
net.Receive("OCCDealer-SellCar",sellcars)


local function modifycarpls(len,ply)
if ONX:NetSpamCheck("OCCDealer-ModifyVeh") == false then return ply:ChatPrint("Stop spamming net messages!") end
local playertablet = OCarDealer:GetPlayerGarage(ply)
    sendtable = net.ReadTable()

if (OCarDealer:PlayerHas(sendtable,ply) == true) then
    for k,v in pairs(playertablet) do
        if (v.Entityname == sendtable.Entityname ) and (v.ID == sendtable.ID) then
            if (ply:GetActiveCar() == nil) then
    		local entity = ply:GetUsingDealer()
    		if (entity:IsValid()) and (OCarDealer:IsDealer(entity)) and (entity:HasVehicle(sendtable.Entityname,sendtable.ID)) then
        sendtable.Price = v.Price
        numwas = k 
        table.remove(playertablet,k)
                local newstable = {
            ["Vehiclename"] = v.Vehiclename,
            ["ID"] = v.ID,
            ["Entityname"] = v.Entityname,
            ["Onlythisusergroups"] = v.Onlythisusergroups,
            ["Price"] = v.Price,
            ["Dealers"] = v.Dealers,
            ["Description"] = v.Description,
            ["Color"] = sendtable.Color,
            ["Bodygroup"] = sendtable.Bodygroup,
            ["Skin"] = sendtable.Skin,
        }
       table.insert(playertablet,newstable)
       local tabletojisin = util.TableToJSON(playertablet,true)
       SavePlayerData(ply,tabletojisin)
       OCarDealer:Notify("modifiedcar",ply)
   else
   	ply:ChatPrint("broken")
   end
      else
    OCarDealer:Notify("cantmodify",ply)
end
end
    end
else
	ply:ChatPrint("You don't own this car!")
end

end
net.Receive("OCCDealer-ModifyVeh", modifycarpls)

local function servervehiclescheckers(len,ply)
	if ONX:NetSpamCheck("OCCDealer-VehicleData") == false then return ply:ChatPrint("Stop spamming net messages!") end
	if ply:IsAdmin() or ply:IsSuperAdmin() then
		local araclar = OCarDealer:GetServerVehicles()
		local dealers,ddatas = OCarDealer:GetServerDealers()
		net.Start("OCCDealer-SendVehicleData")
		net.WriteTable(araclar)	
		net.WriteTable(ddatas)
		net.Send(ply)
	end
end
net.Receive("OCCDealer-VehicleData",servervehiclescheckers)

local function servervehicleadd(len,ply)
	if ONX:NetSpamCheck("OCCDealer-AddNewVehicle") == false then return ply:ChatPrint("Stop spamming net messages!") end
local notthisvehicles = {"Seat_Airboat","Chair_Office2","phx_seat","phx_seat2","phx_seat3","Chair_Plastic","Seat_Jeep","Chair_Office1","Chair_Wood","Airboat","Jeep","Pod"}
local found = 0
if ply:IsSuperAdmin() then
local arac = net.ReadString()
local aracname = net.ReadString()
local aracdesc = net.ReadString()
local aracprice = net.ReadUInt(32)
local aracperms = net.ReadTable()
local aracjobs = net.ReadTable()
local aracdeal = net.ReadTable()
if !(arac==nil) and !(ONX:IsTableNil(aracdeal)) and !(aracprice==nil) then
for k,v in pairs(OCarDealer.ServerVehicles) do
	if v.Entityname == arac then
		found = found+1
	end
end
if (found == 0) and !(table.HasValue(notthisvehicles,arac)) then
table.SortByMember( OCarDealer.ServerVehicles, "ID" )
local aractable = {}
aractable.Entityname = arac
aractable.Price = aracprice
aractable.Vehiclename = aracname
aractable.Description = aracdesc
aractable.Onlythisusergroups = aracperms
aractable.OnlythisJobs = aracjobs
aractable.Dealers = aracdeal
if OCarDealer.ServerVehicles[1] then
aractable.ID = OCarDealer.ServerVehicles[1].ID+1
else
	aractable.ID = 1
end
        for k1,v1 in pairs(aractable.Dealers) do
        	local ent = OCarDealer:GetDealerByID(v1)
        	if !(ent:HasVehicle(aractable.Entityname,aractable.ID)) then
        		ent:AddVehicle(aractable)
        	end
        end
table.insert(OCarDealer.ServerVehicles, aractable)
OCarDealer:Notify("araceklendi",ply)

OCarDealer:SaveCars()
end
end
end
end
net.Receive("OCCDealer-AddNewVehicle",servervehicleadd)

local function spawncar(len,ply)
	if ONX:NetSpamCheck("OCCDealer-SpawnVehicle") == false then return ply:ChatPrint("Stop spamming net messages!") end
    local gelentable = net.ReadTable()
local onusew = ply:GetUsingDealer()
local jobok = true
local vehicle
if  !( (list.Get( "Vehicles" )[ gelentable.Entityname ]) or (list.Get("simfphys_vehicles")[gelentable.Entityname] and simfphys.SpawnVehicleSimple))  then return end
local arac = OCarDealer:GetServerVehicle(gelentable)
       if  !(ONX:IsTableNil(arac.OnlythisJobs))  then
        if (table.HasValue(arac.OnlythisJobs,ply:Team())) then
            jobok = true
        else
            jobok = false
        end
    end
if onusew:IsValid() then
    local id = onusew:ReturnID()
if id then
    if OCarDealer:PlayerHas(gelentable,ply) and (ply:GetActiveCar() == nil)  then
        if jobok == true then 
        local lol,aractab = OCarDealer:PlayerHas(gelentable,ply)
if  !( (list.Get( "Vehicles" )[ aractab.Entityname ]) or (list.Get("simfphys_vehicles")[aractab.Entityname]))  then return end
    local entolmali = onusew:GetAvailablePark()
    if (entolmali) and (entolmali:IsValid()) then
if  list.Get("Vehicles")[aractab.Entityname]  then
t = list.Get( "Vehicles" )[ aractab.Entityname ]
model = t.Model
        ply.vehicle = ents.Create("prop_vehicle_jeep")
        ply.vehicle:SetModel(model)
        ply.vehicle.VehicleTable = list.Get( "Vehicles" )[ aractab.Entityname ]
        ply.vehicle:SetKeyValue("vehiclescript",list.Get( "Vehicles" )[ aractab.Entityname ].KeyValues.vehiclescript) 
        ply.vehicle:SetVehicleClass( aractab.Entityname )
        ply.vehicle:SetPos( entolmali:LocalToWorld(entolmali:OBBCenter()) + Vector(0,0,30) ) 
        ply.vehicle:SetAngles(entolmali:GetAngles())

        ply.vehicle:Spawn()
elseif list.Get("simfphys_vehicles")[aractab.Entityname] then
    if simfphys and simfphys.SpawnVehicleSimple then
    local ang = entolmali:GetAngles()
ply.vehicle = simfphys.SpawnVehicleSimple( aractab.Entityname, (entolmali:LocalToWorld(entolmali:OBBCenter()) + Vector(0,0,30)), ang )
end
end
        for c,d in pairs(aractab.Bodygroup) do
    ply.vehicle:SetBodygroup(d.Idbodygroup,d.hasbody)
end
if aractab.Skin then
    ply.vehicle:SetSkin(aractab.Skin)
end
    ply.vehicle:SetColor(Color(aractab.Color.r,aractab.Color.g,aractab.Color.b,255))
    ply.vehicle:DropToFloor()
    ply.vehicle:vSetID(aractab.ID)
    ply.vehicle:Activate()
    ply.vehicle:vSetOwner(ply)
    if DarkRP then
        ply.vehicle:keysOwn(ply)
    end
    ply.vehicle:CallOnRemove( "RemoveUrSelf", function( ent ) local sowner = ent:vGetOwner() if sowner:IsPlayer() then sowner:SetActiveCar(nil,nil) end end )
    ply:SetActiveCar(ply.vehicle,aractab.Entityname)
    OCarDealer:Notify("spawnedvehicle",ply)

else
    OCarDealer:Notify("parksarebusy",ply)
end
else
    OCarDealer:Notify("cantusejob",ply)
end
else
    OCarDealer:Notify("alreadyonecarspawned",ply)
end        
end
end
end
net.Receive("OCCDealer-SpawnVehicle",spawncar)

local function recallcar(len,ply)
	if ONX:NetSpamCheck("OCCDealer-ParkVehicle") == false then return ply:ChatPrint("Stop spamming net messages!") end
local dealer = ply:GetUsingDealer()
local vehicle = ply:GetActiveCar()

if (dealer:IsValid()) then
if (dealer:GetPos():Distance(vehicle:GetPos()) < 400 ) or (dealer:IsEntCloseParks(vehicle)) or !(vehicle:IsValid()) then 
    vehicle:Remove()
    ply:SetActiveCar(nil,nil)
    OCarDealer:Notify("recalledvehicle",ply)
else
    OCarDealer:Notify("vehiclecantrecalled",ply)
end
end
end
net.Receive("OCCDealer-ParkVehicle",recallcar)    

local function servervehiclesave(len,ply)
	if ONX:NetSpamCheck("OCCDealer-SaveVehicleData") == false then return ply:ChatPrint("Stop spamming net messages!") end
local notthisvehicles = {"Seat_Airboat","Chair_Office2","phx_seat","phx_seat2","phx_seat3","Chair_Plastic","Seat_Jeep","Chair_Office1","Chair_Wood","Airboat","Jeep","Pod"}
local found = 0
if ply:IsSuperAdmin() then
local arac = net.ReadString()
local aracname = net.ReadString()
local aracdesc = net.ReadString()
local aracprice = net.ReadUInt(32)
local aracperms = net.ReadTable()
local aracjobs = net.ReadTable()
local aracdealers = net.ReadTable()
local theremoved = {}
for k,v in pairs(OCarDealer.ServerVehicles) do
    if v.Entityname == arac then
        v.Vehiclename = aracname
        v.Price = aracprice
        v.Description = aracdesc
        v.Onlythisusergroups = aracperms
        v.OnlythisJobs = aracjobs
        for k1,v1 in pairs(v.Dealers) do
        	if not (table.HasValue(aracdealers,v1)) then
        		table.insert(theremoved,v1)
end
end        		
        v.Dealers = aracdealers
        for k1,v1 in pairs(theremoved) do
        	local ent = OCarDealer:GetDealerByID(v1)
            if ent:IsValid() then
        	ent:RemoveVehicle(v)
        else
            table.RemoveByValue(v.Dealers, v1)
        end
    end
        for k1,v1 in pairs(v.Dealers) do
        	local ent = OCarDealer:GetDealerByID(v1)
        	if !(ent:HasVehicle(v.Entityname,v.ID)) then
        		ent:AddVehicle(v)
        	end
        end
        OCarDealer:Notify("savedvehicle",ply)
    end
end
end
OCarDealer:SaveCars()
end
net.Receive("OCCDealer-SaveVehicleData",servervehiclesave)

local function removevehicleserver(len,ply)
if ONX:NetSpamCheck("OCCDealer-DeleteVehicle") == false then return ply:ChatPrint("Stop spamming net messages!") end
if ply:IsSuperAdmin() then
local arac = net.ReadString()
local aracid = net.ReadUInt(32)
for k,v in pairs(OCarDealer.ServerVehicles) do
    if v.Entityname == arac and v.ID == aracid then
        local dealers = OCarDealer:GetServerDealers()
        for k1,v1 in pairs(dealers) do
            if (v1:HasVehicle(v.Entityname,v.ID)) then
                v1:RemoveVehicle(v)
            end
        end
        table.remove(OCarDealer.ServerVehicles,k)
        OCarDealer:Notify("deletedvehicle",ply)
    end
end
OCarDealer:SaveCars()
for k,v in pairs(player.GetAll()) do
OCarDealer:InitializePlayer(v)
end
end
end
net.Receive("OCCDealer-DeleteVehicle",removevehicleserver)

function OCarDealer:SaveCars()
local tbtojs = util.TableToJSON(OCarDealer.ServerVehicles,true)
file.Write("ocardealer/servervehicles/vehicles.txt",tbtojs)
end	

--- ENTITY FUNCS

function OCarDealer:IsDealer(ent)
if (ent:GetClass() == "ocardealer_npc") and !(ent:ReturnID() == nil) then
    return true
else
    return false
end
end


function OCarDealer:GetDealerByID(dealerid)
for k,v in pairs(ents.GetAll()) do 
if OCarDealer:IsDealer(v) then
    if v:ReturnID() == dealerid then
        return v
end
end
end
end

function OCarDealer:GetServerDealers()
	local map = game.GetMap()
    local nottable = file.Read("ocardealer/dealerdata/"..map.."_dealers.txt")
  	local entitytab = util.JSONToTable(nottable)
  	if (ONX:IsTableNil(entitytab)) then
  		entitytab = {}
  	end
	local dealers = {}

for k,v in pairs(ents.GetAll()) do 
if OCarDealer:IsDealer(v) then
table.insert(dealers,v)
end
end

return dealers,entitytab
end 

function OCarDealer:savedealers()
table.SortByMember( entitytable, "ID" )
local tabletojson = util.TableToJSON(entitytable,true)
local map = game.GetMap()
file.Write("ocardealer/dealerdata/"..map.."_dealers.txt",tabletojson)
end

function OCarDealer:CreatePark(ply,dealerid,onlysee)
	if onlysee == false then
local opark = ents.Create( "ocardealer_park" )
if ( !IsValid( opark ) ) then return end
opark:SetPos( ply:GetPos()+ Vector(5, 5,3) )
opark:SetNW2Entity("Parkbelongs", OCarDealer:GetDealerByID(dealerid))
opark:Spawn()
opark:Activate()
opark:SetParkOwner(ply)
end
ply:SetCanSee(OCarDealer:GetDealerByID(dealerid))
end

local function editpark(len,ply)
	if ONX:NetSpamCheck("OCCDealer-CreatePark") == false then return ply:ChatPrint("Stop spamming net messages!") end
	        local osee = net.ReadBool()
        local ent = ply:GetNW2Entity("Editingthisdealer")
        local entid = ent:ReturnID()
    if (ply:IsSuperAdmin()) and !( entid == nil ) and (ent:IsValid()) then
    OCarDealer:CreatePark(ply,entid,osee)
end
end
net.Receive("OCCDealer-CreatePark",editpark)

local function returndealerstuff(len,ply)
	if ONX:NetSpamCheck("OCCDealer-GetDealerInformation") == false then return ply:ChatPrint("Stop spamming net messages!") end
	if ply:IsSuperAdmin() then
    local id = net.ReadInt(32)
    local dealer = OCarDealer:GetDealerByID(id)
    local dealerinformations = {}
    dealerinformations.DealerName = dealer:GetDealerName()
    dealerinformations.Parks = dealer:ReturnParks()
    dealerinformations.Model = dealer:GetModel()
    net.Start("OCCDealer-SendDealerInformation")
    net.WriteTable(dealerinformations)
    net.Send(ply)
    ply:SetNW2Entity("Editingthisdealer", dealer)
end
end
net.Receive("OCCDealer-GetDealerInformation",returndealerstuff)

local function savedealerfunc(len,ply)
	if ONX:NetSpamCheck("OCCDealer-SaveDealerData") == false then return ply:ChatPrint("Stop spamming net messages!") end
    inform = net.ReadTable()
    local onusedealer = ply:GetNW2Entity("Editingthisdealer")
    if ply:IsSuperAdmin() then
    if OCarDealer:IsDealer(onusedealer) then
        onusedealer:SetModel(inform.Model)
        onusedealer:SetDealerName(inform.DName)
        OCarDealer:Savenpc(onusedealer)
		OCarDealer:Notify("savednpc",ply)
    end
end
end
net.Receive("OCCDealer-SaveDealerData",savedealerfunc)

function OCarDealer:SaveDealerParks(ply,dealerid)
for k,v in pairs(ents.GetAll()) do
    if (v:GetClass() == "ocardealer_park" ) and (v:GetNW2Entity("Parkbelongs"):IsValid()) then
        if v:GetNW2Entity("Parkbelongs"):ReturnID() == dealerid then
            if (v:IsAvailable()) then
            v:GetNW2Entity("Parkbelongs"):ParksAdd(v)
            OCarDealer:Savenpc(v:GetNW2Entity("Parkbelongs"))
            v:GetPhysicsObject():EnableMotion(false)
            ply:SetCanSee(nil)
            ply:ChatPrint("A park saved to the this dealer's system :"..v:GetNW2Entity("Parkbelongs"):ReturnID())
        else
            ply:ChatPrint("A park can't save because something on it.")
        end
        end
    end
end
		OCarDealer:Notify("savednpc",ply)
end    

local function savepark(len,ply)
	if ONX:NetSpamCheck("OCCDealer-SavePark") == false then return ply:ChatPrint("Stop spamming net messages!") end
    if ply:IsSuperAdmin() then
    if ply:GetNW2Entity("Editingthisdealer") then
        local id = ply:GetNW2Entity("Editingthisdealer"):ReturnID()
        if id then
            OCarDealer:SaveDealerParks(ply,id)
        else
        	ply:ChatPrint("You aren't editing an NPC!")
end

end
end
end
net.Receive("OCCDealer-SavePark",savepark)



local function checkents(pos,fornpc)

local tr = util.TraceHull( {
    start = Vector(pos.x-2,pos.y-2,pos.z-1),
    endpos = Vector(pos.x+2,pos.y+2,pos.z+1),
    mins = Vector( -5, -5, -5 ),
    maxs = Vector( 5, 5, 5 ),
} )
    local littab = {"pyhsgun_beam","predicted_viewmodel","player","worldspawn"}  -----
    if not table.HasValue(littab,tr.Entity:GetClass()) then
        print(tr.Entity:GetClass())
        return print("Not enough area to create NPC! The Blocking entity is : "..tr.Entity:GetClass())
    else
        return true
    end

end

function OCarDealer:CreateDealers()
    local map = game.GetMap()
if !(file.Exists("ocardealer/dealerdata/"..map.."_dealers.txt","DATA")) then
    file.Write("ocardealer/dealerdata/"..map.."_dealers.txt")
end   

    local  nottable = file.Read("ocardealer/dealerdata/"..map.."_dealers.txt")
  entitytable = util.JSONToTable(nottable)

if  !(ONX:IsTableNil(entitytable)) then 
    table.SortByMember( entitytable, "ID" )
for k,v in pairs(entitytable) do
    local ents = ents.Create("ocardealer_npc")
    ents:SetModel(v.Model)
    ents:SetPos(v.Pos)
    ents:SetAngles(v.Angles)
    ents:SetNW2Int("NPCID",v.ID)
     ents:SetDealerName(v.Name)
    ents:Spawn()
    ents:Activate()


end
for k,v in pairs(player.GetAll()) do
    v:SetActiveCar(nil,nil)
end

OCarDealer:ConsolePrint("ONX's Car Dealers created.")
else
        entitytable = {}
end
end

function OCarDealer:CreateParks()
    local dealers,dealerdata = OCarDealer:GetServerDealers()
    for k,v in pairs(dealerdata) do
        local parks = v.Spawns
        for k1,v1 in pairs(parks) do 
            local parknumber = ents.Create("ocardealer_park")
            parknumber:SetNW2Entity("Parkbelongs", OCarDealer:GetDealerByID(v.ID))
            parknumber:SetPos(v1.Pos)
            parknumber:SetAngles(v1.Ang)
            parknumber:Spawn()
            parknumber:GetPhysicsObject():EnableMotion(false)
            local findbyid = OCarDealer:GetDealerByID(v.ID)
            findbyid:ParksAdd(parknumber)
        end
    end
OCarDealer:ConsolePrint("ONX's Car Dealers's parks created.")
end

function OCarDealer:InitializeCars()
        local ownedvehicless = file.Read("ocardealer/servervehicles/vehicles.txt")
    local ownedvehicles = util.JSONToTable(ownedvehicless)
    if !(ONX:IsTableNil(ownedvehicles)) then 
        OCarDealer.ServerVehicles = ownedvehicles
        local dealers = OCarDealer:GetServerDealers()
        for k,v in pairs(OCarDealer.ServerVehicles) do
            for k1,v1 in pairs(dealers) do
                if (string.find(v.Entityname, "sim") or (list.Get("simfphys_vehicles")[v.Entityname])) and (simfphys)  then
                    if !(simfphys.SpawnVehicleSimple) then
                        table.remove(ownedvehicles,k)
                    end
                end
                if (table.HasValue(v.Dealers,v1:ReturnID())) then
                    v1:AddVehicle(v)
                end
            end
        end     
    else
        OCarDealer.ServerVehicles = {}
    end
    OCarDealer:SaveCars()
end

function OCarDealer:InitializePlayer(ply)
if !(ONX:IsTableNil(OCarDealer.ServerVehicles)) then
local playertablet = OCarDealer:GetPlayerGarage(ply)
for k,v in pairs(OCarDealer.ServerVehicles) do
	for a,b in pairs(playertablet) do
		if (v.Entityname == b.Entityname) and (v.ID == b.ID) then
			b.ingame = true
		end
	end
end

for k,v in pairs(playertablet) do 
	if not v.ingame == true then
table.remove(playertablet,k)	
OCarDealer:ConsolePrint("A vehicle removed from "..ply:Name().."'s inventory.")
	end
v.ingame = nil
end
				
	        local newtable = util.TableToJSON(playertablet,true)
	        SavePlayerData(ply,newtable)
    else
    local playertablets = OCarDealer:GetPlayerGarage(ply)
        if !(ONX:IsTableNil(playertablets)) then
		SavePlayerData(ply,"")
            OCarDealer:ConsolePrint("Data reset.")
        end
    end
if IsValid(ply.vehicle) then
	ply.vehicle:Remove()
end
ply:SetActiveCar(nil,nil)

end	


local function serverstart()
if !(file.Exists("ocardealer/dealerdata","DATA")) then
    file.CreateDir("ocardealer/dealerdata")
end 
OCarDealer:CreateDealers()
OCarDealer:CreateParks()
OCarDealer:InitializeCars()

end
hook.Add("InitPostEntity","npcdatasystem",serverstart)  

local function aftercleanup()
OCarDealer:CreateDealers()
OCarDealer:CreateParks()
OCarDealer:InitializeCars()

end
hook.Add("PostCleanupMap","ocardealeraftercleanup",aftercleanup)  



function OCarDealer:CreateNPC(ply,name)
    if ply:IsSuperAdmin() then
        if ply:IsInWorld() and (ply:IsOnGround()) then
        local pos = ply:GetPos()
        if checkents(pos) then
        table.SortByMember( entitytable, "ID" )
        local ent = ents.Create("ocardealer_npc")
        ent:SetPos(ply:GetPos())
        ent:SetAngles(ply:GetAngles())
        if entitytable[1] then
        ent:SetNW2Int("NPCID",entitytable[1].ID+1)
    else
        ent:SetNW2Int("NPCID",1)
    end
        ent:SetModel("models/humans/group01/female_01.mdl")
                ent:DropToFloor()
        ent:SetDealerName(name)
        ent:Spawn()
        ent:Activate()

        local entitydata = {}
        entitydata.Pos = ent:GetPos()
        entitydata.Angles = ent:GetAngles()
        entitydata.ID = ent:ReturnID()
        entitydata.Spawns = {}
        entitydata.Name = name
        entitydata.Model = "models/humans/group01/female_01.mdl"
        table.insert(entitytable,entitydata)
        OCarDealer:savedealers()
        ply:ChatPrint("You created a npc with ID :"..ent:ReturnID())
    else
        ply:ChatPrint("Not Enough area for npc!")
    end
else
    ply:ChatPrint("You have to be on ground!")
end
else
    ply:ChatPrint("You have to be Superadmin!")
end
end
local function createnpc(ply,cmd,args)
	if (args[1] != nil) then
OCarDealer:CreateNPC(ply,args[1])
else
	OCarDealer:CreateNPC(ply,"OCarDealer")
end
end
concommand.Add("ocardealer_dealer_create",createnpc)



function OCarDealer:Savenpc(ent)
table.SortByMember( entitytable, "ID" )
    if OCarDealer:IsDealer(ent) then
        for k1,v1 in pairs(entitytable) do
            if (v1.ID == ent:ReturnID() ) then
            v1.Pos = ent:GetPos()
            v1.Angles = ent:GetAngles()
            local spawns =  {}
            for k,v in pairs(ent:ReturnParks()) do
                if v:IsValid() then
            local spawn = {}
            spawn.Pos = v:GetPos()
            spawn.Ang = v:GetAngles()
            table.insert(spawns, spawn)
        end
        end
            v1.Spawns = spawns
            v1.Name = ent:GetDealerName()
            v1.Model = ent:GetModel()
        end
    end
end
OCarDealer:savedealers()
end
local function savenpcs(ply,cmd,args)
for k,v in pairs(ents.GetAll()) do
    if OCarDealer:IsDealer(v) then
        OCarDealer:Savenpc(v)
        ply:ChatPrint("You saved a NPC with ID :"..v:ReturnID())
    end
end

end
concommand.Add("ocardealer_dealer_save",savenpcs)


function OCarDealer:DeleteNPC(pl,id)
if pl:IsSuperAdmin() then
    table.SortByMember( entitytable, "ID" )
    for k,v in pairs(entitytable) do
    if v.ID == id then
        for a1,b1 in pairs(ents.GetAll()) do
            if (OCarDealer:IsDealer(b1)) and (b1:ReturnID() == v.ID) then
            	  for a2,b2 in pairs(b1:ReturnParks()) do
                	b2:Remove()
                end
                b1:Remove()
            end
        end
        table.remove(entitytable,k)
        OCarDealer:savedealers()
        pl:ChatPrint("You deleted the npc with "..id.." ID.")

    end
end

        for k,v in pairs(OCarDealer.ServerVehicles) do
        	if table.HasValue(v.Dealers, id) then
        		table.RemoveByValue(v.Dealers, id)
        	end
        end
        OCarDealer:SaveCars()
end
end

net.Receive("OCCDealer-DeleteNPC",function(len,ply)
	if ONX:NetSpamCheck("OCCDealer-DeleteNPC") == false then return ply:ChatPrint("Stop spamming net messages!") end
if ply:IsSuperAdmin() then
    local onusedealer = ply:GetNW2Entity("Editingthisdealer")
    if OCarDealer:IsDealer(onusedealer) then
    	local id = onusedealer:ReturnID()
    OCarDealer:DeleteNPC(ply,id)
end
  end
end)


