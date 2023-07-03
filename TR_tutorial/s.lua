function endTutorial(uid)
    exports.TR_mysql:querry("UPDATE tr_accounts SET tutorial = NULL WHERE UID = ? LIMIT 1", uid)
end
addEvent("endTutorial", true)
addEventHandler("endTutorial", resourceRoot, endTutorial)

addCommandHandler('test1', function()
    --local uid = getElementData(player, 'characterUID');
    --if uid then
    exports.TR_mysql:querry("UPDATE tr_accounts SET tutorial = NULL WHERE UID = 4 LIMIT 1")
    --end;
    outputConsole('eloelo')
end);


function createScenery()
    local boat = createVehicle(454, -4569, 289.7, 0, 0, 0, 247)
    setElementFrozen(boat, true)
    setVehicleColor(boat, 144,42,25,254,254,254,144,42,25,144,42,25)

    addEventHandler("onVehicleStartEnter", boat, function() cancelEvent() end)

    -- Dawn brother
    local dialogue = exports.TR_npc:createDialogue()
    exports.TR_npc:addDialogueText(dialogue, "Witaj.", {pedResponse = "Witaj. Co Cię tu sprowadza?"})
    exports.TR_npc:addDialogueText(dialogue, "A nic, tak sobie przyszedłem.", {pedResponse = "A to witaj w progach mego brata. Jak coś chcesz to częstuj się ze stołu.", responseTo = "Witaj."})
    exports.TR_npc:addDialogueText(dialogue, "Nie mogę powiedzieć.", {pedResponse = "Jesteś z policji? Jak tak to wynocha!", responseTo = "Witaj."})
    exports.TR_npc:addDialogueText(dialogue, "Chciałbym się dowiedzieć jak trafić do miasta.", {pedResponse = "A to ty w tej sprawie. No to nie ma żadnego powrotu.", responseTo = "Witaj."})
    exports.TR_npc:addDialogueText(dialogue, "Jak to?! [Pchnij samouczek]", {pedResponse = "Tak to! Jedynym momentem kiedy wracasz do miasta jest chwila uniesienia jaką możesz otrzymać korzystając z tego co masz na stole! Bierz i się nie zastanawiaj. Mówię ci, nie pożałujesz! Zresztą jeśli mi nie wierzysz to zadzwoń do mego brata Dawn'a. On Ci wszystko wytłumaczy.", responseTo = "Chciałbym się dowiedzieć jak trafić do miasta."})
    exports.TR_npc:addDialogueText(dialogue, "To może mi chociaż jego numer podasz?", {pedResponse = "A no tak! 800-57-83", responseTo = "Jak to?! [Pchnij samouczek]"})
    exports.TR_npc:addDialogueText(dialogue, "Nie kłam!", {pedResponse = "Uważaj jak chcesz. Ja mam swoje zdanie, ty masz swoje.", responseTo = "Chciałbym się dowiedzieć jak trafić do miasta."})

    exports.TR_npc:addDialogueText(dialogue, "Nie twój interes.", {pedResponse = "Co tak od razu z grubej rury? Nie dość, że jesteś w moim mieszkaniu to jeszcze się tak zachowujesz.", responseTo = "Witaj."})

    exports.TR_npc:addDialogueText(dialogue, "Trzymaj się.", {pedResponse = "Ty też."})

    local ped = exports.TR_npc:createNPC(142, 2703.6733398438, -1427.5433349609, 63.031028747559, 90, "Joseph Hort", "Mieszkaniec wyspy", "dialogue")
    setElementInterior(ped, 0)
    setElementDimension(ped, 5)
    setElementData(ped, "animation", {"beach", "Lay_Bac_Loop"})

    exports.TR_npc:setNPCDialogue(ped, dialogue)


    -- Boat
    local dialogue = exports.TR_npc:createDialogue()
    exports.TR_npc:addDialogueText(dialogue, "Chciałbym się dostać na brzeg.", {pedResponse = "Za darmo nie pływam. Taka podróż kosztuje u mnie $5000."})
    exports.TR_npc:addDialogueText(dialogue, "Może się dogadamy jakoś inaczej?", {pedResponse = "", responseTo = "Chciałbym się dostać na brzeg.", trigger = "tutorialTrade"})
    exports.TR_npc:addDialogueText(dialogue, "Nie mam tyle pieniędzy.", {pedResponse = "No to ja na to nic nie poradzę.", responseTo = "Chciałbym się dostać na brzeg."})

    exports.TR_npc:addDialogueText(dialogue, "Fajny jacht.", {pedResponse = "A dziękuję, dziękuję."})

    local ped = exports.TR_npc:createNPC(142, -4573.20703125, 290.2080078125, 1.218750953674, 316, "Matthew McGort", "Przewoźnik", "dialogue")
    exports.TR_npc:setNPCDialogue(ped, dialogue)
end
createScenery()


function tutorialTrade()
    triggerClientEvent(client, "tutorialTrade", resourceRoot)
end
addEvent("tutorialTrade", true)
addEventHandler("tutorialTrade", root, tutorialTrade)