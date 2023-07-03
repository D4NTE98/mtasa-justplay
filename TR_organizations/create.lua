local sx, sy = guiGetScreenSize()
local zoom = 1
local baseX = 1900
local minZoom = 2
if sx < baseX then
  zoom = math.min(minZoom, baseX/sx)
end

local guiInfo = {
    x = (sx - 540/zoom)/2,
    y = (sy - 450/zoom)/2,
    w = 540/zoom,
    h = 450/zoom,

    price = 10000,
}

CreateOrg = {}
CreateOrg.__index = CreateOrg

function CreateOrg:create(...)
    local instance = {}
    setmetatable(instance, CreateOrg)
    if instance:constructor(...) then
        return instance
    end
    return false
end

function CreateOrg:constructor(...)
    self.alpha = 0
    self.tab = "info"
    self.pedName = arg[1]

    self.fonts = {}
    self.fonts.main = exports.TR_dx:getFont(14)
    self.fonts.parts = exports.TR_dx:getFont(11)
    self.fonts.small = exports.TR_dx:getFont(10)

    self.buttons = {}
    self.buttons.exit = exports.TR_dx:createButton(guiInfo.x + 20/zoom, guiInfo.y + guiInfo.h - 60/zoom, 225/zoom, 40/zoom, "Anuluj")
    self.buttons.submit = exports.TR_dx:createButton(guiInfo.x + guiInfo.w - 245/zoom, guiInfo.y + guiInfo.h - 60/zoom, 225/zoom, 40/zoom, "Rozumiem")
    exports.TR_dx:setButtonVisible(self.buttons, false)

    self.checkbox = exports.TR_dx:createCheck(guiInfo.x + (guiInfo.w/2) - 120/zoom, guiInfo.y + guiInfo.h - 212/zoom, 40/zoom, 40/zoom, false, "Organizacja przestępcza")
    exports.TR_dx:setCheckVisible(self.checkbox, false)

    self.edits = {}
    self.edits.name = exports.TR_dx:createEdit(guiInfo.x + (guiInfo.w - 350/zoom)/2, guiInfo.y + (guiInfo.h - 100/zoom)/2, 350/zoom, 40/zoom, "Nazwa organizacji", false, self.sa)
    exports.TR_dx:setEditLimit(self.edits.name, 20)
    exports.TR_dx:setEditVisible(self.edits, false)

    self.func = {}
    self.func.render = function() self:render() end
    self.func.buttonClick = function(...) self:buttonClick(...) end

    self:open()
    return true
end


function CreateOrg:open()
    self.state = "opening"
    self.tick = getTickCount()

    exports.TR_dx:showButton(self.buttons)
    exports.TR_dx:setOpenGUI(true)

    showCursor(true)
    addEventHandler("onClientRender", root, self.func.render)
    addEventHandler("guiButtonClick", root, self.func.buttonClick)
end

function CreateOrg:close()
    self.state = "closing"
    self.tick = getTickCount()

    exports.TR_dx:hideButton(self.buttons)
    exports.TR_dx:hideCheck(self.checkbox)
    exports.TR_dx:hideEdit(self.edits)

    showCursor(false)
    removeEventHandler("guiButtonClick", root, self.func.buttonClick)
end

function CreateOrg:destroy()
    exports.TR_dx:setOpenGUI(false)
    exports.TR_dx:destroyButton(self.buttons)
    exports.TR_dx:destroyCheck(self.checkbox)
    exports.TR_dx:destroyEdit(self.edits)

    removeEventHandler("onClientRender", root, self.func.render)
    guiInfo.window = nil
    self = nil
end


function CreateOrg:animate()
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
      end
    end
end


function CreateOrg:render()
    self:animate()
    self:drawBackground(guiInfo.x, guiInfo.y, guiInfo.w, guiInfo.h, tocolor(23,25,31, 255 * self.alpha), 5)
    dxDrawText("Tworzenie organizacji", guiInfo.x, guiInfo.y, guiInfo.x + guiInfo.w, guiInfo.y + 50/zoom, tocolor(44,183,236, 255 * self.alpha), 1/zoom, self.fonts.main, "center", "center")

    if self.tab == "info" then
        self:renderInfo()
    else
      self:renderCreate()
    end
    --
    -- dxDrawText("Koszt założenia organizacji wynosi #d4af37$50 000#aaaaaa.", guiInfo.x + (guiInfo.w - 250/zoom)/2, guiInfo.y + 92/zoom, guiInfo.x + (guiInfo.w + 250/zoom)/2, guiInfo.y + guiInfo.h - 55/zoom, tocolor(170, 170, 170, 255 * self.alpha), 1/zoom, self.fonts.small, "center", "top", false, false, false, true)

end

function CreateOrg:renderInfo()
    dxDrawText("Posiadanie własnej organizacji nie jest prostym zadaniem. Oto kilka rzeczy, które musisz wiedzieć przed jej założeniem:\n- aby nie stracić organizacji należy opłacać cotygodniowy czynsz wynoszący $2000\n- nałożony jest limit pracowników, pojazdów i procentu zarobku, które można zwiększać\n- organizacją zarządza się korzystając z komputera znajdującego się pod przyciskiem F3\n- każda organizacja może posiadać swój wewnętrzny ranking, którym można zarządać korzystając z komputera\n- każda organizacja posiada własne logo, którego zmianę można zgłosić w panelu organizacji", guiInfo.x + 20/zoom, guiInfo.y + 50/zoom, guiInfo.x + guiInfo.w - 15/zoom, guiInfo.y + guiInfo.h - 55/zoom, tocolor(170, 170, 170, 255 * self.alpha), 1/zoom, self.fonts.parts, "left", "top", true, true)
    dxDrawText("Założona organizacja posiada limit pracowników wynoszący 5 osób, pojazdów wynoszący 3 sztuki oraz podstawowe zarobki wynoszące  3% pensji pracowników w pracach.", guiInfo.x + 10/zoom, guiInfo.y + 80/zoom, guiInfo.x + guiInfo.w- 10/zoom, guiInfo.y + guiInfo.h - 80/zoom, tocolor(220, 110, 110, 255 * self.alpha), 1/zoom, self.fonts.parts, "center", "bottom", true, true)
end

function CreateOrg:renderCreate()
  dxDrawText("Aby sfinalizować zakładanie organizacji, wystarczy abyś wpisał poniżej jej nazwę. Nazwy nie mogą się powtarzać.", guiInfo.x + 10/zoom, guiInfo.y + 50/zoom, guiInfo.x + guiInfo.w- 10/zoom, guiInfo.y + guiInfo.h - 55/zoom, tocolor(170, 170, 170, 255 * self.alpha), 1/zoom, self.fonts.parts, "center", "top", true, true)

  dxDrawText("Koszt założenia organizacji: $"..guiInfo.price, guiInfo.x + 10/zoom, guiInfo.y - 90/zoom, guiInfo.x + guiInfo.w- 10/zoom, guiInfo.y + guiInfo.h/2 - 90/zoom, tocolor(104,112,125, 255 * self.alpha), 1/zoom, self.fonts.parts, "center", "bottom", true, true)
  dxDrawText("Pamiętaj, że nazwa organizacji jak i jej logo nie mogą łamać regulaminu serwera ani swoim wyglądem ani treścią. Organizacje, których nazwy będą obraźliwe, członkowie będą nieaktywni lub liczba pracowników będzie wynosić poniżej 3 osób będą usuwane.", guiInfo.x + 10/zoom, guiInfo.y + 80/zoom, guiInfo.x + guiInfo.w- 10/zoom, guiInfo.y + guiInfo.h - 80/zoom, tocolor(220, 110, 110, 255 * self.alpha), 1/zoom, self.fonts.parts, "center", "bottom", true, true)
end

function CreateOrg:buttonClick(...)
    if exports.TR_dx:isResponseEnabled() then return false end
    if arg[1] == self.buttons.exit then
        self:close()

    elseif arg[1] == self.buttons.submit then
      if self.tab == "info" then
        self.tab = "create"
        exports.TR_dx:setButtonText(self.buttons.submit, "Załóż organizację")
        exports.TR_dx:setEditVisible(self.edits, true)
        exports.TR_dx:setCheckVisible(self.checkbox, true)
      elseif self.tab == "create" then
        self.orgName = guiGetText(self.edits.name)

        if string.len(self.orgName) < 5 or string.len(self.orgName) > 20 then exports.TR_noti:create("Nazwa organizacji powinna zawierać od 5 do 20 liter.", "error") return end
        if not self:checkString(self.orgName) then exports.TR_noti:create("Nazwa organizacji zawiera nieodpowiednie znaki.", "error") return end

        exports.TR_dx:setResponseEnabled(true)
        triggerServerEvent("checkOrgNameFree", resourceRoot, self.orgName)
      end
    end
end


function CreateOrg:checkString(text)
  if string.find(text, "%c") or string.find(text, "%p") or string.find(text, "%z") then
    return false
  else
    return true
  end
end

function CreateOrg:drawBackground(x, y, rx, ry, color, radius, post)
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

function CreateOrg:isMouseInPosition(x, y, width, height)
	if (not isCursorShowing()) then
		return false
	end
  local cx, cy = getCursorPosition()
  local cx, cy = (cx*sx), (cy*sy)
  if (cx >= x and cx <= x + width) and (cy >= y and cy <= y + height) then
    return true
  else
    return false
  end
end

function CreateOrg:response(...)
  if arg[1] == "bought" then
    self:close()
    exports.TR_dx:setResponseEnabled(false)

  elseif arg[1] == "cantCreate" then
    exports.TR_noti:create("Taka nazwa organizacji jest już zajęta.", "error")
    exports.TR_dx:setResponseEnabled(false)

  elseif arg[1] == "canCreate" then
  	local selected = exports.TR_dx:isCheckSelected(self.checkbox)
    triggerServerEvent("createPayment", resourceRoot, guiInfo.price, "payForNewOrg", {self.pedName, self.orgName, selected})

  elseif not arg[1] then
    exports.TR_dx:setResponseEnabled(false)
  end
end


function createOrganization(...)
    if guiInfo.window then return end
    guiInfo.window = CreateOrg:create(...)
end
addEvent("createOrganization", true)
addEventHandler("createOrganization", root, createOrganization)

function createOrganizationResponse(...)
    if not guiInfo.window then return end
    guiInfo.window:response(...)
end
addEvent("createOrganizationResponse", true)
addEventHandler("createOrganizationResponse", root, createOrganizationResponse)

-- exports.TR_dx:setOpenGUI(false)

-- if getPlayerName(localPlayer) == "Xantris" then
--   createOrganization("Test")
-- end