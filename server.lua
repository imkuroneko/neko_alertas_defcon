local filePath = GetResourcePath(GetCurrentResourceName()).."/data.json"
local QBCore = exports['qb-core']:GetCoreObject()

lib.locale()
DefconCurrentStatus = nil

-- ===== Registrar comando
lib.addCommand(Config.Command, { help = locale('command_help'), params = {} }, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)

    if Player and Player.PlayerData.job.name == 'police' then
        if Player.PlayerData.job.onduty then
            TriggerClientEvent('neko_alertas_defcon:client:open_menu', source)
        else
            TriggerClientEvent('ox_lib:notify', source, { description = locale('player_not_duty') , type = 'error' })
        end
    else
        TriggerClientEvent('ox_lib:notify', source, { description = locale('player_not_police') , type = 'error' })
    end
end)

-- ===== Evento
RegisterServerEvent('neko_alertasdefcon:server:change_status')
AddEventHandler('neko_alertasdefcon:server:change_status', function(data)
    local src = source
    if data.status ~= 'g' and data.status ~= 'y' and data.status ~= 'r' then return end

    if data.status == DefconCurrentStatus then
        TriggerClientEvent('ox_lib:notify', source, { description = locale('update_status_current') , type = 'info' })
    else
        UpdateLatestStatus(data.status)

        TriggerClientEvent('ox_lib:notify', source, { description = locale('update_status_success') , type = 'success' })
        DefconCurrentStatus = data.status
        SendWebhookPublic()
        SendWebhookLog(src)
    end
end)

-- ===== Thread
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        TriggerClientEvent('neko_alertas_defcon:client:set_current_status', -1, { status = DefconCurrentStatus })
    end
end)

-- ===== On Script Start
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    DefconCurrentStatus = GetLatestStatus()
    print("^5El script ha cargado exitosamente")
end)

-- ===== Funciones
function SendWebhookPublic()
    local t, m, c = '', '', 0
    if DefconCurrentStatus == 'r' then
        t = 'webhook_public_title_red'
        m = 'webhook_public_description_red'
        c = 14884925
    elseif DefconCurrentStatus == 'y' then
        t = 'webhook_public_title_yellow'
        m = 'webhook_public_description_yellow'
        c = 15585109
    else
        t = 'webhook_public_title_green'
        m = 'webhook_public_description_green'
        c = 8567357
    end

    SendContentToDiscord(Config.webhookPublic, true, {
        { ['title'] = locale(t), ['description'] = locale(m), ['color'] = c, ['timestamp'] = os.date("!%Y-%m-%dT%H:%M:%SZ", os.time()) }
    })
end

function SendWebhookLog(source)
    local officer = QBCore.Functions.GetPlayer(source)

    local name   = officer.PlayerData.charinfo.firstname..' '..officer.PlayerData.charinfo.lastname
    local cid    = officer.PlayerData.citizenid
    local title  = 'placeholder'

    if DefconCurrentStatus == 'r' then
        title = locale('webhook_public_title_red')
    elseif DefconCurrentStatus == 'y' then
        title = locale('webhook_public_title_yellow')
    else
        title = locale('webhook_public_title_green')
    end


    SendContentToDiscord(Config.webhookLogs, false, {
        { ['title'] = locale(title), ['description'] = locale('webhook_log_description', name, cid), ['color'] = 3191259, ['timestamp'] = os.date("!%Y-%m-%dT%H:%M:%SZ", os.time()) }
    })
end

function SendContentToDiscord(webhookUrl, tagEveryone, embedContent)
    if DefconCurrentStatus ~= 'r' and DefconCurrentStatus ~= 'g' and DefconCurrentStatus ~= 'y' then return end
    if not webhookUrl or webhookUrl == '' or webhookUrl == nil then return end

    local contentData = {}

    contentData['embeds'] = embedContent

    if tagEveryone then contentData['content'] = '@everyone' end

    PerformHttpRequest(webhookUrl, function(e, t, h) end, 'POST', json.encode(contentData), { ['Content-Type'] = 'application/json' })
end

-- ===== Persistance ♥
function GetLatestStatus()
    local file = io.open(filePath, "r")
    if file then
        local contents = file:read("*a")
        contents = json.decode(contents);
        io.close(file)
        return contents.status
    else
        file = io.open(filePath, "w+")
        file:write(json.encode({ status = 'g' }, { indent = true }))
        io.close(file)

        return 'g'
    end
end

function UpdateLatestStatus(newStatus)
    local file = io.open(filePath, "w+")
    file:write(json.encode({ status = newStatus }, { indent = true }))
    io.close(file)
    DefconCurrentStatus = newStatus
end