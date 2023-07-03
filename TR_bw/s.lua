local damageTypes = {
    [19] = "zginął rakietą",
    [37] = "spalił się",
    [49] = "został staranowany",
    [50] = "został pocięty śmiegłem",
    [51] = "wybuchł",
    [52] = "w wyniku driveby",
    [53] = "utonął",
    [54] = "spadł z wysokości",
    [55] = "??",
    [56] = "zginął w wyniku walki wręcz",
    [57] = "zginął ze strzału z bronii",
    [59] = "zginął w wyniku wybuchu czołgu",
    [63] = "wybuchł"
}

function onPlayerDied(ammo, killer, weapon, bodypart)
    exports.TR_weaponSlots:takeAllWeapons(source)
    setElementData(source, "weapons", false)
    setElementData(source, "fakeWeapons", false)

    local skin = getElementModel(source)
    local int = getElementInterior(source)
    local dim = getElementDimension(source)
    local pos = Vector3(getElementPosition(source))

    spawnPlayer(source, pos, 0, skin, int, dim)
    setElementHealth(source, 1)

    setPlayerInBW(source)

    --print(getPlayerName(killer))

    if not source then return end

    if isElement(killer) then
        if getElementType(killer) == "player" then

            outputConsole(string.format("Zostałeś zabity przez gracza %s.", getPlayerName(killer)), source)

            local time = getRealTime()
            local tf = string.format("[%02d:%02d %02d.%02d]", time.hour, time.minute, time.monthday, time.month)


                exports.TR_discord:remoteDsc(tf.." | "..string.format("**%s** zabił gracza **%s** przy użyciu **%s**", getPlayerName(killer), getPlayerName(source), getWeaponNameFromID(weapon)), "bw")
        elseif getElementType(killer) == "vehicle" then
            local driver = getVehicleOccupant(killer, 0)
            if driver then

                outputConsole(string.format("Zostałeś przejechany przez gracza %s.", getPlayerName(driver)), source)

            else

            end
        end

    elseif damageTypes[weapon] then

    end
end
addEventHandler("onPlayerWasted", root, onPlayerDied)


function setPlayerInBW(plr)
    local uid = getElementData(plr, "characterUID")
    if not uid then return end

    if exports.TR_events:isPlayerOnEvent(plr) then
        exports.TR_events:playerLoseEvent(plr, true)
        triggerClientEvent(plr, "endBW", resourceRoot)
        return
    end

    local time = 60
    -- if not isElementWithinColShape(plr, DMzone) then
    --     time = 300
    -- end

    exports.TR_fractions:addFractionCustomRequest("m", plr, "Stracił przytomność.", {getElementPosition(plr)})

    exports.TR_mysql:querry("UPDATE tr_accounts SET bwTime = ? WHERE bwTime IS NULL AND UID = ? LIMIT 1", time, uid)

    setPedAnimation(source, "PED", "KO_shot_front", -1, false, false, false, true)
    setElementData(source, "animation", {"PED", "KO_shot_front", true})

    local cuffed = getElementData(plr, "cuffed")
    local cuffedBy = getElementData(plr, "cuffedBy")
    if cuffed then
        detachElements(cuffed, plr)
        removeElementData(plr, "cuffed")
        removeElementData(cuffed, "cuffedBy")
        removeElementData(cuffed, "animation")

    elseif cuffedBy then
        detachElements(plr, cuffedBy)
        removeElementData(plr, "cuffedBy")
        removeElementData(cuffedBy, "cuffed")
        removeElementData(cuffedBy, "animation")
    end
end
addEvent("setPlayerInBW", true)
addEventHandler("setPlayerInBW", resourceRoot, setPlayerInBW)

function updatePlayerBwTime(time, blockAnim)
    local uid = getElementData(client, "characterUID")
    if not uid then return end

    if time == 0 then
        exports.TR_mysql:querry("UPDATE tr_accounts SET bwTime = NULL WHERE bwTime IS NOT NULL AND UID = ? LIMIT 1", uid)
        if not getPedOccupiedVehicle(client) then
            if not getElementData(client, "cuffedBy") and not blockAnim then
                setPedAnimation(client, "PED", "getup_front", -1, false, false, false, false)
            end
        end
    else
        exports.TR_mysql:querry("UPDATE tr_accounts SET bwTime = ? WHERE bwTime IS NOT NULL AND UID = ? LIMIT 1", time, uid)
    end
end
addEvent("updatePlayerBwTime", true)
addEventHandler("updatePlayerBwTime", resourceRoot, updatePlayerBwTime)


function removePlayerBW(targetID)
    if not exports.TR_admin:hasPlayerPermission(source, "bwOff") then return end
    if not targetID then triggerClientEvent(source, "showCustomMessage", resourceRoot, "#008a2eUżycie komendy", "#438f5c/bwoff (id gracza)", "files/images/command.png") return end

    local target = getElementByID("ID"..targetID)
    if not target then exports.TR_noti:create(source, "Podany gracz nie został znaleziony.", "error") return end

    triggerClientEvent(target, "endBW", resourceRoot)
    exports.TR_noti:create(source, string.format("Gracz %s został ocucony.", getPlayerName(target)), "system")
    exports.TR_noti:create(target, string.format("Administrator %s ocucił cię.", getPlayerName(source)), "system")
end
addEvent("removePlayerBW", true)
addEventHandler("removePlayerBW", root, removePlayerBW)
exports.TR_chat:addCommand("bwoff", "removePlayerBW")

addCommandHandler("bwoff", function(source, cmd, targetID)
    if not exports.TR_admin:hasPlayerPermission(source, "bwOff") then return end
    if not targetID then triggerClientEvent(source, "showCustomMessage", resourceRoot, "#008a2eUżycie komendy", "#438f5c/bwoff (id gracza)", "files/images/command.png") return end

    local target = getElementByID("ID"..targetID)
    if not target then exports.TR_noti:create(source, "Podany gracz nie został znaleziony.", "error") return end

    triggerClientEvent(target, "endBW", resourceRoot)
    exports.TR_noti:create(source, string.format("Gracz %s został ocucony.", getPlayerName(target)), "system")
    exports.TR_noti:create(target, string.format("Administrator %s ocucił cię.", getPlayerName(source)), "system")
end)

function getNearestHospital(plr)
    local nearestHospital, closestDist = false, 99999999
    local plrPos = Vector3(getElementPosition(plr))
    for i, v in pairs(hospitals) do
        local dist = getDistanceBetweenPoints3D(plrPos, v.pos)
        if dist < closestDist then
            closestDist = dist
            nearestHospital = v.pos
        end
    end
    return nearestHospital
end