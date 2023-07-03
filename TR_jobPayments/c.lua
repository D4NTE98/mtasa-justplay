settings = {
    paymentBonus = 1,
    jobRooms = {},
}

function giveJobPayment(amount, paymentType, jobID)
    local uid = getElementData(localPlayer, "characterUID")
    local payment, ticket, ticketFull = calculatePlayerPayment(amount)

    local orgID, moneyToOrg = giveMoneyToOrganization(amount)

    local pointsAdd = nil
    if math.random(1, 10) <= 2 then
        pointsAdd = math.random(1, 3)
        setElementData(localPlayer, "characterPoints", getElementData(localPlayer, "characterPoints") + pointsAdd)
    end

    --payment = payment - (payment/0.2) -- podatek dla urzedu miasta sf

    if pointsAdd then
        exports.TR_noti:create(string.format("Za wykonaną pracę zarobiłeś $%.2f oraz %d pkt doświadczenia.", payment, pointsAdd), "money")
    else
        exports.TR_noti:create(string.format("Za wykonaną pracę zarobiłeś $%.2f.", payment), "money")
    end
    if ticket then exports.TR_noti:create(string.format("Wypłata została pomniejszona o kwotę $%.2f, ze względu na nieopłacone mandaty. Do opłacenia mandatów pozostało $%.2f.", ticket, ticketFull), "info", 5) end

    if not paymentType or paymentType == "cash" then
        triggerServerEvent("syncJobPayment", resourceRoot, uid, payment + settings.paymentBonus, "cash", jobID, orgID, moneyToOrg)
    else
        triggerServerEvent("syncJobPayment", resourceRoot, uid, payment + settings.paymentBonus, "bank", jobID, orgID, moneyToOrg)
    end

    triggerEvent("addAchievements", resourceRoot, "firstMoney")
end


function giveMoneyToOrganization(amount)
    local orgID = getElementData(localPlayer, "characterOrgID")
    local orgType = getElementData(localPlayer, "characterOrgType")
    if not orgID or orgType == "crime" then return false, false end

    local moneyPercent = getElementData(localPlayer, "characterOrgMoneyPercent") or 0
    local percent = tonumber(moneyPercent)/100 + 0.05
    local money = math.floor(amount * percent * 100)/100

    -- local orgMoneyAdd = getElementData(localPlayer, "orgMoneyAdd")
    -- if not orgMoneyAdd then
    --     setElementData(localPlayer, "orgMoneyAdd", {
    --         total = money,
    --         count = 1,
    --     }, false)
    --     return false, false
    -- end
    -- if orgMoneyAdd.count < 2 then
    --     setElementData(localPlayer, "orgMoneyAdd", {
    --         total = orgMoneyAdd.total + money,
    --         count = orgMoneyAdd.count + 1,
    --     }, false)
    --     return false, false
    -- end

    -- local moneyCount = orgMoneyAdd.total + money

    -- setElementData(localPlayer, "orgMoneyAdd", {
    --     total = 0,
    --     count = 0,
    -- }, false)

    return orgID, money
end

function calculatePlayerPayment(amount)
    local data = getElementData(localPlayer, "characterData")
    local multiplayer = settings.paymentBonus

    if data.premium == "diamond" then multiplayer = multiplayer + 0.1
    elseif data.premium == "gold" then multiplayer = multiplayer + 0.05 end

    local totalPrice = amount * multiplayer
    local forTicket = false
    local ticketPrice = false

    local ticketPrice = getElementData(localPlayer, "ticketPrice")
    if ticketPrice then
        if ticketPrice > 0 then
            forTicket = math.min(totalPrice * 0.25, ticketPrice)

            totalPrice = totalPrice - forTicket
            ticketPrice = ticketPrice - forTicket

            setElementData(localPlayer, "ticketPrice", ticketPrice)
        end
    end

    return totalPrice, forTicket, ticketPrice
end

function checkJobMultiplayerEvents(time)

    local time = settings.serverTime
    if time then
        if time.weekday == 0 then
            if time.hour >= 19 and time.hour < 24 then
                if settings.paymentBonus ~= 2.5 then
                    settings.paymentBonus = 2.5
                    openPaymentInfo({
                        title = "Happy Sunday",
                        desc = "Jako iż wybiła już godzina 19:00 rozpoczął się event, dzięki któremu możecie zwiększyć ilość gotówki w swoim portfelu.",
                        gift = "Zarobek został zwiększony o 50% aż do godziny 24:00!",
                        type = "constant",
                    })
                end
                return
            end
       end
    end

    if settings.paymentBonus ~= 1 then
        openPaymentInfo({
            title = settings.lastEventTitle,
            desc = "Cieszymy się, że wpadliście na organizowany przez nas event zarobkowy. Mamy nadzieję, że na następnym spotkamy się w równie licznym gronie!",
            gift = "Zarobek powrócił do normalności!",
            type = "end",
        })
        settings.paymentBonus = 1
    end
end

function openPaymentInfo(...)
    settings.info:show(...)
end

function startCheckingJobPayments()
    checkJobMultiplayerEvents()
    setTimer(checkJobMultiplayerEvents, 5000, 0)
    triggerServerEvent("requestServerTime", resourceRoot)
end

function updateServerTime(time)
    settings.serverTime = time
end
addEvent("updateServerTime", true)
addEventHandler("updateServerTime", root, updateServerTime)

if getElementData(localPlayer, "characterUID") then setTimer(startCheckingJobPayments, 1000, 1) end