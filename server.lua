local QBCore = exports['qb-core']:GetCoreObject()
local nivelAlertaActual = 0

RegisterCommand("alertaslspd", function(source)
    local Player = QBCore.Functions.GetPlayer(source)

    print("1")

    if Player and Player.PlayerData.job.name == 'police' then
        print("2")
        if Player.PlayerData.job.onduty then
            print("3")
            TriggerClientEvent("neko_alertaslspd:client:openMenu", source)
        else
            print("4")
            TriggerClientEvent('QBCore:Notify', source, 'No te encuentras de servicio')
        end
    else
        print("5")
        TriggerClientEvent('QBCore:Notify', source, 'No eres del cuerpo policial')
    end
end, false)

RegisterServerEvent('neko_alertaslspd:server:setAlertaVerde')
AddEventHandler('neko_alertaslspd:server:setAlertaVerde', function()
    nivelAlertaActual = 0
end)

RegisterServerEvent('neko_alertaslspd:server:setAlertaAmarilla')
AddEventHandler('neko_alertaslspd:server:setAlertaAmarilla', function()
    nivelAlertaActual = 1
end)

RegisterServerEvent('neko_alertaslspd:server:setAlertaRoja')
AddEventHandler('neko_alertaslspd:server:setAlertaRoja', function()
    nivelAlertaActual = 2
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if nivelAlertaActual == 0 then
            TriggerClientEvent('neko_alertaslspd:client:setAlertaVerde:Jugadores', -1)
        elseif nivelAlertaActual == 1 then
            TriggerClientEvent('neko_alertaslspd:client:setAlertaAmarilla:Jugadores', -1)
        elseif nivelAlertaActual == 2 then
            TriggerClientEvent('neko_alertaslspd:client:setAlertaRoja:Jugadores', -1)
        end
    end
end)
