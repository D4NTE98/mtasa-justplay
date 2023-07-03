local sx, sy = guiGetScreenSize()
local zoom = 1
local baseX = 1900
local minZoom = 2
if sx < baseX then
    zoom = math.min(minZoom, baseX/sx)
end

local guiInfo = {
    x = (sx - 800/zoom)/2,
    y = (sy - 530/zoom)/2,
    w = 800/zoom,
    h = 530/zoom,
}

AdminList = {}
AdminList.__index = AdminList

function AdminList:create(...)
    local instance = {}
    setmetatable(instance, AdminList)
    if instance:constructor(...) then
        return instance
    end
    return false
end

function AdminList:constructor(...)
    self:buildOrgList(arg[1])
    self.scroll = 0

    self.fonts = {}
    self.fonts.main = exports.TR_dx:getFont(14)
    self.fonts.admin = exports.TR_dx:getFont(12)

    self.func = {}
    self.func.render = function() self:render() end
    self.func.onClick = function(...) self:onClick(...) end
    self.func.onScroll = function(...) self:onScroll(...) end

    showCursor(true)
    addEventHandler("onClientRender", root, self.func.render)
    bindKey("mouse1", "down", self.func.onClick)
    bindKey("mouse_wheel_up", "down", self.func.onScroll)
    bindKey("mouse_wheel_down", "down", self.func.onScroll)
    return true
end

function AdminList:close()
    showCursor(false)
    removeEventHandler("onClientRender", root, self.func.render)
    unbindKey("mouse_wheel_up", "down", self.func.onScroll)
    unbindKey("mouse_wheel_down", "down", self.func.onScroll)
    unbindKey("mouse1", "down", self.func.onClick)

    exports.TR_dx:destroyEdit(self.edits)

    guiInfo.panel = nil
    self = nil
end

function AdminList:buildOrgList(...)
    self.organizations = arg[1]

    if not self.edits then
        self.edits = {}
    end

    for i = 1, math.min(#self.organizations, 15) do
        if not self.edits[i] then
            self.edits[i] = exports.TR_dx:createEdit(guiInfo.x + 475/zoom, guiInfo.y + 76/zoom + (i-1) * 30/zoom, 100/zoom, 28/zoom, "r,g,b")
        end

        local v = self.organizations[i]
        if v.zoneColor then
            exports.TR_dx:setEditText(self.edits[i], v.zoneColor)
        end
    end
end

function AdminList:render()
    self:drawBackground(guiInfo.x, guiInfo.y, guiInfo.w, guiInfo.h, tocolor(16,18,23, 255), 14)
    dxDrawText("Lista organizacji", guiInfo.x, guiInfo.y, guiInfo.x + guiInfo.w, guiInfo.y + 50/zoom, tocolor(44,181,233, 255), 1/zoom, self.fonts.main, "center", "center")

    dxDrawText("Organizacja", guiInfo.x + 15/zoom, guiInfo.y + 40/zoom, guiInfo.x + guiInfo.w, guiInfo.y + 70/zoom, tocolor(220, 220, 220, 255), 1/zoom, self.fonts.admin, "left", "center")
    dxDrawText("Właściciel", guiInfo.x + 200/zoom, guiInfo.y + 40/zoom, guiInfo.x + guiInfo.w, guiInfo.y + 70/zoom, tocolor(220, 220, 220, 255), 1/zoom, self.fonts.admin, "left", "center")
    dxDrawText("Typ", guiInfo.x + 370/zoom, guiInfo.y + 40/zoom, guiInfo.x + 420/zoom, guiInfo.y + 70/zoom, tocolor(220, 220, 220, 255), 1/zoom, self.fonts.admin, "center", "center")
    dxDrawText("Kolor strefy", guiInfo.x + 460/zoom, guiInfo.y + 40/zoom, guiInfo.x + 580/zoom, guiInfo.y + 70/zoom, tocolor(220, 220, 220, 255), 1/zoom, self.fonts.admin, "center", "center")
    dxDrawText("Działania", guiInfo.x + guiInfo.w - 150/zoom, guiInfo.y + 40/zoom, guiInfo.x + guiInfo.w - 14/zoom, guiInfo.y + 70/zoom, tocolor(220, 220, 220, 255), 1/zoom, self.fonts.admin, "center", "center")

    dxDrawLine(guiInfo.x + 10/zoom, guiInfo.y + 72/zoom, guiInfo.x + guiInfo.w - 10/zoom, guiInfo.y + 72/zoom, tocolor(44,181,233, 255), 2)

    for i = 1, 15 do
        local v = self.organizations[i + self.scroll]
        if v then
            dxDrawText(v.name, guiInfo.x + 15/zoom, guiInfo.y + 75/zoom + (i-1) * 30/zoom, guiInfo.x, guiInfo.y + 105/zoom + (i-1) * 30/zoom, tocolor(190, 190, 190, 255), 1/zoom, self.fonts.admin, "left", "center")
            dxDrawText(v.username, guiInfo.x + 200/zoom, guiInfo.y + 75/zoom + (i-1) * 30/zoom, guiInfo.x, guiInfo.y + 105/zoom + (i-1) * 30/zoom, tocolor(190, 190, 190, 255), 1/zoom, self.fonts.admin, "left", "center")
            local r,g,b=120,120,120
            if v.type == 'crime' then
                r,g,b=220,25,0
            elseif v.type == 'org' then
                r,g,b=44,181,233
            end
            dxDrawText('X', guiInfo.x + 370/zoom, guiInfo.y + 75/zoom + (i-1) * 30/zoom, guiInfo.x + 420/zoom, guiInfo.y + 105/zoom + (i-1) * 30/zoom, tocolor(r,g,b, 255), 1/zoom, self.fonts.admin, "center", "center")

            if self:isMouseInPosition(guiInfo.x + guiInfo.w - 30/zoom, guiInfo.y + 82/zoom + (i-1) * 30/zoom, 16/zoom, 16/zoom) then
                dxDrawImage(guiInfo.x + guiInfo.w - 30/zoom, guiInfo.y + 82/zoom + (i-1) * 30/zoom, 16/zoom, 16/zoom, "files/images/people.png", 0, 0, 0, tocolor(170, 170, 170, 255))
                self:renderInfo("Ustaw jako cywilna")
            else
                dxDrawImage(guiInfo.x + guiInfo.w - 30/zoom, guiInfo.y + 82/zoom + (i-1) * 30/zoom, 16/zoom, 16/zoom, "files/images/people.png", 0, 0, 0, tocolor(120, 120, 120, 255))
            end
            if self:isMouseInPosition(guiInfo.x + guiInfo.w - 60/zoom, guiInfo.y + 82/zoom + (i-1) * 30/zoom, 16/zoom, 16/zoom) then
                dxDrawImage(guiInfo.x + guiInfo.w - 60/zoom, guiInfo.y + 82/zoom + (i-1) * 30/zoom, 16/zoom, 16/zoom, "files/images/people.png", 0, 0, 0, tocolor(170, 170, 170, 255))
                self:renderInfo("Ustaw jako przestępcza")
            else
                dxDrawImage(guiInfo.x + guiInfo.w - 60/zoom, guiInfo.y + 82/zoom + (i-1) * 30/zoom, 16/zoom, 16/zoom, "files/images/people.png", 0, 0, 0, tocolor(120, 120, 120, 255))
            end
            if self:isMouseInPosition(guiInfo.x + guiInfo.w - 150/zoom, guiInfo.y + 82/zoom + (i-1) * 30/zoom, 16/zoom, 16/zoom) then
                dxDrawImage(guiInfo.x + guiInfo.w - 150/zoom, guiInfo.y + 82/zoom + (i-1) * 30/zoom, 16/zoom, 16/zoom, "files/images/color.png", 0, 0, 0, tocolor(170, 170, 170, 255))
                self:renderInfo("Zmień kolor")
            else
                dxDrawImage(guiInfo.x + guiInfo.w - 150/zoom, guiInfo.y + 82/zoom + (i-1) * 30/zoom, 16/zoom, 16/zoom, "files/images/color.png", 0, 0, 0, tocolor(120, 120, 120, 255))
            end
        end
    end
end

function AdminList:renderInfo(text)
    local cx, cy = getCursorPosition()
    if cx and cy then
        local cx, cy = cx * sx + 7/zoom, cy * sy + 5/zoom
        local width = dxGetTextWidth(text, 1/zoom, self.fonts.admin) + 10/zoom

        self:drawBackground(cx, cy, width, 30/zoom, tocolor(16,18,23, 255), 14, true)
        dxDrawText(text, cx + 5/zoom, cy, cx + width - 5/zoom, cy + 30/zoom, tocolor(170, 170, 170, 255), 1/zoom, self.fonts.admin, "center", "center", false, false, true)
    end
end


function AdminList:onClick()
    if exports.TR_dx:isResponseEnabled() then return end
    for i = 1, 15 do
        local v = self.organizations[i + self.scroll]
        if v then
            if self:isMouseInPosition(guiInfo.x + guiInfo.w - 30/zoom, guiInfo.y + 82/zoom + (i-1) * 30/zoom, 16/zoom, 16/zoom) then
                exports.TR_dx:setResponseEnabled(true)
                triggerServerEvent("changeOrganizationAdminType", resourceRoot, v.ID, "org", false)

            elseif self:isMouseInPosition(guiInfo.x + guiInfo.w - 60/zoom, guiInfo.y + 82/zoom + (i-1) * 30/zoom, 16/zoom, 16/zoom) then
                exports.TR_dx:setResponseEnabled(true)
                triggerServerEvent("changeOrganizationAdminType", resourceRoot, v.ID, "crime", "gang")
            elseif self:isMouseInPosition(guiInfo.x + guiInfo.w - 150/zoom, guiInfo.y + 82/zoom + (i-1) * 30/zoom, 16/zoom, 16/zoom) then
                local text = guiGetText(self.edits[i])
                if string.find(text, " ") then exports.TR_noti:create("Kolor nie powinien zawierać spacji.") return end
                exports.TR_dx:setResponseEnabled(true)
                triggerServerEvent("changeOrganizationAdminColor", resourceRoot, v.ID, text)
            end
        end
    end
end

function AdminList:onScroll(btn)
    if btn == "mouse_wheel_up" then
        if self.scroll <= 0 then return end
        self.scroll = self.scroll - 1

    elseif btn == "mouse_wheel_down" then
        if self.scroll + 15 >= #self.organizations then return end
        self.scroll = self.scroll + 1
    end
end

function AdminList:response(...)
    exports.TR_dx:setResponseEnabled(false)
    self:buildOrgList(...)
end

function AdminList:firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

function AdminList:drawBackground(x, y, rx, ry, color, radius, post)
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

function AdminList:isMouseInPosition(x, y, width, height)
    if (not isCursorShowing()) then return false end
    local cx, cy = getCursorPosition()
    local cx, cy = (cx*sx), (cy*sy)
    if (cx >= x and cx <= x + width) and (cy >= y and cy <= y + height) then return true end
    return false
end

function AdminList:secondsToClock(seconds)
    local seconds = tonumber(seconds)
    if seconds <= 0 then
      return "00:00:00";
    else
      hours = string.format("%02.f", math.floor(seconds/3600));
      mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)));
      secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60));
      return hours..":"..mins..":"..secs
    end
end

function startAdminList(...)
    if not guiInfo.panel then
        guiInfo.panel = AdminList:create(...)
    else
        guiInfo.panel:close()
    end
end
addEvent("startAdminOrganizationsList", true)
addEventHandler("startAdminOrganizationsList", root, startAdminList)

function updateAdminPanelList(...)
    guiInfo.panel:response(...)
end
addEvent("updateAdminOrganizationsList", true)
addEventHandler("updateAdminOrganizationsList", root, updateAdminPanelList)