ESX = nil
local PlayerData, startBlip, working = {}, nil, false

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)


Citizen.CreateThread(function()
    while ESX == nil do TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) Wait(0) end
    while ESX.GetPlayerData().job == nil do Wait(0) end
    PlayerData = ESX.GetPlayerData()
    while true do
        local me, sleep, hasjob = PlayerPedId(), 250, true
        if Config.Job['jobRequired'] then
            if PlayerData.job.name ~= Config.Job['jobName'] then
                hasjob = false
            end
        end
        if working then hasjob = false end
        if hasjob then
            if not DoesBlipExist(startBlip) then
                startBlip = addBlip(Config.JobCenter, 545, 0, Strings['start_job'])
            end
        else
            if DoesBlipExist(startBlip) then
                RemoveBlip(startBlip)
            end
        end
        local distance = GetDistanceBetweenCoords(GetEntityCoords(me), Config.JobCenter, true)
        if distance <= 25.0 and hasjob then
            sleep = 0
            DrawMarker(39, Config.JobCenter, vector3(0.0, 0.0, 0.0), vector3(0.0, 0.0, 0.0), vector3(1.0, 1.0, 1.0), 255, 0, 255, 150, false, false, 2, false, false, false)
            if distance <= 1.5 then
                helpText(Strings['e_browse_jobs'])
                if IsControlJustReleased(0, 38) then
                    TriggerServerEvent('esx_ets:jobMenu')
                end
            end
        end
        Wait(sleep)
    end
end)

RegisterNetEvent('esx_ets:start')
AddEventHandler('esx_ets:start', function(data, jobid)
    data.start = data.start[math.random(#data.start)]
    data.trailer = data.trailer[math.random(#data.trailer)]
    data.arrive = data.arrive[math.random(#data.arrive)]
    working = true
    local truck, trailer = loadVehicle(data.vehicles[1], data.start[1], data.start[2]), loadVehicle(data.vehicles[2], data.trailer[1], data.trailer[2])
    SetVehicleNumberPlateText(truck, ('XW  %02d%s%s'):format(math.random(1,99),string.char(math.random(97,122)),string.char(math.random(97,122))))
    local destinationBlip, truckBlip, trailerBlip = addBlip(data.arrive, 38, 3, Strings['destination'])
    local hasTrailer = false
    while true do
        if GetEntityCoords(trailer) == vector3(0,0,0) then -- If trailer can't spawn
            working = false
            text('Your trailer couldn\'t spawn properly, please start a new trucking job', 5000)
            if DoesBlipExist(truckBlip) then RemoveBlip(truckBlip) end
            if DoesBlipExist(trailerBlip) then RemoveBlip(trailerBlip) end
            if DoesBlipExist(destinationBlip) then RemoveBlip(destinationBlip) end
            Citizen.SetTimeout(60000, function()
                DeleteVehicle(truck)
                DeleteVehicle(trailer)
              end)
            return
        end
        if GetVehicleEngineHealth(truck) <= 150 then -- If truck is incapacitated
            working = false
            if DoesBlipExist(truckBlip) then RemoveBlip(truckBlip) end
            if DoesBlipExist(trailerBlip) then RemoveBlip(trailerBlip) end
            if DoesBlipExist(destinationBlip) then RemoveBlip(destinationBlip) end
            Citizen.SetTimeout(60000, function()
                DeleteVehicle(truck)
                DeleteVehicle(trailer)
              end)
            text(Strings['fail'], 5000)
            return
        end
        local sleep, distance = 250, GetDistanceBetweenCoords(data.arrive, GetEntityCoords(trailer), true)
        if not IsPedInVehicle(PlayerPedId(), truck, false) then
            text(Strings['get_to_truck'], 250)
            if not DoesBlipExist(truckBlip) then
                truckBlip = addBlip(GetEntityCoords(truck), 477, 5, Strings['truck']) 
                SetBlipRoute(truckBlip, true) 
            end
            if DoesBlipExist(trailerBlip) then RemoveBlip(trailerBlip) end
            if DoesBlipExist(destinationBlip) then RemoveBlip(destinationBlip) end
        else
            if not IsVehicleAttachedToTrailer(truck, trailer) then
                if not hasTrailer then
                    Citizen.CreateThread(function()
                        while not IsVehicleAttachedToTrailer(truck,trailer) and not hasTrailer do
                            DrawMarker(0, GetEntityCoords(trailer)+vector3(0.0,0.0,4.0), vector3(0.0, 0.0, 0.0), vector3(0.0, 0.0, 0.0), vector3(1.0, 1.0, 1.0), 255, 0, 255, 150, false, false, 2, false, false, false)
                            Wait(0)
                        end
                        hasTrailer = true
                        end)
                end
                text(Strings['get_to_trailer'], 250)
                if not DoesBlipExist(trailerBlip) then 
                    trailerBlip = addBlip(GetEntityCoords(trailer), 479, 5, Strings['trailer']) 
                    SetBlipRoute(trailerBlip, true) 
                end
                if DoesBlipExist(destinationBlip) then RemoveBlip(destinationBlip) end
            else
                if DoesBlipExist(trailerBlip) then RemoveBlip(trailerBlip) end

                if not DoesBlipExist(destinationBlip) then
                    destinationBlip = addBlip(data.arrive, 38, 3, Strings['destination'])
                    SetBlipRoute(destinationBlip, true)
                end
            end
            if DoesBlipExist(truckBlip) then RemoveBlip(truckBlip) end
        end
        if distance <= 45.0 and IsPedInVehicle(PlayerPedId(), truck, false) and IsVehicleAttachedToTrailer(truck, trailer) then
            sleep = 0
            DrawMarker(1, data.arrive, vector3(0.0, 0.0, 0.0), vector3(0.0, 0.0, 0.0), vector3(1.0, 1.0, 1.0), 255, 255, 50, 150, false, false, 2, false, false, false)
            if distance <= 10.0 then
                while not IsVehicleStopped(truck) do
                    text(Strings['stop'], 250)
                    Wait(250)
                end
                text(Strings['detach'], 3000)
                Wait(3000)
                BringVehicleToHalt(trailer, 0)
                DetachVehicleFromTrailer(truck)
                DetachVehicleFromTrailer(trailer)
                break
            else
                text(Strings['park'])
            end
        else
            if IsPedInVehicle(PlayerPedId(), truck, false) and IsVehicleAttachedToTrailer(truck, trailer) then
                text(Strings['drive_destination'], 250)
            end
        end
        Wait(sleep)
    end
    Citizen.SetTimeout(15000, function()
        DeleteVehicle(trailer)
      end)
    RemoveBlip(destinationBlip)
    RemoveBlip(trailerBlip)
    RemoveBlip(truckBlip)
    while true and working do
        if GetVehicleEngineHealth(truck) <= 150 then -- If truck is incapacitated
            working = false
            if DoesBlipExist(truckBlip) then RemoveBlip(truckBlip) end
            if DoesBlipExist(trailerBlip) then RemoveBlip(trailerBlip) end
            if DoesBlipExist(destinationBlip) then RemoveBlip(destinationBlip) end
            Citizen.SetTimeout(60000, function()
                DeleteVehicle(truck)
                DeleteVehicle(trailer)
              end)
            text(Strings['fail'], 5000)
            return
        end
        local sleep, distance = 250, GetDistanceBetweenCoords(GetEntityCoords(truck), data.start[1], true)
        if not IsPedInVehicle(PlayerPedId(), truck, false) and distance >= 10.0 then
            text(Strings['get_to_truck'], 250)
            if not DoesBlipExist(truckBlip) then
                truckBlip = addBlip(GetEntityCoords(truck), 477, 5, Strings['truck']) 
                SetBlipRoute(truckBlip, true) 
            end
            if DoesBlipExist(destinationBlip) then RemoveBlip(destinationBlip) end
        else
            if DoesBlipExist(truckBlip) then RemoveBlip(truckBlip) end
            if not DoesBlipExist(destinationBlip) then
                destinationBlip = addBlip(data.start[1], 38, 3, Strings['destination'])
                SetBlipRoute(destinationBlip, true)
            end
            if distance <= 30.0 then
                sleep = 0
                DrawMarker(1, data.start[1], vector3(0.0, 0.0, 0.0), vector3(0.0, 0.0, 0.0), vector3(1.0, 1.0, 1.0), 255, 255, 50, 150, false, false, 2, false, false, false)
                if distance <= 10.0 then
                    if IsPedInVehicle(PlayerPedId(), truck, false) then
                        text(Strings['get_out'])
                    else
                        if DoesBlipExist(destinationBlip) then RemoveBlip(destinationBlip) end
                        if DoesBlipExist(truckBlip) then RemoveBlip(truckBlip) end
                        break
                    end
                else
                    text(Strings['park_truck'])
                end
            else
                text(Strings['drive_back'], 250)
            end
        end
        Wait(sleep)
    end
    local damages = {['windows'] = {}, ['tires'] = {}, ['doors'] = {}, ['body_health'] = GetVehicleBodyHealth(truck), ['engine_health'] = GetVehicleEngineHealth(truck)}
    for i = 0, GetVehicleNumberOfWheels(truck) do
        if IsVehicleTyreBurst(truck, i, false) then table.insert(damages['tires'], i) end 
    end
    for i = 0, 13 do
        if not IsVehicleWindowIntact(truck, i) then table.insert(damages['windows'], i) end
    end
    for i = 0, GetNumberOfVehicleDoors(truck) do 
        if IsVehicleDoorDamaged(truck, i) then table.insert(damages['doors'], i) end 
    end
    DeleteVehicle(truck)
    working = false
    TriggerServerEvent('esx_ets:jobFinished', jobid, damages)
end)

RegisterNetEvent('esx_ets:menu')
AddEventHandler('esx_ets:menu', function(data)
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open(
            'default', GetCurrentResourceName(), 'choose_job',
        {
            title = Strings['menu_title'],
            align = 'top-left',
            elements = data
        },
        function(data, menu)
            TriggerServerEvent('esx_ets:startJob', data.current.value)
            menu.close()
        end,
    function(data, menu)
        menu.close()
    end)
end)

text = function(text, duration)
    ClearPrints()
    BeginTextCommandPrint('STRING')
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandPrint(duration, 1)
end


loadVehicle = function(vehicle, coords, heading)
    local model
    if type(vehicle) == 'number' then model = vehicle else model = GetHashKey(vehicle) end
    while not HasModelLoaded(model) do Wait(0) RequestModel(model) end
    local car = CreateVehicle(model, coords, heading, true, false)
    SetEntityAsMissionEntity(car, true, true)
    fuel = 100.00
    SetVehicleFuelLevel(car, fuel)
    return car
end

helpText = function(msg)
    BeginTextCommandDisplayHelp('STRING')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, false, true, -1)
end

addBlip = function(coords, sprite, colour, text)
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, colour)
    SetBlipScale (blip, 0.8)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
    return blip
end

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end