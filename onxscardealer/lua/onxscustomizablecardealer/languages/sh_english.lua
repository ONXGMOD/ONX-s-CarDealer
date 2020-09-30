
local languagen = {}


languagen.close = "Close"
languagen.price = "Price"
languagen.description = "Description"
languagen.nodescription = "No Description."
languagen.modify = "MODIFY"
languagen.buy = "BUY"
languagen.shop = "SHOP"
languagen.spawn = "SPAWN"
languagen.sell = "SELL"
languagen.tuning = "TUNING"
languagen.paint = "PAINT"
languagen.respray = "RESPRAY"
languagen.accept = "ACCEPT"
languagen.garage = "GARAGE"
languagen.novehicleserver = "No vehicles at dealer! To add, you can use Settings>Dealer Settings!"
languagen.donthave = "You haven't got a car!"
languagen.onlythisug = "Only for this usergroups :"
languagen.onlythisjbs = "Only for this jobs :"
languagen.recall = "RECALL"
languagen.shopbdc = "You can buy cars here!"
languagen.garagebdc = "You can check your garage here!"
languagen.skin = "SKIN"
languagen.settings = "SETTINGS"
languagen.serverset = "Server Settings"
languagen.clientset = "Client Settings"
languagen.search = "Search..."

languagen.notifymessage= {
	["boughtcar"] = "You bought a vehicle for %s !",
["araceklendi"] = "You added vehicle to server!",
["modifiedcar"] = "You modified your car!",
 ["uleftsomethingwrong"] = "You left somtehing empty!",
  ["parksarebusy"] = "All the parks are busy of this dealer!",
   ["alreadyonecarspawned"] = "You already spawned a car!",
["cantmodify"] = "You can't modify your car!",
["vehiclecantrecalled"] = "Your car isn't close any park!",
["savedvehicle"] = "You saved a vehicle!",
["savednpc"] = "You saved a NPC!",
["nomoney"] = "You can't afford this!",
["cantusejob"] = "You can't use this car with this job!",
["cantuseplygroup"] = "You don't have right to buy this.",
["deletedvehicle"] = "You deleted a vehicle from system!",
["spawnedvehicle"] = "You successfully spawned your vehicle!",
["recalledvehicle"] = "You successfully recalled your vehicle!",
["selledvehicle"] = "You sold your vehicle for %s !"
}

OCarDealer:AddLanguage(languagen,"English")