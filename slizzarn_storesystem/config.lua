Config = {}

Config.Framework = 'ESX';
-- ESX | QBCore

Config.Stores = {
    -- Store example
    -- {
    --     name = '24/7', -- Required and needs to be unique from the other stores
    --     title = '24/7 Supermarket', -- Required, is shown in the header and the blip
    --     logo = 'https://i.imgur.com/pXRRvoB.png', -- Optional.
    --     colors = { -- All of these inside colors are required
    --         bg = 'rgba(100, 100, 100, .3)', -- Background color for the boxes and containers
    --         bgGradient = 'rgba(4, 180, 71, 0.2)', -- Background gradient color
    --         primary = 'rgb(4, 180, 7)', -- Color for highlighted items and buttons
    --         text = '#fff' -- Make sure it has high contrast with the background color
    --         colorCode = '~g~' -- Optional. The color for the interaction text. Default is ~g~
    --     },
    --     categories = {
    --         {
    --             title = 'Test category',
    --             products = {
    --                 { 
    --                     label = 'Test product', 
    --                     name = 'test_product', 
    --                     price = 20,
    --                     image = '' 
    --                 }
    --             }
    --         }
    --     },
    --     blip = { -- Optional. If removed, the store will not show a blip on the map.
    --         sprite = 59, -- Required. The sprite of the blip.
    --         scale = 0.8, -- Optional. The scale of the blip. Default is 0.8.
    --         color = 3 -- Optional. The color of the blip. Default is 4.
    --     },
    --     ped = { -- Here you can define the ped that will be spawned when the store is opened.
    --         model = `mp_m_shopkeep_01`, -- Required. Ped list: https://docs.fivem.net/docs/game-references/ped-models
    --         scenario = '', -- Optional, you can add a scenario. Scenario list: https://pastebin.com/6mrYTdQv
    --         animation = { -- Optional, you can add an animation. 
    --             dict = '',
    --             anim = ''
    --         }
    --     },
    --     locations = { -- Required. The list of locations where the store will be available. If you have peds and you want a specific heading for each one, you have to define the locations as vector4s.
    --         vector3(0, 0, 0)
    --     }
    -- },

    -- !!! IMPORTANT !!!
    -- The products in the stores are not default items in your inventory. They are custom items. You can add them to your inventory or remove them and add your own.
    -- So don't be shocked if you don't get the items after you buy them.
    -- !!! IMPORTANT !!! 
    {
        name = 'kfc',
        title = 'KFC',
        logo = 'https://imgur.com/FXl8x6i.png',
        colors = {
            bg = 'rgba(100, 100, 100, .3)',
            bgGradient = 'rgba(0, 0, 0, 0.2)',
            primary = 'rgb(0, 0, 0)',
            text = '#fff',
            colorCode = '~r~'
        },
        categories = {
            {
                title = 'New Range',
                products={
                    {name='hot_crispy_zinger_box', price=13.45},
                }
            },
            {
                title = 'Shared Meals',
                products={
                    {name='family_feast', price=32.95},
                }
            },
            {
                title = '',
                products={
                    {},
                }
            },
            {
                title = '',
                products={
                    {},
                }
            },
            {
                title = '',
                products={
                    {},
                }
            },
            {
                title = '',
                products={
                    {},
                }
            },
            {
                title = '',
                products={
                    {},
                }
            },
            {
                title = '',
                products={
                    {},
                }
            },
            {
                title = '',
                products={
                    {},
                }
            },
        },
        
        local items = exports.ox_inventory:Items()
        for i=1,#categories do
            for j=1, #categories[i].products do
                categories[i].products[j].label = items[categories[i].products[j].name]
                categories[i].products[j].image = 'http://edgegaming.net/fivemresources/shop/img/' .. categories[i].products[j].name .. '.png'
            end
        end
        ped = {
            model = `mp_m_shopkeep_01`,
            animation = {
                dict = 'anim@mp_corona_idles@male_d@idle_a', 
                anim = 'idle_a'
            }
        },
        locations = {
            vector4(345.9562, -885.132, 29.339, 354.4)
        }
    },
    {
        name = 'mcd',
        title = 'McDonald\'s',
        logo = 'https://imgur.com/nG0y2Ds.png',
        colors = {
            bg = 'rgba(100, 100, 100, .3)',
            bgGradient = 'rgba(0, 0, 0, 0.2)',
            primary = 'rgb(0, 0, 0)',
            text = '#fff',
            colorCode = '~r~'
        },
        categories = {
            {
                title = 'Beef',
                products = {
                    { label = 'Quarter Pounder Burger', name = 'quarterpounder', price = 7.50, image = 'https://imgur.com/96yBql8.png' },
                    { label = 'Big Mac Burger', name = 'bigmac', price = 7.15, image = 'https://imgur.com/KWPmrof.png' },
                    { label = 'Double Cheeseburger', name = 'doublecheeseburger', price = 5.60, image = 'https://imgur.com/SzxXsYW.png' },
                }
            },
            {
                title = 'Chicken & Fish',
                products = {
                    { label = 'McChicken Burger', name = 'mcchicken', price = 6.95, image = 'https://imgur.com/66QAqM4.png' },
                    { label = 'Chicken N Cheese Burger', name = 'chickenncheese', price = 4, image = 'https://imgur.com/fLMjrkm.png' },
                    { label = 'McSpicy Burger', name = 'mcspicy', price = 9.25, image = 'https://imgur.com/Rp2bzp3.png' },
                    { label = 'McChicken Wrap', name = 'chickenwrap', price = 8.50, image = 'https://imgur.com/gJ1QPdh.png' },
                    { label = '10 McNuggets', name = '10nuggets', price = 8.90, image = 'https://imgur.com/a48vPZw.png' },
                    { label = 'Fillet O Fish Burger', name = 'filletofish', price = 6.10, image = 'https://imgur.com/NcKh3TA.png' },
                }
            },
            {
                title = 'All-Day Breakfast',
                products = {
                    { label = 'Sausage McMuffin', name = 'sausagemcmuffin', price = 4.50, image = 'https://imgur.com/nkpHkdD.png' },
                    { label = 'Sausage & Egg McMuffin', name = 'sausageeggmcmuffin', price = 5.40, image = 'https://imgur.com/ybHidSk.png' },
                }
            },
            {
                title = 'Sides',
                products = {
                    { label = 'Large Fries', name = 'fries', price = 3.90, image = 'https://imgur.com/E2F6pbr.png' },
                    { label = 'Hash Brown', name = 'hashbrown', price = 2.60, image = 'https://imgur.com/9oihQWH.png' },
                }
            },
            {
                title = 'Drinks',
                products = {
                    { label = 'Large Sprite', name = 'largesprite', price = 4.60, image = 'https://imgur.com/byLpum4.png' },
                    { label = 'Large Coke', name = 'largecoke', price = 4.60, image = 'https://imgur.com/LN3bwFI.png' },
                    { label = 'Large Vanilla Coke', name = 'vanillacoke', price = 4.60, image = 'https://imgur.com/TTi4Xnt.png' },
                    { label = 'Large Fanta', name = 'largefanta', price = 4.60, image = 'https://imgur.com/1ugVLe1.png' },
                }
            },
            {
                title = 'Desserts',
                products = {
                    { label = 'Oreo McFlurry', name = 'oreomcflurry', price = 4, image = 'https://imgur.com/tY8tn5A.png' },
                    { label = 'Soft Serve', name = 'icecream', price = 0.85, image = 'https://imgur.com/d2nnPi3.png' },
                    { label = 'Apple Pie', name = 'applepie', price = 3.15, image = 'https://imgur.com/ACXmOR1.png' },
                }
            }
        },
       
        ped = {
            model = `mp_m_shopkeep_01`,
            animation = {
                dict = 'anim@mp_corona_idles@male_d@idle_a', 
                anim = 'idle_a'
            }
        },
        locations = {
            vector4(279.5916, -974.777, 29.425, 355.1),
            vector4(-399.896, 6068.238, 31.500, 71.98)
          
        }
    },


    {
        name = 'kwikemart',
        title = 'Kwik E Mart',
        logo = 'https://imgur.com/rAZE9RN.png',
        colors = {
            bg = 'rgba(100, 100, 100, .3)',
            bgGradient = 'rgba(0, 0, 0, 0.2)',
            primary = 'rgb(0, 0, 0)',
            text = '#fff',
            colorCode = '~g~'
        },
        categories = {
            {
                title = 'Food',
                products = {
                    { label = 'Bread', name = 'bread', price = 4, image = 'https://imgur.com/5KXXrTM.png' },
                    { label = 'Cadbury Dairy Milk', name = 'chocolate', price = 3.50, image = 'https://imgur.com/jD3l2hK.png' },
                    { label = 'Twix', name = 'twix', price = 2.50, image = 'https://imgur.com/3BOHC5a.png' },
                    { label = 'Cheese Toastie', name = 'cheesetoastie', price = 5, image = 'https://imgur.com/7GSGa7W.png' },
                    { label = 'Cheese Twisties', name = 'cheesetwisties', price = 7, image = 'https://imgur.com/2lO0JmA.png' },
                    { label = 'Chicken Twisties', name = 'chickentwisties', price = 7, image = 'https://imgur.com/QXI9DjH.png' },
                    { label = 'Chicken & Lettuce Sandwich', name = 'chickenlettucesandwich', price = 5, image = 'https://imgur.com/VCwgfNn.png' },
                    { label = 'Potato Chips', name = 'potatochip', price = 7, image = 'https://imgur.com/0ref5BM.png' },
                    { label = 'Sausage Roll', name = 'sausageroll', price = 5, image = 'https://imgur.com/pAIiqSo.png' },
                    { label = 'Four n Twenty Meat Pie', name = 'meatpie', price = 4, image = 'https://imgur.com/uB1qW0F.png' },
                    { label = 'Mixed Nuts', name = 'mixednuts', price = 3, image = 'https://imgur.com/NZ28PrM.png' },
                    { label = 'Mudcake', name = 'mudcake', price = 9, image = 'https://imgur.com/4TT61gf.png' },
                }
            },  
            {
                title = 'Drinks',
                products = {
                    { label = '600ml Coke', name = 'coke', price = 3, image = 'https://imgur.com/uGDzWre.png' },
                    { label = 'Regular Coffee', name = 'Coffee', price = 1, image = 'https://imgur.com/JLvi5eq.png' },
                    { label = '600ml Fanata', name = 'fanta', price = 3, image = 'https://imgur.com/nF2m2a5.png' },
                    { label = '600ml Sprite', name = 'sprite', price = 3, image = 'https://imgur.com/YKdbNSx.png' },
                    { label = 'Lipton Iced Tea', name = 'icedtea', price = 3, image = 'https://imgur.com/lmqsm8w.png' },
                    { label = '500ml Monster Energy Drink', name = 'monster', price = 3.50, image = 'https://imgur.com/y6BptQb.png' },
                    { label = '500ml Monster Energy Zero Ultra', name = 'whitemonster', price = 3.50, image = 'https://imgur.com/wgHNjfy.png' },
                    { label = '473ml Red Bull', name = 'redbull', price = 5, image = 'https://imgur.com/bHuJRdn.png' },
                    { label = '500ml Mt Franklin Water', name = 'water', price = 2.50, image = 'https://imgur.com/H7Xa2Dv.png' },
                }
            },
            {
                title = 'Miscellaneous',
                products = {
                    { label = 'Phone', name = 'phone', price = 500, image = 'https://edgegaming.net/fivemresources/shop/img/phone.png' },
                    { label = 'Marlboro Red', name = 'marlboro', price = 6, image = 'https://www.netsnus.se/2237-large/marlboro-red.jpg' },
                }
            }
        },
        blip = {
            sprite = 59,
            scale = 0.8,
            color = 2
        },
        ped = {
            model = `mp_m_shopkeep_01`,
            animation = {
                dict = 'anim@mp_corona_idles@male_d@idle_a', 
                anim = 'idle_a'
            }
        },
        locations = {
            vector4(372.9861755371094, 328.0340270996094, 103.5664520263672, 255.75537109375),
            vector4(-47.3737564086914, -1758.6895751953125, 29.42098999023437, 49.17065048217773),
            vector4(24.44316673278808, -1345.6220703125, 29.49702453613281, 266.9807739257813),
            vector4(-705.903564453125, -914.5589599609376, 19.21558570861816, 90.38861083984376),
            vector4(1164.8587646484375, -323.6117248535156, 69.20510864257812, 102.84022521972656),
            vector4(2555.494873046875, 380.917724609375, 108.62299346923828, 358.311279296875),
            vector4(549.2811889648438, 2669.71630859375, 42.15649032592773, 99.09514617919922),
            vector4(1959.25244140625, 3741.510009765625, 32.34373474121094, 300.1443176269531),
            vector4(1697.356201171875, 4923.4189453125, 42.06363677978515, 325.4171142578125),
            vector4(-3243.989501953125, 1000.162841796875, 12.83070564270019, 356.3724060058594),
            vector4(-3040.598876953125, 584.0460815429688, 7.90892791748046, 14.97980117797851),
            vector4(-1819.542724609375, 793.546875, 138.08627319335938, 133.1322784423828),
            vector4(1728.6326904296875, 6416.71337890625, 35.03721618652344, 243.89891052246097),
            vector4(2676.549072265625, 3280.256103515625, 55.24112319946289, 332.0104064941406)
        }
    },
    {
        name = 'bws',
        title = 'Beer Wine & Spirits',
        logo = 'https://imgur.com/tRha3bK.png',
        colors = {
            bg = 'rgba(100, 100, 100, .3)',
            bgGradient = 'rgba(0, 0, 0, 0.2)',
            primary = 'rgba(0, 0, 0, 1)',
            text = '#fff',
            colorCode = '~y~'
        },
        categories = {
            {
                title = 'Snacks',
                products = {
                    { label = 'Beef Jerky', name = 'beefjerky', price = 5, image = 'https://imgur.com/Xg0pWDi.png' },
                    { label = 'Nobby\'s Pork Crackle', name = 'porkcrackle', price = 5, image = 'https://imgur.com/cnkNLUt.png' },
                }
            },
            {
                title = 'Beer & Wine',
                products = {
                    { label = 'Pepsi Max 1.25L', name = 'pepsimax', price = 8, image = 'https://www.tingstad.com/fixed/images/Main/1644232673/21603.png' },
                    { label = 'Coca Cola Zero 1.25L', name = 'colazero_b', price = 9, image = 'https://kkliquor.com/wp-content/uploads/2020/04/987133.png' },
                    { label = 'Red Bull 250mL', name = 'redbull', price = 3, image = 'https://res.cloudinary.com/coopsverige/image/upload/e_sharpen,f_auto,fl_clip,fl_progressive,q_90,c_lpad,g_center,h_330,w_330/v1620136239/428428.png' },
                    { label = 'Coca Cola Zero 375mL', name = 'colazero_s', price = 8, image = 'https://varsego.se/storage/DBA7D9965AD0807A68A0C6CE9E39F74EA73950E4B640AA56642995B15A605FE4/29ebd87df32d4553920b8eafa98f452b/500-500-0-png.Png/media/534beee9572b45fdaf91311bcc21fb0c/13149%20Coca%20Cola%20Zero%2020x33cl%20Sleek%20can_2.png' },
                }
            },
            {
                title = 'Diverse',
                products = {
                    { label = 'iPhone 13 Pro Max', name = 'iphone', price = 100, image = 'https://cdn-tele2-external-images.azureedge.net/nproz1mx87a8/6OwQvQDdiRKKi5U8tIbOO9/8c024fe4ba6753443c51aa705e219289/iPhone_13_pro_max_blue_2up_detail.png' },
                    { label = 'Marlboro Red', name = 'marlboro', price = 6, image = 'https://www.netsnus.se/2237-large/marlboro-red.jpg' },
                }
            }
        },
        blip = {
            sprite = 59,
            scale = 0.8,
            color = 5
        },
        ped = {
            model = `a_m_m_salton_03`,
            scenario = 'PROP_HUMAN_BUM_SHOPPING_CART'
        },
        locations = {
            vector4(-1221.4722900390625, -907.9589233398438, 12.32635116577148, 30.03417778015136),
            vector4(1134.2567138671875, -983.1217651367188, 46.41580200195312, 278.6879577636719)
        }
    },
    -- { -- This is an example of a pharmacy store. Uncomment to use.
    --     name = 'dollarpills',
    --     title = 'Dollar Pills Pharmacy',
    --     colors = {
    --         bg = 'rgb(255, 255, 255, 0.9)',
    --         bgGradient = 'rgba(82, 141, 203, 0.3)',
    --         primary = 'rgba(82, 141, 203, 1)',
    --         text = '#000',
    --         colorCode = '~b~'
    --     },
    --     categories = {
    --         {
    --             title = 'Diverse',
    --             products = {
    --                 { label = 'Bandage', name = 'bandage', price = 2, image = 'https://www.stadium.se/INTERSHOP/static/WFS/Stadium-SwedenB2C-Site/-/Stadium/sv_SE/Detail/281029_101_SELECT_STRETCH%20BANDAGE.png' },
    --                 { label = 'Alvedon 500mg', name = 'alvedon', price = 3, image = 'https://i-cf65.ch-static.com/content/dam/cf-consumer-healthcare/panadol/sv_SE/products/Alvedon500mg_455x455.png?auto=format' },
    --                 { label = 'Ipren 400mg', name = 'ipren', price = 2, image = 'https://www.apoteksgruppen.se/remote/api.opv.se/WS/General/v173/thumbnails/px400/op3scqpitgel5f6qkbfdbay2iu000000.Png?preset=200' }

    --             }
    --         }
    --     },
    --     blip = {
    --         sprite = 59,
    --         scale = 0.8,
    --         color = 3
    --     },
    --     ped = {
    --         model = `s_m_m_scientist_01`,
    --         animation = {
    --             dict = 'anim@mp_corona_idles@male_d@idle_a', 
    --             anim = 'idle_a'
    --         }
    --     },
    --     locations = {
    --         vector4(68.56552124023438, -1569.4864501953125, 29.5977668762207, 54.44762802124023)
    --     }
    -- }
}

-- Language
 
-- If you want to use a custom language, set it here. 
-- Be sure to not remove %s in strings, they get replaced with values.

Config.lang = {
    press_e = '~INPUT_CONTEXT~ Buy from %s',
    press_e_qbcore = '[E] Open %s',
    currency = '$%s',
    add_to_cart = 'Add to cart',
    your_cart = 'Your cart',
    cart_products = 'Your cart contains (%s) items',
    total = 'Total',
    cart_empty = 'Your cart is empty...',
    continue = 'Continue',
    confirm_purchase = 'Are you sure you want to purchase?',
    confirm_accept = 'Yes, purchase',
    confirm_deny = 'No, cancel',
    purchase_failed = 'Purchase failed, you don\'t have enough money.',