local NPCs = {
    -- Liquor bar
    {
        skin = 272,
        pos = Vector3(2460.9892578125, -2343.9714355469, 98.145309448242),
        int = 0,
        dim = 10,
        rot = 180,
        name = "Dimitri Siergiejew",
        role = "Barman",
        dialogue = {
            {"Dzień dobry.", {pedResponse = "Dzień dobry. Co podać?", img = "shop", trigger = "openShopMenu", triggerData = {"liquorBar"}}},
            {"Do widzenia.", {pedResponse = "Do widzenia. Mam nadzieję, że jeszczę cię tutaj zobaczę."}},
        },
    },
    {
        skin = 40,
        pos = Vector3(2466.7487792969, -2341.4946289063, 98.145309448242),
        int = 0,
        dim = 10,
        rot = 0,
        name = "Carolina Siergiejew",
        role = "Barmanka",
        dialogue = {
            {"Dzień dobry.", {pedResponse = "Wypad zza lady. Nie pracujesz tutaj!"}},
        },
    },
    {
        skin = 272,
        pos = Vector3(-223.30326843262, 1405.3262939453, 27.7734375),
        int = 18,
        dim = 1,
        rot = 96,
        name = "James Gertrick",
        role = "Barman",
        shopName = "Bar Lil' Probe'Inn",
        dialogue = {
            {"Dzień dobry.", {pedResponse = "Dzień dobry. Co podać?", img = "shop", trigger = "openShopMenu", triggerData = {"liquorBar"}}},
            {"Do widzenia.", {pedResponse = "Do widzenia. Mam nadzieję, że jeszczę cię tutaj zobaczę."}},
        },
    },
    {
        skin = 272,
        pos = Vector3(681.69860839844, -455.46060180664, -25.60000038147),
        int = 1,
        dim = 1,
        rot = 0,
        name = "Gregory Shimanov",
        role = "Barman",
        shopName = "Welcome Pump",
        dialogue = {
            {"Dzień dobry.", {pedResponse = "Dzień dobry. Co podać?", img = "shop", trigger = "openShopMenu", triggerData = {"liquorBar"}}},
            {"Do widzenia.", {pedResponse = "Do widzenia. Mam nadzieję, że jeszczę cię tutaj zobaczę."}},
        },
    },
    {
        skin = 248,
        pos = Vector3(497.11486816406, -77.561233520508, 998.76507568359),
        int = 11,
        dim = 1,
        rot = 0,
        name = "James Plant",
        role = "Barman",
        shopName = "The Green Bottles",
        dialogue = {
            {"Dzień dobry.", {pedResponse = "Dzień dobry. Co podać?", img = "shop", trigger = "openShopMenu", triggerData = {"liquorBar"}}},
            {"Do widzenia.", {pedResponse = "Do widzenia. Mam nadzieję, że jeszczę cię tutaj zobaczę."}},
        },
    },
    {
        skin = 192,
        pos = Vector3(450.64736938477, -82.231094360352, 999.5546875),
        int = 4,
        dim = 4,
        rot = 180,
        name = "Jay Plant",
        role = "Barman",
        shopName = "Jay's Dinner",
        dialogue = {
            {"Dzień dobry.", {pedResponse = "Dzień dobry. Co podać?", img = "shop", trigger = "openShopMenu", triggerData = {"liquorBar"}}},
            {"Do widzenia.", {pedResponse = "Do widzenia. Mam nadzieję, że jeszczę cię tutaj zobaczę."}},
        },
    },
    {
        skin = 192,
        pos = Vector3(457.93338012695, -105.41290283203, 999.5999755859),
        int = 5,
        dim = 3,
        rot = 180,
        name = "Hank Grose",
        role = "Barman",
        shopName = "Gant Bridge Dinner",
        dialogue = {
            {"Dzień dobry.", {pedResponse = "Dzień dobry. Co podać?", img = "shop", trigger = "openShopMenu", triggerData = {"liquorBar"}}},
            {"Do widzenia.", {pedResponse = "Do widzenia. Mam nadzieję, że jeszczę cię tutaj zobaczę."}},
        },
    },
    {
        skin = 100,
        pos = Vector3(497.11486816406, -77.561233520508, 998.76507568359),
        int = 11,
        dim = 2,
        rot = 0,
        name = "Michael Willord",
        role = "Barman",
        shopName = "The Craw Bar",
        dialogue = {
            {"Dzień dobry.", {pedResponse = "Dzień dobry. Co podać?", img = "shop", trigger = "openShopMenu", triggerData = {"liquorBar"}}},
            {"Do widzenia.", {pedResponse = "Do widzenia. Mam nadzieję, że jeszczę cię tutaj zobaczę."}},
        },
    },
    {
        skin = 100,
        pos = Vector3(497.11486816406, -77.561233520508, 998.76507568359),
        int = 11,
        dim = 3,
        rot = 0,
        name = "Frank Marken",
        role = "Barman",
        shopName = "Vice",
        dialogue = {
            {"Dzień dobry.", {pedResponse = "Dzień dobry. Co podać?", img = "shop", trigger = "openShopMenu", triggerData = {"liquorBar"}}},
            {"Do widzenia.", {pedResponse = "Do widzenia. Mam nadzieję, że jeszczę cię tutaj zobaczę."}},
        },
    },



    {
        skin = 11,
        pos = Vector3(1206.1989746094, -29.887580871582, 1000.953125),
        int = 3,
        dim = 2,
        rot = 271,
        name = "Olivia Jones",
        role = "Barmanka",
        dialogue = {
            {"Chciałbym zakupić jakiś trunek.", {pedResponse = "Co podać w takim razie?", img = "shop", trigger = "openShopMenu", triggerData = {"stripClub"}}},
            {"Do widzenia.", {pedResponse = "Do widzenia."}},
        },
    },
    {
        skin = 11,
        pos = Vector3(-2655.6145019531, 1413.8552246094, 906.2734375),
        int = 3,
        dim = 1,
        rot = 318,
        name = "Margareth Smith",
        role = "Barmanka",
        dialogue = {
            {"Chciałbym zakupić jakiś trunek.", {pedResponse = "Co podać w takim razie?", img = "shop", trigger = "openShopMenu", triggerData = {"stripClub"}}},
            {"Do widzenia.", {pedResponse = "Do widzenia."}},
        },
    },
    {
        skin = 171,
        pos = Vector3(-2661.3955078125, 1406.6691894531, 906.2734375),
        int = 3,
        dim = 1,
        rot = 178,
        name = "Olivier Muller",
        role = "Barman",
        dialogue = {
            {"Chciałbym zakupić jakiś trunek.", {pedResponse = "Co podać w takim razie?", img = "shop", trigger = "openShopMenu", triggerData = {"stripClub"}}},
            {"Do widzenia.", {pedResponse = "Do widzenia."}},
        },
    },
    {
        skin = 172,
        pos = Vector3(-2662.8410644531, 1413.3537597656, 906.2734375),
        int = 3,
        dim = 1,
        rot = 94,
        name = "Samantha Jhonson",
        role = "Barmanka",
        dialogue = {
            {"Chciałbym zakupić jakiś trunek.", {pedResponse = "Co podać w takim razie?", img = "shop", trigger = "openShopMenu", triggerData = {"stripClub"}}},
            {"Do widzenia.", {pedResponse = "Do widzenia."}},
        },
    },
    {
        skin = 171,
        pos = Vector3(1214.9304199219, -15.260576248169, 1000.921875),
        int = 2,
        dim = 2,
        rot = 1,
        name = "Charlie Wang",
        role = "Barman",
        dialogue = {
            {"Chciałbym zakupić jakiś trunek.", {pedResponse = "Co podać w takim razie?", img = "shop", trigger = "openShopMenu", triggerData = {"stripClub"}}},
            {"Do widzenia.", {pedResponse = "Do widzenia."}},
        },
    },
    {
        skin = 172,
        pos = Vector3(1206.1989746094, -29.887580871582, 1000.953125),
        int = 3,
        dim = 1,
        rot = 271,
        name = "Amelia White",
        role = "Barmanka",
        dialogue = {
            {"Chciałbym zakupić jakiś trunek.", {pedResponse = "Co podać w takim razie?", img = "shop", trigger = "openShopMenu", triggerData = {"stripClub"}}},
            {"Do widzenia.", {pedResponse = "Do widzenia."}},
        },
    },
    {
        skin = 171,
        pos = Vector3(1214.9304199219, -15.260576248169, 1000.921875),
        int = 2,
        dim = 1,
        rot = 1,
        name = "Liam Smith",
        role = "Barman",
        dialogue = {
            {"Chciałbym zakupić jakiś trunek.", {pedResponse = "Co podać w takim razie?", img = "shop", trigger = "openShopMenu", triggerData = {"stripClub"}}},
            {"Do widzenia.", {pedResponse = "Do widzenia."}},
        },
    },

    -- Fuel stations
    {
        skin = 309,
        pos = Vector3(1918.9114990234, -1775.4122314453, 13.546875),
        int = 0,
        dim = 0,
        rot = 268,
        name = "James Aston",
        role = "Pracownik stacji",
        shopName = "Stacja paliw",
        dialogue = {
            {"Dzień dobry. Poproszę...", {pedResponse = "", img = "shop", trigger = "openShopMenu", triggerData = {"market"}}},
            {"Do widzenia.", {pedResponse = "Do widzenia."}},
        },
    },

    -- Mechanic
    {
        skin = 268,
        pos = Vector3(-2042.8974609375, 152.640625, 28.8359375),
        int = 0,
        dim = 0,
        rot = 0,
        name = "Dwaine Khonsari",
        role = "Mechanik samochodowy",
        dialogue = {
            {"Siema. Jak leci?", {pedResponse = "Dobrze. Powoli do przodu. A u ciebie?"}},
            {"Też dobrze.", {pedResponse = "To świetnie! Oby tak dalej.", responseTo = "Siema. Jak leci?"}},
            {"Tragicznie.", {pedResponse = "A co się stało?", responseTo = "Siema. Jak leci?"}},
            {"Nie mogę powiedzieć.", {pedResponse = "To zostaw to dla siebie. Pewnie ci przejdzie za niedługo.", responseTo = "Tragicznie."}},
            {"Za długo by opowiadać...", {pedResponse = "No cóż, trudno. Sam czasu nie mam za dużo.", responseTo = "Tragicznie."}},

            {"Jak mogę zacząć tu pracować?", {pedResponse = "Tutaj obok przy biurku. Praca ta nie wymaga żadnych specjalnych umiejętności. Wszystkiego nauczę cię na miejscu."}},
            {"Kto jest właścicielem warsztatu?", {pedResponse = "Warsztat został przejęty przeze mnie i mojego przyjaciela Jethro. Niestety nie uda ci się go spotkać ponieważ pojechał do Vice City w celach biznesowych."}},

            {"Trzymaj się.", {pedResponse = "Ty też, tylko nie podpieraj ściany bo cię z roboty wyrzucą!"}},
        },
    },
}

function createNPCs()
    for i, v in pairs(NPCs) do
        local ped = exports.TR_npc:createNPC(v.skin, v.pos.x, v.pos.y, v.pos.z, v.rot, v.name, v.role, "dialogue")
        setElementInterior(ped, v.int)
        setElementDimension(ped, v.dim)
        if v.animation then setElementData(ped, "animation", v.animation) end
        if v.shopName then setElementData(ped, "shopName", v.shopName, false) end

        if v.dialogue then
            local dialogue = exports.TR_npc:createDialogue()
            for _, option in pairs(v.dialogue) do
                exports.TR_npc:addDialogueText(dialogue, option[1], option[2])
            end
            exports.TR_npc:setNPCDialogue(ped, dialogue)
        end
    end
end
createNPCs()


function openShopMenu(ped, data)
    if data[1] == "cluckin" then
        triggerClientEvent(client, "createShop", resourceRoot, "Cluckin' Bell", {
            {
                type = 2,
                variant = 7,
                variant2 = 0,
                price = 44.20,
            },
            {
                type = 2,
                variant = 7,
                variant2 = 1,
                price = 28.60,
            },
            {
                type = 2,
                variant = 7,
                variant2 = 2,
                price = 18.50,
            },
            {
                type = 2,
                variant = 7,
                variant2 = 3,
                price = 11.50,
            },
            {
                type = 2,
                variant = 7,
                variant2 = 4,
                price = 10,
            },
            {
                type = 2,
                variant = 7,
                variant2 = 5,
                price = 15,
            },
            {
                type = 2,
                variant = 7,
                variant2 = 6,
                price = 24,
            },
            {
                type = 2,
                variant = 7,
                variant2 = 7,
                price = 11.70,
            },
            {
                type = 2,
                variant = 7,
                variant2 = 8,
                price = 13,
            },
            {
                type = 2,
                variant = 3,
                variant2 = 0,
                price = 6,
            },
            {
                type = 2,
                variant = 3,
                variant2 = 1,
                price = 6,
            },

            {
                type = 2,
                variant = 1,
                variant2 = 0,
                price = 3.80,
            },
        })

    elseif data[1] == "agd" then
        triggerClientEvent(client, "createShop", resourceRoot, "Sklep AGD", {
            {
                type = 20,
                variant = 0,
                variant2 = 0,
                price = 5000,
            },
        })

    elseif data[1] == "burger" then
        triggerClientEvent(client, "createShop", resourceRoot, "Burger Shot", {
            {
                type = 2,
                variant = 8,
                variant2 = 0,
                price = 26.30,
            },
            {
                type = 2,
                variant = 8,
                variant2 = 1,
                price = 18.60,
            },
            {
                type = 2,
                variant = 8,
                variant2 = 2,
                price = 13.25,
            },
            {
                type = 2,
                variant = 8,
                variant2 = 3,
                price = 8.30,
            },
            {
                type = 2,
                variant = 2,
                variant2 = 0,
                price = 6.20,
            },
            {
                type = 2,
                variant = 3,
                variant2 = 0,
                price = 5.50,
            },
            {
                type = 2,
                variant = 3,
                variant2 = 1,
                price = 5.50,
            },

            {
                type = 2,
                variant = 1,
                variant2 = 0,
                price = 4.20,
            },
        })

    elseif data[1] == "pizza" then
        triggerClientEvent(client, "createShop", resourceRoot, "The Well Stacked Pizza", {
            {
                type = 2,
                variant = 9,
                variant2 = 0,
                price = 55.20,
            },
            {
                type = 2,
                variant = 9,
                variant2 = 1,
                price = 34.70,
            },
            {
                type = 2,
                variant = 9,
                variant2 = 2,
                price = 24.60,
            },
            {
                type = 2,
                variant = 9,
                variant2 = 3,
                price = 13.50,
            },
            {
                type = 2,
                variant = 9,
                variant2 = 4,
                price = 32.40,
            },
            {
                type = 2,
                variant = 9,
                variant2 = 5,
                price = 4.30,
            },
            {
                type = 2,
                variant = 3,
                variant2 = 0,
                price = 6.40,
            },
            {
                type = 2,
                variant = 3,
                variant2 = 1,
                price = 6.40,
            },

            {
                type = 2,
                variant = 1,
                variant2 = 0,
                price = 3,
            },
        })

    elseif data[1] == "donuts" then
        triggerClientEvent(client, "createShop", resourceRoot, "Rusty Brown's Ring Donuts", {
            {
                type = 2,
                variant = 10,
                variant2 = 0,
                price = 40,
            },
            {
                type = 2,
                variant = 10,
                variant2 = 1,
                price = 38,
            },
            {
                type = 2,
                variant = 10,
                variant2 = 2,
                price = 24.30,
            },
            {
                type = 2,
                variant = 10,
                variant2 = 3,
                price = 18.50,
            },
            {
                type = 2,
                variant = 10,
                variant2 = 4,
                price = 11.30,
            },
            {
                type = 2,
                variant = 10,
                variant2 = 5,
                price = 4.70,
            },
            {
                type = 2,
                variant = 10,
                variant2 = 6,
                price = 5.20,
            },
        })

    elseif data[1] == "liquorBar" then
        local shopName = getElementData(ped, "shopName")
        triggerClientEvent(client, "createShop", resourceRoot, shopName and shopName or "Liquor Bar", {
            {
                type = 2,
                variant = 2,
                variant2 = 0,
                price = 13.20,
            },
            {
                type = 2,
                variant = 2,
                variant2 = 1,
                price = 13.8,
            },
            {
                type = 2,
                variant = 3,
                variant2 = 0,
                price = 9.10,
            },
            {
                type = 2,
                variant = 3,
                variant2 = 1,
                price = 9.10,
            },
            {
                type = 2,
                variant = 4,
                variant2 = 0,
                price = 8,
            },
            {
                type = 2,
                variant = 4,
                variant2 = 1,
                price = 8.30,
            },
            {
                type = 2,
                variant = 4,
                variant2 = 2,
                price = 8.50,
            },
            {
                type = 8,
                variant = 0,
                variant2 = 0,
                price = 45.20,
            },
            {
                type = 8,
                variant = 1,
                variant2 = 0,
                price = 48.70,
            },
            {
                type = 8,
                variant = 2,
                variant2 = 0,
                price = 56.20,
            },
            {
                type = 8,
                variant = 0,
                variant2 = 1,
                price = 7.20,
            },
            {
                type = 8,
                variant = 1,
                variant2 = 1,
                price = 8.20,
            },
            {
                type = 8,
                variant = 2,
                variant2 = 1,
                price = 9.90,
            },
            {
                type = 8,
                variant = 3,
                variant2 = 1,
                price = 5.40,
            },
            {
                type = 8,
                variant = 4,
                variant2 = 1,
                price = 8.90,
            },
            {
                type = 6,
                variant = 0,
                variant2 = 0,
                price = 26.10,
                value = 20,
            },
            {
                type = 19,
                variant = 0,
                variant2 = 0,
                price = 10,
                value = 20,
            },
            {
                type = 19,
                variant = 0,
                variant2 = 1,
                price = 10,
                value = 20,
            },
        })

    elseif data[1] == "pharmacy" then
        local shopName = getElementData(ped, "shopName")
        triggerClientEvent(client, "createShop", resourceRoot, "San Andreas Pharmacy", {
            {
                type = 16,
                variant = 4,
                variant2 = 0,
                price = 550,
                value = 1,
            },
            {
                type = 16,
                variant = 4,
                variant2 = 1,
                price = 3000,
                value = 5,
            },
            { -- Xanax
                type = 18,
                variant = 3,
                variant2 = 0,
                price = 80,
            },
            { -- Adderal
                type = 18,
                variant = 3,
                variant2 = 1,
                price = 110,
            },
        })

    elseif data[1] == "market" then
        local shopName = getElementData(ped, "shopName")
        triggerClientEvent(client, "createShop", resourceRoot, shopName and shopName or "Market", {
            {
                type = 2,
                variant = 0,
                variant2 = 0,
                price = 3.50,
            },
            {
                type = 2,
                variant = 0,
                variant2 = 1,
                price = 7.50,
            },
            {
                type = 2,
                variant = 0,
                variant2 = 4,
                price = 3.50,
            },
            {
                type = 2,
                variant = 0,
                variant2 = 5,
                price = 4,
            },
            {
                type = 2,
                variant = 0,
                variant2 = 7,
                price = 3,
            },
            {
                type = 2,
                variant = 0,
                variant2 = 8,
                price = 2.50,
            },
            {
                type = 2,
                variant = 1,
                variant2 = 0,
                price = 3.50,
            },
            {
                type = 2,
                variant = 1,
                variant2 = 1,
                price = 3,
            },
            {
                type = 2,
                variant = 1,
                variant2 = 2,
                price = 5,
            },
            {
                type = 2,
                variant = 1,
                variant2 = 5,
                price = 6,
            },
            {
                type = 2,
                variant = 1,
                variant2 = 6,
                price = 4,
            },
            {
                type = 2,
                variant = 1,
                variant2 = 7,
                price = 7,
            },
            {
                type = 2,
                variant = 1,
                variant2 = 8,
                price = 6.50,
            },
            {
                type = 8,
                variant = 1,
                variant2 = 1,
                price = 7.20,
            },
            {
                type = 8,
                variant = 3,
                variant2 = 1,
                price = 4.40,
            },
            {
                type = 8,
                variant = 4,
                variant2 = 1,
                price = 6.90,
            },
            {
                type = 6,
                variant = 0,
                variant2 = 0,
                price = 15.90,
                value = 20,
            },
            {
                type = 19,
                variant = 0,
                variant2 = 0,
                price = 10,
                value = 20,
            },
            {
                type = 19,
                variant = 0,
                variant2 = 1,
                price = 10,
                value = 20,
            },

            {
                type = 16,
                variant = 4,
                variant2 = 0,
                price = 680,
                value = 1,
            },
            {
                type = 16,
                variant = 4,
                variant2 = 1,
                price = 3200,
                value = 5,
            },
        })

    elseif data[1] == "stripClub" then
        local shopName = getElementData(ped, "shopName")
        triggerClientEvent(client, "createShop", resourceRoot, shopName and shopName or "Klub nocny", {
            {
                type = 8,
                variant = 0,
                variant2 = 0,
                price = 55.20,
            },
            {
                type = 8,
                variant = 1,
                variant2 = 0,
                price = 59.70,
            },
            {
                type = 8,
                variant = 2,
                variant2 = 0,
                price = 68.20,
            },
            {
                type = 8,
                variant = 0,
                variant2 = 1,
                price = 10.20,
            },
            {
                type = 8,
                variant = 1,
                variant2 = 1,
                price = 12.20,
            },
            {
                type = 8,
                variant = 2,
                variant2 = 1,
                price = 15.90,
            },
            {
                type = 8,
                variant = 3,
                variant2 = 1,
                price = 8.40,
            },
            {
                type = 8,
                variant = 4,
                variant2 = 1,
                price = 11.90,
            },
            {
                type = 19,
                variant = 0,
                variant2 = 0,
                price = 10,
                value = 20,
            },
            {
                type = 19,
                variant = 0,
                variant2 = 1,
                price = 10,
                value = 20,
            },
        })

    elseif data[1] == "casino" then
        local shopName = getElementData(ped, "shopName")
        triggerClientEvent(client, "createShop", resourceRoot, "Bar w kasynie", {
            {
                type = 8,
                variant = 0,
                variant2 = 0,
                price = 55.20,
            },
            {
                type = 8,
                variant = 1,
                variant2 = 0,
                price = 59.70,
            },
            {
                type = 8,
                variant = 2,
                variant2 = 0,
                price = 68.20,
            },
            {
                type = 8,
                variant = 0,
                variant2 = 1,
                price = 10.20,
            },
            {
                type = 8,
                variant = 1,
                variant2 = 1,
                price = 12.20,
            },
            {
                type = 8,
                variant = 2,
                variant2 = 1,
                price = 15.90,
            },
            {
                type = 8,
                variant = 3,
                variant2 = 1,
                price = 8.40,
            },
            {
                type = 8,
                variant = 4,
                variant2 = 1,
                price = 11.90,
            },
        })
    end
end
addEvent("openShopMenu", true)
addEventHandler("openShopMenu", root, openShopMenu)