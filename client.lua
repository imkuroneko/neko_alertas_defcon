local QBCore = exports['qb-core']:GetCoreObject()
lib.locale()
local defconMenu = {}
PlayerLoaded = false

-- ===== Armar estructura del menú
defconMenu = {
    id    = 'defcon_status',
    title = locale('menu_title'),
    options = {
        {
            title = locale('menu_title_green'),
            description = locale('menu_description_green'),
            icon = 'fas fa-fw fa-circle',
            iconColor = '#82ba3d',
            serverEvent = 'neko_alertasdefcon:server:change_status',
            args = { status = 'g' }
        },
        {
            title = locale('menu_title_yellow'),
            description = locale('menu_description_yellow'),
            icon = 'fas fa-fw fa-circle',
            iconColor = '#edcf55',
            serverEvent = 'neko_alertasdefcon:server:change_status',
            args = { status = 'y' }
        },
        {
            title = locale('menu_title_red'),
            description = locale('menu_description_red'),
            icon = 'fas fa-fw fa-circle',
            iconColor = '#e3203d',
            serverEvent = 'neko_alertasdefcon:server:change_status',
            args = { status = 'r' }
        }
    }
}

lib.registerContext(defconMenu)

-- ===== Armar estructura del menú de alertas
RegisterNetEvent('neko_alertas_defcon:client:open_menu')
AddEventHandler('neko_alertas_defcon:client:open_menu', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        if PlayerData.job.type ~= 'leo' then
            lib.notify({ description = locale('player_not_police') , type = 'error' })
        else
            if not PlayerData.job.onduty then
                lib.notify({ description = locale('player_not_duty') , type = 'error' })
            else
                lib.showContext(defconMenu.id)
            end
        end
    end)
end)

-- ===== Enviar el evento de estado al cliente de los jugadores
RegisterNetEvent('neko_alertas_defcon:client:set_current_status')
AddEventHandler('neko_alertas_defcon:client:set_current_status', function(data)
    if PlayerLoaded then
        SendNUIMessage({ alert = data.status })
    else
        SendNUIMessage({ alert = 'g' })
    end
end)



RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerLoaded = true
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerLoaded = false
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    PlayerLoaded = true
end)