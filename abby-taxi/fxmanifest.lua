fx_version 'adamant'

game 'gta5'

description "Abigail's Taxi Job"

version '0.1'

client_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'config.lua',
	'client.lua',
	'locales/en.lua',
	}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'config.lua',
	'server.lua',
}

ui_page "nui/meter.html"

files {
	"nui/digital-7.regular.ttf",
	"nui/meter.html",
	"nui/meter.css",
	"nui/meter.js",
	'nui/img/phone.png',
	'nui/img/fare1.png',
	'nui/img/fare2.png',
	'nui/img/*.png',
}
dependency 'es_extended'

