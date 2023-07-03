function createPirate()
    local dialogue = exports.TR_npc:createDialogue()
    exports.TR_npc:addDialogueText(dialogue, "Witaj. Po co ci tyle butli z gazem?", {pedResponse = "Ahoj kamracie! To nie butle z gazem tylko z tlenem."})
    exports.TR_npc:addDialogueText(dialogue, "Ahoj? Kamracie? Jesteś jakimś żeglarzem?", {pedResponse = "Nie, ale od zawsze fascynowały mnie opowieści morskie, a jeśli wierzyć legendom przodków wilków morskich to właśnie w tym miejscu w XVII wieku rozbił się piracki statek z wielkim łupem! Moją misją jest znaleźć wszystkie skarby jakie skrywają te głębiny.", responseTo = "Witaj. Po co ci tyle butli z gazem?"})
    exports.TR_npc:addDialogueText(dialogue, "Czy mogę Ci jakoś pomóc w poszukiwaniach?", {pedResponse = "Ayyy! Oczywiście młody kamracie, jedź do San Fierro aby wyrobić uprawnienia pływackie, patrząc po twoim mizernym wyglądzie przyda ci się też nabrać troche doświadczenia w mieście, kiedy już będziesz czuł się pewnie wróć do mnie!", responseTo = "Ahoj? Kamracie? Jesteś jakimś żeglarzem?"})
    exports.TR_npc:addDialogueText(dialogue, "W takim razie wrócę niebawem.", {pedResponse = "", responseTo = "Czy mogę Ci jakoś pomóc w poszukiwaniach?"})
    exports.TR_npc:addDialogueText(dialogue, "[pod nosem] Otaczają mnie szaleńcy...", {pedResponse = "", responseTo = "Ahoj? Kamracie? Jesteś jakimś żeglarzem?"})

    exports.TR_npc:addDialogueText(dialogue, "Jak mogę zacząć tu pracować?", {pedResponse = "Ahoj młody kamracie! Chętnie przyjmę cie do pracy jako podwodny poszukiwacz zaginionych artefaktów, jednak przed tym wyrób uprawnienia pływackie w San Fierro oraz nabierz trochę doświadczenia w pracy w mieście. Kiedy już będziesz gotowy to przyjedź do mnie, będę na ciebie czekał."})
    exports.TR_npc:addDialogueText(dialogue, "Do zobaczenia.", {pedResponse = "", responseTo = "Jak mogę zacząć tu pracować?"})

    exports.TR_npc:addDialogueText(dialogue, "Wydaje mi się, że to może cię zainteresować.", {pedResponse = "Możliwe możliwe. Wszystko zależy od tego, co mi zaoferujesz."})
    exports.TR_npc:addDialogueText(dialogue, "Znalazłem tą starą srebrną szkatułkę.", {pedResponse = "", responseTo = "Wydaje mi się, że to może cię zainteresować.", trigger = "divingPirateGiveItems", triggerData = {"silver"}})
    exports.TR_npc:addDialogueText(dialogue, "Podczas pływania znalazłem tą paczkę ze złotem.", {pedResponse = "", responseTo = "Wydaje mi się, że to może cię zainteresować.", trigger = "divingPirateGiveItems", triggerData = {"gold"}})
    exports.TR_npc:addDialogueText(dialogue, "A co dasz mi za te podarte łachy?", {pedResponse = "Jakie zaś łachy? O czym ty do mnie mówisz?", responseTo = "Wydaje mi się, że to może cię zainteresować."})
    exports.TR_npc:addDialogueText(dialogue, "Dasz radę coś z tym zrobić? (koszt: $5000)", {pedResponse = "", responseTo = "A co dasz mi za te podarte łachy?", trigger = "divingPirateGiveItems", triggerData = {"skin"}})
    exports.TR_npc:addDialogueText(dialogue, "Może później...", {pedResponse = "", responseTo = "A co dasz mi za te podarte łachy?"})

    exports.TR_npc:addDialogueText(dialogue, "Powodzenia w poszukiwaniach!", {pedResponse = "Dzięki wielkie. Ahoj!"})


    local ped = exports.TR_npc:createNPC(120, -912.466796875, 2671.662109375, 42.370262145996, 235, "Jack Spaylow", "Właściciel FoF", "dialogue")
    exports.TR_npc:setNPCDialogue(ped, dialogue)
end
createPirate()


function divingPirateGiveItems(ped, data)
    local pedName = getElementData(ped, "name")
    local uid = getElementData(client, "characterUID")

    if data[1] == "silver" then
        local item = exports.TR_mysql:querry("SELECT ID FROM tr_items WHERE owner = ? AND type = 22 AND variant = 0 AND variant2 = 0 AND ownedType = 0 LIMIT 1", uid)
        if not item or not item[1] then
            triggerClientEvent(client, "showCustomMessage", resourceRoot, pedName, "Szkoda, że naprawdę nie masz tej szkatułki...", "files/images/npc.png")
            return
        end

        exports.TR_core:giveMoneyToPlayer(client, 300)
        exports.TR_mysql:querry("DELETE FROM tr_items WHERE ID = ? LIMIT 1", item[1].ID)
        triggerClientEvent(client, "showCustomMessage", resourceRoot, pedName, "Dam ci za nią $300 i bez żadnych negocjacji! Dawaj mi ją tutaj.", "files/images/npc.png")
        triggerClientEvent(client, "takePlayerItem", resourceRoot, tonumber(item[1].ID))

    elseif data[1] == "gold" then
        local item = exports.TR_mysql:querry("SELECT ID FROM tr_items WHERE owner = ? AND type = 22 AND variant = 0 AND variant2 = 1 AND ownedType = 0 LIMIT 1", uid)
        if not item or not item[1] then
            triggerClientEvent(client, "showCustomMessage", resourceRoot, pedName, "Mieszek? Tyś mieszek chociaż raz widział?", "files/images/npc.png")
            return
        end

        exports.TR_api:givePremium(getPlayerName(client), 1, 1)
        exports.TR_mysql:querry("DELETE FROM tr_items WHERE ID = ? LIMIT 1", item[1].ID)
        triggerClientEvent(client, "showCustomMessage", resourceRoot, pedName, "Dam ci za nią specjalną nagrodę, jest równie złota co twoja paczka!", "files/images/npc.png")
        triggerClientEvent(client, "takePlayerItem", resourceRoot, tonumber(item[1].ID))

    elseif data[1] == "skin" then
        local item = exports.TR_mysql:querry("SELECT ID FROM tr_items WHERE owner = ? AND type = 22 AND variant = 0 AND variant2 = 2 AND ownedType = 0 LIMIT 1", uid)
        if not item or not item[1] then
            triggerClientEvent(client, "showCustomMessage", resourceRoot, pedName, "Mówisz o tych wodorostach? Przyjdź jak znajdziesz prawdziwe łachy pirata.", "files/images/npc.png")
            return
        end

        if exports.TR_core:takeMoneyFromPlayer(client, 5000) then
            exports.TR_mysql:querry("INSERT INTO `tr_items`(`owner`, `type`, `variant`, `variant2`, `value`) VALUES (?, ?, ?, ?, ?)", uid, 3, 10, 0, 203)
            exports.TR_mysql:querry("DELETE FROM tr_items WHERE ID = ? LIMIT 1", item[1].ID)
            triggerClientEvent(client, "showCustomMessage", resourceRoot, pedName, "Na czarną perłę! Toż to ubranie jednego z XVII-sto wiecznych kamratów! Jest jednak niekompletne. Widzę kilka dziur. Ta gotówka powinna jednak wystarczyć na uszycie czegoś porządnego!", "files/images/npc.png")
            triggerClientEvent(client, "takePlayerItem", resourceRoot, tonumber(item[1].ID))
        else
            triggerClientEvent(client, "showCustomMessage", resourceRoot, pedName, "Jak uda ci się zdobyć $5000 na materiały to mogę ci uszyć piękny strój pirata!", "files/images/npc.png")
        end

    end
end
addEvent("divingPirateGiveItems", true)
addEventHandler("divingPirateGiveItems", root, divingPirateGiveItems)


-- Job skins
function startDivingJob()
    setElementModel(client, 291)
end
addEvent("startDivingJob", true)
addEventHandler("startDivingJob", resourceRoot, startDivingJob)

function giveDivingJobItem(type)
    local plrUID = getElementData(client, "characterUID")

    if type == "clothes" then
        local uid = getElementData(client, "characterUID")
        exports.TR_mysql:querry("INSERT INTO `tr_items`(`owner`, `type`, `variant`, `variant2`, `value`) VALUES (?, ?, ?, ?, ?)", uid, 22, 0, 2, 0)
        exports.TR_items:updateItems(client, false)

    elseif type == "gold" then
        local uid = getElementData(client, "characterUID")
        exports.TR_mysql:querry("INSERT INTO `tr_items`(`owner`, `type`, `variant`, `variant2`, `value`) VALUES (?, ?, ?, ?, ?)", uid, 22, 0, 1, 0)
        exports.TR_items:updateItems(client, false)

    elseif type == "silver" then
        local uid = getElementData(client, "characterUID")
        exports.TR_mysql:querry("INSERT INTO `tr_items`(`owner`, `type`, `variant`, `variant2`, `value`) VALUES (?, ?, ?, ?, ?)", uid, 22, 0, 0, 0)
        exports.TR_items:updateItems(client, false)

    end
end
addEvent("giveDivingJobItem", true)
addEventHandler("giveDivingJobItem", resourceRoot, giveDivingJobItem)