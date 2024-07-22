local Framework = nil

Citizen.CreateThread(function()
    Framework = exports['qb-core']:GetCoreObject()
end)

RegisterNetEvent('ty-coinflip:client:FlipCoin')
AddEventHandler('ty-coinflip:client:FlipCoin', function()
    local playerPed = PlayerPedId()

    -- Play coin flip animation
    RequestAnimDict("anim@mp_player_intcelebrationmale@coin_roll_and_toss")
    while not HasAnimDictLoaded("anim@mp_player_intcelebrationmale@coin_roll_and_toss") do
        Citizen.Wait(100)
    end
    TaskPlayAnim(playerPed, "anim@mp_player_intcelebrationmale@coin_roll_and_toss", "coin_roll_and_toss", 8.0, -8.0, -1, 0, 0, false, false, false)

    -- Wait for animation to finish
    Citizen.Wait(GetAnimDuration("anim@mp_player_intcelebrationmale@coin_roll_and_toss", "coin_roll_and_toss") * 1000)

    -- Show result
    local result = math.random(2) == 1 and Config.Locale.heads or Config.Locale.tails
    if Config.Display3DTextEnabled then
        TriggerServerEvent('ty-coinflip:server:Show3DText', GetPlayerServerId(PlayerId()), result)
    end
    if Config.NotifySelfEnabled then
        NotifyPlayer(string.format(Config.Locale.coin_flip, result))
    end
    if Config.NotifyNearbyEnabled then
        TriggerServerEvent('ty-coinflip:server:NotifyNearby', GetEntityCoords(playerPed), result)
    end

    -- Add coin back to inventory
    TriggerServerEvent('ty-coinflip:server:AddCoinBack')
end)

RegisterNetEvent('ty-coinflip:client:Show3DText')
AddEventHandler('ty-coinflip:client:Show3DText', function(playerId, text)
    local displayTime = Config.DisplayTime
    local endTime = GetGameTimer() + displayTime

    Citizen.CreateThread(function()
        while GetGameTimer() < endTime do
            Citizen.Wait(0)
            local playerPed = GetPlayerPed(GetPlayerFromServerId(playerId))
            local coords = GetPedBoneCoords(playerPed, 31086) -- Get the head bone coordinates
            local playerCoords = GetEntityCoords(PlayerPedId())
            if #(playerCoords - coords) <= Config.DisplayRange then
                DrawText3D(coords.x, coords.y, coords.z + 0.5, text)
            end
        end
    end)
end)

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
        local factor = (string.len(text)) / 370
        DrawRect(_x, _y + 0.0150, 0.015 + factor, 0.03, 0, 0, 0, 75)
    end
end

function NotifyPlayer(msg)
    Framework.Functions.Notify(msg, "success")
end
