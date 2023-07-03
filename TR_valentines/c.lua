local sx, sy = guiGetScreenSize()
local zoom = 1
local baseX = 1920;
local minZoom = 2
if sx < baseX then
    zoom = math.min(minZoom, baseX/sx)
end

local guiInfo = {
    x = (sx - 1160/zoom)/2,
    y = (sy - 420/zoom)/2,
    w = 1160/zoom,
    h = 420/zoom,
}

PrizePicker = {}
PrizePicker.__index = PrizePicker

function PrizePicker:create(...)
    local instance = {}
    setmetatable(instance, PrizePicker)
    if instance:constructor(...) then
        return instance
    end
    return false
end

function PrizePicker:constructor(...)
    self.alpha = 0
    self:buildData(arg[1])

    self.fonts = {}
    self.fonts.main = exports.TR_dx:getFont(14)
    self.fonts.prize = exports.TR_dx:getFont(12)
    self.fonts.limit = exports.TR_dx:getFont(10)

    self.func = {}
    self.func.render = function() self:render() end
    self.func.onClick = function(...) self:onClick(...) end

    self:open()
    return true
end

function PrizePicker:buildData(data)
    self.prizeData = {
        money = 0,
        gold = 0,
        diamond = 0,
        vehicle = 0,
        house = 0,
    }
end

function PrizePicker:open()
    self.state = "opening"
    self.tick = getTickCount()

    showCursor(true)
    addEventHandler("onClientRender", root, self.func.render)
    addEventHandler("onClientClick", root, self.func.onClick)
end

function PrizePicker:close()
    self.state = "closing"
    self.tick = getTickCount()

    showCursor(false)
    setElementFrozen(localPlayer, false)
    removeEventHandler("onClientClick", root, self.func.onClick)
end

function PrizePicker:destroy()
    removeEventHandler("onClientRender", root, self.func.render)

    guiInfo.picker = nil
    self = nil
end

function PrizePicker:animate()
    if not self.tick then return end
    local progress = (getTickCount() - self.tick)/500
    if self.state == "opening" then
      self.alpha = interpolateBetween(0, 0, 0, 1, 0, 0, progress, "Linear")
      if progress >= 1 then
        self.alpha = 1
        self.state = "opened"
        self.tick = nil
      end

    elseif self.state == "closing" then
      self.alpha = interpolateBetween(1, 0, 0, 0, 0, 0, progress, "Linear")
      if progress >= 1 then
        self.alpha = 0
        self.state = "closed"
        self.tick = nil

        self:destroy()
        return true
      end
    end
end

function PrizePicker:render()
    self:animate()

    self:drawBackground(guiInfo.x, guiInfo.y, guiInfo.w, guiInfo.h, tocolor(23,25,31, 255 * self.alpha), 15)
    dxDrawText("Wybierz swoją wymarzoną świąteczną nagrodę", guiInfo.x, guiInfo.y + 10/zoom, guiInfo.x + guiInfo.w, guiInfo.y + 50/zoom, tocolor(44,181,233, 255 * self.alpha), 1/zoom, self.fonts.main, "center")

    if self:isMouseInPosition(guiInfo.x + 59/zoom - 30/zoom, guiInfo.y + 60/zoom, 190/zoom, 300/zoom) and not self.responseEnabled and self.prizeData.money < 3 then
        self:drawBackground(guiInfo.x + 59/zoom - 30/zoom, guiInfo.y + 60/zoom, 190/zoom, 300/zoom, tocolor(42,45,51, 255 * self.alpha), 15)
    else
        self:drawBackground(guiInfo.x + 59/zoom - 30/zoom, guiInfo.y + 60/zoom, 190/zoom, 300/zoom, tocolor(34,36,43, 255 * self.alpha), 15)
    end
    if self:isMouseInPosition(guiInfo.x + 158/zoom + 128/zoom - 30/zoom, guiInfo.y + 60/zoom, 190/zoom, 300/zoom) and not self.responseEnabled and self.prizeData.gold < 3 then
        self:drawBackground(guiInfo.x + 158/zoom + 128/zoom - 30/zoom, guiInfo.y + 60/zoom, 190/zoom, 300/zoom, tocolor(42,45,51, 255 * self.alpha), 15)
    else
        self:drawBackground(guiInfo.x + 158/zoom + 128/zoom - 30/zoom, guiInfo.y + 60/zoom, 190/zoom, 300/zoom, tocolor(34,36,43, 255 * self.alpha), 15)
    end
    if self:isMouseInPosition(guiInfo.x + 257/zoom + 128/zoom * 2 - 30/zoom, guiInfo.y + 60/zoom, 190/zoom, 300/zoom) and not self.responseEnabled and self.prizeData.diamond < 3 then
        self:drawBackground(guiInfo.x + 257/zoom + 128/zoom * 2 - 30/zoom, guiInfo.y + 60/zoom, 190/zoom, 300/zoom, tocolor(42,45,51, 255 * self.alpha), 15)
    else
        self:drawBackground(guiInfo.x + 257/zoom + 128/zoom * 2 - 30/zoom, guiInfo.y + 60/zoom, 190/zoom, 300/zoom, tocolor(34,36,43, 255 * self.alpha), 15)
    end
    if self:isMouseInPosition(guiInfo.x + 356/zoom + 128/zoom * 3 - 30/zoom, guiInfo.y + 60/zoom, 190/zoom, 300/zoom) and not self.responseEnabled and self.prizeData.vehicle < 3 then
        self:drawBackground(guiInfo.x + 356/zoom + 128/zoom * 3 - 30/zoom, guiInfo.y + 60/zoom, 190/zoom, 300/zoom, tocolor(42,45,51, 255 * self.alpha), 15)
    else
        self:drawBackground(guiInfo.x + 356/zoom + 128/zoom * 3 - 30/zoom, guiInfo.y + 60/zoom, 190/zoom, 300/zoom, tocolor(34,36,43, 255 * self.alpha), 15)
    end
    if self:isMouseInPosition(guiInfo.x + 455/zoom + 128/zoom * 4 - 30/zoom, guiInfo.y + 60/zoom, 190/zoom, 300/zoom) and not self.responseEnabled and self.prizeData.house < 3 then
        self:drawBackground(guiInfo.x + 455/zoom + 128/zoom * 4 - 30/zoom, guiInfo.y + 60/zoom, 190/zoom, 300/zoom, tocolor(42,45,51, 255 * self.alpha), 15)
    else
        self:drawBackground(guiInfo.x + 455/zoom + 128/zoom * 4 - 30/zoom, guiInfo.y + 60/zoom, 190/zoom, 300/zoom, tocolor(34,36,43, 255 * self.alpha), 15)
    end

    dxDrawImage(guiInfo.x + 59/zoom, guiInfo.y + 70/zoom, 128/zoom, 128/zoom, "files/images/money.png", 0, 0, 0, tocolor(255, 255, 255, 255 * self.alpha))
    dxDrawImage(guiInfo.x + 158/zoom + 128/zoom, guiInfo.y + 70/zoom, 128/zoom, 128/zoom, "files/images/crown.png", 0, 0, 0, tocolor(255, 255, 255, 255 * self.alpha))
    dxDrawImage(guiInfo.x + 257/zoom + 128/zoom * 2, guiInfo.y + 70/zoom, 128/zoom, 128/zoom, "files/images/diamond.png", 0, 0, 0, tocolor(255, 255, 255, 255 * self.alpha))
    dxDrawImage(guiInfo.x + 356/zoom + 128/zoom * 3, guiInfo.y + 70/zoom, 128/zoom, 128/zoom, "files/images/garage.png", 0, 0, 0, tocolor(255, 255, 255, 255 * self.alpha))
    dxDrawImage(guiInfo.x + 455/zoom + 128/zoom * 4, guiInfo.y + 70/zoom, 128/zoom, 128/zoom, "files/images/house.png", 0, 0, 0, tocolor(255, 255, 255, 255 * self.alpha))

    dxDrawText("PIENIĄDZE", guiInfo.x + 59/zoom, guiInfo.y + 210/zoom, guiInfo.x + 59/zoom + 128/zoom, guiInfo.y + 200/zoom, tocolor(150, 204, 127, 255 * self.alpha), 1/zoom, self.fonts.main, "center", "top")
    dxDrawText("GOLD", guiInfo.x + 158/zoom + 128/zoom, guiInfo.y + 210/zoom, guiInfo.x + 158/zoom + 128/zoom * 2, guiInfo.y + 200/zoom, tocolor(255, 193, 7, 255 * self.alpha), 1/zoom, self.fonts.main, "center", "top")
    dxDrawText("DIAMOND", guiInfo.x + 257/zoom + 128/zoom * 2, guiInfo.y + 210/zoom, guiInfo.x + 257/zoom + 128/zoom * 3, guiInfo.y + 200/zoom, tocolor(80, 230, 255, 255 * self.alpha), 1/zoom, self.fonts.main, "center", "top")
    dxDrawText("POJAZD", guiInfo.x + 356/zoom + 128/zoom * 3, guiInfo.y + 210/zoom, guiInfo.x + 356/zoom + 128/zoom * 4, guiInfo.y + 200/zoom, tocolor(193, 55, 39, 255 * self.alpha), 1/zoom, self.fonts.main, "center", "top")
    dxDrawText("POSIADŁOŚĆ", guiInfo.x + 455/zoom + 128/zoom * 4, guiInfo.y + 210/zoom, guiInfo.x + 455/zoom + 128/zoom * 5, guiInfo.y + 200/zoom, tocolor(229, 210, 184, 255 * self.alpha), 1/zoom, self.fonts.main, "center", "top")

    dxDrawText("$8000", guiInfo.x + 59/zoom, guiInfo.y + 235/zoom, guiInfo.x + 59/zoom + 128/zoom, guiInfo.y + 200/zoom, tocolor(220, 220, 220, 255 * self.alpha), 1/zoom, self.fonts.prize, "center", "top")
    dxDrawText("5 DNI", guiInfo.x + 158/zoom + 128/zoom, guiInfo.y + 235/zoom, guiInfo.x + 158/zoom + 128/zoom * 2, guiInfo.y + 200/zoom, tocolor(220, 220, 220, 255 * self.alpha), 1/zoom, self.fonts.prize, "center", "top")
    dxDrawText("2 DNI", guiInfo.x + 257/zoom + 128/zoom * 2, guiInfo.y + 235/zoom, guiInfo.x + 257/zoom + 128/zoom * 3, guiInfo.y + 200/zoom, tocolor(220, 220, 220, 255 * self.alpha), 1/zoom, self.fonts.prize, "center", "top")
    dxDrawText("+1 MIEJSCE", guiInfo.x + 356/zoom + 128/zoom * 3, guiInfo.y + 235/zoom, guiInfo.x + 356/zoom + 128/zoom * 4, guiInfo.y + 200/zoom, tocolor(220, 220, 220, 255 * self.alpha), 1/zoom, self.fonts.prize, "center", "top")
    dxDrawText("+1 MIEJSCE", guiInfo.x + 455/zoom + 128/zoom * 4, guiInfo.y + 235/zoom, guiInfo.x + 455/zoom + 128/zoom * 5, guiInfo.y + 200/zoom, tocolor(220, 220, 220, 255 * self.alpha), 1/zoom, self.fonts.prize, "center", "top")

    dxDrawText("Lubisz wydawać pieniądze? Każdy lubi! Ten mały zastrzyk pieniężny może ci pomóc w rozwoju.", guiInfo.x + 49/zoom, guiInfo.y + 260/zoom, guiInfo.x + 69/zoom + 128/zoom, guiInfo.y + 200/zoom, tocolor(170, 170, 170, 255 * self.alpha), 1/zoom, self.fonts.limit, "center", "top", false, true)
    dxDrawText("Jeśli chcesz poczuć się wyróżniony na serwerze, zawsze możesz dołączyć do grona graczy premium!", guiInfo.x + 148/zoom + 128/zoom, guiInfo.y + 260/zoom, guiInfo.x + 168/zoom + 128/zoom * 2, guiInfo.y + 200/zoom, tocolor(170, 170, 170, 255 * self.alpha), 1/zoom, self.fonts.limit, "center", "top", false, true)
    dxDrawText("Chcesz stać się najbardziej prestiżową osobą na serwerze? Ten prezent jest idealny dla Ciebie!", guiInfo.x + 247/zoom + 128/zoom * 2, guiInfo.y + 260/zoom, guiInfo.x + 267/zoom + 128/zoom * 3, guiInfo.y + 200/zoom, tocolor(170, 170, 170, 255 * self.alpha), 1/zoom, self.fonts.limit, "center", "top", false, true)
    dxDrawText("Lubisz kolekcjonować samochody, ale brakuje ci miejsca? Od teraz twoje marzenie może się spełnić!", guiInfo.x + 346/zoom + 128/zoom * 3, guiInfo.y + 260/zoom, guiInfo.x + 366/zoom + 128/zoom * 4, guiInfo.y + 200/zoom, tocolor(170, 170, 170, 255 * self.alpha), 1/zoom, self.fonts.limit, "center", "top", false, true)
    dxDrawText("Jeśli uważasz, że jedna posiadłość to za mało, zawsze może się to zmienić. Przyszła pora na nowy zakup!", guiInfo.x + 445/zoom + 128/zoom * 4, guiInfo.y + 260/zoom, guiInfo.x + 465/zoom + 128/zoom * 5, guiInfo.y + 200/zoom, tocolor(170, 170, 170, 255 * self.alpha), 1/zoom, self.fonts.limit, "center", "top", false, true)

    dxDrawText("Wszystkie prezenty wybieraj mądrze. Święty Mikołaj nie pozwoli abyś dostał wszystkie, ponieważ nie jesteś jedyną osobą która ich potrzebuje. Wybierz swoją nagrodę rozsądnie! Wesołych świąt!", guiInfo.x + 20/zoom, guiInfo.y + 260/zoom, guiInfo.x + guiInfo.w - 20/zoom, guiInfo.y + guiInfo.h - 10/zoom, tocolor(170, 170, 170, 255 * self.alpha), 1/zoom, self.fonts.limit, "center", "bottom", false, true)
end

function PrizePicker:onClick(btn, state)
    if self.responseEnabled then return end
    if btn == "left" and state == "down" then
        if self:isMouseInPosition(guiInfo.x + 59/zoom - 30/zoom, guiInfo.y + 60/zoom, 190/zoom, 300/zoom) then
            if self.prizeData.money >= 3 then return end

            self.responseEnabled = true
            exports.TR_dx:setResponseEnabled(true)
            triggerServerEvent("playerSelectEventPrize", resourceRoot, "money")

        elseif self:isMouseInPosition(guiInfo.x + 158/zoom + 128/zoom - 30/zoom, guiInfo.y + 60/zoom, 190/zoom, 300/zoom) then
            if self.prizeData.gold >= 3 then return end

            self.responseEnabled = true
            exports.TR_dx:setResponseEnabled(true)
            triggerServerEvent("playerSelectEventPrize", resourceRoot, "gold")

        elseif self:isMouseInPosition(guiInfo.x + 257/zoom + 128/zoom * 2 - 30/zoom, guiInfo.y + 60/zoom, 190/zoom, 300/zoom) then
            if self.prizeData.diamond >= 3 then return end

            self.responseEnabled = true
            exports.TR_dx:setResponseEnabled(true)
            triggerServerEvent("playerSelectEventPrize", resourceRoot, "diamond")

        elseif self:isMouseInPosition(guiInfo.x + 356/zoom + 128/zoom * 3 - 30/zoom, guiInfo.y + 60/zoom, 190/zoom, 300/zoom) then
            if self.prizeData.vehicle >= 3 then return end

            self.responseEnabled = true
            exports.TR_dx:setResponseEnabled(true)
            triggerServerEvent("playerSelectEventPrize", resourceRoot, "garage")

        elseif self:isMouseInPosition(guiInfo.x + 455/zoom + 128/zoom * 4 - 30/zoom, guiInfo.y + 60/zoom, 190/zoom, 300/zoom) then
            if self.prizeData.house >= 3 then return end

            self.responseEnabled = true
            exports.TR_dx:setResponseEnabled(true)
            triggerServerEvent("playerSelectEventPrize", resourceRoot, "houses")
        end
    end
end

function PrizePicker:response(prize)
    exports.TR_dx:setResponseEnabled(false)

    if prize == "money" then
        exports.TR_noti:create("Widzę, że łasy na pieniądze jesteś. Oto twoje\n$8000. Tylko nie wydaj tego na głupoty.", "gift", 10)

    elseif prize == "gold" then
        exports.TR_noti:create("Widzę, że skusiła cię lekka sława. Pamiętaj, że sława potrafi zgubić.", "gift", 10)

    elseif prize == "diamond" then
        exports.TR_noti:create("Widzę, że ktoś tu aspiruje na króla dzielnicy. To dobrze, to dobrze. Powodzenia!", "gift", 10)

    elseif prize == "garage" then
        exports.TR_noti:create("Widzę, że jednak kusi cię większa kolekcja. Chcę kiedyś zobaczyć wszystkie te furki!", "gift", 10)

    elseif prize == "houses" then
        exports.TR_noti:create("Widzę, że jednak chcesz czasami spojrzeć z innego okna na świat. Wykończ go tylko.", "gift", 10)

    end

    self:close()
end

function PrizePicker:drawBackground(x, y, rx, ry, color, radius, post)
    rx = rx - radius * 2
    ry = ry - radius * 2
    x = x + radius
    y = y + radius

    if (rx >= 0) and (ry >= 0) then
      dxDrawRectangle(x, y, rx, ry, color, post)
      dxDrawRectangle(x, y - radius, rx, radius, color, post)
      dxDrawRectangle(x, y + ry, rx, radius, color, post)
      dxDrawRectangle(x - radius, y, radius, ry, color, post)
      dxDrawRectangle(x + rx, y, radius, ry, color, post)

      dxDrawCircle(x, y, radius, 180, 270, color, color, 7, 1, post)
      dxDrawCircle(x + rx, y, radius, 270, 360, color, color, 7, 1, post)
      dxDrawCircle(x + rx, y + ry, radius, 0, 90, color, color, 7, 1, post)
      dxDrawCircle(x, y + ry, radius, 90, 180, color, color, 7, 1, post)
    end
end

function PrizePicker:isMouseInPosition(x, y, width, height)
    if (not isCursorShowing()) then return false end
    local cx, cy = getCursorPosition()
    local cx, cy = (cx*sx), (cy*sy)
    if (cx >= x and cx <= x + width) and (cy >= y and cy <= y + height) then return true end
    return false
end

function openSantaPrizePicker(data, isFirst)
    if guiInfo.picker then return end
    setElementFrozen(localPlayer, true)

    exports.TR_chat:showCustomMessage("Święty Mikołaj", "Jasne. Wybierz co tylko zapragniesz!", "files/images/npc.png")

    guiInfo.picker = PrizePicker:create(data)
end
addEvent("openSantaPrizePicker", true)
addEventHandler("openSantaPrizePicker", root, openSantaPrizePicker)

function playerSelectEventPrize(prize)
    if not guiInfo.picker then return end

    setTimer(function()
        guiInfo.picker:response(prize)
    end, 1000, 1)
end
addEvent("playerSelectEventPrize", true)
addEventHandler("playerSelectEventPrize", root, playerSelectEventPrize)