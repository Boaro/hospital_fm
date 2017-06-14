---------- VARIABLES ----------


local treatment = false


local time = false


---------- FONCTIONS ----------


function Notify(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(false, false)
end


function ShowInfo(text, state)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)DisplayHelpTextFromStringLabel(0, state, 0, -1)
end


---------- CITIZEN ----------

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        DrawMarker(0, 338.85, -1394.56, 31.51, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
	local blip = AddBlipForCoord(338.85,-1394.56,31.51)
	SetBlipSprite(blip,80)
        SetBlipColour(blip,1)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Hospital')
	EndTextCommandSetBlipName(blip)
	SetBlipAsShortRange(blip,true)
        SetBlipAsMissionCreatorBlip(blip,true)
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
	if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 338.85,-1394.56,32.50, true) <= 2 then
            ShowInfo('Press ~INPUT_VEH_HORN~ to be treated by a doctor ~r~(~h~~g~500$~r~)', 0)
            if (IsControlJustPressed(1,38)) and (GetEntityHealth(GetPlayerPed(-1)) < 200) and (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 338.85,-1394.56,32.50, true) <= 2) then
                Notify("A ~h~~g~doctor ~s~will ~h~~r~treat~s~ you, ~h~~b~be patient~s~.")
                treatment = true
            end
        end
        if treatment == true then
	        Citizen.Wait(15000)
            time = true
	    end
        if treatment == true and time == true and (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 338.85,-1394.56,32.50, true) <= 2) then
            TriggerServerEvent('hopital:prix')
            SetEntityHealth(GetPlayerPed(-1), 200)
            Notify("A ~h~~g~doctor ~h~~r~treated~s~ you.")
            treatment = false
            time = false
        end
        if treatment == true and time == true and (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 338.85,-1394.56,32.50, true) > 2) then
            Notify("You have ~h~~r~moved away~s~, the ~h~~g~doctor~s~ could not ~h~~r~heal~s~ you!")
            treatment = false
            time = false            
        end        
	end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if (IsControlJustPressed(1,38)) and (GetEntityHealth(GetPlayerPed(-1)) == 200) and (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 338.85,-1394.56,32.50, true) <= 2) then
        	Notify("You don't need ~h~~r~treatment~s~.")
        end
    end
end)


---------- CREATE BY BOARO ----------


---------- RUINER ISLAND ----------
