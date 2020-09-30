local meta = FindMetaTable("Player")
local entmeta = FindMetaTable("Entity") 

function meta:SetActiveCar(Car,name)
	if !(Car == nil) then
	if ((Car:IsValid()) and (Car:IsVehicle())) then
	self.ActiveVeh = Car
	self.ActiveVehName = name
end
else
	self.ActiveVeh = Car
	self.ActiveVehName = name
end
end

function meta:GetActiveCar()
	return self.ActiveVeh, self.ActiveVehName
end
function meta:SetUsingDealer(dealer)
	if !(dealer == nil) then
	if OCarDealer:IsDealer(dealer) then
		self.ActiveDeal = dealer
	end
else
	self.ActiveDeal = dealer
end
end
function meta:GetUsingDealer()
	return self.ActiveDeal
end

function meta:SetCanSee(dealer)
self:SetNW2Entity("canseethisdealersparks", dealer)

end   

function entmeta:vSetOwner(ply)
	if (ply:IsPlayer()) then
	entmeta.vowner = ply

	end
	end 
function entmeta:vGetOwner()

	return entmeta.vowner

end

function entmeta:vSetID(id)
if isnumber(id) then
	entmeta.vsid = id
end
end	

function entmeta:vGetID()

	return entmeta.vsid

end