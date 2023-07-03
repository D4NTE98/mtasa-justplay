local sx, sy = guiGetScreenSize()
local zoom = 1
local baseX = 1920
local minZoom = 2
if sx < baseX then
    zoom = math.min(minZoom, baseX/sx)
end

local guiInfo = {
    gui = {
        x = (sx - 500/zoom)/2,
        y = sy - 200/zoom,
        w = 500/zoom,
        h = 155/zoom,
    },
    depth = 30,

    avaliableOptions = {
        ["vehicle"] = {
            {
                name = "Obróć pojazd",
                trigger = "vehicleFlip",
            },
            {
                name = "Spuść/zaciągnij ręczny",
                trigger = "vehicleUnfreeze",
            },
            {
                name = "Oddaj do przechowywalni",
                trigger = "warpToGarage",
            },
            {
                name = "Teleportuj do siebie",
                trigger = "tpHere",
            },
            {
                name = "Zatankuj do 10l",
                trigger = "fuelVehicle",
            },
            {
                name = "Napraw",
                trigger = "fixVehicle",
            },
        },
        ["player"] = {
            {
                name = "Ulecz gracza",
                trigger = "healPlayer",
            },
            {
                name = "Przenieś na spawn",
                trigger = "reloadPlayer",
            },
            {
                name = "Teleportuj do siebie",
                trigger = "tpHere",
            },
        },
    }
}

AdminPanel = {}
AdminPanel.__index = AdminPanel

function AdminPanel:create()
    local instance = {}
    setmetatable(instance, AdminPanel)
    if instance:constructor() then
        return instance
    end
    return false
end

function AdminPanel:constructor()
    self.loadedData = "loading"

    self.fonts = {}
    self.fonts.main = exports.TR_dx:getFont(14)
    self.fonts.options = exports.TR_dx:getFont(12)
    self.fonts.move = exports.TR_dx:getFont(7)

    self.func = {}
    self.func.render = function() self:render() end
    self.func.scrollKey = function(...) self:scrollKey(...) end
    self.func.useInteraction = function() self:useInteraction() end

    return true
end

function AdminPanel:destroy()
    if self.opened then self:close() end
    self = nil
end

function AdminPanel:open()
    addEventHandler("onClientRender", root, self.func.render)
    bindKey("mouse_wheel_up", "down", self.func.scrollKey)
    bindKey("mouse_wheel_down", "down", self.func.scrollKey)
    bindKey("mouse1", "down", self.func.useInteraction)

    self.scroll = 1
    self.opened = true
end

function AdminPanel:close()
    removeEventHandler("onClientRender", root, self.func.render)
    unbindKey("mouse_wheel_up", "down", self.func.scrollKey)
    unbindKey("mouse_wheel_down", "down", self.func.scrollKey)
    unbindKey("mouse1", "down", self.func.useInteraction)
    self.opened = false
end

function AdminPanel:useInteraction()
    if not self.selectedElement then return end
    if self.loadedData == "loading" then return end
    if not self:canUseOption() then exports.TR_noti:create("Musisz odczekać przed wykonaniem kolejnej interakcji.", "error") return end

    local selectedOption = self.avaliableOptions[self.scroll]
    if selectedOption == "warpToGarage" then
        local id = getElementID(self.selectedElement)
        if id then
           if id == 324 then exports.TR_noti:create("Kto Ci pozwolił ruszać ten pojazd?", "error") return end 
           if string.len(id) > 2 then exports.TR_noti:create("Ten pojazd nie jest prywatny.", "error") return end
        end
    else
        triggerServerEvent("useAdminPanelOption", resourceRoot, self.selectedElement, selectedOption.trigger)
    end
end

function AdminPanel:scrollKey(key)
    if key == "mouse_wheel_up" then
        if not self.avaliableOptions then return end
        if self.scroll == #self.avaliableOptions then return end
        self.scroll = self.scroll + 1

    elseif key == "mouse_wheel_down" then
        if not self.avaliableOptions then return end
        if self.scroll == 1 then return end
        self.scroll = self.scroll - 1
    end

    if key == "arrow_u" then
        if not self.avaliableOptions then return end
        if self.scroll == #self.avaliableOptions then return end
        self.scroll = self.scroll + 1

    elseif key == "arrow_d" then
        if not self.avaliableOptions then return end
        if self.scroll == 1 then return end
        self.scroll = self.scroll - 1
    end
end

function AdminPanel:canUseOption()
    if self.lastActionTick then
        if (getTickCount() - self.lastActionTick)/1000 > 1 then
            self.lastActionTick = getTickCount()
            return true
        end
        return false
    end
    self.lastActionTick = getTickCount()
    return true
end


function AdminPanel:checkObject()
    local x, y, z = getCameraMatrix()
    local lx, ly, lz = getWorldFromScreenPosition(sx/2, sy/2, guiInfo.depth)

    local hit, _, _, _, hitElement = processLineOfSight(x, y, z, lx, ly, lz, true, true, true, true, true, false, false, false, localPlayer)
    if hit and hitElement then
        self:getData(hitElement)
    else
        self.selectedElement = nil
    end
end

function AdminPanel:getData(hitElement)
    if hitElement == self.selectedElement then return end

    self.selectedElement = hitElement
    self.objectType = getElementType(hitElement)
    self.loadedData = "loading"

    if not guiInfo.avaliableOptions[self.objectType] then
        self.selectedElement = nil
        self.loadedData = "loading"
        return
    end
    self.avaliableOptions = guiInfo.avaliableOptions[self.objectType]
    if self.objectType == "player" then
        local id = getElementData(hitElement, "ID")
        if not id then return end
        local data = getElementData(hitElement, "characterData")
        local org = getElementData(hitElement, "characterOrg")
        self.loadedData = {
            username = string.format("%s (%d)", getPlayerName(hitElement), id),
            money = tonumber(data.money),
            org = org,
        }
        return
    end

    triggerServerEvent("getDataToAdminPanel", resourceRoot, self.selectedElement)
end

function AdminPanel:renderCrosshair()
    dxDrawRectangle(sx/2 - 2, sy/2 - 2, 4, 4, tocolor(44,181,233, 255))
    dxDrawText("NAJEDŹ NA WYBRANY OBIEKT", sx/2, sy/2 + 8, sx/2, sy/2, tocolor(44,181,233, 255), 1/zoom, self.fonts.move, "center", "top")
end

function AdminPanel:render()
    if getPedOccupiedVehicle(localPlayer) then
        self:close()
        return
    end

    self:checkObject()
    self:renderCrosshair()

    if not self.selectedElement then return end
    self:drawBackground(guiInfo.gui.x, guiInfo.gui.y, guiInfo.gui.w, guiInfo.gui.h, tocolor(23,25,31, 255), 15)
    dxDrawRectangle(guiInfo.gui.x, guiInfo.gui.y + guiInfo.gui.h - 36/zoom, guiInfo.gui.w, 2/zoom, tocolor(16,18,23, 255))

    self:drawList()
end

function AdminPanel:drawList()
    local selectedOption = self.avaliableOptions[self.scroll]
    dxDrawText("Akcja: "..selectedOption.name, guiInfo.gui.x, guiInfo.gui.y, guiInfo.gui.x + guiInfo.gui.w, guiInfo.gui.y + guiInfo.gui.h - 10/zoom, tocolor(44,181,233, 255), 1/zoom, self.fonts.options, "center", "bottom")

    if self.loadedData == "loading" then
        dxDrawText("Trwa wczytywanie danych...", guiInfo.gui.x, guiInfo.gui.y, guiInfo.gui.x + guiInfo.gui.w, guiInfo.gui.y + guiInfo.gui.h - 36/zoom, tocolor(255, 255, 255, 255), 1/zoom, self.fonts.options, "center", "center")
        return
    end

    if self.objectType == "vehicle" then
        if self.loadedData then
            local displayID = ""
            local id = getElementID(self.selectedElement)
            if id then
                displayID = string.format(" (%d)", string.sub(id, 8, string.len(id)))
            end
            local owners = getElementData(self.selectedElement, "vehicleOwners")
            local lastDriver = getElementData(self.selectedElement, "lastDriver")

            dxDrawText(string.format("UID Właściciela: %s", owners and tostring(owners[1]) or "Brak"), guiInfo.gui.x + 10/zoom, guiInfo.gui.y + 30/zoom, guiInfo.gui.x + guiInfo.gui.w, guiInfo.gui.h, tocolor(170, 170, 170, 255), 1/zoom, self.fonts.options, "left", "top")
            dxDrawText(string.format("Ostatni kierowca: %s", lastDriver or "Brak"), guiInfo.gui.x + 10/zoom, guiInfo.gui.y + 50/zoom, guiInfo.gui.x + guiInfo.gui.w, guiInfo.gui.h, tocolor(170, 170, 170, 255), 1/zoom, self.fonts.options, "left", "top")
            dxDrawText(string.format("Ilość benzyny: %.2f l", self.loadedData.fuel or 0), guiInfo.gui.x + 10/zoom, guiInfo.gui.y + 70/zoom, guiInfo.gui.x + guiInfo.gui.w, guiInfo.gui.h, tocolor(170, 170, 170, 255), 1/zoom, self.fonts.options, "left", "top")
            dxDrawText(string.format("Przebieg: %.2f km", self.loadedData.mileage or 0), guiInfo.gui.x + 10/zoom, guiInfo.gui.y + 90/zoom, guiInfo.gui.x + guiInfo.gui.w, guiInfo.gui.h, tocolor(170, 170, 170, 255), 1/zoom, self.fonts.options, "left", "top")

            dxDrawText(getVehicleName(self.selectedElement)..displayID, guiInfo.gui.x, guiInfo.gui.y + 5/zoom, guiInfo.gui.x + guiInfo.gui.w, guiInfo.gui.h, tocolor(255, 255, 255, 255), 1/zoom, self.fonts.main, "center", "top")

        else
            dxDrawText("UID Właściciela: Brak", guiInfo.gui.x + 10/zoom, guiInfo.gui.y + 30/zoom, guiInfo.gui.x + guiInfo.gui.w, guiInfo.gui.h, tocolor(170, 170, 170, 255), 1/zoom, self.fonts.options, "left", "top")
            dxDrawText(string.format("Ostatni kierowca: %s", lastDriver or "Brak"), guiInfo.gui.x + 10/zoom, guiInfo.gui.y + 50/zoom, guiInfo.gui.x + guiInfo.gui.w, guiInfo.gui.h, tocolor(170, 170, 170, 255), 1/zoom, self.fonts.options, "left", "top")

            dxDrawText(getVehicleName(self.selectedElement), guiInfo.gui.x, guiInfo.gui.y + 5/zoom, guiInfo.gui.x + guiInfo.gui.w, guiInfo.gui.h, tocolor(255, 255, 255, 255), 1/zoom, self.fonts.main, "center", "top")
        end

    elseif self.objectType == "player" then
        dxDrawText(string.format("Pieniądze gracza: $%.2f", self.loadedData.money), guiInfo.gui.x + 10/zoom, guiInfo.gui.y + 30/zoom, guiInfo.gui.x + guiInfo.gui.w, guiInfo.gui.h, tocolor(170, 170, 170, 255), 1/zoom, self.fonts.options, "left", "top")
        dxDrawText(string.format("Życie: %d%%", getElementHealth(self.selectedElement)), guiInfo.gui.x + 10/zoom, guiInfo.gui.y + 50/zoom, guiInfo.gui.x + guiInfo.gui.w, guiInfo.gui.h, tocolor(170, 170, 170, 255), 1/zoom, self.fonts.options, "left", "top")
        dxDrawText(string.format("Organizacja: %s", self.loadedData.org or "Brak"), guiInfo.gui.x + 10/zoom, guiInfo.gui.y + 90/zoom, guiInfo.gui.x + guiInfo.gui.w, guiInfo.gui.h, tocolor(170, 170, 170, 255), 1/zoom, self.fonts.options, "left", "top")

        dxDrawText(self.loadedData.username, guiInfo.gui.x, guiInfo.gui.y + 5/zoom, guiInfo.gui.x + guiInfo.gui.w, guiInfo.gui.h, tocolor(255, 255, 255, 255), 1/zoom, self.fonts.main, "center", "top")
    end
end

function AdminPanel:syncData(data)
    self.loadedData = data
end



function AdminPanel:drawBackground(x, y, rx, ry, color, radius, post)
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