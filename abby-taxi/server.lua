ESX = exports['es_extended']:getSharedObject()
RegisterNetEvent('abby-taxi:jobComplete')
AddEventHandler('abby-taxi:jobComplete', function(total)
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_taxi', function(account)
        local xPlayer = ESX.GetPlayerFromId(source)
        if account then
            local playerMoney  = math.ceil(total / 100 * Config.PlayerCut)
            local societyMoney = total - playerMoney
            
            MySQL.Async.fetchAll('INSERT INTO `abby-taxi` (`date`, `name`, `fare`, `playercut`, `businesscut`) VALUES (DEFAULT, "' .. xPlayer.name .. '","' .. math.floor(total) .. '","' .. math.floor(playerMoney) .. '","' .. math.floor(societyMoney) .. '")', function() end)

            xPlayer.addMoney(playerMoney)
            TriggerEvent("edge_admin:log_money", "Job Pay", xPlayer.identifier, xPlayer.name, xPlayer.job.name..": "..xPlayer.job.grade_name.." - $"..playerMoney, "#4c97ae")
            account.addMoney(societyMoney)
            TriggerEvent("edge_admin:log", "Job Society Pay", xPlayer.identifier, xPlayer.name, xPlayer.job.name.." - $"..societyMoney, "#8f4cae")
        else
            xPlayer.addMoney(total)
            TriggerEvent("edge_admin:log_money", "Job Pay", xPlayer.identifier, xPlayer.name, xPlayer.job.name..": "..xPlayer.job.grade_name.." - $"..total, "#4c97ae")
        end
    end)
end)