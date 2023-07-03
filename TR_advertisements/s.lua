local data = {
    adverts = {},
    advertPlayers = {},
}

function openAdvert()
    data.timer = nil

    local info = data.adverts[1]
    data.advertPlayers[info.sender] = nil
    triggerClientEvent(root, "openAdvert", resourceRoot, info.sender, info.text)

    

    table.remove(data.adverts, 1)

    createTimer()
end

function createTimer()
    if data.timer then return end
    if #data.adverts < 1 then return end

    data.timer = setTimer(openAdvert, 12000, 1)
end

function addAdvert(sender, text)
    if data.advertPlayers[sender] then return exports.TR_noti:create(source, "Nie możesz dodać kolejnego ogłoszenia, ponieważ już posiadasz jedno w kolejce.", "error") end
    if #data.adverts >= 10 then return exports.TR_noti:create(source, "Twoje ogłoszenie nie zostało dodane, ponieważ w kolejce jest zbyt dużo ogłoszeń.", "error") end
    if string.len(text) < 5 then return exports.TR_noti:create(source, "Za krótkie ogłoszenie.", "error") end

    data.advertPlayers[sender] = true
    table.insert(data.adverts, #data.adverts + 1, {
        sender = sender,
        text = text,
    })

    exports.TR_noti:create(source, "Twoje ogłoszenie zostało dodane do kolejki.", "success")

    createTimer()
end
addEvent("addAdvert", true)
addEventHandler("addAdvert", root, addAdvert)

function addAdvertForPremium(...)
    local data = getElementData(source, "characterData")
    if not data then return print('brak eldaty characterData') end
    if data.premium == 'diamond' or data.premium == 'gold' then
    --if not exports.TR_chat:hasPlayerMute(source, true) then exports.TR_noti:create("Nie możesz dodać ogłoszenia, ponieważ zostałeś wyciszony przez administratora.", "error") return end

    local msg = table.concat({...}, " ")
    addAdvert(getPlayerName(source), msg)

    print('dodane ogłoszenie')
end
end
addEvent("addAdvertForPremium", true)
addEventHandler("addAdvertForPremium", root, addAdvertForPremium)
exports.TR_chat:addCommand("ogloszenie", "addAdvertForPremium")