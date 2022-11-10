fx_version 'adamant'

game 'gta5'

description "Abigail's Taxi Job - Admin Panel"

version '0.1'

client_scripts {
	'@oxmysql/lib/MySQL.lua',
    'client.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
    'server.lua',
}

ui_page "nui/admin.html"

files {
	"nui/admin.html",
	"nui/admin.css",
	"nui/admin.js",
	'nui/img/*.png',
}
dependency 'es_extended'
dependency 'abby-taxi'