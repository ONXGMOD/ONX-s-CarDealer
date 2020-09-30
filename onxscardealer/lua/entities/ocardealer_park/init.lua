AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" )  

include('shared.lua')



function ENT:Initialize()

 
    self:SetModel( "models/hunter/plates/plate3x6.mdl" )
    
    self:PhysicsInit( SOLID_VPHYSICS )
    self:SetMoveType( MOVETYPE_VPHYSICS )   
    self:SetSolid( SOLID_VPHYSICS )       
    self:SetUseType(SIMPLE_USE)
    self:SetCollisionGroup(COLLISION_GROUP_WORLD)


    local phys = self:GetPhysicsObject()
    if (phys:IsValid()) then
        phys:Wake()
    end
    self:DropToFloor()
end


 
function ENT:SetParkOwner(ply)
    if ply then 
        self:SetNW2Int("playerusing",ply)
    else
        self:SetNW2Int("playerusing",nil)
    end
end

function ENT:IsAvailable()
	local startp = self:GetPos()
	local endp = self:GetPos()+self:GetUp()*95
	local maxp = self:OBBMaxs()
	local minp = self:OBBMins()

	local traceh = util.TraceHull( {
		start = startp,
		endpos = endp,
		maxs =  maxp,
		mins = minp,
		filter = self
	} )

	if (traceh.Entity == NULL) or (traceh.Entity == self) then
		return true
	else
			return false
	end
end	


local function Playerpickit( ply, ent )
    if (ent:GetClass() == "ocardealer_park") then
        if  (ply:CanSee(ent:GetNW2Entity("Parkbelongs")) == true) then
        return true
    else
        return false
    end
end

end
hook.Add( "PhysgunPickup", "OCarDealer_CanPick", Playerpickit )






  