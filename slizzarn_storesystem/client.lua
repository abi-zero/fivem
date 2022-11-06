ESX = nil;
QBCore = nil;

Stores = {
    currentStore = nil
}

-- Functions
function Stores:init()
    if Config.Framework == 'ESX' then
		while ESX == nil do
			TriggerEvent('esx:getSharedObject', function(obj) 
				ESX = obj 
			end)

			Citizen.Wait(0)
		end
	elseif Config.Framework == 'QBCore' then
		QBCore = exports['qb-core']:GetCoreObject();

		local playerData = QBCore.Functions.GetPlayerData();

		if playerData then
			QBCore.playerJob = playerData.job
		end

		RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
			QBCore.playerJob = QBCore.Functions.GetPlayerData().job
		end)
	end

    Citizen.Wait(1000);

    -- Load language configuration
    SendNUIMessage({
        message = 'setLang',
        data = Config.lang
    })

    -- Add blip for the stores
    for k,v in pairs(Config.Stores) do
        if v.blip then
            for _, coords in pairs(v.locations) do
                local blip = AddBlipForCoord(coords.xy);

                SetBlipSprite (blip, v.blip.sprite)
                SetBlipDisplay(blip, 4)
                SetBlipScale  (blip, v.blip.scale or 0.8)
                SetBlipColour (blip, v.blip.color or 4)
                SetBlipAsShortRange(blip, true)
        
                BeginTextCommandSetBlipName('STRING')
                AddTextComponentString(v.title)
                EndTextCommandSetBlipName(blip)
            end
        end
    end

    local drawingText = false;

    while true do
        local playerPed = PlayerPedId();
        local loopInterval = 3000;

        while self.currentStore do
            Citizen.Wait(1500)
        end

        for k,v in pairs(Config.Stores) do
            for id, coords in pairs(v.locations) do
                local dst = #(GetEntityCoords(playerPed) - coords.xyz);

                if dst < 150.0 and v.ped and (not v.ped.entities or not v.ped.entities[tostring(id)] or not DoesEntityExist(v.ped.entities[tostring(id)])) then
                    if not HasModelLoaded(v.ped.model) then
                        RequestModel(v.ped.model);
                        
                        while not HasModelLoaded(v.ped.model) do
                            Citizen.Wait(0);
                        end
                    end

                    -- Create cashier ped with the model
                    local ped = CreatePed(4, v.ped.model, coords.xyz - vector3(0, 0, 0.98), coords.w or 0, false, false);

                    -- Waiting for the ped to be created
                    while not DoesEntityExist(ped) do
                        Citizen.Wait(150)
                    end

                    -- Set ped as invincible
                    SetEntityInvincible(ped, true);
                    SetBlockingOfNonTemporaryEvents(ped, true);
                    FreezeEntityPosition(ped, true);

                    -- Starting scenario if any is specified
                    if v.ped.scenario then
                        TaskStartScenarioInPlace(ped, v.ped.scenario, 0, true);
                    end

                    -- Playing animation if any is specified
                    if v.ped.animation then
                        if not HasAnimDictLoaded(v.ped.animation.dict) then
                            RequestAnimDict(v.ped.animation.dict);
                            
                            while not HasAnimDictLoaded(v.ped.animation.dict) do
                                Citizen.Wait(0)
                            end
                        end

                        TaskPlayAnim(ped, v.ped.animation.dict, v.ped.animation.anim, 8.0, -8.0, -1, 1, 0, false, false, false);
                    end

                    if not v.ped.entities then
                        v.ped.entities = {}
                    end

                    -- Saving the ped in the table
                    v.ped.entities[tostring(id)] = ped;
                end

                if dst < 10.0 then
                    loopInterval = 1000;

                    if dst < 2.0 then
                        loopInterval = 5;

                        if Config.Framework == 'ESX' then
                            ESX.ShowHelpNotification(Config.lang.press_e:format((v.colors.colorCode or '~g~') .. v.title .. '~s~'))
                        elseif Config.Framework == 'QBCore' and not drawingText then
                            exports["qb-core"]:DrawText(Config.lang.press_e_qbcore:format(v.title))

                            drawingText = true
                        end

                        if IsControlJustReleased(0, 38) then
                            self:open(v.name)
                        end
                    elseif drawingText then
                        exports["qb-core"]:HideText()
                        drawingText = false
                    end
                end
            end
        end

        Citizen.Wait(loopInterval)
    end
end

function Stores:open(name)
    local store = self:get(name);

    if not store then return end

    Stores.currentStore = name;

    SetNuiFocus(true, true);

    -- Send the store data to the NUI
    SendNUIMessage({
        message = 'setShop',
        data = {
            categories = store.categories,
            colors = store.colors,
            logo = store.logo,
            title = store.title
        }
    })

    SendNUIMessage({
        message = 'display',
        data = true
    })
end

function Stores:get(name)
    for k,v in pairs(Config.Stores) do
        if v.name == name then
            return v
        end
    end

    return false
end

-- Events
AddEventHandler('onResourceStop', function(resourceName)
    if  resourceName ~= GetCurrentResourceName() then return end

    -- Deleting all cashier peds
    for k,v in pairs(Config.Stores) do
        if v.ped.entities then
            for _, ped in pairs(v.ped.entities) do
                DeletePed(ped);
            end
        end
    end
end)

-- Threads
Citizen.CreateThread(function()
    Stores:init()
end)

-- NUI callbacks
RegisterNUICallback('close', function(data, cb)
    Stores.currentStore = nil;

    SetNuiFocus(false, false)

    SendNUIMessage({
        message = 'display',
        data = false
    })

    cb()
end)

RegisterNUICallback('purchase', function(items, cb)
    if Config.Framework == 'ESX' then
        ESX.TriggerServerCallback('slizzarn_storesystem:purchase', function(result)
            cb(result)
        end, items, Stores.currentStore)
    elseif Config.Framework == 'QBCore' then
        QBCore.Functions.TriggerCallback('slizzarn_storesystem:purchase', function(result)
            cb(result)
        end, items, Stores.currentStore)
    end
end)