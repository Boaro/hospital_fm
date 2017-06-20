---------- VARIABLES ----------


local treatment = false


local timer = false


local blips = {
  {name="Hospital", id=80, x= 338.85, y= -1394.56, z= 31.51, color= 1},
  {name="Hospital", id=80, x= -449.67, y= -340.83, z= 33.50, color= 1},
}


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
  for _, item in pairs(blips) do
    item.blip = AddBlipForCoord(item.x, item.y, item.z)
    SetBlipSprite(item.blip, item.id)
    SetBlipColour(item.blip, item.color)
    SetBlipAsShortRange(item.blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(item.name)
    EndTextCommandSetBlipName(item.blip)
  end
end)


Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    for _, item in pairs(blips) do
	  if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), item.x, item.y, item.z, true) <= 20 then
        DrawMarker(0, item.x, item.y, item.z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), item.x,item.y,item.z, true) <= 2 then
          ShowInfo('Pres ~INPUT_VEH_HORN~ to be treated ~r~(~h~~g~500$~r~)', 0)
          if (IsControlJustPressed(1,38)) and (GetEntityHealth(GetPlayerPed(-1)) < 200) and (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), item.x, item.y, item.z, true) <= 2) then
            Notify("A ~h~~g~doctor ~s~will ~h~~r~treat~s~ you, ~h~~b~be patient~s~.")
            treatment = true
          end
        end
      end
      if (IsControlJustPressed(1,38)) and (GetEntityHealth(GetPlayerPed(-1)) == 200) and (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), item.x, item.y, item.z, true) <= 2) then
        Notify("You don't need ~h~~r~treatment~s~.")
      end
      if treatment == true then
	    Citizen.Wait(15000)
        timer = true
	  end
      if treatment == true and timer == true and (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), item.x, item.y, item.z, true) <= 2) then
        TriggerServerEvent('hospital:price')
        SetEntityHealth(GetPlayerPed(-1), 200)
        Notify("A ~h~~g~doctor ~h~~r~treated~s~ you.")
        treatment = false
        timer = false
      end
      if treatment == true and timer == true and (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), item.x, item.y, item.z, true) > 2) then
        Notify("You have ~h~~r~moved away~s~, the ~h~~g~doctor~s~ could not ~h~~r~heal~s~ you!")
        treatment = false
        timer = false            
      end
    end 
  end       
end)


---------- CREATE BY BOARO ----------


---------- RUINER ISLAND ----------