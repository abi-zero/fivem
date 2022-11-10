Config = {}
Config.Locale = 'en' -- Language for notifications, UI and NPCs. Only 'en' is implemented.
Config.Unit = 'km' -- 'km' or 'mi' for kilometres or miles respectively.
Config.FarePerDistance = 500 -- How much money is given per Config.Unit
Config.PlayerCut = 80 -- How much of the fare the player receives, in percent
Config.Flagfall = 10

Config.MinWaitTime = 10000 -- Minimum wait time to find a passenger
Config.MaxWaitTime = 20000 -- Maximum wait time to find a passenger
Config.MsgWaitTime = 5000  -- Wait time after dropping off a passenger to send searching_for_passenger notification

Config.AdminGrade = 1 -- Minimum job grade to access the admin menu.

Config.Passenger = {}
Config.Passenger.PickupDistance = 15 
Config.Passenger.InstantPickup = false
Config.Passenger.DropoffDistance = 15
Config.Passenger.InstantDropoff = false
Config.Passenger.Blip = {}

Config.Area = {}
Config.Area.Areas = {
    {name='The Hills',center=vector2(-1920,650),radius=1000},
    {name='Downtown',center=vector2(0,-850),radius=300},
    {name='The Southern Suburbs',center=vector2(100,-1600),radius=300},
    {name='The Waterfront',center=vector2(-1000,-1000),radius=400},
    {name='Little Seoul',center=vector2(-625,-850),radius=200},
    {name='Vinewood',center=vector2(200,200),radius=400},
    {name='The Airport',center=vector2(-940,-2580),radius=150},
    {name='Sandy Shores',center=vector2(1740,3430),radius=450},
}

Config.Vehicle = {}
Config.Vehicle.Model = 'taxi'
Config.Vehicle.SpawnMenuLocation = vector3(896.5,-158.5,76.5)
Config.Vehicle.SpawnLocation = vector3(897.5,-152.5,76)
Config.Vehicle.DeleteLocation = vector3(897.5,-152.5,76)