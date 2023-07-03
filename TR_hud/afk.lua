local sx, sy = guiGetScreenSize()
local zoom = 1
local baseX = 1920
local minZoom = 2
if sx < baseX then
    zoom = math.min(minZoom, baseX/sx)
end

local disabledKeys = {
    ["escape"] = true,
    ["lalt"] = true,
    ["ralt"] = true,
    ["rcrtl"] = true,
    ["lcrtl"] = true,
    ["capslock"] = true,
}

Afk = {}
Afk.__index = Afk

function Afk:create()
    local instance = {}
    setmetatable(instance, Afk)
    if instance:constructor() then
        return instance
    end
    return false
end

function Afk:constructor()
    self.lastTick = getTickCount()
    self.alpha = 0

    self.fonts = {}
    self.fonts.text = exports.TR_dx:getFont(14)
    self.fonts.info = exports.TR_dx:getFont(20)

    self.func = {}
    self.func.check = function() self:checkAfk() end
    self.func.clicker = function(...) self:click(...) end
    self.func.renderer = function() self:render() end

    setTimer(self.func.check, 10000, 0)
    addEventHandler("onClientKey", root, self.func.clicker)
    return true
end

function Afk:open()
    if self.opened then return end
    self.opened = true

    exports.TR_hud:setHudVisible(false)
    exports.TR_chat:showCustomChat(false)
    exports.TR_interaction:closeInteraction()

    setElementData(localPlayer, "afk", true)
    addEventHandler("onClientRender", root, self.func.renderer, false, "low")

    self.state = "show"
    self.lastAlpha = self.alpha
    self.showTick = getTickCount()

    if getPlayerName(localPlayer) == "DeMoNeK_" or getPlayerName(localPlayer) == "NyAngel" then
        createTrayNotification("Weź ty zacznij coś robić na tym serwerze a nie tylko afk walisz ciulu.")
    else
        createTrayNotification("Jesteś nieaktywny powyżej minuty i został na Ciebie nałożony status AFK.")
    end
end

function Afk:close()
    if not self.opened then return end
    self.opened = nil

    exports.TR_hud:setHudVisible(true)
    exports.TR_chat:showCustomChat(true)

    setElementData(localPlayer, "afk", nil)

    self.state = "hide"
    self.lastAlpha = self.alpha
    self.showTick = getTickCount()
end



function Afk:animate()
    if self.state == "show" then
        local progress = (getTickCount() - self.showTick)/1000
        self.alpha = interpolateBetween(self.lastAlpha, 0, 0, 1, 0, 0, progress, "Linear")

        if progress >= 1 then
            self.state = "showed"
            self.alpha = 1
            self.showTick = nil
        end

    elseif self.state == "hide" then
        local progress = (getTickCount() - self.showTick)/1000
        self.alpha = interpolateBetween(self.lastAlpha, 0, 0, 0, 0, 0, progress, "Linear")

        if progress >= 1 then
            self.state = nil
            self.alpha = 0
            self.showTick = nil

            removeEventHandler("onClientRender", root, self.func.renderer)
        end
    end
end

function Afk:render()
    self:animate()
    dxDrawImage(0, 0, sx, sy, "files/images/hud/bg.png", 0, 0, 0, tocolor(255, 255, 255, 255 * self.alpha), true)
    dxDrawText("Away From Keyboard", 0, sy - 70/zoom, sx, sy, tocolor(44,181,233, 255 * self.alpha), 1/zoom, self.fonts.info, "center", "top", false, false, true)
    dxDrawText("Wykonaj jakąś aktywność.", 0, sy - 35/zoom, sx, sy, tocolor(200, 200, 200, 255 * self.alpha), 1/zoom, self.fonts.text, "center", "top", false, false, true)
end



function Afk:checkAfk()
    if not getElementData(localPlayer, "characterUID") then return end
    if (getTickCount() - self.lastTick)/60000 >= 1 then
        self:open()
    end

    if (getTickCount() - self.lastTick)/300000 >= 1 then
        if exports.TR_admin:isPlayerOnDuty() then return end
        triggerServerEvent("kickPlayer", resourceRoot, localPlayer, "ANTY AFK", "Nie wykonałeś żadnej akcji przez 5 minut.")
    end
end

function Afk:click(...)
    if (getKeyState("lalt") or getKeyState("ralt")) and arg[1] == "tab" then return end
    if disabledKeys[arg[1]] then return end

    self:close()
    self.lastTick = getTickCount()
end

Afk:create()