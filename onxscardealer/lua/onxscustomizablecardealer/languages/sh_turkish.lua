
local languages = {}

languages.close = "KAPAT"
languages.price = "Fiyat"
languages.description = "Açıklama"
languages.nodescription = "Açıklaması yok."
languages.modify = "OZELLESTIR"
languages.buy = "SATIN AL"
languages.shop = "GALERI"
languages.spawn = "OLUSTUR"
languages.sell = "SAT"
languages.tuning = "TUNING"
languages.paint = "BOYAMA"
languages.respray = "BOYA"
languages.accept = "KABUL ET"
languages.garage = "GARAJ"
languages.novehicleserver = "Galeriye araç eklenmemiş! Eklemek için Ayarlar>Sunucu Ayarlarını kullanın!"
languages.donthave = "Aracin yok!"
languages.onlythisug = "Uygun Yetkiler:"
languages.onlythisjbs = "Uygun Meslekler:"
languages.recall = "CAGIR"
languages.shopbdc = "Araç Galerisi!"
languages.garagebdc = "Garajın!"
languages.skin = "CILT"
languages.settings = "AYARLAR"
languages.serverset = "Sunucu Ayarlari"
languages.clientset = "Istemci Ayarlari"
languages.search= "Ara..."


languages.notifymessage= {
	["boughtcar"] = "Araci %s fiyata satin aldin!",
["araceklendi"] = "Arac sunucuya eklendi!",
["modifiedcar"] = "Aracini ozellestirdin!",
 ["uleftsomethingwrong"] = "Bir seyleri doldurmamissin!",
  ["parksarebusy"] = "Olusturacak musait park yok!",
   ["alreadyonecarspawned"] = "Zaten arac olusturmussun!",
["cantmodify"] = "Aracini ozellestiremezsin!",
["vehiclecantrecalled"] = "Aracin hicbir parka yakin degil!",
["savedvehicle"] = "Arac bilgisini kaydettin!",
["savednpc"] = "NPC kaydettin!",
["nomoney"] = "Bunu karsilayamazsin!",
["cantusejob"] = "Bu araci bu meslekle kullanamazsin!",
["cantuseplygroup"] = "Bu araci alacak yetkin yok!",
["deletedvehicle"] = "Sistemden aracı başarıyla sildin!",
["spawnedvehicle"] = "Başarıyla park yerinde aracını oluşturdun!",
["recalledvehicle"] = "Aracını başarıyla geri çağırdın!",
["selledvehicle"] = "Aracini %s fiyata sattin!"
}

OCarDealer:AddLanguage(languages,"Turkish")