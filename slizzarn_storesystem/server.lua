function getTotalPrice(items)
    -- Calculate total price of items

    local total = 0;

    for k,v in pairs(items) do
        total += v.price*v.quantity;
    end

    return total;
end

function isItemsValid(items, store)
    -- Check if items are valid for store
    -- Neccessary because people may buy items that are not in the store

    local categories = store.categories;

    for k,v in pairs(items) do
        local valid = false;

        for _, category in pairs(categories) do
            for _, product in pairs(category.products) do
                if product.name == v.name and product.price == v.price then
                    valid = true;
                end
            end
        end

        if not valid then
            return false;
        end
    end

    return true
end

function getStore(name)
    -- Get store by name

    for k,v in pairs(Config.Stores) do
        if v.name == name then
            return v
        end
    end

    return false
end

Citizen.CreateThread(function()
    if Config.Framework == 'ESX' then
        local p = promise.new();

        TriggerEvent('esx:getSharedObject', function(obj) 
            p:resolve(obj) 
        end)

        ESX = Citizen.Await(p)

        if not ESX then
            console.log('^3Error: Couldn\'t import ESX')
        end

        ESX.RegisterServerCallback('slizzarn_storesystem:purchase', function(source, cb, items, store)
            local player = ESX.GetPlayerFromId(source);

            local store = getStore(store);

            if not store then return end

            if not isItemsValid(items, store) then return end

            local totalPrice = getTotalPrice(items);

            local playerMoney = player.getMoney and player.getMoney() or (player.getAccount('money') and player.getAccount('money').money or 0);

            -- Check if player has enough money
            if playerMoney >= totalPrice then
                -- Remove money from player
                if player.removeMoney then
                    player.removeMoney(totalPrice)
                else
                    player.removeAccountMoney('money', totalPrice)
                end

                -- Add items to player
                for k,v in pairs(items) do
                    TriggerClientEvent('esx:showNotification', source, 'You bought ' ..v.quantity.. ' for $' ..v.price * v.quantity..'.')
                    player.addInventoryItem(v.name, v.quantity);
                end

                cb(true)
            else
                cb(false)
            end
        end)
    elseif Config.Framework == 'QBCore' then
        QBCore = exports['qb-core']:GetCoreObject();

        if not QBCore then
            console.log('^3Error: Couldn\'t import QBCore')
        end

        QBCore.Functions.CreateCallback('slizzarn_storesystem:purchase', function(source, cb, items, store)
            local player = QBCore.Functions.GetPlayer(source);

            local store = getStore(store);

            if not store then return end

            if not isItemsValid(items, store) then return end

            local totalPrice = getTotalPrice(items);

            local playerMoney = player.PlayerData.money["cash"];

            -- Check if player has enough money
            if playerMoney >= totalPrice then
                -- Remove money from player
                player.Functions.RemoveMoney("cash", totalPrice)

                -- Add items to player
                for k,v in pairs(items) do
                    player.Functions.AddItem(v.name, v.quantity);
                end

                cb(true);
            else
                cb(false);
            end
        end)
    end
end)