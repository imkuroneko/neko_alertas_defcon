fx_version  'cerulean'
game        'gta5'
lua54       'yes'
-- ===========================================================
description 'Sistemas de alertas (DEFCON) para la policía'
author      'KuroNeko'
-- ===========================================================
version     '1.1.0'

-- ===========================================================
shared_scripts { '@ox_lib/init.lua' }
server_scripts { 'config.lua', 'server.lua' }
client_scripts { 'client.lua' }

ui_page        'ui/index.html'
files          { 'locales/*.json', 'ui/**' }
