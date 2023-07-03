function getReports()
    local reports = exports.TR_mysql:querry("SELECT reporter, reported FROM tr_reports WHERE admin IS NULL")
    triggerClientEvent(client, "updateReports", resourceRoot, reports)
end
addEvent("getReports", true)
addEventHandler("getReports", root, getReports)

function updateReports()
    local reports = exports.TR_mysql:querry("SELECT reporter, reported FROM tr_reports WHERE admin IS NULL")
    triggerClientEvent(root, "updateReports", resourceRoot, reports)
end

function updateLogs(text)
    triggerClientEvent(root, "updateLogs", resourceRoot, text)
end
addEvent("updateLogs", true)
addEventHandler("updateLogs", root, updateLogs)


-- Chat systems
function clearChat(...)
    if not hasPlayerPermission(source, "clearChat") then return end
    triggerClientEvent(root, "clearChat", resourceRoot)
end
addEvent("clearChatCommand", true)
addEventHandler("clearChatCommand", root, clearChat)
exports.TR_chat:addCommand("cc", "clearChatCommand")



-- Penalties
function mute(targetID, count, unit, ...)
    if not isPlayerOnDuty(source) then return end
    if not targetID or not count or not unit then triggerClientEvent(source, "showCustomMessage", resourceRoot, "#008a2eUżycie komendy", "#438f5c/mute (ID/Nick) (ilość) (m/h/d) (powód)", "files/images/command.png") return end

    unit = string.lower(unit)
    count = tonumber(count)

    local reason = table.concat(arg, " ")
    if not avaliableMuteUnits[unit] or string.len(reason) < 1 then triggerClientEvent(source, "showCustomMessage", resourceRoot, "#008a2eUżycie komendy", "#438f5c/mute (ID/Nick) (ilość) (m/h/d) (powód)", "files/images/command.png") return end

    local target = findPlayer(source, targetID)
    if not target then exports.TR_noti:create(source, "Podany gracz nie został znaleziony.", "error") return end
    if source == target then exports.TR_noti:create(source, "Nie możesz wyciszyć samego siebie.", "error") return end

    if not hasPlayerPermission(source, "isDev") and isPlayerOnDuty(target) then exports.TR_noti:create(source, "Nie możesz wyciszyć członka administracji.", "error") return end

    local targetUID = getElementData(target, "characterUID")
    local targetName = getPlayerName(target)
    local targetSerial = getPlayerSerial(target)
    exports.TR_mysql:querry(string.format("INSERT INTO `tr_penalties` (`plrUID`, `serial`, `reason`, `time`, `timeEnd`, `type`, `admin`) VALUES (?, ?, ?, NOW(), DATE_ADD(NOW(), INTERVAL %d %s), 'mute', ?)", count, avaliableMuteUnits[unit]), targetUID, targetSerial, reason, getPlayerName(source))

    local adminName = getPlayerName(source)
    exports.TR_noti:create(root, string.format("%s został wyciszony przez %s.\nPowód: %s", targetName,adminName, reason), "penalty")
    setElementData(target, "playerMute", true)

    local time = getRealTime()
    --exports.TR_discord:sendChannelMsg("adminPenalties", {
    --    time = string.format("[%02d:%02d %02d.%02d]", time.hour, time.minute, time.monthday, time.month),
     --   author = adminName,
    --    text = string.format("zmutował gracza %s na okres %d%s. Powód: %s", targetName, count, unit, reason),
    --})
    local tf = string.format("[%02d:%02d %02d.%02d]", time.hour, time.minute, time.monthday, time.month)
    exports.TR_discord:remoteDsc(tf.." | "..string.format("**%s** zmutował gracza **%s** na okres **%d%s**. Powód: **%s**", adminName, targetName, count, unit, reason), "kary")
end
addEvent("mutePlayerCommand", true)
addEventHandler("mutePlayerCommand", root, mute)
exports.TR_chat:addCommand("mute", "mutePlayerCommand")

function warn(targetID, ...)
    if not isPlayerOnDuty(source) then return end

    local reason = table.concat(arg, " ")
    if not targetID or not reason or string.len(reason) < 1 then triggerClientEvent(source, "showCustomMessage", resourceRoot, "#008a2eUżycie komendy", "#438f5c/warn (ID/Nick) (powód)", "files/images/command.png") return end

    local target = findPlayer(source, targetID)
    if not target then exports.TR_noti:create(source, "Podany gracz nie został znaleziony.", "error") return end
    --if source == target then exports.TR_noti:create(source, "Nie możesz ostrzedz samego siebie.", "error") return end
    if not hasPlayerPermission(source, "isDev") and isPlayerOnDuty(target) then exports.TR_noti:create(source, "Nie możesz ostrzedz członka administracji.", "error") return end

    local targetUID = getElementData(target, "characterUID")
    local targetName = getPlayerName(target)
    local targetSerial = getPlayerSerial(target)
    local adminName = getPlayerName(source)

    exports.TR_mysql:querry("INSERT INTO `tr_penalties` (`plrUID`, `serial`, `reason`, `time`, `timeEnd`, `type`, `admin`) VALUES (?, ?, ?, NOW(), NULL, 'warn', ?)", targetUID, targetSerial, reason, adminName)
    triggerClientEvent(root, "showWarn", resourceRoot, targetName, adminName, reason)

    local time = getRealTime()
    --exports.TR_discord:sendChannelMsg("adminPenalties", {
     --   time = string.format("[%02d:%02d %02d.%02d]", time.hour, time.minute, time.monthday, time.month),
     --   author = adminName,
     --   text = string.format("ostrzegł gracza %s. Powód: %s", targetName, reason),
    --})

    local tf = string.format("[%02d:%02d %02d.%02d]", time.hour, time.minute, time.monthday, time.month)
    exports.TR_discord:remoteDsc(tf.." | "..string.format("**%s** ostrzegł gracza **%s**. Powód: **%s**", adminName, targetName, reason), "kary")
end
addEvent("warnCommand", true)
addEventHandler("warnCommand", root, warn)
exports.TR_chat:addCommand("warn", "warnCommand")

function warnExport(targetID, ...)
	local reason = table.concat(arg, " ")
	if not reason then return end
	local target = findPlayer(source, targetID)
	if not target then return end
    local targetUID = getElementData(target, "characterUID")
    local targetName = getPlayerName(target)
    local targetSerial = getPlayerSerial(target)
    local adminName = "Anty Cheat"
    
    exports.TR_mysql:querry("INSERT INTO `tr_penalties` (`plrUID`, `serial`, `reason`, `time`, `timeEnd`, `type`, `admin`) VALUES (?, ?, ?, NOW(), NULL, 'warn', ?)", targetUID, targetSerial, reason, adminName)
    triggerClientEvent(root, "showWarn", resourceRoot, targetName, adminName, reason)    
end

function kick(targetID, ...)
    if not hasPlayerPermission(source, "kick") then return end

    local reason = table.concat(arg, " ")
    if not targetID or not reason or string.len(reason) < 1 then triggerClientEvent(source, "showCustomMessage", resourceRoot, "#008a2eUżycie komendy", "#438f5c/kick (ID/Nick) (powód)", "files/images/command.png") return end

    local target = findPlayer(source, targetID)
    if not target then exports.TR_noti:create(source, "Podany gracz nie został znaleziony.", "error") return end
    if source == target then exports.TR_noti:create(source, "Nie możesz wyrzucić samego siebie.", "error") return end
    if not hasPlayerPermission(source, "isDev") and isPlayerOnDuty(target) then exports.TR_noti:create(source, "Nie możesz wyrzucić członka administracji.", "error") return end

    local targetUID = getElementData(target, "characterUID")
    local targetName = getPlayerName(target)
    local targetSerial = getPlayerSerial(target)
    local adminName = getPlayerName(source)

    exports.TR_noti:create(root, string.format("%s został wyrzucony przez %s.\nPowód: %s", targetName, adminName, reason), "penalty")
    exports.TR_mysql:querry("INSERT INTO `tr_penalties` (`plrUID`, `serial`, `reason`, `time`, `timeEnd`, `type`, `admin`) VALUES (?, ?, ?, NOW(), NULL, 'kick', ?)", targetUID, targetSerial, reason, adminName)
    kickPlayerFromServer(target, getPlayerName(source), reason)

    local time = getRealTime()
    --exports.TR_discord:sendChannelMsg("adminPenalties", {
    --    time = string.format("[%02d:%02d %02d.%02d]", time.hour, time.minute, time.monthday, time.month),
    --    author = adminName,
    --    text = string.format("wyrzucił gracza %s. Powód: %s", targetName, reason),
    --})
    local tf = string.format("[%02d:%02d %02d.%02d]", time.hour, time.minute, time.monthday, time.month)
    exports.TR_discord:remoteDsc(tf.." | "..string.format("**%s** wyrzucił gracza %s. Powód: %s", adminName, targetName, reason), "kary")
end
addEvent("kickPlayerCommand", true)
addEventHandler("kickPlayerCommand", root, kick)
exports.TR_chat:addCommand("kick", "kickPlayerCommand")

function ban(targetID, count, unit, ...)
    if not hasPlayerPermission(source, "ban") then return end
    if not targetID or not count or not unit then triggerClientEvent(source, "showCustomMessage", resourceRoot, "#008a2eUżycie komendy", "#438f5c/ban (ID/Nick) (ilość) (d/m/y) (powód)", "files/images/command.png") return end

    unit = string.lower(unit)
    count = tonumber(count)

    local reason = table.concat(arg, " ")
    if not avaliableUnits[unit] or string.len(reason) < 1 then triggerClientEvent(source, "showCustomMessage", resourceRoot, "#008a2eUżycie komendy", "#438f5c/ban (ID/Nick) (ilość) (d/m/y) (powód)", "files/images/command.png") return end

    local target = findPlayer(source, targetID)
    if not target then exports.TR_noti:create(source, "Podany gracz nie został znaleziony.", "error") return end
    if source == target then exports.TR_noti:create(source, "Nie możesz zbanować samego siebie.", "error") return end
    if not hasPlayerPermission(source, "isDev") and isPlayerOnDuty(target) then exports.TR_noti:create(source, "Nie możesz wyrzucić członka administracji.", "error") return end

    local targetUID = getElementData(target, "characterUID")
    local targetName = getPlayerName(target)
    local targetSerial = getPlayerSerial(target)
    exports.TR_mysql:querry(string.format("INSERT INTO `tr_penalties` (`plrUID`, `serial`, `reason`, `time`, `timeEnd`, `type`, `admin`) VALUES (?, ?, ?, NOW(), DATE_ADD(NOW(), INTERVAL %d %s), 'ban', ?)", count, avaliableUnits[unit]), targetUID, targetSerial, reason, getPlayerName(source))

    local adminName = getPlayerName(source)
    exports.TR_noti:create(root, string.format("%s został zbanowany przez %s.\nPowód: %s", targetName, adminName, reason), "penalty")
    kickPlayerFromServer(target, getPlayerName(source), "Zostałeś zbanowany. Wejdź na serwer aby zobaczyć szczegóły.")

    local time = getRealTime()
    --exports.TR_discord:sendChannelMsg("adminPenalties", {
    --    time = string.format("[%02d:%02d %02d.%02d]", time.hour, time.minute, time.monthday, time.month),
    --    author = adminName,
    --    text = string.format("zbanował gracza %s na okres %d%s. Powód: %s", targetName, count, unit, reason),
    --})

    local tf = string.format("[%02d:%02d %02d.%02d]", time.hour, time.minute, time.monthday, time.month)
    exports.TR_discord:remoteDsc(tf.." | "..string.format("**%s** zbanował gracza %s na okres %d%s. Powód: %s", adminName, targetName, count, unit, reason), "kary")
end
addEvent("banPlayerCommand", true)
addEventHandler("banPlayerCommand", root, ban)
exports.TR_chat:addCommand("ban", "banPlayerCommand")

function tpl(targetID, count, unit, ...)
    if not hasPlayerPermission(source, "tpl") then return end
    if not targetID or not count or not unit then triggerClientEvent(source, "showCustomMessage", resourceRoot, "#008a2eUżycie komendy", "#438f5c/tpl (ID/Nick) (ilość) (d/m/y) (powód)", "files/images/command.png") return end

    unit = string.lower(unit)
    count = tonumber(count)

    local reason = table.concat(arg, " ")
    if not avaliableMuteUnits[unit] or string.len(reason) < 1 then triggerClientEvent(source, "showCustomMessage", resourceRoot, "#008a2eUżycie komendy", "#438f5c/tpl (ID/Nick) (ilość) (d/m/y) (powód)", "files/images/command.png") return end

    local target = findPlayer(source, targetID)
    if not target then exports.TR_noti:create(source, "Podany gracz nie został znaleziony.", "error") return end
    if source == target then exports.TR_noti:create(source, "Nie możesz zabrać prawa jazdy samemu sobie.", "error") return end

    if not hasPlayerPermission(source, "isDev") and isPlayerOnDuty(target) then exports.TR_noti:create(source, "Nie możesz zabrać prawa jazdy członkowi administracji.", "error") return end

    local targetUID = getElementData(target, "characterUID")
    local targetName = getPlayerName(target)
    local targetSerial = getPlayerSerial(target)
    local adminName = getPlayerName(source)
    exports.TR_mysql:querry(string.format("INSERT INTO `tr_penalties` (`plrUID`, `serial`, `reason`, `time`, `timeEnd`, `type`, `admin`) VALUES (?, ?, ?, NOW(), DATE_ADD(NOW(), INTERVAL %d %s), 'license', ?)", count, avaliableMuteUnits[unit]), targetUID, targetSerial, reason, adminName)

    exports.TR_noti:create(root, string.format("%s stracił możliwość kierowania pojazdami.\nPowód: %s", targetName, reason), "penalty")

    local seat = getPedOccupiedVehicleSeat(target)
    if seat == 0 then
        removePedFromVehicle(target)
    end

    local time = getRealTime()
    --exports.TR_discord:sendChannelMsg("adminPenalties", {
    --    time = string.format("[%02d:%02d %02d.%02d]", time.hour, time.minute, time.monthday, time.month),
    --    author = adminName,
    --    text = string.format("zabrał prawo jazdy gracza %s na okres %d%s. Powód: %s", targetName, count, unit, reason),
    --})

    local tf = string.format("[%02d:%02d %02d.%02d]", time.hour, time.minute, time.monthday, time.month)
    exports.TR_discord:remoteDsc(tf.." | "..string.format("**%s** zabrał prawo jazdy gracza %s na okres %d%s. Powód: %s", adminName, targetName, count, unit, reason), "kary")
end
addEvent("tplPlayerCommand", true)
addEventHandler("tplPlayerCommand", root, tpl)
exports.TR_chat:addCommand("tpl", "tplPlayerCommand")

function resetMail(targetUID, mail)
    if not hasPlayerPermission(source, "resetMail") then return end
    if not targetUID or not mail then triggerClientEvent(source, "showCustomMessage", resourceRoot, "#008a2eUżycie komendy", "#438f5c/resetMail (UID) (mail)", "files/images/command.png") return end

    exports.TR_mysql:querry("UPDATE tr_accounts SET email = ? WHERE UID = ? LIMIT 1", mail, targetUID)
    exports.TR_noti:create(source, "Mail gracza został zaktualizowany pomyślnie.", "success")
end
addEvent("resetMail", true)
addEventHandler("resetMail", root, resetMail)
exports.TR_chat:addCommand("resetMail", "resetMail")


-- Teleports
function tpToPlayer(targetID)
    if not hasPlayerPermission(source, "playerTp") then return end
    if not targetID then triggerClientEvent(source, "showCustomMessage", resourceRoot, "#008a2eUżycie komendy", "#438f5c/tp (ID/Nick)", "files/images/command.png") return end

    local target = findPlayer(source, targetID)
    if not target then exports.TR_noti:create(source, "Podany gracz nie został znaleziony.", "error") return end
    if source == target then exports.TR_noti:create(source, "Nie możesz teleportować się do samego siebie.", "error") return end

    if isPlayerOnDuty(target) then
        if not hasPlayerPermission(source, "isDev") and hasPlayerPermission(target, "isDev") then
            exports.TR_noti:create(source, "Nie możesz teleportować się do tego gracza.", "system")
            exports.TR_noti:create(target, string.format("Administrator %s próbował się do ciebie teleportować.", getPlayerName(source)), "system")
            return
        end
    end

    local veh = getPedOccupiedVehicle(target)
    if veh then
        local passangers = getVehicleMaxPassengers(veh)
        local found = false
        for i = 0, passangers do
            if not getVehicleOccupant(veh, i) then
                found = true
                warpPedIntoVehicle(source, veh, i)
                break
            end
        end

        if not found then
            setElementPosition(source, Vector3(getElementPosition(target)))
            setElementInterior(source, getElementInterior(target))
            setElementDimension(source, getElementDimension(target))
        end
    else
        setElementPosition(source, Vector3(getElementPosition(target)))
        setElementInterior(source, getElementInterior(target))
        setElementDimension(source, getElementDimension(target))
    end

    local targetName = getPlayerName(target)
    local adminName = getPlayerName(source)
    exports.TR_noti:create(source, string.format("Teleportowałeś się do gracza %s.", targetName), "system")
    exports.TR_noti:create(target, string.format("%s teleportował się do ciebie.", adminName), "system")
end
addEvent("tpToPlayerCommand", true)
addEventHandler("tpToPlayerCommand", root, tpToPlayer)
exports.TR_chat:addCommand("tp", "tpToPlayerCommand")

function tpPlayerHere(targetID)
    if not hasPlayerPermission(source, "playerTp") then return end
    if not targetID then triggerClientEvent(source, "showCustomMessage", resourceRoot, "#008a2eUżycie komendy", "#438f5c/tphere (ID/Nick)", "files/images/command.png") return end

    local target = findPlayer(source, targetID)
    if not target then exports.TR_noti:create(source, "Podany gracz nie został znaleziony.", "error") return end
    if source == target then exports.TR_noti:create(source, "Nie możesz teleportować siebie do samego siebie.", "error") return end
    if getElementData(target, "prisonIndex") then exports.TR_noti:create(source, "Nie możesz teleportować do siebie osoby z więzienia.", "error") return end

    if getPedOccupiedVehicle(target) then removePedFromVehicle(target) end
    setElementPosition(target, Vector3(getElementPosition(source)))
    setElementInterior(target, getElementInterior(source))
    setElementDimension(target, getElementDimension(source))

    local targetName = getPlayerName(target)
    local adminName = getPlayerName(source)
    exports.TR_noti:create(source, string.format("Teleportowałeś gracza %s do siebie.", targetName), "system")
    exports.TR_noti:create(target, string.format("%s teleportował cię do siebie.", adminName), "system")
end
addEvent("tpHerePlayerCommand", true)
addEventHandler("tpHerePlayerCommand", root, tpPlayerHere)
exports.TR_chat:addCommand("tphere", "tpHerePlayerCommand")

function tpVehHere(targetID)
    if not hasPlayerPermission(source, "vehicleTp") then return end
    if not targetID then triggerClientEvent(source, "showCustomMessage", resourceRoot, "#008a2eUżycie komendy", "#438f5c/tpv (id pojazdu)", "files/images/command.png") return end

    local target = getElementByID("vehicle"..targetID)
    if not target then exports.TR_noti:create(source, "Podany pojazd nie został znaleziony.", "error") return end

    if getElementDimension(source) ~= 0 or getElementInterior(source) ~= 0 then exports.TR_noti:create(source, "Nie możesz się teleportować będąc w interiorze.", "error") return end

    setElementPosition(source, Vector3(getElementPosition(target)))
    exports.TR_noti:create(source, string.format("Teleportowałeś się do pojazdu o id %d.", targetID), "system")

    local adminName = getPlayerName(source)
end
addEvent("tpHereVehicleCommand", true)
addEventHandler("tpHereVehicleCommand", root, tpVehHere)
exports.TR_chat:addCommand("tpv", "tpHereVehicleCommand")

function tpToVeh(targetID)
    if not hasPlayerPermission(source, "vehicleTp") then return end
    if not targetID then triggerClientEvent(source, "showCustomMessage", resourceRoot, "#008a2eUżycie komendy", "#438f5c/tpvhere (id pojazdu)", "files/images/command.png") return end

    local target = getElementByID("vehicle"..targetID)
    if not target then exports.TR_noti:create(source, "Podany pojazd nie został znaleziony.", "error") return end

    if getElementDimension(source) ~= 0 or getElementInterior(source) ~= 0 then exports.TR_noti:create(source, "Nie możesz się teleportować będąc w interiorze.", "error") return end

    setElementPosition(target, Vector3(getElementPosition(source)))
    exports.TR_noti:create(source, string.format("Teleportowałeś pojazd o id %d do siebie.", targetID), "system")
end
addEvent("tpToVehicleCommand", true)
addEventHandler("tpToVehicleCommand", root, tpToVeh)
exports.TR_chat:addCommand("tpvhere", "tpToVehicleCommand")

function adminTeleportVehicleGarage(targetID)
    if not hasPlayerPermission(source, "vehicleTp") then return end
    if not targetID then triggerClientEvent(source, "showCustomMessage", resourceRoot, "#008a2eUżycie komendy", "#438f5c/tvg (id pojazdu)", "files/images/command.png") return end

    local vehicle = getElementByID("vehicle"..targetID)
    if not vehicle then exports.TR_noti:create(source, "Podany samochód nie został odnaleziony.", "error") return end

    local data = getElementData(vehicle, "vehicleData")
    exports.TR_vehicles:saveVehicle(vehicle)
    exports.TR_mysql:querry("UPDATE tr_vehicles SET parking = ? WHERE ID = ? LIMIT 1", 50, data.ID)
    destroyElement(vehicle)

    exports.TR_noti:create(source, "Pomyślnie przeniosłeś samochód do przechowywalni.", "success")
end
addEvent("adminTeleportVehicleGarage", true)
addEventHandler("adminTeleportVehicleGarage", root, adminTeleportVehicleGarage)
exports.TR_chat:addCommand("tpvg", "adminTeleportVehicleGarage")

function report(targetID, ...)
    local reason = table.concat(arg, " ")
    if not targetID or not reason then triggerClientEvent(source, "showCustomMessage", resourceRoot, "#008a2eUżycie komendy", "#438f5c/report (ID/Nick) (powód)", "files/images/command.png") return end
    if string.len(reason) < 1 then triggerClientEvent(source, "showCustomMessage", resourceRoot, "#008a2eUżycie komendy", "#438f5c/report (ID/Nick) (powód)", "files/images/command.png") return end

    local target = findPlayer(source, targetID)
    if not target then exports.TR_noti:create(source, "Podany gracz nie został znaleziony.", "error") return end

    local reportTime = getElementData(source, "reportTime")
    if reportTime then
        if (getTickCount() - reportTime)/60000 < 1 then
            exports.TR_noti:create(source, "Zgłoszenie do administracji możesz wysłać raz na minutę.", "error")
            return
        end
    end
    setElementData(source, "reportTime", getTickCount())

    triggerClientEvent(root, "client -> addReport", root, '[#'..getElementData(source, 'ID')..'] '..getPlayerName(source)..' -> '..getPlayerName(target)..' -> '..reason, getElementData(source, 'ID'))

    exports.TR_noti:create(source, "Wysłano zgłoszenie na gracza "..getPlayerName(target), "info")

    for _,pl in ipairs(getElementsByType('player')) do
        if isPlayerOnDuty(pl) then
          exports.TR_noti:create(pl, "Przyszedł nowy report!", "info")  
        end
    end
end
addEvent("reportCommand", true)
addEventHandler("reportCommand", root, report)
exports.TR_chat:addCommand("report", "reportCommand")

function areport(targetID)
    if not isPlayerOnDuty(source) then return end

    local target = findPlayer(source, targetID)
    if not target then exports.TR_noti:create(source, "Nie odnaleziono reporta na podanego gracza.", "error") return end

    triggerClientEvent(root, "client -> removeReport", root, getElementData(target, 'ID'))
    exports.TR_noti:create(source, "Przyjąłeś report nałożony na gracza "..getPlayerName(target), "system")
    if not target then return end;
    exports.TR_noti:create(target, getPlayerName(source).." przyjął twój report!", "system")
end
addEvent("areportCommand", true)
addEventHandler("areportCommand", root, areport)
exports.TR_chat:addCommand("cl", "areportCommand")

function getAdminReports()
    if not isPlayerOnDuty(source) then return end

    if hasPlayerPermission(source, "allReports") then
        local time = getRealTime()
        local reports = exports.TR_mysql:querry("SELECT tr_accounts.username as username, COUNT(*) as count FROM tr_reports LEFT JOIN tr_accounts ON tr_accounts.username = tr_reports.admin WHERE YEARWEEK(`date`, 1) = YEARWEEK(CURDATE(), 1) GROUP BY tr_accounts.username")
        if reports and reports[1] then
            local text = ""
            for i, v in pairs(reports) do
                text = string.format("%s%s: %s", i == 1 and text or text.."\n", v.username or "ERROR", v.count or "0")
            end
            triggerClientEvent(source, "showCustomMessage", resourceRoot, "STATYSTYKI REPORTÓW Z TEGO TYGODNIA", text, "files/images/system.png")
        else
            triggerClientEvent(source, "showCustomMessage", resourceRoot, "STATYSTYKI REPORTÓW Z TEGO TYGODNIA", "Nie ma żadnych reportów w tym miesiącu.", "files/images/system.png")
        end
    else
        local time = getRealTime()
        local reports = exports.TR_mysql:querry("SELECT COUNT(*) as count FROM tr_reports WHERE admin = ? AND YEARWEEK(`date`, 1) = YEARWEEK(CURDATE(), 1)", getPlayerName(source))
        if reports and reports[1] then
            triggerClientEvent(source, "showCustomMessage", resourceRoot, "STATYSTYKI REPORTÓW Z TEGO TYGODNIA", string.format("Twoje reporty: %s", reports[1].count), "files/images/system.png")
        else
            triggerClientEvent(source, "showCustomMessage", resourceRoot, "STATYSTYKI REPORTÓW Z TEGO TYGODNIA", "Nie masz jeszcze żadnych reportów w tym miesiącu.", "files/images/system.png")
        end
    end
end
--addEvent("getAdminReports", true)
--addEventHandler("getAdminReports", root, getAdminReports)
--exports.TR_chat:addCommand("reports", "getAdminReports")



-- Online admin list
function onlineAdmins()
    local adminText = "#7e0f0fZarząd: \n#999999"
    local admins = {
        ["owner"] = {},
        ["guardian"] = {},
        ["admin"] = {},
        ["globalmoderator"] = {},
        ["moderator"] = {},
        ["support"] = {},
    }

    for i, v in pairs(getElementsByType("player")) do
        local rank = getElementData(v, "adminDuty")
        if rank and not getElementData(v, "fakeName") then
            if string.find(rank, "owner") then table.insert(admins["owner"], {getElementData(v, "ID"), getPlayerName(v)})
            elseif string.find(rank, "guardian") then table.insert(admins["guardian"], {getElementData(v, "ID"), getPlayerName(v)})
            elseif string.find(rank, "admin") then table.insert(admins["admin"], {getElementData(v, "ID"), getPlayerName(v)})
            elseif string.find(rank, "globalmoderator") then table.insert(admins["globalmoderator"], {getElementData(v, "ID"), getPlayerName(v)})
            elseif string.find(rank, "moderator") then table.insert(admins["moderator"], {getElementData(v, "ID"), getPlayerName(v)})
            elseif string.find(rank, "support") then table.insert(admins["support"], {getElementData(v, "ID"), getPlayerName(v)})
            end
        end
    end

    if #admins["owner"] > 0 then
        for i, v in pairs(admins["owner"]) do
            adminText = string.format("%s%s#bbbbbb[%d] #999999%s%s", adminText, i == 1 and "" or " ", v[1], v[2], i == #admins["owner"] and "" or ", ")
        end
    else
        adminText = adminText .. "Brak"
    end

    adminText = adminText .. " \n \n#e73f0bGuardian: \n#999999"
    if #admins["guardian"] > 0 then
        for i, v in pairs(admins["guardian"]) do
            adminText = string.format("%s%s#bbbbbb[%d] #999999%s%s", adminText, i == 1 and "" or " ", v[1], v[2], i == #admins["guardian"] and "" or ", ")
        end
    else
        adminText = adminText .. "Brak"
    end

    adminText = adminText .. " \n \n#da1717Administrator: \n#999999"
    if #admins["admin"] > 0 then
        for i, v in pairs(admins["admin"]) do
            adminText = string.format("%s%s#bbbbbb[%d] #999999%s%s", adminText, i == 1 and "" or " ", v[1], v[2], i == #admins["admin"] and "" or ", ")
        end
    else
        adminText = adminText .. "Brak"
    end

    adminText = adminText .. " \n \n#5ce76aGlobal Moderator: \n#999999"
    if #admins["globalmoderator"] > 0 then
        for i, v in pairs(admins["globalmoderator"]) do
            adminText = string.format("%s%s#bbbbbb[%d] #999999%s%s", adminText, i == 1 and "" or " ", v[1], v[2], i == #admins["moderator"] and "" or ", ")
        end
    else
        adminText = adminText .. "Brak"
    end

    adminText = adminText .. " \n \n#0a8f0bModerator: \n#999999"
    if #admins["moderator"] > 0 then
        for i, v in pairs(admins["moderator"]) do
            adminText = string.format("%s%s#bbbbbb[%d] #999999%s%s", adminText, i == 1 and "" or " ", v[1], v[2], i == #admins["moderator"] and "" or ", ")
        end
    else
        adminText = adminText .. "Brak"
    end

    adminText = adminText .. " \n \n#1ba3f3Supporter: \n#999999"
    if #admins["support"] > 0 then
        for i, v in pairs(admins["support"]) do
            adminText = string.format("%s%s#bbbbbb[%d] #999999%s%s", adminText, i == 1 and "" or " ", v[1], v[2], i == #admins["support"] and "" or ", ")
        end
    else
        adminText = adminText .. "Brak"
    end

    triggerClientEvent(source, "showCustomMessage", resourceRoot, "ADMINISTRACJA ONLINE", adminText, "files/images/system.png")
end
addEvent("onlineAdmins", true)
addEventHandler("onlineAdmins", root, onlineAdmins)
exports.TR_chat:addCommand("admins", "onlineAdmins")

function adminHealPlayer(targetID)
    if not isPlayerOnDuty(source) then return end
    if not targetID then triggerClientEvent(source, "showCustomMessage", resourceRoot, "#008a2eUżycie komendy", "#438f5c/heal (ID/Nick)", "files/images/command.png") return end

    local target = findPlayer(source, targetID)
    if not target then exports.TR_noti:create(source, "Podany gracz nie został znaleziony.", "error") return end

    setElementHealth(target, 100)

    local adminName = getPlayerName(source)
    local targetName = getPlayerName(target)
    exports.TR_noti:create(source, string.format("Pomyślnie uleczyłeś gracza %s.", targetName), "success")
    exports.TR_noti:create(target, string.format("Zostałeś uleczony przez %s.", adminName), "system")
end
addEvent("adminHealPlayer", true)
addEventHandler("adminHealPlayer", root, adminHealPlayer)
exports.TR_chat:addCommand("heal", "adminHealPlayer")


-- #5ce76a


-- Vehicle events
function adminFuelVehicle()
    if not hasPlayerPermission(source, "vehicleFuel") then return end
    local veh = getPedOccupiedVehicle(source)
    if not veh then exports.TR_noti:create(source, "Musisz siedzieć w pojeździe aby go dotankować.", "error") return end

    local data = getElementData(veh, "vehicleData")
    if not data then exports.TR_noti:create(source, "Nie można dotankować tego pojazdu.", "error") return  end

    data.fuel = data.fuel + 100
    setElementData(veh, "vehicleData", data, false)
    triggerClientEvent(source, "playerSpeedometerOpen", resourceRoot, veh, data)
    exports.TR_noti:create(source, "Pomyślnie dolano 100l benzyny do pojazdu.", "success")
end
addEvent("adminFuelVehicle", true)
addEventHandler("adminFuelVehicle", root, adminFuelVehicle)
exports.TR_chat:addCommand("fuel", "adminFuelVehicle")

function adminFixVehicle()
    if not hasPlayerPermission(source, "vehicleFuel") then return end
    local veh = getPedOccupiedVehicle(source)
    if not veh then exports.TR_noti:create(source, "Musisz siedzieć w pojeździe aby go naprawić.", "error") return end

    local data = getElementData(veh, "vehicleData")
    if not data then exports.TR_noti:create(source, "Nie można naprawić tego pojazdu.", "error") return  end

    fixVehicle(veh)
    exports.TR_noti:create(source, "Pomyślnie naprawiono pojazd.", "success")
end
addEvent("adminFixVehicle", true)
addEventHandler("adminFixVehicle", root, adminFixVehicle)
exports.TR_chat:addCommand("fix", "adminFixVehicle")

function adminFlipVehicle()
    if not hasPlayerPermission(source, "vehicleFuel") then return end
    local veh = getPedOccupiedVehicle(source)
    if not veh then exports.TR_noti:create(source, "Musisz siedzieć w pojeździe aby go obrócić.", "error") return end

    local data = getElementData(veh, "vehicleData")
    if not data then exports.TR_noti:create(source, "Nie można obrócić tego pojazdu.", "error") return  end

    setElementRotation(veh, 0, 0, 0)
    exports.TR_noti:create(source, "Pomyślnie obrócono pojazd.", "success")
end
addEvent("adminFlipVehicle", true)
addEventHandler("adminFlipVehicle", root, adminFlipVehicle)
exports.TR_chat:addCommand("flip", "adminFFlipVehicle")


-- Admin addons
function adminJetPack()
    if not isPlayerOnDuty(source) then return end

    if isPedWearingJetpack(source) then
        setPedWearingJetpack(source, false)
    else
        setPedWearingJetpack(source, true)
    end
end
addEvent("adminJetPack", true)
addEventHandler("adminJetPack", root, adminJetPack)
exports.TR_chat:addCommand("jp", "adminJetPack")

function adminInvisible()
    if not isPlayerOnDuty(source) then return end

    local alpha = getElementData(source, "inv")
    if alpha then
        setElementAlpha(source, 255)
        setElementData(source, "inv", false)
    else
        setElementData(source, "inv", true)
    end
end
addEvent("adminInvisible", true)
addEventHandler("adminInvisible", root, adminInvisible)
exports.TR_chat:addCommand("inv", "adminInvisible")

function adminInterior(int)
    if not isPlayerOnDuty(source) then return end
    if tonumber(int) == nil then triggerClientEvent(source, "showCustomMessage", resourceRoot, "#008a2eUżycie komendy", "#438f5c/int (id)", "files/images/command.png") return end
    setElementInterior(source, tonumber(int))

    if adminVehicles[source] then
        exports.TR_noti:create(source, "Jako iż opuściłeś interior w którym stworzyłeś pojazdy, zostały one usunięte.", "info")
    end
    removeAdminSpawnedVehicles(source)
end
addEvent("adminInterior", true)
addEventHandler("adminInterior", root, adminInterior)
exports.TR_chat:addCommand("int", "adminInterior")

function adminDimension(dim)
    if not isPlayerOnDuty(source) then return end
    if tonumber(dim) == nil then triggerClientEvent(source, "showCustomMessage", resourceRoot, "#008a2eUżycie komendy", "#438f5c/dim (id)", "files/images/command.png") return end
    setElementDimension(source, tonumber(dim))

    if adminVehicles[source] then
        exports.TR_noti:create(source, "Jako iż opuściłeś dimension w którym stworzyłeś pojazdy, zostały one usunięte.", "info")
    end
    removeAdminSpawnedVehicles(source)
end
addEvent("adminDimension", true)
addEventHandler("adminDimension", root, adminDimension)
exports.TR_chat:addCommand("dim", "adminDimension")

function adminSpec(targetID)
    if not isPlayerOnDuty(source) then return end
    if not targetID then triggerClientEvent(source, "showCustomMessage", resourceRoot, "#008a2eUżycie komendy", "#438f5c/spec (ID/Nick)", "files/images/command.png") return end

    local target = findPlayer(source, targetID)
    if not target then exports.TR_noti:create(source, "Podany gracz nie został znaleziony.", "error") return end

    triggerClientEvent(source, "createSpecWindow", resourceRoot, target)
end
addEvent("adminSpec", true)
addEventHandler("adminSpec", root, adminSpec)
exports.TR_chat:addCommand("spec", "adminSpec")


function adminSpawnVeh(model)
    if not isPlayerOnDuty(source) then return end

    local model = tonumber(model)
    if not model then triggerClientEvent(source, "showCustomMessage", resourceRoot, "#008a2eUżycie komendy", "#438f5c/cv (model)", "files/images/command.png") return end
    if not isVehicleModelAvaliable(model) then exports.TR_noti:create(source, "Ten model pojazdu jest niedostępny.", "error") return end
    --if getElementInterior(source) == 0 and getElementDimension(source) == 0 then exports.TR_noti:create(source, "Samochody możesz tworzyć tylko na interiorze lub dimensionie innym niż podstawowy.", "error") return end

    if not adminVehicles[source] then adminVehicles[source] = {} end
    if #adminVehicles[source] >= 50 then exports.TR_noti:create(source, "Osiągnąłeś limit zrespionych pojazdów.", "error") return end

    local veh = createVehicle(model, Vector3(getElementPosition(source)),Vector3(getElementRotation(source)))
    setElementData(veh, "vehicleData", {
        mileage = 0,
        fuel = 100,
    }, false)
    setElementInterior(veh, getElementInterior(source))
    setElementDimension(veh, getElementDimension(source))
    setElementData(veh, "freeForAll", true)
    warpPedIntoVehicle(source, veh)
    table.insert(adminVehicles[source], veh)
end
addEvent("adminSpawnVeh", true)
addEventHandler("adminSpawnVeh", root, adminSpawnVeh)
exports.TR_chat:addCommand("cv", "adminSpawnVeh")

function adminDespawnVeh(model)
    if not isPlayerOnDuty(source) then return end
    if not adminVehicles[source] then exports.TR_noti:create(source, "Nie masz zespawnowanych żadnych pojazdów.", "error") return end

    removeAdminSpawnedVehicles(source)
    exports.TR_noti:create(source, "Wszystkie pojazdy zostały pomyślnie usunięte.", "success")
end
addEvent("adminDespawnVeh", true)
addEventHandler("adminDespawnVeh", root, adminDespawnVeh)
exports.TR_chat:addCommand("dcv", "adminDespawnVeh")


-- Admin events
function adminChat(...)
    if not isPlayerOnDuty(source, true) then return end

    local players = getElementsByType("player")
    local id = getElementData(source, "ID")
    local plrName = getPlayerName(source)
    local msg = table.concat({...}, " ")

    local rank = getAdminRank(source)

    for _, player in ipairs(players) do
        local isAdm = getAdminRank(player)
        if isAdm then
            triggerClientEvent(player, "showCustomMessage", resourceRoot, string.format("%s %s", rank, plrName), "#cccccc"..msg, "files/images/system.png")
        end
    end
end
addEvent("adminChat", true)
addEventHandler("adminChat", root, adminChat)
exports.TR_chat:addCommand("a", "adminChat")

function adminNotiChat(...)
    if not isPlayerOnDuty(source) then return end

    local players = getElementsByType("player")
    local id = getElementData(source, "ID")
    local plrName = getPlayerName(source)
    local msg = table.concat({...}, " ")

    local rank = getAdminRank(source)
    triggerClientEvent(root, "showCustomMessage", resourceRoot, string.format("%s %s", rank, plrName), "#cccccc"..msg, "files/images/megaphone.png")
end
addEvent("adminNotiChat", true)
addEventHandler("adminNotiChat", root, adminNotiChat)
exports.TR_chat:addCommand("info", "adminNotiChat")

function adminNotiChat2(...)
    if not isPlayerOnDuty(source) then return end

    local players = getElementsByType("player")
    local id = getElementData(source, "ID")
    local plrName = getPlayerName(source)
    local msg = table.concat({...}, " ")

    local rank = getAdminRank(source)
    triggerClientEvent(root, "showCustomMessage", resourceRoot, string.format("#1ba3f3[EVENT] #cccccc%s", plrName), "#cccccc"..msg, "files/images/megaphone.png")
end
addEvent("adminNotiChat2", true)
addEventHandler("adminNotiChat2", root, adminNotiChat2)
exports.TR_chat:addCommand("eventinfo", "adminNotiChat2")

function createAdminEvent(type, price)
    if not isPlayerOnDuty(source) then return end

    if not type or not price then
        triggerClientEvent(source, "showCustomMessage", resourceRoot, "#008a2eUżycie komendy", "#438f5c/sevent (typ) (nagroda)\nMD - Monster Derby (nagroda dla wygranego)\nCD - Crossed Derby (nagroda dla wygranego)\nRD - Random Derby (nagroda dla wygranego)\nOX - Prawda / Fałsz (nagroda dla wygranego, wymagany admin)\nPB - Pirate Boarding (nagroda podzielona na członków drużyny)\nFO - Falling Boards (nagroda podzielona na członków drużyny)", "files/images/command.png")
        return
    end

    if not exports.TR_events:canCreateEvent(source) then return end

    if not exports.TR_events:isEventExists(type) then
        exports.TR_noti:create(source, "Taki event nie istnieje.", "error")
        return
    end

    local price = tonumber(price)
    if not price then
        exports.TR_noti:create(source, "Wpisana kwota jest niepoprawna.", "error")
        return
    end

    if price < 0 then
        exports.TR_noti:create(source, "Wpisana kwota jest niepoprawna.", "error")
        return
    end

    triggerClientEvent(source, "payForAdminEvent", resourceRoot, type, price)
end
addEvent("createAdminEvent", true)
addEventHandler("createAdminEvent", root, createAdminEvent)
exports.TR_chat:addCommand("sevent", "createAdminEvent")



-- Developers
function cmd_gp(plr, cmd)
    if not isPlayerOnDuty(plr) then return end
    if not hasPlayerPermission(plr, "isDev") then return end
	local x,y,z = getElementPosition(plr)
	local _,_,rz = getElementRotation(plr)
	local int = getElementInterior(plr)
	local dim = getElementDimension(plr)
	outputChatBox(x..", "..y..", "..z..", "..rz, plr)
	outputChatBox("int: "..int.." dim: "..dim, plr)
end
addCommandHandler("gp", cmd_gp)

addCommandHandler("setslots", function(source, cmd, count)
    if not isPlayerOnDuty(source) then return end
    if not hasPlayerPermission(source, "isDev") then return end

    local slots = tonumber(count)
    if slots == nil then return end

    if slots > 500 then slots = 500 end
    setMaxPlayers(slots)

    exports.TR_noti:create(source, string.format("Sloty zostały ustawione na %d.", slots), "success")
end)

addCommandHandler("setpasswd", function(source, cmd, pass)
    if not isPlayerOnDuty(source) then return end
    if not hasPlayerPermission(source, "isDev") then return end

    setServerPassword("")
end)

local sceneEnabled = false
function adminScene(...)
    if not isPlayerOnDuty(source) then return end
    if not hasPlayerPermission(source, "isDev") then return end

    if sceneEnabled then
        exports.TR_starter:stopResources({"eventScene"})
        exports.TR_noti:create(source, "Scena została wyłączona.", "system")
        sceneEnabled = nil
    else
        exports.TR_starter:startResources({"eventScene"})
        exports.TR_noti:create(source, "Scena została włączona.", "system")
        sceneEnabled = true
    end
end
addEvent("adminScene", true)
addEventHandler("adminScene", root, adminScene)
exports.TR_chat:addCommand("scene", "adminScene")


-- Teleport creator
function ctp(slots)
    if not isPlayerOnDuty(source) then return end
    local slots = tonumber(slots)
    if not slots then triggerClientEvent(source, "showCustomMessage", resourceRoot, "#008a2eUżycie komendy", "#438f5c/ctp (ilość slotów)", "files/images/command.png") return end

    if adminTeleports[source] then exports.TR_noti:create(source, "Masz już utworzony jeden teleport. Musisz go najpierw usunąć aby stworzyć nowy.", "error") return end

    local pos = Vector3(getElementPosition(source))
    local int = getElementInterior(source)
    local dim = getElementDimension(source)
    local adminName = getPlayerName(source)
    adminTeleports[source] = {
        slots = slots,
        pos = pos,
        element = createElement("adminTP"),
        int = int,
        dim = dim,
        players = {},
    }
    setElementPosition(adminTeleports[source].element, pos)
    setElementInterior(adminTeleports[source].element, int)
    setElementDimension(adminTeleports[source].element, dim)

    setElementData(adminTeleports[source].element, "data", {
        slots = slots,
        admin = adminName,
    })

    exports.TR_noti:create(source, "Teleport został stworzony pomyślnie.", "success")
    exports.TR_noti:create(root, string.format("Administrator %s stworzył teleport.\n/tpa %s aby się teleportować.", adminName, adminName), "system", 10)
end
addEvent("ctpAdminPoint", true)
addEventHandler("ctpAdminPoint", root, ctp)
exports.TR_chat:addCommand("ctp", "ctpAdminPoint")

function dtp()
    if not isPlayerOnDuty(source) then return end
    if not adminTeleports[source] then exports.TR_noti:create(source, "Nie masz stworzonego żadnego teleportu.", "error") return end

    destroyElement(adminTeleports[source].element)
    adminTeleports[source] = nil

    exports.TR_noti:create(source, "Twój teleport został pomyślnie usunięty.", "success")
end
addEvent("dtpAdminPoint", true)
addEventHandler("dtpAdminPoint", root, dtp)
exports.TR_chat:addCommand("dtp", "dtpAdminPoint")

function tpa(playerID)
    if not playerID then triggerClientEvent(source, "showCustomMessage", resourceRoot, "#008a2eUżycie komendy", "#438f5c/tpa (ID/Nick)", "files/images/command.png") return end

    local admin = getElementByID("ID"..playerID)
    if not admin then admin = getPlayerFromName(playerID) end
    if not admin or not adminTeleports[admin] then exports.TR_noti:create(source, "Ten administrator nie stworzył żadnego punktu teleportacji.", "error") return end
    if adminTeleports[admin].slots <= 0 then exports.TR_noti:create(source, "Wszystkie miejsca na ten teleport zostały wykorzystane.", "error") return end
    if adminTeleports[admin].players[source] then exports.TR_noti:create(source, "Skorzystałeś już z tego teleportu.", "error") return end

    adminTeleports[admin].players[source] = true
    adminTeleports[admin].slots = adminTeleports[admin].slots - 1

    local data = getElementData(adminTeleports[admin].element, "data")
    data.slots = data.slots - 1
    setElementData(adminTeleports[admin].element, "data", data)

    removePedFromVehicle(source)
    setElementPosition(source, adminTeleports[admin].pos)
    setElementInterior(source, adminTeleports[admin].int)
    setElementDimension(source, adminTeleports[admin].dim)

    exports.TR_noti:create(source, "Pomyślnie przeniosłeś się do punktu administratorskiego.", "success")

    if adminTeleports[admin].slots <= 0 then
        destroyElement(adminTeleports[admin].element)
        adminTeleports[admin] = nil
    end
end
addEvent("tpaAdminPoint", true)
addEventHandler("tpaAdminPoint", root, tpa)
exports.TR_chat:addCommand("tpa", "tpaAdminPoint")

-- Utils
function reconnectPlayer()
    redirectPlayer(source, getServerConfigSetting("serverip"), getServerPort())
end
addEvent("reconnectPlayer", true)
addEventHandler("reconnectPlayer", root, reconnectPlayer)
exports.TR_chat:addCommand("reconnect", "reconnectPlayer")


function findPlayer(plr, id)
    local target = getElementByID("ID"..id)
    if not target then target = getPlayerFromName(id) end
    if not target or not isElement(target) then exports.TR_noti:create(plr, "Podany gracz nie został znaleziony.", "error") return false end
    return target
end

function getAdminRank(plr)
    local rank = getElementData(plr, "adminDuty")
    if not rank then return false end

    if string.find(rank, "owner") then return "#7e0f0f[Z]" end
    if string.find(rank, "guardian") then return "#e73f0b[G]" end
    if string.find(rank, "admin") then return "#da1717[A]" end
    if string.find(rank, "moderator") then return "#0f6c10[M]" end
    if string.find(rank, "support") then return "#1ba3f3[S]" end
    if string.find(rank, "developer") then return "#9424b4[D]" end
end

function isVehicleModelAvaliable(model)
    for i, v in pairs(avaliableModels) do
        if v == model then return true end
    end
    return false
end