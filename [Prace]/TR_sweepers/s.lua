local settings = {
    actualPrice = 0,
    priceRandom = {3.00, 4.20}, -- 5.00, 8.00
    sortBonus = 2.35, -- 10%
}

function createNPC()
    local ped = exports.TR_npc:createNPC(17, -2724.93359375, 78.828125, 4.3359375, 132, "Saim Wiggins", "Właściciel Sweeper Company", "dialogue")
    setElementInterior(ped, 0)
    setElementDimension(ped, 0)

    local dialogue = exports.TR_npc:createDialogue()
    exports.TR_npc:addDialogueText(dialogue, "Witam.", {pedResponse = "Witam. W czym mogę służyć?"})

    exports.TR_npc:addDialogueText(dialogue, "Jaka jest cena za kg śmieci?", {pedResponse = "", responseTo = "Witam.", trigger = "getSweeperNpcInfo", triggerData = {"price"}})
    exports.TR_npc:addDialogueText(dialogue, "Chciałbym się dowiedzieć ile mam zebranych kg.", {pedResponse = "", responseTo = "Witam.", trigger = "getSweeperNpcInfo", triggerData = {"count"}})
    exports.TR_npc:addDialogueText(dialogue, "Chciałbym sprzedać śmieci po aktualnej cenie.", {pedResponse = "", responseTo = "Witam.", trigger = "getSweeperNpcInfo", triggerData = {"sellNow"}})
    exports.TR_npc:addDialogueText(dialogue, "Chciałbym oddać śmieci do sortowni.", {pedResponse = "", responseTo = "Witam.", trigger = "getSweeperNpcInfo", triggerData = {"sellLater"}})
    exports.TR_npc:addDialogueText(dialogue, "Chciałbym odebrać pieniądze z sortowni.", {pedResponse = "", responseTo = "Witam.", trigger = "getSweeperNpcInfo", triggerData = {"takeoutLater"}})
    exports.TR_npc:addDialogueText(dialogue, "Jednak nic nie potrzebuję. Do widzenia.", {pedResponse = "Do widzenia.", responseTo = "Witam.", trigger = ""})

    exports.TR_npc:addDialogueText(dialogue, "Do widzenia.", {pedResponse = "Do widzenia."})

    exports.TR_npc:setNPCDialogue(ped, dialogue)
end
createNPC()

function randomPrice()
    settings.actualPrice = math.random(settings.priceRandom[1] * 100, settings.priceRandom[2] * 100)/100

    triggerClientEvent(root, "showCustomMessage", resourceRoot, "Właściciel sortowni", "Nowa cena za kg śmieci - "..settings.actualPrice.."$", "files/images/npc.png")
end
randomPrice()
setTimer(randomPrice, 4 * 60 * 60000, 0)


function getSweeperNpcInfo(el, data)
    local uid = getElementData(client, "characterUID")

    if data[1] == "price" then
        triggerClientEvent(client, "showCustomMessage", resourceRoot, "Saim Wiggins", string.format("Aktualnie cena za kg śmieci wynosi $%.2f.", settings.actualPrice), "files/images/npc.png")

    elseif data[1] == "count" then
        local count = exports.TR_mysql:querry("SELECT count FROM tr_sweepers WHERE plrUID = ? LIMIT 1", uid)
        if count and count[1] then
            if count[1].count then
                triggerClientEvent(client, "showCustomMessage", resourceRoot, "Saim Wiggins", string.format("System pokazuje mi, iż masz zebranych %.2fkg śmieci.", tonumber(count[1].count)), "files/images/npc.png")
            else
                triggerClientEvent(client, "showCustomMessage", resourceRoot, "Saim Wiggins", "Przykro mi, lecz nie mam nikogo takiego w systemie.", "files/images/npc.png")
            end
        else
            triggerClientEvent(client, "showCustomMessage", resourceRoot, "Saim Wiggins", "Przykro mi, lecz nie mam nikogo takiego w systemie.", "files/images/npc.png")
        end

    elseif data[1] == "sellNow" then
        local count = exports.TR_mysql:querry("SELECT count FROM tr_sweepers WHERE plrUID = ? LIMIT 1", uid)
        if count and count[1] then
            if count[1].count then
                local count = tonumber(count[1].count)
                if count > 0 then
                    if exports.TR_core:giveMoneyToPlayer(client, count * settings.actualPrice) then
                        triggerClientEvent(client, "showCustomMessage", resourceRoot, "Saim Wiggins", string.format("Ze sprzedaży śmieci otrzymujesz $%.2f.", count * settings.actualPrice), "files/images/npc.png")
                    end
                    exports.TR_mysql:querry("UPDATE tr_sweepers SET count = 0 WHERE plrUID = ? LIMIT 1", uid)
                else
                    triggerClientEvent(client, "showCustomMessage", resourceRoot, "Saim Wiggins", "Przykro mi, lecz posiadasz 0kg śmieci. Aby je sprzedać musisz je najpierw zebrać.", "files/images/npc.png")
                end
            else
                triggerClientEvent(client, "showCustomMessage", resourceRoot, "Saim Wiggins", "Przykro mi, lecz nie mam nikogo takiego w systemie.", "files/images/npc.png")
            end
        else
            triggerClientEvent(client, "showCustomMessage", resourceRoot, "Saim Wiggins", "Przykro mi, lecz nie mam nikogo takiego w systemie.", "files/images/npc.png")
        end

    elseif data[1] == "sellLater" then
        local count = exports.TR_mysql:querry("SELECT count FROM tr_sweepers WHERE plrUID = ? LIMIT 1", uid)
        if count and count[1] then
            if count[1].count then
                local count = tonumber(count[1].count)
                if count > 0 then
                    exports.TR_mysql:querry("UPDATE tr_sweepers SET count = 0 WHERE plrUID = ? LIMIT 1", uid)
                    exports.TR_mysql:querry("INSERT INTO tr_sweepersSorting (plrUID, money, takeoutTime) VALUES (?, ?, DATE_ADD(NOW(), INTERVAL 1 DAY))", uid, count * (settings.actualPrice * settings.sortBonus))

                    triggerClientEvent(client, "showCustomMessage", resourceRoot, "Saim Wiggins", string.format("W takim razie wysyłam śmieci do sortowni. Pieniądze powinny przyjść do mnie po 24h. Proszę się stawić jutro aby odebrać należne wynagrodzenie.", count * settings.actualPrice), "files/images/npc.png")
                else
                    triggerClientEvent(client, "showCustomMessage", resourceRoot, "Saim Wiggins", "Przykro mi, lecz posiadasz 0kg śmieci. Aby je sprzedać musisz je najpierw zebrać.", "files/images/npc.png")
                end
            else
                triggerClientEvent(client, "showCustomMessage", resourceRoot, "Saim Wiggins", "Przykro mi, lecz nie mam nikogo takiego w systemie.", "files/images/npc.png")
            end
        else
            triggerClientEvent(client, "showCustomMessage", resourceRoot, "Saim Wiggins", "Przykro mi, lecz nie mam nikogo takiego w systemie.", "files/images/npc.png")
        end

    elseif data[1] == "takeoutLater" then
        local count = exports.TR_mysql:querry("SELECT SUM(money) as count FROM tr_sweepersSorting WHERE plrUID = ? AND taken IS NULL AND takeoutTime <= NOW()", uid)
        if count and count[1] then
            if count[1].count then
                local count = tonumber(count[1].count)
                if count > 0 then
                    if exports.TR_core:giveMoneyToPlayer(client, count) then
                        triggerClientEvent(client, "showCustomMessage", resourceRoot, "Saim Wiggins", string.format("Przyszła twoja wypłata z sortowni. Twoje wynagrodzenie wynosi $%.2f.", count), "files/images/npc.png")
                    end
                    exports.TR_mysql:querry("UPDATE tr_sweepersSorting SET taken = 1 WHERE plrUID = ? AND taken IS NULL AND takeoutTime <= NOW()", uid)
                else
                    triggerClientEvent(client, "showCustomMessage", resourceRoot, "Saim Wiggins", "Przykro mi, lecz posiadasz 0kg śmieci. Aby je sprzedać musisz je najpierw zebrać.", "files/images/npc.png")
                end
            else
                triggerClientEvent(client, "showCustomMessage", resourceRoot, "Saim Wiggins", "Przykro mi, lecz nie mam nikogo takiego w systemie.", "files/images/npc.png")
            end
        else
            triggerClientEvent(client, "showCustomMessage", resourceRoot, "Saim Wiggins", "Przykro mi, lecz nie mam nikogo takiego w systemie.", "files/images/npc.png")
        end
    end
end
addEvent("getSweeperNpcInfo", true)
addEventHandler("getSweeperNpcInfo", root, getSweeperNpcInfo)


function onPlayerSweeperJobTakout(count)
    local uid = getElementData(client, "characterUID")
    local hasCount = exports.TR_mysql:querry("SELECT ID FROM tr_sweepers WHERE plrUID = ? LIMIT 1", uid)
    if hasCount and hasCount[1] then
        exports.TR_mysql:querry("UPDATE tr_sweepers SET count = count + ? WHERE plrUID = ? LIMIT 1", count, uid)
    else
        exports.TR_mysql:querry("INSERT INTO tr_sweepers (plrUID, count) VALUES (?, ?)", uid, count)
    end
end
addEvent("onPlayerSweeperJobTakout", true)
addEventHandler("onPlayerSweeperJobTakout", root, onPlayerSweeperJobTakout)


function createSweeperVehicle(pos, upgraded)
    local veh = createVehicle(574, pos[1], pos[2], pos[3], 0, 0, 0)
    setVehicleColor(veh, 60, 60, 60)

    setElementData(veh, "vehicleData", {
		fuel = 70,
		mileage = math.random(350000, 500000),
		engineType = "d",
	}, false)
    setElementData(veh, "vehicleOwner", client)
    setElementData(veh, "blockCollisions", true)
    setVehicleVariant(veh, 2, 2)

    local plr = client
    setTimer(function()
        warpPedIntoVehicle(plr, veh)
        setElementInterior(plr, 0)
        setElementDimension(plr, 0)
        setVehicleEngineState(veh, true)
    end, 100, 1)

    setVehicleHandling(veh, "maxVelocity", 80) -- 47
    addVehicleUpgrade(veh, 1025)

    exports.TR_objectManager:attachObjectToPlayer(client, veh)
end
addEvent("createSweeperVehicle", true)
addEventHandler("createSweeperVehicle", resourceRoot, createSweeperVehicle)

function canEnterVehicle(plr, seat, jacked, door)
    cancelEvent()
end
addEventHandler("onVehicleStartEnter", resourceRoot, canEnterVehicle)

function onVehicleExit(plr, seat, jacked, door)
    if seat == 0 then
        cancelEvent()
        triggerClientEvent(plr, "onJobVehicleExit", resourceRoot)
    end
end
addEventHandler("onVehicleStartExit", resourceRoot, onVehicleExit)