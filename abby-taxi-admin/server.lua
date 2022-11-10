player = nil
ESX = exports['es_extended']:getSharedObject()
RegisterNetEvent('abby-taxi-admin:adminMenu')
AddEventHandler('abby-taxi-admin:adminMenu', function(player)
	lastHour, lastSixHours, lastTwentyFourHours = 0,0,0
	lastWeek, lastFortnight, lastMonth = 0,0,0
	balance, numEmployees = 0,0
	statistics = {}
	employees = {best={},worst={}}
	trips = {}
	local source = source
	MySQL.Async.fetchAll('SELECT * FROM `abby-taxi` ORDER BY `date` DESC LIMIT 23', function(result)
		trips = {}
		for i=1, #result, 1 do
			table.insert(trips, {
				date = result[i].date,
				name = result[i].name,
				fare = result[i].fare,
				playercut = result[i].playercut,
				businesscut = result[i].businesscut,
			})
		end
	end)
	Wait(1000)
	TriggerClientEvent('abby-taxi-admin:updateTrips',source,json.encode(trips))
	MySQL.Async.fetchAll('SELECT SUM(`businesscut`) AS `total` FROM `abby-taxi` WHERE `date` >= DATE_ADD(CURRENT_TIMESTAMP, INTERVAL -1 HOUR)', function(result)
		lastHour = result[1].total
	end)
	MySQL.Async.fetchAll('SELECT SUM(`businesscut`) AS `total` FROM `abby-taxi` WHERE `date` >= DATE_ADD(CURRENT_TIMESTAMP, INTERVAL -6 HOUR)', function(result)
		lastSixHours = result[1].total
	end)
	MySQL.Async.fetchAll('SELECT SUM(`businesscut`) AS `total` FROM `abby-taxi` WHERE `date` >= DATE_ADD(CURRENT_TIMESTAMP, INTERVAL -1 DAY)', function(result)
		lastTwentyFourHours = result[1].total
	end)
	MySQL.Async.fetchAll('SELECT SUM(`businesscut`) AS `total` FROM `abby-taxi` WHERE `date` >= DATE_ADD(CURRENT_TIMESTAMP, INTERVAL -7 DAY)', function(result)
		lastWeek = result[1].total
	end)
	MySQL.Async.fetchAll('SELECT SUM(`businesscut`) AS `total` FROM `abby-taxi` WHERE `date` >= DATE_ADD(CURRENT_TIMESTAMP, INTERVAL -14 DAY)', function(result)
		lastFortnight = result[1].total
	end)
	MySQL.Async.fetchAll('SELECT SUM(`businesscut`) AS `total` FROM `abby-taxi` WHERE `date` >= DATE_ADD(CURRENT_TIMESTAMP, INTERVAL -30 DAY)', function(result)
		lastMonth = result[1].total
	end)
	Wait(1000)
	if lastHour == nil then
		lastHour = 0
	end
	if lastSixHours == nil then
		lastSixHours = 0
	end
	if lastTwentyFourHours == nil then
		lastTwentyFourHours = 0
	end

	totals = {
		{label = 'Last Hour',total = lastHour,},
		{label = 'Last 6 Hours', total = lastSixHours,},
		{label = 'Last 24 Hours', total = lastTwentyFourHours,},
		{label = 'Last 7 Days',total = lastWeek,},
		{label = 'Last 14 Days',total = lastFortnight,},
		{label = 'Last 30 Days',total = lastMonth,},
	}
	TriggerClientEvent('abby-taxi-admin:updateTotals',source,json.encode(totals))

	MySQL.Async.fetchAll('SELECT `name`, SUM(`businesscut`) AS `total` FROM `abby-taxi` WHERE `date` >= DATE_ADD(CURRENT_TIMESTAMP, INTERVAL -1 HOUR) GROUP BY 1 ORDER BY 2 DESC LIMIT 1', function(result)
		employees.best.lastHour = result
	end)
	MySQL.Async.fetchAll('SELECT `name`, SUM(`businesscut`) AS `total` FROM `abby-taxi` WHERE `date` >= DATE_ADD(CURRENT_TIMESTAMP, INTERVAL -6 HOUR) GROUP BY 1 ORDER BY 2 DESC LIMIT 1', function(result)
		employees.best.lastSixHours = result
	end)
	MySQL.Async.fetchAll('SELECT `name`, SUM(`businesscut`) AS `total` FROM `abby-taxi` WHERE `date` >= DATE_ADD(CURRENT_TIMESTAMP, INTERVAL -24 HOUR) GROUP BY 1 ORDER BY 2 DESC LIMIT 1', function(result)
		employees.best.lastTwentyFourHours = result
	end)
	MySQL.Async.fetchAll('SELECT `name`, SUM(`businesscut`) AS `total` FROM `abby-taxi` WHERE `date` >= DATE_ADD(CURRENT_TIMESTAMP, INTERVAL -7 DAY) GROUP BY 1 ORDER BY 2 DESC LIMIT 1', function(result)
		employees.best.lastWeek = result
	end)
	MySQL.Async.fetchAll('SELECT `name`, SUM(`businesscut`) AS `total` FROM `abby-taxi` WHERE `date` >= DATE_ADD(CURRENT_TIMESTAMP, INTERVAL -14 DAY) GROUP BY 1 ORDER BY 2 DESC LIMIT 1', function(result)
		employees.best.lastFortnight = result
	end)
	MySQL.Async.fetchAll('SELECT `name`, SUM(`businesscut`) AS `total` FROM `abby-taxi` WHERE `date` >= DATE_ADD(CURRENT_TIMESTAMP, INTERVAL -30 HOUR) GROUP BY 1 ORDER BY 2 DESC LIMIT 1', function(result)
		employees.best.lastMonth = result
	end)

	MySQL.Async.fetchAll('SELECT `name`, SUM(`businesscut`) AS `total` FROM `abby-taxi` WHERE `date` >= DATE_ADD(CURRENT_TIMESTAMP, INTERVAL -1 HOUR) GROUP BY 1 ORDER BY 2 ASC LIMIT 1', function(result)
		employees.worst.lastHour = result
	end)
	MySQL.Async.fetchAll('SELECT `name`, SUM(`businesscut`) AS `total` FROM `abby-taxi` WHERE `date` >= DATE_ADD(CURRENT_TIMESTAMP, INTERVAL -6 HOUR) GROUP BY 1 ORDER BY 2 ASC LIMIT 1', function(result)
		employees.worst.lastSixHours = result
	end)
	MySQL.Async.fetchAll('SELECT `name`, SUM(`businesscut`) AS `total` FROM `abby-taxi` WHERE `date` >= DATE_ADD(CURRENT_TIMESTAMP, INTERVAL -24 HOUR) GROUP BY 1 ORDER BY 2 ASC LIMIT 1', function(result)
		employees.worst.lastTwentyFourHours = result
	end)
	MySQL.Async.fetchAll('SELECT `name`, SUM(`businesscut`) AS `total` FROM `abby-taxi` WHERE `date` >= DATE_ADD(CURRENT_TIMESTAMP, INTERVAL -7 DAY) GROUP BY 1 ORDER BY 2 ASC LIMIT 1', function(result)
		employees.worst.lastWeek = result
	end)
	MySQL.Async.fetchAll('SELECT `name`, SUM(`businesscut`) AS `total` FROM `abby-taxi` WHERE `date` >= DATE_ADD(CURRENT_TIMESTAMP, INTERVAL -14 DAY) GROUP BY 1 ORDER BY 2 ASC LIMIT 1', function(result)
		employees.worst.lastFortnight = result
	end)
	MySQL.Async.fetchAll('SELECT `name`, SUM(`businesscut`) AS `total` FROM `abby-taxi` WHERE `date` >= DATE_ADD(CURRENT_TIMESTAMP, INTERVAL -30 HOUR) GROUP BY 1 ORDER BY 2 ASC LIMIT 1', function(result)
		employees.worst.lastMonth = result
	end)

	Wait(100)
	TriggerClientEvent('abby-taxi-admin:updateEmployees',source,json.encode(employees))

	MySQL.Async.fetchAll('SELECT `money` as `balance` FROM `addon_account_data` WHERE `account_name` = "society_taxi"', function(result)
		bal = result
	end)
	MySQL.Async.fetchAll('SELECT COUNT(*) as `employees` FROM `users` WHERE `job` = "taxi"', function(result)
		employees = result
	end)
	Wait(3000)
	TriggerClientEvent('abby-taxi-admin:updateStatistics',source,json.encode({bal,employees}))
end)