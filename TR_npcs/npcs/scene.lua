local dialogueEnter = exports.TR_npc:createDialogue()
exports.TR_npc:addDialogueText(dialogueEnter, "Chciałbym dostać się do strfy VIP.", {pedResponse = "", trigger = "sceneGetVipPlace"})
exports.TR_npc:addDialogueText(dialogueEnter, "Do widzenia.", {pedResponse = ""})

local dialogueExit = exports.TR_npc:createDialogue()
exports.TR_npc:addDialogueText(dialogueExit, "Chciałbym opuścić już strfę VIP.", {pedResponse = "", trigger = "sceneLeaveVipPlace"})
exports.TR_npc:addDialogueText(dialogueExit, "Do widzenia.", {pedResponse = ""})

local pedEnter = exports.TR_npc:createNPC(164, 413.80798339844, -1847.0151367188, 3.6386370658875, 320, "Paul Sneek", "Ochroniarz eventu", "dialogue")
exports.TR_npc:setNPCDialogue(pedEnter, dialogueEnter)

local pedExit = exports.TR_npc:createNPC(163, 466.77505493164, -1849.8460693359, 3.7835826873779, 134, "Thomas Jones", "Ochroniarz eventu", "dialogue")
exports.TR_npc:setNPCDialogue(pedExit, dialogueExit)



function sceneGetVipPlace(ped)
    local pedName = getElementData(ped, "name")
    local dataPlr = getElementData(client, "characterData")
    if dataPlr.premium ~= "diamond" and dataPlr.premium ~= "gold" then
        triggerClientEvent(client, "showCustomMessage", resourceRoot, pedName, "Nie mogę cię wpuścić, ponieważ nie jesteś VIP'em.", "files/images/npc.png")
        return
    end

    setElementPosition(source, 413.59481811523, -1849.7081298828, 3.6582946777344)
    triggerClientEvent(client, "showCustomMessage", resourceRoot, pedName, "Jasne. Tędy proszę.", "files/images/npc.png")
end
addEvent("sceneGetVipPlace", true)
addEventHandler("sceneGetVipPlace", root, sceneGetVipPlace)

function sceneLeaveVipPlace(ped)
    local pedName = getElementData(ped, "name")

    setElementPosition(source, 466.73623657227, -1847.3111572266, 3.9562630653381)
    triggerClientEvent(client, "showCustomMessage", resourceRoot, pedName, "Jasne. Tędy proszę.", "files/images/npc.png")
end
addEvent("sceneLeaveVipPlace", true)
addEventHandler("sceneLeaveVipPlace", root, sceneLeaveVipPlace)