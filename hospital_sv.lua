require "resources/essentialmode/lib/MySQL"
MySQL:open("127.0.0.1", "gta5_gamemode_essential", "root", "")

RegisterServerEvent('hopital:prix')
AddEventHandler('hopital:prix', function()
  	local prix = 500
	TriggerEvent('es:getPlayerFromId', source, function(user)
  	user:removeMoney((prix))
 	end)
end)