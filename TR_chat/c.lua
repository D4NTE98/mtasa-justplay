local sx, sy = guiGetScreenSize()
local zoom = 1
local baseX = 1900
local minZoom = 2
if sx < baseX then
  zoom = math.min(minZoom, baseX/sx)
end

local settings = {
  x = 10,
  y = 5,
  w = 520,
  h = 350,

  displayW = 520/zoom,
  displayH = 350/zoom,

  maxMessages = 25,
  maxRepeatedMessage = 2,
  scrollingSpeed = 20,

  fonts = {
    text = exports.TR_dx:getFont(11),
    bubble = exports.TR_dx:getFont(12),
  },

  enabledConsole = {
    ["files/images/call.png"] = "[TEL] %s: %s",
    ["files/images/diathermy.png"] = "[FR] %s: %s",
    ["files/images/npc.png"] = "[NPC] %s: %s",
    ["files/images/organization.png"] = "[ORG] %s: %s",
    ["files/images/star.png"] = "[PREM] %s: %s",
  },
}

local emotes = {
  [":%)"] = "uśmiecha się",
  [":D"] = "szeroko się uśmiecha",

  [";%)"] = "puszcza oczko",
  [";%D"] = "puszcza oczko szeroko się uśmiechając",
  [":/"] = "krzywi się",

  [":P"] = "wystawia język",
  [":p"] = "wystawia język",
  [";P"] = "głupio się śmieje",
  [";p"] = "głupio się śmieje",

  [":%*"] = "całuje",
  [":o"] = "dziwi się",
  [":O"] = "dziwi się",

  ["XD"] = "płacze ze śmiechu",
  ["xD"] = "płacze ze śmiechu",
  ["Xd"] = "płacze ze śmiechu",
  ["xd"] = "płacze ze śmiechu",

  [":%("] = "smuci się",
  [":'%("] = "płacze",
  [";%("] = "płacze",
}

local commandHints = {
  ["/reconnect"] = {"- służy do ponownego połączenia się z serwerem"},
  ["/sms"] = {"(ID/Nick) (treść) - służy do napisania prywatnej wiadomości"},
  ["/pw"] = {"(ID/Nick) (treść) - służy do napisania prywatnej wiadomości"},
  ["/pm"] = {"(ID/Nick) (treść) - służy do napisania prywatnej wiadomości"},
  ["/w"] = {"(ID/Nick) (treść) - służy do napisania prywatnej wiadomości"},
  ["/przelej"] = {"(ID/Nick) (kwota) - służy do przekazania pieniędzy graczowi"},
  ["/rsms"] = {"(treść) - służy do odpisywania na ostatnią prywatną wiadomość"},
  ["/re"] = {"(treść) - służy do odpisywania na ostatnią prywatną wiadomość"},
  ["/me"] = {"(treść) - służy do opisywania czynności wykonywanej przez gracza"},
  ["/do"] = {"(treść) - służy do opisywania uczuć gracza"},
  ["/b"] = {"(treść) - służy do pisania na chacie ooc"},
  ["/report"] = {"(ID/Nick) (powód) - służy do zreportowania gracza"},
  ["/t"] = {"(wiadomość) - służy do pisania podczas rozmowy telefonicznej"},
  ["/admins"] = {"- służy do wyświetlania administracji online"},
  ["/binds"] = {"- służy do zmiany przypisanych bindów"},
  ["/event"] = {"- służy do dołączania na event"},
  ["/znajdzki"] = {"- służy do pokazania ilości zebranych znajdziek"},
  ["/camera"] = {"- służy do odpalenia kamery filmowej"},
  ["/tpa"] = {"(ID/Nick) - służy do teleportacji do punktu ustawionego przez admina"},
  ["/phone"] = {" - służy do otwarcia/zamknięcia telefonu"},
  ["/taxi"] = {" - służy do zamówienia taxi"},

  ["/try"] = {"(wiadomość) - służy do losowania udanej/nie udanej akcji"},
  ["/dice"] = {"- służy do rzucenia kością"},

  ["/p"] = {"(wiadomość) - służy do pisania na globalnym chacie premium", {premium = "gold/diamond"}},
  ["/ogloszenie"] = {"- służy do nadania ogłoszenia", {premium = "gold/diamond"}},

  -- Admins
  ["/areport"] = {"- służy do przyjęcia ostatniego reporta", {admin = true}},
  ["/spec"] = {"(ID/Nick) - służy do podglądania podanego gracza", {admin = true}},
  ["/kick"] = {"(ID/Nick) (powód) - służy do wyrzucenia gracza z serwera", {admin = true, permission = "kick"}},
  ["/info"] = {"(treść) - służy do pisania globalnych informacji", {admin = true, permission = "kick"}},
  ["/ban"] = {"(ID/Nick) (ilość) (d/m/y) (powód) - służy do zbanowania gracza na serwerze", {admin = true, permission = "ban"}},
  ["/mute"] = {"(ID/Nick) (ilość) (m/h/d) (powód) - służy do wyciszenia gracza na serwerze", {admin = true}},
  ["/tpl"] = {"(ID/Nick) (ilość) (m/h/d) (powód) - służy do zablokowania graczowi możliwości kierowania pojazdem", {admin = true, permission = "tpl"}},
  ["/warn"] = {"(ID/Nick) (powód) - służy do nadania ostrzeżenia na gracza", {admin = true}},
  ["/cc"] = {"- służy do czyszczenia chatu", {admin = true, permission = "clearChat"}},
  ["/tp"] = {"(ID/Nick) - służy do teleportowania siebie do gracza", {admin = true, permission = "playerTp"}},
  ["/tphere"] = {"(ID/Nick) - służy do teleportowania gracza do siebie", {admin = true, permission = "playerTp"}},
  ["/tpv"] = {"(ID pojazdu) - służy do teleportowania siebie do pojazdu", {admin = true, permission = "vehicleTp"}},
  ["/tpvhere"] = {"(ID pojazdu) - służy do teleportowania pojazdu do siebie", {admin = true, permission = "vehicleTp"}},
  ["/tpvg"] = {"(ID pojazdu) - służy do teleportowania pojazdu do garażu", {admin = true, permission = "vehicleTp"}},
  ["/fuel"] = {"- służy do dotankowania 10l benzyny do pojazdu", {admin = true, permission = "vehicleFuel"}},
  ["/bwoff"] = {"(ID/Nick) - służy do ocucenia podanego gracza", {admin = true, permission = "bwOff"}},
  ["/heal"] = {"(ID/Nick) - służy do uleczenia podanego gracza", {admin = true, permission = "heal"}},
  ["/citem"] = {"- służy do tworzenia przedmiotów", {admin = true, permission = "itemCreate"}},
  ["/jp"] = {"- służy do dania/zabrania jetpacka", {admin = true}},
  ["/reports"] = {"- służy do sprawdzenia ilości przyjętych reportów w aktualnym miesiącu", {admin = true}},
  ["/int"] = {"(ID) - służy do teleportacji na podany interior", {admin = true}},
  ["/dim"] = {"(ID) - służy do teleportacji na podany dimension", {admin = true}},
  ["/inv"] = {"- służy do włączenia/wyłączenia niewidzialności", {admin = true}},
  ["/sevent"] = {"(typ) (wygrana) - służy do stworzenia danego typu eventu wraz z nagrodą", {admin = true}},
  ["/cv"] = {"(model) - służy do stworzenia pojazdu o danym modelu", {admin = true}},
  ["/dcv"] = {"- służy do usunięcia wszystkich pojazdów stworzonych komendą /cv", {admin = true}},
  ["/ctp"] = {"(ilość slotów) - służy do ustawienia teleportu dla graczy", {admin = true}},
  ["/dtp"] = {"- służy do usunięcia teleportu ustawionego komendą /ctp", {admin = true}},
  ["/bboff"] = {"(ID/Nick) - służy do usunięcia boomboxa danego gracza", {admin = true}},
  ["/checkplayer"] = {"(UID/Nick) - służy do otwarcia panelu administratora", {admin = true}},


  ["/orglogos"] = {"- służy do przeglądania próśb o zmianę logo organizacji", {admin = true, permission = "orgLogos"}},
  ["/resetMail"] = {"(UID) (email) - służy do zmiany emaila danej osoby", {admin = true, permission = "resetMail"}},

  -- Devs
  ["/techpause"] = {"- służy do włączenia/wyłączenia przerwy technicznej", {dev = true}},
  ["/scene"] = {"- włącza światełka na scenie eventowej", {dev = true}},
}

Chat = {}
Chat.__index = Chat

function Chat:create(...)
  local instance = {}
  setmetatable(instance, Chat)
  if instance:constructor(...) then
    return instance
  end
  return false
end

function Chat:constructor(...)
  self.messages = {}
  self.showed = false
  self.scrolled = 0
  self.lastMessage = ""
  self.anim = 0
  self.remembered = {}
  self.rememberIndex = 0
  self.bubblesTexts = {}
  self.minified = false

  -- Static
  self.target = dxCreateRenderTarget(settings.w, settings.h, true)
  settings.fontHeight = dxGetFontHeight(1, settings.fonts.text)
  self.edit = exports.TR_dx:createEdit(settings.x, settings.y + settings.displayH, settings.displayW, 40/zoom)
  exports.TR_dx:setEditVisible(self.edit, false)
  exports.TR_dx:setEditLimit(self.edit, 120)

  self.textures = {}
  self.textures.chat = dxCreateTexture("files/images/chat.png", "argb", true, "clamp")
  self.textures.organization = dxCreateTexture("files/images/organization.png", "argb", true, "clamp")
  self.textures.premium = dxCreateTexture("files/images/star.png", "argb", true, "clamp")
  self.textures.fraction = dxCreateTexture("files/images/diathermy.png", "argb", true, "clamp")


  self.func = {}
  self.func.render = function(...) self:render() end
  self.func.switch = function(...) self:switch(...) end
  self.func.key = function(...) self:key(...) end
  self.func.scrollOnKey = function(...) self:scrollOnKey(...) end
  self.func.restore = function() self:updateChat() end
  self.func.autoComplete = function(...) self:autoComplete(...) end
  bindKey("t", "down", self.func.switch)
  bindKey("o", "down", self.func.switch)
  bindKey("y", "down", self.func.switch)
  bindKey("u", "down", self.func.switch)
  bindKey("/", "down", self.func.switch)
  bindKey("p", "down", self.func.switch)
  bindKey("pgup", "both", self.func.scrollOnKey)
  bindKey("pgdn", "both", self.func.scrollOnKey)
  addEventHandler("onClientRestore", root, self.func.restore)
  addEventHandler("onClientRender", root, self.func.render)
  addEventHandler("onClientKey", root, self.func.autoComplete)

  showChat(false)
  return true
end

function Chat:scrollOnKey(...)
  if isTimer(self.scrollTimerKey) then killTimer(self.scrollTimerKey) end

  if arg[2] == "down" then
    if arg[1] == "pgup" then
      self.scrollTimerKey = setTimer(self.func.key, 100, 0, "pgup", true)
      self:key("pgup", true)

    elseif arg[1] == "pgdn" then
      self.scrollTimerKey = setTimer(self.func.key, 100, 0, "pgdn", true)
      self:key("pgdn", true)
    end
  end
end

function Chat:updateChat()
  dxSetRenderTarget(self.target, true)
  dxSetBlendMode("modulate_add")

  if self.minified then
    if self.messages[1] then
      local y = settings.h - self.scrolled
      for i = 1, settings.maxMessages do
        if self.messages[i] then
          local height = self:getTextHeightMinified(self.messages[i])
          y = y - height - 5

          self:drawBubbleBackground(0, y, math.min(self.messages[i].widthMinified, settings.w), height + 2, tocolor(16,18,23, 255), 4)
          dxDrawImage(8, y + 7, 16, 16, self.messages[i].img, 0, 0, 0, tocolor(255, 255, 255, 255))

          dxDrawText("     "..self.messages[i].textMinified, 10, y + 5, settings.w - 20, y + 28, tocolor(200, 200, 200, 255), 1, settings.fonts.text, "left", "top", false, false, false, true)
        end
      end
    end

  else
    if self.messages[1] then
      local y = settings.h - self.scrolled
      for i = 1, settings.maxMessages do
        if self.messages[i] then
          local height = self:getTextHeight(self.messages[i])
          y = y - height - 40

          if y < settings.h then
            if self.messages[i].widthSender > self.messages[i].width then
              self:drawBackgroundSenderWider(0, y, self.messages[i].widthSender + 22, 28, tocolor(16,18,23, 255), 3)
              self:drawBackgroundShorter(0, y + 28, self.messages[i].width, height, tocolor(23,25,31, 255), 3)
            else
              self:drawBackgroundSender(0, y, self.messages[i].widthSender + 22, 28, tocolor(16,18,23, 255), 3)
              self:drawBackground(0, y + 28, self.messages[i].width, height, tocolor(23,25,31, 255), 3)
            end

            dxDrawImage(8, y + 7, 16, 16, self.messages[i].img, 0, 0, 0, tocolor(255, 255, 255, 255))
            dxDrawText(self.messages[i].sender, 32, y, settings.w - 10, y + 28, tocolor(200, 200, 200, 255), 1, settings.fonts.text, "left", "center", false, false, false, true)
            dxDrawText(self.messages[i].text, 10, y + 25, settings.w - 10, y + 30 + height, tocolor(150, 150, 150, 255), 1, settings.fonts.text, "left", "center", false, false, false, true)
          end
          if y + height < 0 then
            break
          end
        end
      end
    end
  end

  dxSetBlendMode("blend")
  dxSetRenderTarget()
end

function Chat:render()
  if isChatVisible() then showChat(false) end
  self:renderBubbles()

  if self.blockVisible then return end
  self:animate()

  dxDrawImage(settings.x, settings.y, settings.displayW, settings.displayH, self.target, 0, 0, 0, tocolor(255, 255, 255, 255 * self.anim))
  if self.opened then self:getCommandHelp() end
end

function Chat:renderBubbles()
  local textY = {}
  local plrPos = Vector3(getCameraMatrix())

  for plr, messages in pairs(self.bubblesTexts) do
    if isElement(plr) then
      local y = 0
      local bx, by, bz = getPedBonePosition(plr, 8)
      local dist = getDistanceBetweenPoints3D(plrPos, bx, by, bz)
      local distance = (15 - dist)/15

      local msgCount = 0

      for i, v in pairs(messages) do
        local textHeight = (30 + 20 * (v.rows-1)) * distance
        y = y + textHeight + 2
        msgCount = msgCount + 1
      end

      if msgCount > 0 then
        for i, v in pairs(messages) do
          if v.state == "opening" then
            local progress = (getTickCount() - v.tick)/500
            v.alpha = interpolateBetween(0, 0, 0, 1, 0, 0, progress, "Linear")

            if progress >= 1 then
              v.alpha = 1
              v.state = "showing"
              v.tick = getTickCount()
            end

          elseif v.state == "showing" then
            local progress = (getTickCount() - v.tick)/v.showTime

            if progress >= 1 then
              v.state = "closing"
              v.tick = getTickCount()
            end

          elseif v.state == "closing" then
            local progress = (getTickCount() - v.tick)/500
            v.alpha = interpolateBetween(1, 0, 0, 0, 0, 0, progress, "Linear")

            if progress >= 1 then
              self.bubblesTexts[v.plr][i] = nil
            end
          end

          if distance > 0 then
            local cx, cy = getScreenFromWorldPosition(bx, by, bz + 0.5 + 0.35 * (1-distance))
            if cx and cy then
              local textHeight = (30 + 20 * (v.rows-1)) * distance
              local textWidth = (v.textWidth + 10) * distance

              self:drawBubbleBackground(cx - textWidth/2, cy - y - 2, textWidth, textHeight, tocolor(23,25,31, 220 * v.alpha), math.floor(4 * distance))
              dxDrawText(v.text, cx, cy - y, cx, cy - y, tocolor(255, 255, 255, 220 * v.alpha), 1 * distance, settings.fonts.bubble, "center", "top", false, false, false, true)

              y = y - textHeight - 2
            end
          end
        end
      else
        self.bubblesTexts[plr] = nil
      end
    else
      self.bubblesTexts[plr] = nil
    end
  end
end

function Chat:getCommandHelp()
  local text = guiGetText(self.edit)
  if string.sub(text, 1, 1) == "/" then
    local command = split(text, " ")
    if string.len(command[1]) < 2 then return end
    local findedCommands = ""
    if command[1] then
      if command[2] then
        if self.commandHints[command[1]] then findedCommands = string.format("%s %s", command[1], self.commandHints[command[1]]) end
      else
        for i, v in pairs(self.commandHints) do
          if string.find(i, command[1]) then
            findedCommands = string.format("%s%s %s\n", findedCommands, i, v)
          end
        end
      end
    end

    dxDrawText(findedCommands, settings.x + 5, settings.y + settings.h + 40, settings.w, 30, tocolor(200, 200, 200, 255 * self.anim), 1, settings.fonts.text, "left", "top")
  end
end

function Chat:autoComplete(btn, state)
  if not self.opened then return end
  if btn ~= "tab" or not state then return end
  local text = guiGetText(self.edit)
  if string.sub(text, 1, 1) == "/" then
    local command = split(text, " ")
    if string.len(command[1]) < 2 then return end

    if command[1] then
      if command[2] then
        if command[3] then return end
        local text = guiGetText(self.edit)
        local find = string.lower(command[2])
        local players = getElementsByType("player")

        for i, v in pairs(players) do
          if getElementData(v, "characterUID") then
            local name = getPlayerName(v)
            if string.find(string.lower(name), "^"..string.lower(find)) then
              exports.TR_dx:setEditText(self.edit, command[1].." "..name.." ")
              break
            end
          end
        end

      else
        for i, v in pairs(self.commandHints) do
          if string.find(i, command[1]) then
            exports.TR_dx:setEditText(self.edit, i.." ")
            break
          end
        end
      end
    end
  end
end

function Chat:animate()
  if not self.tick then return end
  local progress = (getTickCount() - self.tick)/self.animSpeed

  if self.state == "opening" then
    self.anim = interpolateBetween(self.lastAnim, 0, 0, 1, 0, 0, progress, "Linear")
    if progress >= 1 then
      self.anim = 1
      self.state = "opened"
      self.tick = nil
    end

  elseif self.state == "closing" then
    self.anim = interpolateBetween(self.lastAnim, 0, 0, 0, 0, 0, progress, "Linear")
    if progress >= 1 then
      self.anim = 0
      self.state = "closed"
      self.tick = nil
    end
  end
end

function Chat:switch(...)
  if getPlayerName(localPlayer) == "Xantris" and (arg[1] == "/" or arg[1] == "p") then return end

  if arg[1] and arg[2] == "down" then
    if self.opened then
      if self.slow then
        if (getTickCount() - self.slow)/200 < 1 then return end
      end
      if exports.TR_dx:isEditEnabled(self.edit) and not arg[3] then return end
      self.opened = nil
      exports.TR_dx:hideEdit(self.edit, 100)
      showCursor(false)

      removeEventHandler("onClientKey", root, self.func.key)
      self.slow = getTickCount()

      setTimer(function()
        exports.TR_dx:setEditText(self.edit, "")
      end, 100, 1)
      self.commandHints = nil
      self.rememberIndex = 0
      setElementData(localPlayer, "chatting", nil)

    else
      if self.blockVisible then return end
      if not self.showed then return end

      --[[
      local isTutorial = exports.TR_tutorial:isTutorialOpen()
      if isTutorial then
        if isTutorial ~= 15 then return end
      else
        if self.blockOpen then return end
      end
      ]]
      if self.blockOpen then return end

      if self.slow then
        if (getTickCount() - self.slow)/200 < 1 then return end
      end
      self.opened = true
      exports.TR_dx:showEdit(self.edit, 100)
      showCursor(true)

      addEventHandler("onClientKey", root, self.func.key)
      guiFocus(self.edit)

      setTimer(function()
        exports.TR_dx:setEditText(self.edit, arg[1] == "/" and "/" or "")
      end, 50, 1)
      self:prepareCommands()
      setElementData(localPlayer, "chatting", true)

      self.chatType = "text"
      if arg[1] == "t" then
        exports.TR_dx:setEditImage(self.edit, self.textures.chat)

      elseif arg[1] == "/" then
        exports.TR_dx:setEditImage(self.edit, self.textures.chat)

      elseif arg[1] == "o" then
        self.chatType = "organization"
        exports.TR_dx:setEditImage(self.edit, self.textures.organization)

      elseif arg[1] == "y" then
        self.chatType = "fraction"
        exports.TR_dx:setEditImage(self.edit, self.textures.fraction)

      elseif arg[1] == "u" then
        self.chatType = "allFraction"
        exports.TR_dx:setEditImage(self.edit, self.textures.fraction)

      elseif arg[1] == "p" then
        self.chatType = "premium"
        exports.TR_dx:setEditImage(self.edit, self.textures.premium)
      end
    end
  end
end

function Chat:key(...)
  if arg[1] == "enter" and arg[2] then
    self:write()

  elseif arg[1] == "escape" and arg[2] then
    cancelEvent()
    self:switch(true, "down", true)

  elseif (arg[1] == "mouse_wheel_up" or arg[1] == "pgup") and arg[2] then
    self:scroll("down")

  elseif (arg[1] == "mouse_wheel_down" or arg[1] == "pgdn") and arg[2] then
    self:scroll("up")

  elseif arg[1] == "arrow_u" and arg[2] then
    if self.rememberIndex == #self.remembered then return end
    self.rememberIndex = math.min(self.rememberIndex + 1, #self.remembered)

    exports.TR_dx:setEditText(self.edit, self.remembered[self.rememberIndex])

  elseif arg[1] == "arrow_d" and arg[2] then
    if self.rememberIndex == 0 then return end
    self.rememberIndex = math.max(self.rememberIndex - 1, 0)

    if self.rememberIndex == 0 then
      exports.TR_dx:setEditText(self.edit, "")
    else
      exports.TR_dx:setEditText(self.edit, self.remembered[self.rememberIndex])
    end
  end
end

function Chat:scroll(...)
  if arg[1] == "up" then
    self.scrolled = self.scrolled + settings.scrollingSpeed
    if self.scrolled >= 0 then self.scrolled = 0 end
    self:updateChat()

  elseif arg[1] == "down" then
    if self.maxScroll > 0 then return end
    self.scrolled = self.scrolled - settings.scrollingSpeed
    if self.scrolled < self.maxScroll then self.scrolled = self.maxScroll end
    self:updateChat()
  end
end

function Chat:getMaxScroll(...)
  local y = settings.h
  for i = 1, settings.maxMessages do
    if self.messages[i] then
      local height = self:getTextHeight(self.messages[i])
      y = y - height - 40
    end
  end
  self.maxScroll = y
end

function Chat:addToRemembered(text)
  if #self.remembered > 0 then
    if self.remembered[1] == text then return end
  end

  if #self.remembered == 10 then
    table.remove(self.remembered, 10)
  end

  table.insert(self.remembered, 1, text)
end

function Chat:write(...)
  local text = arg[1] and arg[1] or guiGetText(self.edit)
  if not text or text == "" then
    exports.TR_dx:setEditText(self.edit, "")
    guiBlur(self.edit)
    self:switch(true, "down")
    return
  end

  text = self:removeColor(text)
  self:addToRemembered(text)
--[[
  local isTutorial = exports.TR_tutorial:isTutorialOpen()
  if isTutorial then
    if isTutorial ~= 15 then return self:clearMessage() end
    if not self:isCommand(text) then return end

    local cmd, details = self:prepareCommand(text)
    if cmd ~= "phone" then return self:clearMessage() end
    exports.TR_phone:switchPhone()
  end
  ]]

  if exports.TR_gangs:isCornerEnabled() and not self:isCommand(text) then
    exports.TR_gangs:useCornerChat(text)

    self:clearMessage()
    self.slow = getTickCount()
    return
  end

  if self.chatType ~= "text" then
    if self.chatType == "organization" then
      if getElementData(localPlayer, "hasBw") then
        self:clearMessage()
        self.slow = getTickCount()
        return
      end
      triggerServerEvent("oCommand", resourceRoot, text)

    elseif self.chatType == "fraction" then
      if getElementData(localPlayer, "hasBw") then
        self:clearMessage()
        self.slow = getTickCount()
        return
      end
      triggerServerEvent("fractionSingleChatMessage", resourceRoot, text)

    elseif self.chatType == "allFraction" then
      if getElementData(localPlayer, "hasBw") then
        self:clearMessage()
        self.slow = getTickCount()
        return
      end
      triggerServerEvent("fractionChatMessage", resourceRoot, text)

    elseif self.chatType == "premium" then
      if getElementData(localPlayer, "hasBw") then
        self:clearMessage()
        self.slow = getTickCount()
        return
      end

      if self.blockPremium then
        exports.TR_noti:create("Nie możesz pisać na chacie premium, ponieważ jest on wyłączony w ustawieniach.", "info")
      else
        triggerServerEvent("onPlayerCustomCommand", localPlayer, "p", text)
      end
    end

    self:clearMessage()
    self.slow = getTickCount()
    return
  end

  if self:isCommand(text) then
    local cmd, details = self:prepareCommand(text)

    if cmd == "t" then
      if exports.TR_phone:canSpeak() then
        if exports.TR_phone:isCustomOpen() then
          exports.TR_phone:setCustomText(unpack(details))
        else
          triggerServerEvent("onPlayerCustomCommand", localPlayer, cmd, unpack(details))
        end
      end

    elseif cmd == "p" then
      if self.blockPremium then
        exports.TR_noti:create("Nie możesz pisać na chacie premium, ponieważ jest on wyłączony w ustawieniach.", "info")
      else
        triggerServerEvent("onPlayerCustomCommand", localPlayer, cmd, unpack(details))
      end

    elseif cmd == "binds" then
      triggerEvent("createBindManager", resourceRoot)

    elseif cmd == "phone" then
      exports.TR_phone:switchPhone()

    elseif cmd == "taxi" then
      exports.TR_phone:autoPhoneByCommand("taxi")

    elseif cmd == "event" then
      local job, type = exports.TR_jobs:getPlayerJob()
      if type then
        exports.TR_noti:create("Nie możesz zapisać się na event jeśli jesteś w trakcie pracy.", "error")
        self:clearMessage()
        self.slow = getTickCount()
        return
      end
      triggerServerEvent("onPlayerCustomCommand", localPlayer, cmd, unpack(details))

    else
      triggerServerEvent("onPlayerCustomCommand", localPlayer, cmd, unpack(details))
    end

  elseif not self:preventSpam(text) then
    if exports.TR_advertisements:isPlayerInRadio() then
      triggerServerEvent("addAdvert", localPlayer, getPlayerName(localPlayer), text)

    else
      if getElementData(localPlayer, "hasBw") then
        self:clearMessage()
        self.slow = getTickCount()
        return
      end

      local symb = string.match(text, "*(.-)*")
      if symb then
        text = string.gsub(text, "*(.-)*", "#C2A2DA**"..symb.."**#969696")
      end

      triggerServerEvent("onPlayerCustomChat", localPlayer, text)
    end
  end

  if arg[1] then return end
  self:clearMessage()
  self.slow = getTickCount()
end

function Chat:clearMessage()
  exports.TR_dx:setEditText(self.edit, "")
  guiBlur(self.edit)
  self:switch(true, "down")
end

function Chat:preventSpam(...)
  if self.lastMessage == utf8.lower(arg[1]) then
    if self.lastMessageCount == settings.maxRepeatedMessage then
      self:addCustomText("#b85149Anty Spam", "#e3847dPowtarzanie ciągle tej samej wiadomości nie sprawi, że ktoś postanowi ci odpisać.", "files/images/system.png")
      return true
    else
      self.lastMessageCount = self.lastMessageCount + 1
    end
  else
    self.lastMessageCount = 1
    self.lastMessage = utf8.lower(arg[1])
  end
  return false
end

function Chat:drawBackground(x, y, rx, ry, color, radius, post)
  rx = rx - radius * 2
  ry = ry - radius * 2
  x = x + radius
  y = y + radius

  if (rx >= 0) and (ry >= 0) then
      dxDrawRectangle(x, y, rx, ry, color, post)
      dxDrawRectangle(x - radius, y - radius, rx + radius, radius, color, post)
      dxDrawRectangle(x, y + ry, rx, radius, color, post)
      dxDrawRectangle(x - radius, y, radius, ry, color, post)
      dxDrawRectangle(x + rx, y, radius, ry, color, post)

      dxDrawCircle(x + rx, y, radius, 270, 360, color, color, 7, 1, post)
      dxDrawCircle(x + rx, y + ry, radius, 0, 90, color, color, 7, 1, post)
      dxDrawCircle(x, y + ry, radius, 90, 180, color, color, 7, 1, post)
  end
end

function Chat:drawBackgroundShorter(x, y, rx, ry, color, radius, post)
  rx = rx - radius * 2
  ry = ry - radius * 2
  x = x + radius
  y = y + radius

  if (rx >= 0) and (ry >= 0) then
    dxDrawRectangle(x - radius, y - radius, rx + radius * 2, ry + radius, color, post)
    dxDrawRectangle(x, y + ry, rx, radius, color, post)

    dxDrawCircle(x + rx, y + ry, radius, 0, 90, color, color, 7, 1, post)
    dxDrawCircle(x, y + ry, radius, 90, 180, color, color, 7, 1, post)
  end
end

function Chat:drawBackgroundSender(x, y, rx, ry, color, radius, post)
  rx = rx - radius * 2
  ry = ry - radius * 2
  x = x + radius
  y = y + radius

  if (rx >= 0) and (ry >= 0) then
      dxDrawRectangle(x - radius, y, rx + radius * 2, ry + radius, color, post)
      dxDrawRectangle(x, y - radius, rx, radius, color, post)

      dxDrawCircle(x, y, radius, 180, 270, color, color, 7, 1, post)
      dxDrawCircle(x + rx, y, radius, 270, 360, color, color, 7, 1, post)
  end
end

function Chat:drawBackgroundSenderWider(x, y, rx, ry, color, radius, post)
  rx = rx - radius * 2
  ry = ry - radius * 2
  x = x + radius
  y = y + radius

  if (rx >= 0) and (ry >= 0) then
      dxDrawRectangle(x - radius, y, rx + radius * 2, ry, color, post)
      dxDrawRectangle(x, y - radius, rx, radius, color, post)
      dxDrawRectangle(x - radius, y + ry, rx + radius, radius, color, post)

      dxDrawCircle(x, y, radius, 180, 270, color, color, 7, 1, post)
      dxDrawCircle(x + rx, y, radius, 270, 360, color, color, 7, 1, post)
      dxDrawCircle(x + rx, y + ry, radius, 0, 90, color, color, 7, 1, post)
  end
end

function Chat:drawBubbleBackground(x, y, rx, ry, color, radius, post)
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

function Chat:getTextHeight(...)
  return math.max(settings.fontHeight + 10, arg[1].rows * settings.fontHeight + 10)
end

function Chat:getTextHeightMinified(...)
  return math.max(settings.fontHeight + 10, arg[1].rowsMinified * settings.fontHeight + 10)
end

function Chat:getTextWidth(...)
  return math.min(settings.w, dxGetTextWidth(self:removeColor(arg[1]), 1, arg[2]) + 20)
end

function Chat:getPlayerName(plr)
  local id = getElementData(plr, "ID")
  local fakeName = getElementData(plr, "fakeName")
  if fakeName then return string.format("#888888[%d] #aaaaaa%s", id, fakeName) end

  local usernameRP = getElementData(plr, "usernameRP")
	if getElementData(plr, "characterMask") and exports.TR_hud:isInDmZone(plr) then return string.format("%s[%d] #aaaaaaNieznajomy #%03d", self:getNickColor(plr), id, id) end
  if getElementData(localPlayer, "wantRP") and usernameRP then return string.format("%s[%d] #aaaaaa%s", self:getNickColor(plr), id, usernameRP) end
  return string.format("%s[%d] #aaaaaa%s", self:getNickColor(plr), id, getPlayerName(plr))
end

function Chat:addText(...)
  if not arg[1] or not arg[2] then return end
  if not isElement(arg[1]) then return end

  if getDistanceBetweenPoints3D(Vector3(getElementPosition(localPlayer)), Vector3(getElementPosition(arg[1]))) > 20 then return end

  local senderID = getElementData(arg[1], "ID")
  local senderData = getElementData(arg[1], "characterData")
  if not senderData then return end
  local text, rows = self:prepareText(arg[2])
  local textMinified, rowsMinified = self:prepareText(self:getPlayerName(arg[1])..": "..arg[2])
  if not text then return end
  local message = {
    senderID = senderID,
    sender = self:getPlayerName(arg[1]),
    text = text,
    textMinified = textMinified,
    rows = rows,
    rowsMinified = rowsMinified,
    img = self:getImage(arg[1]),
    width = self:getTextWidth(text, settings.fonts.text),
    widthMinified = self:getTextWidth(self:removeColor("     "..textMinified), settings.fonts.text),
  }
  message.widthSender = self:getTextWidth(message.sender, settings.fonts.text)

  self:showChatInConsole(message.sender, arg[2])

  if #self.messages == settings.maxMessages then table.remove(self.messages) end
  table.insert(self.messages, 1, message)
  self:getMaxScroll()
  self:updateChat()
end

function Chat:addBubbleText(...)
  if arg[1] == localPlayer then return end
  local text, rows = self:prepareText(arg[2])

  if not self.bubblesTexts[arg[1]] then self.bubblesTexts[arg[1]] = {} end
  table.insert(self.bubblesTexts[arg[1]], {
    plr = arg[1],
    text = text,
    rows = rows,
    showTime = math.max(math.min(utf8.len(text), 12), 3) * 1000,
    tick = getTickCount(),
    state = "opening",
    textWidth = dxGetTextWidth(text, 1, settings.fonts.bubble, true)
  })
end

function Chat:showChatInConsole(sender, text)
  outputConsole(self:removeColor(string.format("%s: %s", sender, text)))
end

function Chat:showTextInConsole(formatter, sender, text)
  outputConsole(self:removeColor(string.format(formatter, self:removeColor(sender), self:removeColor(text))))
end

function Chat:addCustomText(...)
  local text, rows = self:prepareText(arg[2])
  local textMinified, rowsMinified = self:prepareText(arg[1]..": "..arg[2])
  if not text then return end
  local message = {
    sender = arg[1],
    text = text,
    textMinified = textMinified,
    rows = rows,
    rowsMinified = rowsMinified,
    img = self:getImage(false, arg[3]),
    width = self:getTextWidth(text, settings.fonts.text),
    widthMinified = self:getTextWidth(self:removeColor("     "..textMinified), settings.fonts.text),
  }



  if message.img == "files/images/star.png" then
    if self.blockPremium then return end

  elseif message.img == "files/images/msg_sent.png" then
    outputConsole(string.format("[%d] %s → %s: %s", getElementData(localPlayer, "ID"), getPlayerName(localPlayer), self:removeColor(message.sender), self:removeColor(arg[2])))

  elseif message.img == "files/images/msg_received.png" then
    playSound("files/sounds/pm.wav")
    outputConsole(string.format("%s → [%d] %s: %s", self:removeColor(message.sender), getElementData(localPlayer, "ID"), getPlayerName(localPlayer), self:removeColor(arg[2])))
  end

  if settings.enabledConsole[message.img] then
    self:showTextInConsole(settings.enabledConsole[message.img], message.sender, arg[2])
  end

  message.widthSender = self:getTextWidth(message.sender, settings.fonts.text)
  if #self.messages == settings.maxMessages then table.remove(self.messages) end
  table.insert(self.messages, 1, message)
  self:getMaxScroll()
  self:updateChat()
end

function Chat:getImage(...)
  if arg[1] then
    local fakeName = getElementData(arg[1], "fakeName")
    if fakeName then return "files/images/man.png" end

    local characterData = getElementData(arg[1], "characterData")
    local characterDuty = getElementData(arg[1], "characterDuty")


    if characterDuty then
      if characterDuty[3] == "fire" then return "files/images/fireman.png"
      elseif characterDuty[3] == "police" then return "files/images/police.png"
      elseif characterDuty[3] == "medic" then return "files/images/doctor.png"
      end
    end

    if getElementData(arg[1], "characterMask") and exports.TR_hud:isInDmZone(arg[1]) then return "files/images/mask.png" end

    -- Image logic for premium etc.
    if characterData.premium == "gold" then
      return "files/images/crown.png"

    elseif characterData.premium == "diamond" then
      return "files/images/diamond.png"

    end
    return "files/images/man.png"

  else
    return arg[2] and arg[2] or "files/images/man.png"
  end
end

function Chat:getNickColor(...)
  if arg[1] then
    if getElementData(arg[1], "characterMask") and exports.TR_hud:isInDmZone(arg[1]) then return "#666666" end

    local rank = getElementData(arg[1], "adminDuty")
    if rank then
      if string.find(rank, "owner") then return "#7e0f0f" end
      if string.find(rank, "guardian") then return "#e73f0b" end
      if string.find(rank, "admin") then return "#da1717" end
      if string.find(rank, "moderator") then return "#0f6c10" end
      if string.find(rank, "support") then return "#1ba3f3" end
      if string.find(rank, "developer") then return "#9424b4" end
    end

    local characterData = getElementData(arg[1], "characterData")
    -- Nick colors logic for premium etc.
    if characterData.premium == "gold" then
      return "#B98C04"

    elseif characterData.premium == "diamond" then
      return "#31caff"

    end
  end
  return "#888888"
end

function Chat:prepareText(...)
  local textTable = {}
  local emotesText = self:getEmotes(arg[1])
  local words = split(emotesText, " ")
  local word = 1
  local text = words[1]
  local lastText = ""

  if #words > 0 then
    while (#words > 0) do
      local textLong = dxGetTextWidth(text, 1, settings.fonts.text)
      if textLong >= (settings.w - 20) then
        if word == 1 then
          local textToFit = ""
          local i = 1
          while textLong >= (settings.w - 20) do
            local forceBrake = dxGetTextWidth(textToFit, 1, settings.fonts.text)
            if forceBrake < (settings.w - 20) then
              textToFit = utf8.sub(text, 1, i)
            else
              textToFit = utf8.sub(textToFit, 1, string.len(textToFit) - 1)
              text = utf8.sub(text, i - 1, string.len(text))

              table.insert(textTable, textToFit)
              textLong = dxGetTextWidth(text, 1, settings.fonts.text)
              textToFit = ""
              lastText = text
              i = 0
            end
            i = i + 1
          end
        end

        table.insert(textTable, lastText)
        for i = 2, (word + 1) do
          table.remove(words, word - i)
        end
        table.remove(words, 1)
        word = 1
        text = words[1]
        lastText = ""

      else
        word = word + 1
        if not words[word] then table.insert(textTable, text) break end
        lastText = text
        text = text.. " " ..words[word]
      end
    end
  else
    -- if i ~= #sentences then
    --   table.insert(textTable, "")
    -- end
    return false
  end

  local concat = table.concat(textTable, "\n")
  return concat, #split(concat, "\n")
end

function Chat:prepareCommands()
  local isOnDuty = exports.TR_admin:isPlayerOnDuty()
  local isOnDev = exports.TR_admin:isPlayerDeveloper()
  local permissions = exports.TR_admin:getAdminPermissions()
  local plrData = getElementData(localPlayer, "characterData")

  self.commandHints = {}
  for i, v in pairs(commandHints) do
    if v[2] then
      if v[2].admin and isOnDuty then
        if v[2].permission then
          if permissions[v[2].permission] then
            self.commandHints[i] = v[1]
          end
        else
          self.commandHints[i] = v[1]
        end

      elseif v[2].dev and isOnDev then
        self.commandHints[i] = v[1]

      elseif v[2].premium == "gold/diamond" and (plrData.premium == "gold" or plrData.premium == "diamond") then
        self.commandHints[i] = v[1]

      elseif v[2].premium and v[2].premium == plrData.premium == "gold" then
        self.commandHints[i] = v[1]
      end
    else
      self.commandHints[i] = v[1]
    end
  end
end

function Chat:getEmotes(...)
  if not getElementData(localPlayer, "wantRP") then return arg[1] end

  local tableText = split(arg[1], " ")
  for i, v in pairs(emotes) do
    for k, text in pairs(tableText) do
      if text == i then
        tableText[k] = string.format("%s*%s*%s", "#C2A2DA", v, "#969696")
      end
    end
  end
  return table.concat(tableText, " ")
end

function Chat:removeColor(...)
  while string.find(arg[1], "#%x%x%x%x%x%x") do
    arg[1] = string.gsub(arg[1], "#%x%x%x%x%x%x", "")
  end
  return arg[1]
end

function Chat:isCommand(...)
  local symbol = string.sub(arg[1], 1, 1)
  if symbol == "/" then
    return true
  end
  return false
end

function Chat:prepareCommand(...)
  arg[1] = string.sub(arg[1], 2, string.len(arg[1]))
  local cmdName = arg[1]
  local cmdData = {}

  if string.find(arg[1], " ") then
    cmdData = split(arg[1], " ")
    cmdName = cmdData[1]
    table.remove(cmdData, 1)
  end

  return cmdName, cmdData
end

function Chat:clear()
  self.messages = {}
  self.scrolled = 0
  self.maxScroll = 0
  self:updateChat()
  return true
end

function Chat:isShowed()
  return self.showed
end

function Chat:show(time)
  self.showed = true
  self.animSpeed = time or 500
  self.state = "opening"
  self.lastAnim = self.anim
  self.tick = getTickCount()
end

function Chat:hide(time)
  self.showed = false
  self:switch(true, "down", true)

  self.animSpeed = time or 500
  self.state = "closing"
  self.lastAnim = self.anim
  self.tick = getTickCount()
end

function Chat:setChatMessage(...)
  self:switch(true, "down")

  setTimer(function()
    exports.TR_dx:setEditText(self.edit, arg[1])
  end, 100, 1)
  setTimer(guiFocus, 100, 1, self.edit)
end

function Chat:setChatBlocked(...)
  self.blockOpen = arg[1]
end

function Chat:isChatOpened()
  return self.opened
end

function Chat:setChatBlockVisible(state)
  self.blockVisible = state
  exports.TR_dashboard:setDashboardResponseShader()
end

function Chat:setMinified(state)
  self.minified = state
  self:updateChat()
  exports.TR_dashboard:setDashboardResponseShader()
end

local chatbox = Chat:create()
function createChat(time)
  chatbox:show(time)
  chatbox:clear()
  chatbox:addCustomText("#ffffffSYSTEM", "Witaj na serwerze Just Play. Jest nam bardzo miło cię powitać i mamy nadzieję, że spędzisz z nami trochę więcej czasu. Pozdrawia, administracja serwera.", "files/images/system.png")
  triggerServerEvent("hasPlayerMute", resourceRoot, localPlayer, true)
end
addEvent("createCustomChat", true)
addEventHandler("createCustomChat", root, createChat)

function showCustomChat(state, time)
  if state then
    chatbox:show(time)
  else
    chatbox:hide(time)
  end
end
addEvent("showChat", true)
addEventHandler("showChat", root, showCustomChat)

function clearChat(...)
  chatbox:clear()
  chatbox:addCustomText("#ffffffSYSTEM", "Chat został wyczyszczony przez administratora.", "files/images/system.png")
end
addEvent("clearChat", true)
addEventHandler("clearChat", root, clearChat)

function showMessage(plr, msg)
  chatbox:addText(plr, msg)
  chatbox:addBubbleText(plr, msg)
end
addEvent("showMessage", true)
addEventHandler("showMessage", root, showMessage)

function showCustomMessage(...)
  chatbox:addCustomText(...)
end
addEvent("showCustomMessage", true)
addEventHandler("showCustomMessage", root, showCustomMessage)

function addBubbleText(...)
  chatbox:addBubbleText(...)
end
addEvent("addBubbleText", true)
addEventHandler("addBubbleText", root, addBubbleText)

function blockPremium(...)
  chatbox.blockPremium = arg[1]
  exports.TR_dashboard:setDashboardResponseShader()
end

function setChatBlocked(...)
  chatbox:setChatBlocked(...)
end

function isChatOpened()
  return chatbox:isChatOpened()
end

function setChatMessage(...)
  chatbox:setChatMessage(...)
end

function setChatBlockVisible(...)
  chatbox:setChatBlockVisible(...)
end

function writeChat(...)
  chatbox:write(...)
end

function setMinified(...)
  chatbox:setMinified(...)
end



-- Create chatbox if player is logged in
if getElementData(localPlayer, "characterUID") then createChat() end