AddCSLuaFile()

OCarDealer.CONFIG = OCarDealer.CONFIG or {}


OCarDealer.CONFIG.SpecialButtons = {
	{
		Name = "Test",   ---- Name will be shown at the button.
		Func = function() gui.OpenURL("https://steamcommunity.com/sharedfiles/filedetails/?id=1937630727") end,
		Desc = "Test",
		Imagelink = "https://g7.pngresmi.com/preview/59/860/56/computer-icons-steam-black-white-desktop-wallpaper-heartbound-steam-icon.jpg"
	},
}

OCarDealer.CONFIG.ClientTitle = "ONX'S CUSTOMIZABLE CAR DEALER"

OCarDealer.CONFIG.NPCTITLECOLOR = color_white

OCarDealer.CONFIG.NPCTITLEOUTLINECOLOR = Color( 0, 0, 0, 255 )

OCarDealer.CONFIG.SHOWPARKTITLE = false


OCarDealer.CONFIG.SellCars = true
if SERVER then
OCarDealer.CONFIG.SellingPercentage = 0.5  /// Means half, if you want to do %100 make it 1 
end


