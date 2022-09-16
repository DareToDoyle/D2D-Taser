ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterUsableItem('tasercart', function(source)
	local source = source
	local xPlayer  = ESX.GetPlayerFromId(source)

    TriggerClientEvent("d2d-taser", source)
	
end)

RegisterNetEvent("d2d-cartcheck")
AddEventHandler("d2d-cartcheck", function()
local source = source
local xPlayer  = ESX.GetPlayerFromId(source)

xPlayer.removeInventoryItem('tasercart', 1)

end)