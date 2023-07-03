function openAtm()
    local uid = getElementData(client, "characterUID")
    if not uid then return end
    local querry = exports.TR_mysql:querry("SELECT bankmoney FROM tr_accounts WHERE UID = ?", uid)
    if querry and querry[1] then
        triggerClientEvent(client, "createAtm", resourceRoot, querry[1].bankmoney)
    else
        triggerClientEvent(client, "createAtm", resourceRoot, false)
    end
end
addEvent("openAtm", true)
addEventHandler("openAtm", root, openAtm)

function withdrawAtm(amount)
    local uid = getElementData(client, "characterUID")
    if not uid then return end
    if exports.TR_core:takeBankMoneyFromPlayer(client, amount) then
        exports.TR_core:giveMoneyToPlayer(client, amount)
        triggerClientEvent(client, "responseAtm", resourceRoot, true, string.format("Pomyślnie wypłacono $%.2f.", amount), "success", -amount)
    else
        triggerClientEvent(client, "responseAtm", resourceRoot, false, "Nie posiadasz na koncie tyle pieniędzy.", "error")
    end
end
addEvent("withdrawAtm", true)
addEventHandler("withdrawAtm", root, withdrawAtm)

function depositAtm(amount)
    local uid = getElementData(client, "characterUID")
    if not uid then return end
    if exports.TR_core:takeMoneyFromPlayer(client, amount) then
        exports.TR_core:giveBankMoneyToPlayer(client, amount)
        triggerClientEvent(client, "responseAtm", resourceRoot, true, string.format("Pomyślnie wpłacono $%.2f.", amount), "success", amount)
    else
        triggerClientEvent(client, "responseAtm", resourceRoot, false, "Nie posiadasz przy sobie tyle pieniędzy.", "error")
    end
end
addEvent("depositAtm", true)
addEventHandler("depositAtm", root, depositAtm)

function createPin(pin)
    local uid = getElementData(client, "characterUID")
    if not uid then return end

    if exports.TR_core:takeMoneyFromPlayer(client, 200) then
        exports.TR_mysql:querry("UPDATE tr_accounts SET bankcode = ? WHERE UID = ?", pin, uid)
        exports.TR_noti:create(client, "Konto bankowe zostało pomyślnie założone.", "success")

        local plrData = getElementData(client, "characterData")
        plrData.bankcode = pin
        setElementData(client, "characterData", plrData)
    else
        exports.TR_noti:create(client, "Nie posiadasz przy sobie tyle pieniędzy aby założyć konto.", "error")
    end
end
addEvent("createPin", true)
addEventHandler("createPin", resourceRoot, createPin)