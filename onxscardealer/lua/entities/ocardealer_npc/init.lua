AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" )  

include('shared.lua')



function ENT:Initialize()

    self.vehicles = {}
    self.parks = {}
    self:SetHullType( HULL_HUMAN )
    self:CapabilitiesAdd( CAP_ANIMATEDFACE)
    self:CapabilitiesAdd(  CAP_TURN_HEAD  )
    self:SetHullSizeNormal()
    self:SetNPCState( NPC_STATE_SCRIPT )
    self:SetSolid(  SOLID_BBOX ) 

    self:SetUseType( SIMPLE_USE ) 
    self:DropToFloor()
end

function ENT:OpenPanel(ply)
jisontotable = OCarDealer:GetPlayerGarage(ply)
local npcvehicles = self.vehicles
local s,activearac = ply:GetActiveCar()
if !(activearac) then
    activearac = ""
end

        net.Start("OCCDealer-OpenPanel")
        net.WriteTable(jisontotable)
        net.WriteTable(npcvehicles)
        net.WriteString(activearac)
        net.Send(ply)
	    ply:SetUsingDealer(self)   


end

function ENT:AcceptInput( Name, Activator, Caller )
    if (Name == "Use") and (Caller:IsPlayer()) then
        self:OpenPanel(Caller)
        end    
end

function ENT:IsExistsShop(entityname,id)
local svehicles = self.vehicles

for k,v in pairs(svehicles) do
if (v.Entityname == entityname) and (v.ID == id ) then
    return true end
end
end
function ENT:ParksAdd(park)
    if not (table.HasValue(self.parks, park)) then
    self.parks[table.Count(self.parks)+1] = park
end
end

function ENT:ReturnParks()
    return self.parks
end


function ENT:AddVehicle(vehicle)
self.vehicles[#self.vehicles+1] = vehicle
end

function ENT:SetDealerName(name)
    self:SetNW2String("dealername", name)
end

function ENT:HasVehicle(entityname,id)
local count = 0
for k,v in pairs (self.vehicles) do
    if (v.Entityname == entityname) and (v.ID == id) then
count = count +1
end
end
if count>0 then
    return true

else
    return false
end
end

function ENT:IsEntCloseParks(ent)
    for k,v in pairs(self.parks) do
        if v:GetPos():Distance(ent:GetPos()) < 400 then
            return true
        end
    end
end

function ENT:GetAvailablePark()
    local chosenent = nil
    for k,v in pairs(self.parks) do
        if v:IsAvailable() then
            chosenent = v
            break
        end
    end
    if !(chosenent == nil) then
        return chosenent
    else
        return false
    end
end

function ENT:RemoveVehicle(vehicle)
    for k,v in pairs(self.vehicles) do
        if (v.ID == vehicle.ID) and (v.Entityname == vehicle.Entityname) then
            table.remove(self.vehicles, k)
        end
    end
end

  
function ENT:DeletePark(park)
    for k,v in pairs(self.parks) do
        if v == park then
            table.remove(k)
        end
    end
end

net.Receive("OCCDealer-ClosePanel", function(len,ply)
    local panelid = net.ReadString()
    if panelid == "DealerSettings" then 
        ply:SetNW2Entity("Editingthisdealer",nil)
    elseif panelid == "ShopPanel" then      
ply:SetUsingDealer(nil)
end
end)

