function OCarDealer:GetUserGroups()
	local usergtable = {}
	if serverguard  then
		for k, v in pairs( serverguard.ranks:GetStored() ) do
			table.insert( usergtable, v.uniqueID )
		end
	elseif CAMI then
		for k, v in pairs( CAMI:GetUsergroups() ) do
			table.insert( usergtable, v.Name )
		end
	end

	return usergtable
end

function OCarDealer:GetJobs()
	local jobtable = {}
	for k,v in pairs(RPExtraTeams) do
		table.insert(jobtable,v)
	end
	return jobtable
end

function OCarDealer:CurrencyMoney(int)
	if DarkRP then
currency = DarkRP.formatMoney(int)
else
	currency = tostring(int).."$"
end
return currency
end

function OCarDealer:AddLanguage(ltable,name)
OCarDealer.LANGUAGES[name] = ltable
end

local metas = FindMetaTable("Player")

function metas:CanSee(dealer)
	ent = self:GetNW2Entity("canseethisdealersparks")
    if ent == dealer then
      return  true
  else
  	return false
    end
end

