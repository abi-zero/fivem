Config = {
    JobCenter = vector3(858.7465, -3202.78, 5.9949),
    ReAdd = 0, -- seconds after a job is finished until its shown again
    Job = {
        ['jobRequired'] = true, -- if true: only players with the specified job can work, false everyone can work
        ['jobName'] = 'trucker',
    },
    Jobs = {
        -- {title = 'title', payment = reward, vehicles = {'truck', 'trailer'}, start = {vector3(x, y, z), heading}, trailer = {vector3(x, y, z), heading}, arrive = vector3(x, y, z)}
        {
            title = 'Haul generic products to generic businesses',
            payment = 5000,
            vehicles = {'phantom', 'trailers2'},
            start = {
                {vector3(855.2794, -3210.29, 5.9006), 180.0},
            },
            trailer = {
                -- Near Trucking HQ
                {vector3(900.6, -3185, 5.9), 0.0},
                {vector3(904.6, -3185, 5.9), 0.0},
                {vector3(908.6, -3185, 5.9), 0.0},
                {vector3(912.6, -3185, 5.9), 0.0},
                {vector3(916.6, -3185, 5.9), 0.0},
                {vector3(920.6, -3185, 5.9), 0.0},
                {vector3(924.6, -3185, 5.9), 0.0},

                -- Postal 28
                {vector3(555.3331, -3033, 6.0696), 0.0},
                {vector3(562.0444, -3033, 6.0692), 0.0},
                {vector3(568.4964, -3033, 6.0692), 0.0},
                {vector3(575.1676, -3033, 6.0692), 0.0},
                {vector3(581.8689, -3033, 6.0692), 0.0},
                {vector3(588.5689, -3033, 6.0692), 0.0},

                -- Postal 42
                {vector3(-309.606, -2716.47, 6.0003), 320.0},
                {vector3(-304.033, -2721.23, 6.0003), 320.0},

                -- Postal 83
                {vector3(-764.842, -2609.51, 13.828), 240.0},
                {vector3(-762.108, -2605.93, 13.828), 240.0},
                {vector3(-759.516, -2600.94, 13.828), 240.0},


            }, 
            arrive = {
                -- Near 177 Fuel Station
                vector3(1189.776, -1396.49, 35.117),
                -- Postal 305
                vector3(-1273.67, -1359.73, 4.3028),
                -- Kortz Center
                vector3(-2296.06, 376.8579, 174.46),
                -- University
                vector3(-1614.19, 179.1549, 59.857),
                -- Golf Course
                vector3(-1379.88, 56.15707, 53.681),
                -- Car Dealer
                vector3(-26.8718, -1081.69, 26.867),
                -- Strip Club
                vector3(145.0377, -1278.24, 29.310),
                -- Fridgit Building (Challenging)
                vector3(969.9677, -1631.12, 30.345),
                -- AGL Refrigerated Storage
                vector3(489.8783, -1390.60, 29.565),

            }
        },
        {
            title = 'Complete the final step of a shipment\'s journey',
            payment = 4500,
            vehicles = {'packer', 'trailers'},
            start = {
                {vector3(855.2794, -3210.29, 5.9006), 180.0},
            }, 
            trailer = {
                -- Near Trucking HQ
                {vector3(900.6, -3185, 5.9), 0.0},
                {vector3(904.6, -3185, 5.9), 0.0},
                {vector3(908.6, -3185, 5.9), 0.0},
                {vector3(912.6, -3185, 5.9), 0.0},
                {vector3(916.6, -3185, 5.9), 0.0},
                {vector3(920.6, -3185, 5.9), 0.0},
                {vector3(924.6, -3185, 5.9), 0.0},

            },
            arrive = {
                -- Postal 209
                vector3(389.5861, -904.486, 29.418),
                -- Bunnings
                vector3(-13.5877, -1752.96, 29.302),
                -- Behind Benny's
                vector3(-207.849, -1346.99, 31.005),
                -- Marina
                vector3(-805.576, -1330.97, 5.0003),
                -- Airport Hotel
                vector3(-754.349, -2295.67, 12.858),
                -- Casino
                vector3(1102.863, 251.0272, 80.855),
                -- Airport
                vector3(-972.619, -2895.13, 13.959),
                -- Pier
                vector3(-1593.48, -923.217, 9.0158),
            }
        },
        {
            title = 'Refuel petrol stations to keep the traffic flowing',
            payment = 8000,
            vehicles = {'phantom', 'tanker'},
            start = {
                {vector3(855.2794, -3210.29, 5.9006), 180.0},
            },
            trailer = {
                -- Postal 75 Fuel
                {vector3(514.8562, -2129.90, 5.9488), 180.0},
                {vector3(520.2633, -2129.86, 5.9863), 180.0},
                {vector3(525.6553, -2131.10, 5.9863), 180.0},
            },
            arrive = {
                -- Petrol Stations
                vector3(260.5907, -1261.54, 29.142),
                vector3(-1796.00, 805.4130, 138.51),
                vector3(1208.586, -1402.75, 35.224),
                vector3(-316.299, -1469.57, 30.547),
                vector3(-2092.73, -320.178, 13.027),
                vector3(624.8001, 269.2702, 103.08),
                vector3(-719.551, -936.672, 19.017),
                vector3(174.0382, -1562.30, 29.264),
                vector3(-74.7895, -1759.74, 29.542),
                vector3(815.0935, -1028.49, 26.258),
                vector3(-1437.44, -276.585, 46.207),
                vector3(1179.279, -326.055, 69.174),
                vector3(-524.838, -1210.96, 18.184),
            }
        },
        {
            title = 'Developer Test Job (You won\'t get anything for completing it)',
            payment = 0,
            vehicles = {'packer', 'trailers'},
            start = {
                {vector3(855.2794, -3210.29, 5.9006), 180.0},
            }, 
            trailer = {
                -- Near Trucking HQ
                {vector3(900.6, -3185, 5.9), 0.0},
                {vector3(904.6, -3185, 5.9), 0.0},
                {vector3(908.6, -3185, 5.9), 0.0},
                {vector3(912.6, -3185, 5.9), 0.0},
                {vector3(916.6, -3185, 5.9), 0.0},
                {vector3(920.6, -3185, 5.9), 0.0},
                {vector3(924.6, -3185, 5.9), 0.0},

            },
            arrive = {
                vector3(900.4137, -3156.37, 5.9008),
            }
        },
    },
}

for i = 1, #Config.Jobs do
    Config.Jobs[i].start = {
        {vector3(849.4893, -3211.05, 5.9008), 180.0},
        {vector3(855.2794, -3210.29, 5.9006), 180.0},
        {vector3(835.1209, -3209.85, 5.9008), 180.0},
        {vector3(827.6207, -3210.37, 5.9008), 180.0},
    }
end

Strings = {
    ['not_job'] = "You aren't employed by the trucking company!",
    ['somebody_doing'] = 'Somebody is already doing this job, please select another one!',
    ['menu_title'] = 'Available contracts',
    ['e_browse_jobs'] = 'Press ~INPUT_CONTEXT~ to browse available jobs',
    ['start_job'] = 'Trucking HQ',
    ['truck'] = 'Truck',
    ['trailer'] = 'Trailer',
    ['get_to_truck'] = 'Get in the ~y~truck',
    ['get_to_trailer'] = 'Drive to the ~y~trailer~w~ and attach it!',
    ['destination'] = 'Destination',
    ['get_out'] = 'Get out of the ~y~truck',
    ['park'] = 'Park the ~y~trailer~w~ at the destination.',
    ['park_truck'] = 'Park the ~y~truck~w~ at the destination.',
    ['drive_destination'] = 'Drive to the ~b~destination~w~.',
    ['reward'] = 'Well done! You recieved ~g~$~w~%s',
    ['paid_damages'] = 'Drive better next time! You paid ~r~$~w~%s for the damages caused!',
    ['drive_back'] = 'Drive the ~y~truck ~w~back to HQ',
    ['detach'] = 'Detaching Trailer...',
    ['stop'] = '~r~Stop your truck!',
    ['fail'] = '~r~You destroyed your truck!',
}