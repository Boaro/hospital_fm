require "resources/essentialmode/lib/MySQL"
MySQL:open("127.0.0.1", "gta5_gamemode_essential", "root", "toor")

RegisterServerEvent('hospital:price')
AddEventHandler('hospital:price', function()
  	local price = 500
	TriggerEvent('es:getPlayerFromId', source, function(user)
  	user:removeMoney((price))
 	end)
end)