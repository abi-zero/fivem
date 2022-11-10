passengerBlip, destinationBlip = nil, nil
rate = Config.FarePerDistance
fare = 0
distance = 0
player = PlayerPedId()
newDistance = 0
playerCoords = vector3(0,0,0)
oldCoords = vector3(0,0,0)
isDoingNPCJob = false
Citizen.CreateThread(function()
	while ESX == nil do
		ESX = exports['es_extended']:getSharedObject()
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
	
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

function GetDistance(a, b)
    return Vdist(a.x,a.y,a.z,b.x,b.y,b.z)
end
function GetFlatDistance(a,b)
    return Vdist(a.x,a.y,0,b.x,b.y,0)
end
function GenerateLocation(playerCoords, radius)
    garbage, coords, coords1 = GetClosestRoad(playerCoords.x+math.random(-radius,radius),playerCoords.y+math.random(-radius,radius),playerCoords.z,1,0,false)
    return vector3(coords)
end
function GetPassenger()
	local search = {}
	local peds   = ESX.Game.GetPeds()

	for i=1, #peds, 1 do
		if IsPedHuman(peds[i]) and IsPedWalking(peds[i]) and not IsPedAPlayer(peds[i]) then
			table.insert(search, peds[i])
		end
	end

	if #search > 0 then
		return search[GetRandomIntInRange(1, #search)]
	end

	for i=1, 250, 1 do
		local ped = GetRandomPedAtCoord(0.0, 0.0, 0.0, math.huge + 0.0, math.huge + 0.0, math.huge + 0.0, 26)

		if DoesEntityExist(ped) and IsPedHuman(ped) and IsPedWalking(ped) and not IsPedAPlayer(ped) then
			table.insert(search, ped)
		end
	end

	if #search > 0 then
		return search[GetRandomIntInRange(1, #search)]
	end
end

function PreparePassenger(passenger)
    ClearPedTasksImmediately(passenger)
    SetEntityAsMissionEntity(passenger, true, false)
    SetBlockingOfNonTemporaryEvents(passenger, true)
    TaskStandStill(passenger, 60000)
end
function ClearPassenger(passenger)
    SetPedAsNoLongerNeeded(passenger)
    SetBlockingOfNonTemporaryEvents(passenger, true)
    Citizen.SetTimeout(60000, function(passenger)
        DeletePed(passenger)
    end)
end
function Notification(message,text)
    if text == nil then
        text = ''
    end
    local notif = Locales[Config.Locale][message][math.random(1,#Locales[Config.Locale][message])][1]
    return string.format(notif,text)
end

function CalculateFare(distance)
    if Config.Unit == 'km' then
        fare = rate * (distance/1000)
    else
        fare = rate * (distance/1609)
    end
    fare = math.floor(100*fare)/100
    return fare
end

function UpdateFare(fare)
    SendNUIMessage({type='update_fare',fare=fare})
end

function UpdateRate(rate)
    SendNUIMessage({type='update_rate',rate=rate})
end

function ResetMeter()
    SendNUIMessage({type='update_fare',fare=0})
end

function TaxiJob()
    distance = 0
    fare = 0
    local hasPassenger, reachedArea, reachedDestination = false, false, false
    player = PlayerPedId()
    playerCoords = GetEntityCoords(player)
    local vehicle = GetVehiclePedIsIn(player, false)
    local vehicleSeat = GetVehicleMaxNumberOfPassengers(vehicle) - 1
    rate = Config.FarePerDistance
    local passenger = GetPassenger()
    PreparePassenger(passenger)
    local passengerCoords = GetEntityCoords(passenger)
    passengerBlip = AddBlipForEntity(passenger)
    SetBlipSprite(passengerBlip,280)
    SetBlipRoute(passengerBlip, true)
    isDoingNPCJob = true
    while not hasPassenger do
        Wait(0)
        rate = 0
        local passengerCoords = GetEntityCoords(passenger)
        if not isDoingNPCJob then
            RemoveBlip(passengerBlip)
            ClearPassenger(passenger)
            return
        end
        if IsPedFatallyInjured(passenger) then
            ESX.ShowNotification(_U('passenger_dead'))
            return
        end
        if GetFlatDistance(playerCoords,passengerCoords) < Config.Passenger.PickupDistance then
            if Config.Passenger.InstantPickup then
                TaskWarpPedIntoVehicle(passenger,vehicle, vehicleSeat)
            else
                TaskEnterVehicle(passenger, vehicle, -1, vehicleSeat, 2.0, 8, 0)
            end
            while not IsPedInVehicle(passenger, vehicle, false) do
                if not isDoingNPCJob then
                    RemoveBlip(passengerBlip)
                    ClearPassenger(passenger)
                    return
                end
                Wait(0)
            end
            hasPassenger = true
            RemoveBlip(passengerBlip)
        end
    end


    local area = Config.Area.Areas[math.random(1,#Config.Area.Areas)]
    ESX.ShowNotification(Notification('area',area.name))
    local areaLocation = vector3(area.center.x, area.center.y, 100)
    local areaBlip = AddBlipForCoord(area.center.x, area.center.y, 100)
    SetBlipSprite(areaBlip,198)
    SetBlipRoute(areaBlip, true)
    rate = Config.FarePerDistance
    while not reachedArea do
        if not isDoingNPCJob then
            RemoveBlip(areaBlip)
            ClearPassenger(passenger)
            return
        end
        if IsPedFatallyInjured(passenger) then
            ClearPassenger(passenger)
            ESX.ShowNotification(_U('passenger_unconscious'))
            return
        end
        if GetFlatDistance(playerCoords,areaLocation) < area.radius then
            reachedArea = true
        end
        Wait(0)
    end


    RemoveBlip(areaBlip)
    local destination = GenerateLocation(vector3(area.center.x,area.center.y,100),area.radius)
    local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(destination.x,destination.y,destination.z))
    ESX.ShowNotification(Notification('destination',streetName))
    local destinationBlip = AddBlipForCoord(destination.x, destination.y, 100)
    SetBlipSprite(destinationBlip,38)
    SetBlipRoute(destinationBlip, true)

    while not reachedDestination do
        if not isDoingNPCJob then
            RemoveBlip(destinationBlip)
            ClearPassenger(passenger)
            return
        end
        if IsPedFatallyInjured(passenger) then
            ClearPassenger(passenger)
            ESX.ShowNotification(_U('passenger_unconscious'))
            return
        end
        if GetFlatDistance(playerCoords, destination) < Config.Passenger.DropoffDistance then
            reachedDestination = true
        end
        Wait(0)
    end

    if Config.Passenger.InstantDropoff then
        TaskLeaveVehicle(passenger, vehicle, 16)
    else
        TaskLeaveVehicle(passenger, vehicle, 0)
    end

    RemoveBlip(destinationBlip)
    ESX.ShowNotification(Notification('complete',''))

    TriggerServerEvent('abby-taxi:jobComplete', fare)
    distance = 0
    fare = 0
    rate = 0
    UpdateRate(rate)
    ClearPassenger(passenger)
    return
end

Citizen.CreateThread(function()
    while true do
        if IsControlJustReleased(0, 167) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'taxi' then
            Menu()
        end
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'taxi' then
            playerCoords = GetEntityCoords(player)
            if GetFlatDistance(playerCoords, Config.Vehicle.SpawnMenuLocation) < 5 then
                DrawMarker(36,Config.Vehicle.SpawnMenuLocation.x,Config.Vehicle.SpawnMenuLocation.y,Config.Vehicle.SpawnMenuLocation.z,0.0,0.0,0.0,0.0,0.0,0.0,1.0,1.0,1.0,255,255,0,255,false,true,2,false,NULL,NULL,false)
                if(IsControlJustReleased(0, 38)) then
                    ESX.Game.SpawnVehicle(Config.Vehicle.Model, Config.Vehicle.SpawnLocation, 325.0, function(vehicle)
                    local playerPed = PlayerPedId()
                    TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                    SetVehicleDirtLevel(vehicle, 0.0)
                    end)
                end
            end
            if GetFlatDistance(playerCoords, Config.Vehicle.DeleteLocation) < 10 then
                DrawMarker(27,Config.Vehicle.DeleteLocation.x,Config.Vehicle.DeleteLocation.y,Config.Vehicle.DeleteLocation.z,0.0,0.0,0.0,0.0,0.0,0.0,1.0,1.0,1.0,255,0,0,255,false,true,2,false,NULL,NULL,false)
                if(IsControlJustReleased(0, 38)) then
                    DeleteVehicle(GetVehiclePedIsIn(player))
                end
            end
        end
        Wait(0)
    end
end)


function Menu()
    ESX.UI.Menu.CloseAll()
    local elems = {
        {label=_U('go_on_duty'),name='start_job'},
        {label=_U('go_off_duty'),name='stop_job'},
        {label=_U('show_meter'),name='show_meter'},
        {label=_U('hide_meter'),name='hide_meter'},
        {label=_U('reset_meter'),name='reset_meter'},
        {label=_U('set_rate'), name='set_rate'},
        {label=_U('disable_meter'), name='disable_meter'},
        {label=_U('admin_menu'), name='admin_menu'},
        {label=_U('hide_admin_menu'), name='hide_admin_menu'},
    }
    ESX.UI.Menu.Open("default",GetCurrentResourceName(),"taxi_menu", {
        title=_U('settings_menu'),
        align='right',
        elements = elems
    }, 
    function(data,menu)
        if data.current.name == 'start_job' then
            isDoingNPCJob = true
            while isDoingNPCJob do
                Citizen.SetTimeout(Config.MsgWaitTime, function()
                    ESX.ShowNotification(_U('searching_for_passenger'))
                end)
                rate = 0
                fare = 0
                Wait(math.random(Config.MinWaitTime, Config.MaxWaitTime))
                TaxiJob()
            end
        elseif data.current.name == 'stop_job' then
            isDoingNPCJob = false
        elseif data.current.name == 'show_meter' then
            SendNUIMessage({type='show_meter'})
        elseif data.current.name == 'hide_meter' then
            SendNUIMessage({type='hide_meter'})
        elseif data.current.name == 'reset_meter' then
            distance = 0
            fare = Config.Flagfall
            UpdateFare(fare)
        elseif data.current.name == 'disable_meter' then
            rate = 0
        elseif data.current.name == 'admin_menu' then
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'taxi' and ESX.PlayerData.job.grade >= Config.AdminGrade then
                TriggerServerEvent('abby-taxi-admin:adminMenu',GetPlayerServerId(PlayerId()))
                TriggerEvent('abby-taxi-admin:showAdminMenu')
            else
                ESX.ShowNotification(_U('not_admin'))
            end
        elseif data.current.name == 'hide_admin_menu' then
            TriggerEvent('abby-taxi-admin:hideAdminMenu')
        elseif data.current.name == 'set_rate' then
            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'set_rate', {
				title = _U('enter_rate')
			}, function(data2, menu2)
				rate = tonumber(data2.value)

				if rate > Config.FarePerDistance then
					ESX.ShowNotification(_U('high_rate'))
				else
					menu2.close()
					menu.close()

					-- todo: refresh on callback
                    UpdateRate(rate)
				end
			end, function(data2, menu2)
				menu2.close()
			end)
        end
    end, 
    function(data,menu)
        menu.close()
    end)
end

--- Taximeter

Citizen.CreateThread(function()
    player = PlayerPedId()
    playerCoords = GetEntityCoords(player)
    oldCoords = playerCoords
    while true do
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'taxi' then
            if(IsPedSittingInAnyVehicle(player)) then
                playerCoords = GetEntityCoords(player)
                newDistance = GetFlatDistance(oldCoords, playerCoords)
                fare = fare + CalculateFare(newDistance)
            end
            oldCoords = playerCoords
            UpdateFare(fare)
            UpdateRate(rate)
            Wait(1500)
        else
            Wait(0)
        end
    end
end)