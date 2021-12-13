fx_version 'cerulean'
games { 'gta5' }

author 'Sulivan .W#0001'
description 'Teleportation script'
version '1.0.0'

dependency "essentialmode"

client_script {
	'steam/client.lua',
	'steam/gui.lua',
	'config.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua'
}