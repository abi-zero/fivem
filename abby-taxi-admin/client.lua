-- Updates

RegisterNetEvent('abby-taxi-admin:updateTrips')
AddEventHandler('abby-taxi-admin:updateTrips',function(data)
	SendNUIMessage({type='update_trips',trips=data})
end)
RegisterNetEvent('abby-taxi-admin:updateStatistics')
AddEventHandler('abby-taxi-admin:updateStatistics', function(data)
	print(data)
	SendNUIMessage({type='update_statistics',statistics=data})
end)

RegisterNetEvent('abby-taxi-admin:updateTotals')
AddEventHandler('abby-taxi-admin:updateTotals',function(totals)
	SendNUIMessage({type='update_totals',data=totals})
end)

RegisterNetEvent('abby-taxi-admin:updateEmployees')
AddEventHandler('abby-taxi-admin:updateEmployees', function(data)
	SendNUIMessage({type='update_employees',data=data})
end)

-- Show/Hide

RegisterNetEvent('abby-taxi-admin:showAdminMenu')
AddEventHandler('abby-taxi-admin:showAdminMenu', function()
	SendNUIMessage({type='show'})
end)

RegisterNetEvent('abby-taxi-admin:hideAdminMenu')
AddEventHandler('abby-taxi-admin:hideAdminMenu', function()
	SendNUIMessage({type='hide'})
end)