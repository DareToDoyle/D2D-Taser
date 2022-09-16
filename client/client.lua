MaxAmmo = Config.Cartridges -- The amount of taser cartridges a person can have.

local ShotsRemaining = MaxAmmo


RegisterNetEvent("d2d-taser")
AddEventHandler("d2d-taser", function()
        
		if ShotsRemaining <= 0 then
		exports['okokNotify']:Alert('AXON Taser', 'Refilling taser. Please wait '..Config.ReloadTime..' seconds', 5000, 'warning')
		TriggerServerEvent("d2d-cartcheck") -- Only uses item if you have 0 cartridges.
        
		Citizen.Wait(Config.ReloadTime * 1000)
        
		ShotsRemaining = MaxAmmo
        exports['okokNotify']:Alert('AXON Taser', 'Taser Cartridges refilled.', 5000, 'warning')
		else
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = GetPlayerPed(-1)
        local taserModel = GetHashKey("WEAPON_STUNGUN")

        if Config.CustomTime == true then
            SetPedMinGroundTimeForStungun(ped, Config.Time * 1000)
        end

        if GetSelectedPedWeapon(ped) == taserModel then
            if IsPedShooting(ped) then
                ShotsRemaining = ShotsRemaining - 1
				exports['okokNotify']:Alert('AXON Taser', 'You have '..ShotsRemaining..' cartridge(s) left.', 5000, 'warning')
            end
        end

        if ShotsRemaining <= 0 then -- Stops player from firing.
            if GetSelectedPedWeapon(ped) == taserModel then
                SetPlayerCanDoDriveBy(ped, false)
                DisablePlayerFiring(ped, true)
            else
               
            end
        end

        
    end
end)

Citizen.CreateThread(function() -- Reload Notification
    while true do
       Citizen.Wait(0)
        local ped = GetPlayerPed(-1)
        local taserModel = GetHashKey("WEAPON_STUNGUN")

        if ShotsRemaining <= 0 then
            if GetSelectedPedWeapon(ped) == taserModel and IsControlJustReleased(0, 106) then
                    exports['okokNotify']:Alert('AXON Taser', 'Reload your taser.', 5000, 'warning')
					Citizen.Wait(5000)
                end
            else
               
            end
        end

end)
