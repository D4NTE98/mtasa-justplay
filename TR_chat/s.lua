function onPlayerChat(msg, type)
  cancelEvent()
end
addEventHandler("onPlayerChat", root, onPlayerChat)

function onPlayerCustomChat(msg)
  if not getElementData(source, "characterUID") or not msg then return end
  if hasPlayerMute(source) then return end

  triggerClientEvent(root, "showMessage", resourceRoot, source, msg)
  -- triggerClientEvent(root, "addBubbleText", resourceRoot, source, msg)

  local id = getElementData(source, "ID")
  local plrName = getPlayerName(source)
  exports.TR_admin:updateLogs(string.format("(CHAT) %s %d: %s", plrName, id, msg))

  local time = getRealTime()

  local tf = string.format("[%02d:%02d %02d.%02d]", time.hour, time.minute, time.monthday, time.month)
  exports.TR_discord:remoteDsc(tf.." | "..string.format("**[**CHAT**]** **%s** **[**%s**]** → **%s**", plrName, id, msg), "chat")
  
end
addEvent("onPlayerCustomChat", true)
addEventHandler("onPlayerCustomChat", root, onPlayerCustomChat)

function onPlayerCustomCommand(...)
  performCommand(...)
end
addEvent("onPlayerCustomCommand", true)
addEventHandler("onPlayerCustomCommand", root, onPlayerCustomCommand)


-- Utils
function getNearPlayers(plr, dist)
  local x, y, z = getElementPosition(plr)
  local col = createColSphere(x, y, z, dist)
  local players = getElementsWithinColShape(col, "player")
  destroyElement(col)
  return players
end

function removeColor(...)
  while string.find(arg[1], "#%x%x%x%x%x%x") do
    arg[1] = string.gsub(arg[1], "#%x%x%x%x%x%x", "")
  end
  return arg[1]
end



-- Prebuild commands
function meCommand(...)
  if hasPlayerMute(source) then return end
  local msg = table.concat({...}, " ")
  if string.len(msg) < 1 then triggerClientEvent(source, "showCustomMessage", resourceRoot, "#008a2eUżycie komendy", "#438f5c/me (wiadomość)", "files/images/command.png") return end
  local nearPlayers = getNearPlayers(source, 20)
  local id = getElementData(source, "ID")
  for _, player in ipairs(nearPlayers) do
    triggerClientEvent(player, "showMessage", resourceRoot, source, "#C2A2DA** "..msg.." **")
  end

  local plrName = getPlayerName(source)
  exports.TR_admin:updateLogs(string.format("#730192(ME)#ffffff %s %d: %s", plrName, id, msg))

  local time = getRealTime()

  local tf = string.format("[%02d:%02d %02d.%02d]", time.hour, time.minute, time.monthday, time.month)
  exports.TR_discord:remoteDsc(tf.." | "..string.format("**[**ME**]** **%s** **[**%s**]** → **%s**", plrName, id, msg), "chat")
end
addCommand("me", meCommand)

function doCommand(...)
  if hasPlayerMute(source) then return end
  local msg = table.concat({...}, " ")
  if string.len(msg) < 1 then triggerClientEvent(source, "showCustomMessage", resourceRoot, "#008a2eUżycie komendy", "#438f5c/do (wiadomość)", "files/images/command.png") return end
  local nearPlayers = getNearPlayers(source, 20)
  local id = getElementData(source, "ID")
  for _, player in ipairs(nearPlayers) do
    triggerClientEvent(player, "showMessage", resourceRoot, source, "#9A9CCD** ("..msg..") **")
  end

  local plrName = getPlayerName(source)
  exports.TR_admin:updateLogs(string.format("#730192(DO)#ffffff %s %d: %s", plrName, id, msg))

  local time = getRealTime()

  local tf = string.format("[%02d:%02d %02d.%02d]", time.hour, time.minute, time.monthday, time.month)
  exports.TR_discord:remoteDsc(tf.." | "..string.format("**[**DO**]** **%s** **[**%s**]** → **%s**", plrName, id, msg), "chat")
  
end
addCommand("do", doCommand)

function oocCommand(...)
  if hasPlayerMute(source) then return end
  local msg = table.concat({...}, " ")
  if string.len(msg) < 1 then triggerClientEvent(source, "showCustomMessage", resourceRoot, "#008a2eUżycie komendy", "#438f5c/b (wiadomość)", "files/images/command.png") return end
  local nearPlayers = getNearPlayers(source, 20)
  local id = getElementData(source, "ID")
  for _, player in ipairs(nearPlayers) do
    triggerClientEvent(player, "showMessage", resourceRoot, source, "#AFAFAF(( "..msg.." ))")
  end

  local plrName = getPlayerName(source)
  exports.TR_admin:updateLogs(string.format("(OOC) %s %d: %s", plrName, id, msg))

  local time = getRealTime()

  local tf = string.format("[%02d:%02d %02d.%02d]", time.hour, time.minute, time.monthday, time.month)
  exports.TR_discord:remoteDsc(tf.." | "..string.format("**[**OOC**]** **%s** **[**%s**]** → **%s**", plrName, id, msg), "chat")
  
end
addCommand("b", oocCommand)

function tryCommand(...)
  if hasPlayerMute(source) then return end
  local msg = table.concat({...}, " ")
  if string.len(msg) < 1 then triggerClientEvent(source, "showCustomMessage", resourceRoot, "#008a2eUżycie komendy", "#438f5c/try (wiadomość)", "files/images/command.png") return end
  local nearPlayers = getNearPlayers(source, 20)
  local id = getElementData(source, "ID")
  local result = math.random(1, 2)
  for _, player in ipairs(nearPlayers) do
    triggerClientEvent(player, "showMessage", resourceRoot, source, string.format("#C2A2DA** %s %s **", result == 1 and "Udało się" or "Nie udało się", msg))
  end

  local plrName = getPlayerName(source)
  exports.TR_admin:updateLogs(string.format("#730192(TRY)#ffffff %s %d: %s", plrName, id, msg))

  local time = getRealTime()

  local tf = string.format("[%02d:%02d %02d.%02d]", time.hour, time.minute, time.monthday, time.month)
  exports.TR_discord:remoteDsc(tf.." | "..string.format("**[**TRY**]** **%s** **[**%s**]** → **%s**", plrName, id, msg), "chat")
  
end
addCommand("try", tryCommand)

function diceCommand(...)
  if hasPlayerMute(source) then return end
  local nearPlayers = getNearPlayers(source, 4)
  local id = getElementData(source, "ID")
  local maxSide = 6
  if tonumber(arg[1]) ~= nil then maxSide = tonumber(arg[1]) end
  local num = math.random(1, maxSide)
  for _, player in ipairs(nearPlayers) do
    triggerClientEvent(player, "showMessage", resourceRoot, source, "#C2A2DA* Kostka pokręciła się dookoła i pokazała liczbę "..num.." *")
  end

  triggerClientEvent(source, "addAchievements", resourceRoot, "diceThrow")
end
addCommand("dice", diceCommand)

function pmCommand(targetID, ...)
  if hasPlayerMute(source) then return end
  if not targetID then triggerClientEvent(source, "showCustomMessage", resourceRoot, "#008a2eUżycie komendy", "#438f5c/sms (ID gracza) (wiadomość)", "files/images/command.png") return end

  local target = findPlayer(client, targetID)
  if not target or not isElement(target) then return end

  local id = getElementData(source, "ID")
  if source == target then exports.TR_noti:create(source, "Nie możesz napisać prywatnej wiadomości sam do siebie.", "error") return end
  if getElementData(source, "smsOff") then exports.TR_noti:create(source, "Nie możesz pisać wiadomości prywatnych, jeśeli masz je samemu wyłączone.", "error") return end
  if getElementData(target, "smsOff") then exports.TR_noti:create(source, "Nie możesz napisać wiadomości prywatnej do tego gracza, ponieważ ma je wyłączone.", "error") return end

  local msg = table.concat({...}, " ")
  if string.len(msg) < 1 then triggerClientEvent(source, "showCustomMessage", resourceRoot, "#008a2eUżycie komendy", "#438f5c/sms (ID gracza) (wiadomość)", "files/images/command.png") return end

  local name = getPlayerSMSName(source)
  local id = getElementData(source, "ID")
  local nameTo = getPlayerSMSName(target)
  local idTo = getElementData(target, "ID")

  triggerClientEvent(source, "showCustomMessage", resourceRoot, string.format("#d89932[%d] %s", idTo, nameTo), "#ac7a28"..msg, "files/images/msg_sent.png")
  triggerClientEvent(target, "showCustomMessage", resourceRoot, string.format("#d89932[%d] %s", id, name), "#ac7a28"..msg, "files/images/msg_received.png")
  setElementData(target, "msgID", id)

  if getElementData(target, "afk") then
    exports.TR_noti:create(source, "Gracz do którego piszesz jest AFK, więc może nie odpisać zbyt szybko.", "info")
  end

  local plrName = getPlayerName(source)
  local targetName = getPlayerName(target)
  exports.TR_admin:updateLogs(string.format("#1c65cc(SMS)#ffffff %s %d → %s %d: %s", plrName, id, targetName, idTo, msg))

  local time = getRealTime()
  local tf = string.format("[%02d:%02d %02d.%02d]", time.hour, time.minute, time.monthday, time.month)
  exports.TR_discord:remoteDsc(tf.." | "..string.format("**[**PM**]** **%s** **[**%s**]** → **%s** **[**%s**]** → %s", plrName, id, targetName, idTo, msg), "chat")
  
end
addCommand("sms", pmCommand)
addCommand("pm", pmCommand)
addCommand("pw", pmCommand)
addCommand("w", pmCommand)

function reCommand(...)
  if hasPlayerMute(source) then return end
  local targetID = getElementData(source, "msgID")
  if not targetID then exports.TR_noti:create(source, "Nie udało się odpowiedzieć na ostatnią wiadomość.", "error") return end

  local target = getElementByID("ID"..targetID)
  if not target or not isElement(target) then exports.TR_noti:create(source, "Podany gracz nie został znaleziony.", "error") return end

  if getElementData(source, "smsOff") then exports.TR_noti:create(source, "Nie możesz pisać wiadomości prywatnych, jeżeli masz je samemu wyłączone.", "error") return end
  if getElementData(target, "smsOff") then exports.TR_noti:create(source, "Nie możesz napisać wiadomości prywatnej do tego gracza, ponieważ ma je wyłączone.", "error") return end
  local msg = table.concat({...}, " ")
  if string.len(msg) < 1 then triggerClientEvent(source, "showCustomMessage", resourceRoot, "#008a2eUżycie komendy", "#438f5c/rsms (wiadomość)", "files/images/command.png") return end

  local name = getPlayerSMSName(source)
  local id = getElementData(source, "ID")
  local nameTo = getPlayerSMSName(target)
  local idTo = getElementData(target, "ID")

  triggerClientEvent(source, "showCustomMessage", resourceRoot, string.format("#d89932[%d] %s", idTo, nameTo), "#ac7a28"..msg, "files/images/msg_sent.png")
  triggerClientEvent(target, "showCustomMessage", resourceRoot, string.format("#d89932[%d] %s", id, name), "#ac7a28"..msg, "files/images/msg_received.png")
  setElementData(target, "msgID", id)

  local plrName = getPlayerName(source)
  local targetName = getPlayerName(target)
  exports.TR_admin:updateLogs(string.format("#1c65cc(SMS)#ffffff %s %d → %s %d: %s", plrName, id, targetName, idTo, msg))

  local time = getRealTime()
  local tf = string.format("[%02d:%02d %02d.%02d]", time.hour, time.minute, time.monthday, time.month)
  exports.TR_discord:remoteDsc(tf.." | "..string.format("**[**PM**]** **%s** **[**%s**]** → **%s** **[**%s**]** → %s", plrName, id, targetName, idTo, msg), "chat")
  
end
addCommand("rsms", reCommand)
addCommand("re", reCommand)

function pCommand(...)
  if hasPlayerMute(source) then return end

  local players = getElementsByType("player")
  local id = getElementData(source, "ID")
  local plrName = getPlayerName(source)
  local msg = table.concat({...}, " ")
  if string.len(msg) < 1 then triggerClientEvent(source, "showCustomMessage", resourceRoot, "#008a2eUżycie komendy", "#438f5c/p (wiadomość)", "files/images/command.png") return end

  local color = getPlayerPremiumChatColor(source)
  if not color or not id or not plrName then return end

  for _, player in ipairs(players) do
    local data = getElementData(player, "characterData")
    if data then
      if data.premium == "gold" or data.premium == "diamond" then
        triggerClientEvent(player, "showCustomMessage", resourceRoot, string.format("%s[%d] %s", color, id, plrName), "#FFDC64"..msg, "files/images/star.png")
      end
    end
  end

  exports.TR_admin:updateLogs(string.format("#e9e452(PREMIUM)#ffffff %s %d: %s", plrName, id, msg))

  local time = getRealTime()
  local tf = string.format("[%02d:%02d %02d.%02d]", time.hour, time.minute, time.monthday, time.month)
  exports.TR_discord:remoteDsc(tf.." | "..string.format("**[**PREMIUM**]** **%s** **[**%s**]** → **%s**", plrName, id, msg), "chat")
  
end
addCommand("p", pCommand)

function oCommand(...)
  if hasPlayerMute(client) then return end
  local orgID = getElementData(client, "characterOrgID")
  if not orgID then return end

  local players = getElementsByType("player")
  local id = getElementData(client, "ID")
  local plrName = getPlayerName(client)
  local msg = table.concat({...}, " ")

  for _, player in ipairs(players) do
    local plrOrg = getElementData(player, "characterOrgID")
    if plrOrg then
      if plrOrg == orgID then
        triggerClientEvent(player, "showCustomMessage", resourceRoot, string.format("#27a2db[%d] %s", id, plrName), "#89c5cd"..msg, "files/images/organization.png")
      end
    end
  end

  exports.TR_admin:updateLogs(string.format("#c27029(ORG)#ffffff %s %d: %s", plrName, id, msg))

  local time = getRealTime()
  local tf = string.format("[%02d:%02d %02d.%02d]", time.hour, time.minute, time.monthday, time.month)
  exports.TR_discord:remoteDsc(tf.." | "..string.format("**[**ORG**]** **%s** **[**%s**]** → **%s**", plrName, id, msg), "chat")
  
end
addEvent("oCommand", true)
addEventHandler("oCommand", resourceRoot, oCommand)



function getPlayerPremiumChatColor(plr)
	local data = getElementData(plr, "characterData")
  if data.premium == "gold" then
    return "#d6a306"

  elseif data.premium == "diamond" then
    return "#31caff"
  end
end

function getPlayerSMSName(plr)
  if getElementData(plr, "characterMask") and exports.TR_hud:isInDmZone(plr) then return string.format("Nieznajomy #%03d", getElementData(plr, "ID")) end
  return getPlayerName(plr)
end

function hasPlayerMute(plr, blockMsg)
  local muteCheckTime = getElementData(plr, "muteCheck")
  if muteCheckTime then
    if (getTickCount() - muteCheckTime)/60000 < 1 and getElementData(plr, "playerMute") then
      if not blockMsg then
        triggerClientEvent(plr, "showCustomMessage", resourceRoot, "#b85149Wyciszenie", "#e3847dNie możesz pisać na chacie, ponieważ zostałeś wyciszony przez administratora.", "files/images/system.png")
      end
      return true
    end
  end
  setElementData(plr, "muteCheck", getTickCount())

  local muteData = exports.TR_mysql:querry("SELECT ID FROM `tr_penalties` WHERE (serial = ? OR username = ? OR plrUID = ?) AND timeEnd > NOW() AND type = 'mute' AND takenBy IS NULL LIMIT 1", getPlayerSerial(plr), getPlayerName(plr), getElementData(plr, "characterUID"))
  if muteData and muteData[1] then
    if not blockMsg then triggerClientEvent(plr, "showCustomMessage", resourceRoot, "#b85149Wyciszenie", "#e3847dNie możesz pisać na chacie, ponieważ zostałeś wyciszony przez administratora.", "files/images/system.png") end
    setElementData(plr, "playerMute", true)
    return true
  end
  removeElementData(plr, "playerMute")

  return false
end
addEvent("hasPlayerMute", true)
addEventHandler("hasPlayerMute", resourceRoot, hasPlayerMute)

function findPlayer(plr, id)
  local target = getElementByID("ID"..id)
  if not target then target = getPlayerFromName(id) end
  if not target or not isElement(target) then exports.TR_noti:create(plr, "Podany gracz nie został znaleziony.", "error") return false end
  return target
end