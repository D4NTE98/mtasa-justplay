local sx, sy = guiGetScreenSize()
local zoom = 1
local baseX = 1920
local minZoom = 2
if sx < baseX then
    zoom = math.min(minZoom, baseX/sx)
end

local guiInfo = {
    x = (sx - 530/zoom)/2,
    y = (sy - 210/zoom)/2,
    w = 530/zoom,
    h = 210/zoom,

    texts = {
        cost = "Witaj na stanowisku naprawczym, jeśli chcesz naprawić swój pojazd\nkliknij niebieski przycisk pod spodem, cena za naprawę\nwynosi jedynie #2cb5e9100$",
        free = "Witaj na stanowisku naprawczym, jeśli chcesz naprawić swój pojazd\nkliknij niebieski przycisk pod spodem.\nNaprawa jest całkowiecie darmowa!",
    },
}

Mechanic = {}
Mechanic.__index = Mechanic

function Mechanic:create()
    self:constructor();
end

function Mechanic:constructor()
    self.func = {}
    self.func.open = function() self:open() end
    self.func.render = function() self:render() end
    self.func.colShapeHit = function(...) self:colShapeHit(source, ...) end
    self.func.colShapeLeave = function(...) self:colShapeLeave(...) end
    self.func.onButtonClick = function(...) self:onButtonClick(...) end
    self.func.onReponse = function(...) self:onReponse(...) end

    self:createCols()
    addEvent("responseRepair", true)
    addEventHandler("responseRepair", root, self.func.onReponse)
    return true
end

function Mechanic:onReponse(state)
    exports.TR_dx:setResponseEnabled(false)

    if state then
        self:close()
    else
        self:close()
    end
end

function Mechanic:createCols()
    self.cols = {}
    for i, v in pairs(positions) do
        --local x, y, z = self:getPosition(v.positions.marker, Vector3(v.positions.marker[4], v.positions.marker[5], v.positions.marker[6]), (v.flipped and Vector3(0, 4.5, 4) or Vector3(0, -4.5, 4)))
        local sphere = createColSphere(v[1], v[2], v[3], 3)
        setElementData(sphere, "tollID", i, false)

        local marker = createMarker(v[1], v[2], v[3] - 0.55, "cylinder", 1, 249, 161, 91, 0)
        setElementData(marker, "markerIcon", "mechanic", false)
        setElementData(marker, "markerData", {
            title = "Mechanik pojazdów",
            desc = "Wjedz w celu naprawy pojazdu",
        }, false)
    end

    addEventHandler("onClientColShapeHit", resourceRoot, self.func.colShapeHit)
    addEventHandler("onClientColShapeLeave", resourceRoot, self.func.colShapeLeave)
end

local lmarker = createMarker(-1705.3232421875, 398.9951171875, 7.241 - 0.30, 'cylinder', 1, 249, 161, 91, 0)
setElementData(marker, "markerIcon", "mechanic", false)
setElementData(marker, "markerData", {
    title = "Lakiernik pojazdów",
    desc = "Wejdz aby rozpocząć duty lakiernika",
}, false)

function lakiernia(el)
    local lakiernia = getElementData(el, 'lakiernik');
    local skin = 0;
    if lakiernia then
        setElementData(el, 'lakiernik', false);
    else
        setElementData(el, 'lakiernik', true);
    end
end;

function Mechanic:colShapeHit(source, el, md)
    if el ~= localPlayer or not md then return end

    self.tollID = getElementData(source, "tollID")
    self:open()
end

function Mechanic:colShapeLeave(el, md)
    if el ~= localPlayer or not md then return end

    if self.state then return end
    if isTimer(self.timer) then killTimer(self.timer) end
    self.timer = nil
end


function Mechanic:open()
    local veh = getPedOccupiedVehicle(localPlayer)
    if not veh then return end
    if getPedOccupiedVehicleSeat(localPlayer) ~= 0 then return end

    setElementFrozen(veh, true)
    if not exports.TR_dx:canOpenGUI() or self:getElementSpeed(veh) > 0 then
        self.timer = setTimer(self.func.open, 500, 1)
        return
    end

    self.iscost = getElementData(veh, "vehicleID")
	self.tick = getTickCount()
    self.state = "show"
    self.alpha = 0

    self.fonts = {}
    self.fonts.main = exports.TR_dx:getFont(14)
    self.fonts.text = exports.TR_dx:getFont(12)

    self.buttons = {}
    self.buttons.cancel = exports.TR_dx:createButton(guiInfo.x + 10/zoom, guiInfo.y + guiInfo.h - 50/zoom, 250/zoom, 40/zoom, "Anuluj naprawę", "grey")
    self.buttons.open = exports.TR_dx:createButton(guiInfo.x + guiInfo.w - 260/zoom, guiInfo.y + guiInfo.h - 50/zoom, 250/zoom, 40/zoom, self.iscost and "Zapłać za naprawę", "blue")
    exports.TR_dx:setButtonVisible(self.buttons, false)
    exports.TR_dx:showButton(self.buttons)

    showCursor(true)
    addEventHandler("onClientRender", root, self.func.render)
    addEventHandler("guiButtonClick", root, self.func.onButtonClick)
    exports.TR_dx:setOpenGUI(true)
end

function Mechanic:close()
	self.tick = getTickCount()
    self.state = "hide"
    self.alpha = 1

    local veh = getPedOccupiedVehicle(localPlayer)
    setElementFrozen(veh, false)

    showCursor(false)
    exports.TR_dx:hideButton(self.buttons)
end


function Mechanic:animate()
    if self.state == "show" then
        local progress = (getTickCount() - self.tick)/500
        self.alpha = interpolateBetween(0, 0, 0, 1, 0, 0, progress, "InOutQuad")

        if progress >= 1 then
            self.tick = getTickCount()
            self.alpha = 1
            self.state = nil
        end

    elseif self.state == "hide" then
        local progress = (getTickCount() - self.tick)/500
        self.alpha = interpolateBetween(1, 0, 0, 0, 0, 0, progress, "InOutQuad")

        if progress >= 1 then
            self.tick = nil
            self.alpha = 0
            self.state = nil

			removeEventHandler("onClientRender", root, self.func.render)
            removeEventHandler("guiButtonClick", root, self.func.onButtonClick)
            exports.TR_dx:setOpenGUI(false)
            exports.TR_dx:destroyButton(self.buttons)
            self.fonts = nil
			return true
        end
    end
end

function Mechanic:render()
    if self:animate() then return end

    self:drawBackground(guiInfo.x, guiInfo.y, guiInfo.w, guiInfo.h, tocolor(16,18,23, 255 * self.alpha), 11)
    dxDrawText("Mechanik pojazdów", guiInfo.x, guiInfo.y, guiInfo.x + guiInfo.w, guiInfo.y + 50/zoom, tocolor(44,181,233, 255 * self.alpha), 1/zoom, self.fonts.main, "center", "center")
    dxDrawText(self.iscost and guiInfo.texts.cost or guiInfo.texts.free, guiInfo.x, guiInfo.y + 50/zoom, guiInfo.x + guiInfo.w, guiInfo.y + 50/zoom, tocolor(170, 170, 170, 255 * self.alpha), 1/zoom, self.fonts.text, "center", "top", false, false, false, true)
end

function Mechanic:onButtonClick(btn)
    if self.state then return end

    if btn == self.buttons.cancel then
        self:close()
    elseif btn == self.buttons.open then
        exports.TR_dx:setResponseEnabled(true)
        triggerServerEvent("repair", resourceRoot, localPlayer)
    end
end

function Mechanic:drawBackground(x, y, w, h, color, radius, post)
    dxDrawRectangle(x, y, w, h, color, post)
    dxDrawRectangle(x + radius, y - radius, w - radius * 2, radius, color, post)
    dxDrawRectangle(x + radius, y + h, w - radius * 2, radius, color, post)
    dxDrawCircle(x + radius, y, radius, 180, 270, color, color, 7, 1, post)
    dxDrawCircle(x + radius, y + h, radius, 90, 180, color, color, 7, 1, post)

    dxDrawCircle(x + w - radius, y, radius, 270, 360, color, color, 7, 1, post)
    dxDrawCircle(x + w - radius, y + h, radius, 0, 90, color, color, 7, 1, post)
end

function Mechanic:getElementSpeed(theElement, unit)
    local elementType = getElementType(theElement)
    unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
    local mult = (unit == 0 or unit == "m/s") and 50 or ((unit == 1 or unit == "km/h") and 180 or 111.84681456)
    return (Vector3(getElementVelocity(theElement)) * mult).length
end

function Mechanic:getPosition(pos, rot, vec)
	local rot = Vector3(rot)
	local mat = Matrix(Vector3(unpack(pos)), rot)
	local newPos = mat:transformPosition(vec)
	return newPos.x, newPos.y, newPos.z, rot.z
end

Mechanic:create()

exports.TR_dx:setOpenGUI(false)
exports.TR_dx:setResponseEnabled(false)