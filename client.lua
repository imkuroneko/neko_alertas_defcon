local QBCore = exports['qb-core']:GetCoreObject()

-- ===== Armar estructura del menú de alertas
RegisterNetEvent('neko_alertaslspd:client:openMenu')
AddEventHandler('neko_alertaslspd:client:openMenu', function()
    exports['qb-menu']:openMenu({
        { header = '⠀⠀⠀⠀⠀⠀⠀🚓 Estado de Alertas', isMenuHeader = true },
        { header = '🟢 ⠀Alerta Verde', txt = '', params = { event = 'neko_alertaslspd:client:setAlertaVerde:Parametro' } },
        { header = '🟡 ⠀Alerta Amarilla', txt = '', params = { event = 'neko_alertaslspd:client:setAlertaAmarilla:Parametro' } },
        { header = '🔴 ⠀Alerta Roja', txt = '', params = { event = 'neko_alertaslspd:client:setAlertaRoja:Parametro' } },
        {
            header = '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀❌ Cerrar',
            params = { event = 'qb-menu:client:closeMenu' }
        },
    })
end)

-- ===== Definir del lado de servidor el estado actual
RegisterNetEvent('neko_alertaslspd:client:setAlertaVerde:Parametro')
AddEventHandler('neko_alertaslspd:client:setAlertaVerde:Parametro', function()
    TriggerServerEvent('neko_alertaslspd:server:setAlertaVerde')
end)

RegisterNetEvent('neko_alertaslspd:client:setAlertaAmarilla:Parametro')
AddEventHandler('neko_alertaslspd:client:setAlertaAmarilla:Parametro', function()
    TriggerServerEvent('neko_alertaslspd:server:setAlertaAmarilla')
end)

RegisterNetEvent('neko_alertaslspd:client:setAlertaRoja:Parametro')
AddEventHandler('neko_alertaslspd:client:setAlertaRoja:Parametro', function()
    TriggerServerEvent('neko_alertaslspd:server:setAlertaRoja')
end)

-- ===== Enviar el evento de estado al cliente de los jugadores
RegisterNetEvent('neko_alertaslspd:client:setAlertaVerde:Jugadores')
AddEventHandler('neko_alertaslspd:client:setAlertaVerde:Jugadores', function()
    SendNUIMessage({ type = 'logo', display = 'alerta_verde' })
end)

RegisterNetEvent('neko_alertaslspd:client:setAlertaAmarilla:Jugadores')
AddEventHandler('neko_alertaslspd:client:setAlertaAmarilla:Jugadores', function()
    SendNUIMessage({ type = 'logo', display = 'alerta_amarilla' })
end)

RegisterNetEvent('neko_alertaslspd:client:setAlertaRoja:Jugadores')
AddEventHandler('neko_alertaslspd:client:setAlertaRoja:Jugadores', function()
    SendNUIMessage({ type = 'logo', display = 'alerta_roja' })
end)