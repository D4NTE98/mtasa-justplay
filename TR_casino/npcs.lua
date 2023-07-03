NPCs = {
    {
        skin = 113,
        pos = Vector3(1953.1748046875, 1011.8955078125, 992.46875),
        rot = 254,
        name = "Olivier Karter",
        role = "Barman",
        int = 10,
        dim = 0,
        type = "bar",
    },
    {
        skin = 113,
        pos = Vector3(1953.796875, 1017.71875, 992.46875),
        rot = 271,
        name = "Mark Gren",
        role = "Barman",
        int = 10,
        dim = 0,
        type = "bar",
    },
    {
        skin = 113,
        pos = Vector3(1953.2900390625, 1023.162109375, 992.46875),
        rot = 286,
        name = "Henry Grose",
        role = "Barman",
        int = 10,
        dim = 0,
        type = "bar",
    },
    {
        skin = 113,
        pos = Vector3(1948.498046875, 1024.0146484375, 992.47448730469),
        rot = 71,
        name = "John Tray",
        role = "Barman",
        int = 10,
        dim = 0,
        type = "bar",
    },
    {
        skin = 113,
        pos = Vector3(1947.802734375, 1017.7958984375, 992.47448730469),
        rot = 89,
        name = "Thomas Jigs",
        role = "Barman",
        int = 10,
        dim = 0,
        type = "bar",
    },
    {
        skin = 113,
        pos = Vector3(1948.4033203125, 1012.0146484375, 992.47448730469),
        rot = 103,
        name = "Daniel Hunter",
        role = "Barman",
        int = 10,
        dim = 0,
        type = "bar",
    },

    -- Caligula's
    {
        skin = 59,
        pos = Vector3(2154.9384765625, 1598.361328125, 1006.1723022461),
        rot = 261,
        name = "Marcus Kraig",
        role = "Bankier",
        int = 1,
        dim = 0,
        type = "chip",
    },
    {
        skin = 76,
        pos = Vector3(2154.91015625, 1600.638671875, 1006.1661987305),
        rot = 280,
        name = "Janna Haffer",
        role = "Bankier",
        int = 1,
        dim = 0,
        type = "chip",
    },
    {
        skin = 113,
        pos = Vector3(2191.3427734375, 1606.310546875, 1005.0690307617),
        rot = 39,
        name = "Johnny Hand",
        role = "Barman",
        int = 1,
        dim = 0,
        type = "bar",
    },
    {
        skin = 113,
        pos = Vector3(2191.2724609375, 1601.1376953125, 1005.0690307617),
        rot = 131,
        name = "Henry Park",
        role = "Barman",
        int = 1,
        dim = 0,
        type = "bar",
    },
    {
        skin = 113,
        pos = Vector3(2196.5771484375, 1606.24609375, 1005.0690307617),
        rot = 313,
        name = "Tom Grant",
        role = "Barman",
        int = 1,
        dim = 0,
        type = "bar",
    },
    {
        skin = 113,
        pos = Vector3(2196.4921875, 1601.060546875, 1005.0690307617),
        rot = 232,
        name = "Matthew Carry",
        role = "Barman",
        int = 1,
        dim = 0,
        type = "bar",
    },

    -- Floor
    {
        skin = 113,
        pos = Vector3(1141.2978515625, -0.724609375, 1000.6796875),
        rot = 94,
        name = "Matt Hirst",
        role = "Barman",
        int = 12,
        dim = 0,
        type = "bar",
    },
    {
        skin = 113,
        pos = Vector3(1141.296875, -4.958984375, 1000.671875),
        rot = 94,
        name = "Derrick Croft",
        role = "Barman",
        int = 12,
        dim = 0,
        type = "bar",
    },
    {
        skin = 113,
        pos = Vector3(1141.296875, -7.2666015625, 1000.671875),
        rot = 94,
        name = "Rickie Fountain",
        role = "Barman",
        int = 12,
        dim = 0,
        type = "bar",
    },
}

function createNpcs()
    local dialogueBar = exports.TR_npc:createDialogue()
    exports.TR_npc:addDialogueText(dialogueBar, "Dzień dobry.", {pedResponse = "Dzień dobry. W czym mogę służyć?"})
    exports.TR_npc:addDialogueText(dialogueBar, "Chciałbym kupić żetony.", {pedResponse = "Oczywiście. Jaką ilość?", responseTo = "Dzień dobry.", icon = "casino"})
    exports.TR_npc:addDialogueText(dialogueBar, "Chciałbym wymienić żetony.", {pedResponse = "Oczywiście. Jaka kwota interesuje?", responseTo = "Dzień dobry.", icon = "casino"})
    exports.TR_npc:addDialogueText(dialogueBar, "Czy mogę zakupić żetony kartą?", {pedResponse = "Jest to niestety niemożliwe. Żetony można kupić tylko za gotówkę.", responseTo = "Dzień dobry."})

    exports.TR_npc:addDialogueText(dialogueBar, "100 żetonów [$100]", {pedResponse = "", responseTo = "Chciałbym kupić żetony.", img = "casino", trigger = "buyCasinoCoins", triggerData = {100}})
    exports.TR_npc:addDialogueText(dialogueBar, "500 żetonów [$500]", {pedResponse = "", responseTo = "Chciałbym kupić żetony.", img = "casino", trigger = "buyCasinoCoins", triggerData = {500}})
    exports.TR_npc:addDialogueText(dialogueBar, "1000 żetonów [$1000]", {pedResponse = "", responseTo = "Chciałbym kupić żetony.", img = "casino", trigger = "buyCasinoCoins", triggerData = {1000}})
    exports.TR_npc:addDialogueText(dialogueBar, "5000 żetonów [$5000]", {pedResponse = "", responseTo = "Chciałbym kupić żetony.", img = "casino", trigger = "buyCasinoCoins", triggerData = {5000}})
    exports.TR_npc:addDialogueText(dialogueBar, "10000 żetonów [$10000]", {pedResponse = "", responseTo = "Chciałbym kupić żetony.", img = "casino", trigger = "buyCasinoCoins", triggerData = {10000}})
    exports.TR_npc:addDialogueText(dialogueBar, "50000 żetonów [$50000]", {pedResponse = "", responseTo = "Chciałbym kupić żetony.", img = "casino", trigger = "buyCasinoCoins", triggerData = {50000}})
    exports.TR_npc:addDialogueText(dialogueBar, "Jednak podziękuję.", {pedResponse = "Nie ma za co. Jestem zawsze do dyspozycji.", responseTo = "Chciałbym kupić żetony."})

    exports.TR_npc:addDialogueText(dialogueBar, "$100 [100 żetonów]", {pedResponse = "", responseTo = "Chciałbym wymienić żetony.", img = "casino", trigger = "sellCasinoCoins", triggerData = {100}})
    exports.TR_npc:addDialogueText(dialogueBar, "$500 [500 żetonów]", {pedResponse = "", responseTo = "Chciałbym wymienić żetony.", img = "casino", trigger = "sellCasinoCoins", triggerData = {500}})
    exports.TR_npc:addDialogueText(dialogueBar, "$1000 [1000 żetonów]", {pedResponse = "", responseTo = "Chciałbym wymienić żetony.", img = "casino", trigger = "sellCasinoCoins", triggerData = {1000}})
    exports.TR_npc:addDialogueText(dialogueBar, "$5000 [5000 żetonów]", {pedResponse = "", responseTo = "Chciałbym wymienić żetony.", img = "casino", trigger = "sellCasinoCoins", triggerData = {5000}})
    exports.TR_npc:addDialogueText(dialogueBar, "$10000 [10000 żetonów]", {pedResponse = "", responseTo = "Chciałbym wymienić żetony.", img = "casino", trigger = "sellCasinoCoins", triggerData = {10000}})
    exports.TR_npc:addDialogueText(dialogueBar, "$50000 [50000 żetonów]", {pedResponse = "", responseTo = "Chciałbym wymienić żetony.", img = "casino", trigger = "sellCasinoCoins", triggerData = {50000}})
    exports.TR_npc:addDialogueText(dialogueBar, "Jednak je sobie zatrzymam.", {pedResponse = "Nie ma problemu. Jestem zawsze do dyspozycji.", responseTo = "Chciałbym wymienić żetony."})

    exports.TR_npc:addDialogueText(dialogueBar, "Chciałbym zakupić jakiś trunek.", {pedResponse = "Oczywiście. Jaka kwota interesuje?", responseTo = "Dzień dobry.", img = "shop", trigger = "openShopMenu", triggerData = {"casino"}})
    exports.TR_npc:addDialogueText(dialogueBar, "Jednak w niczym. Dziękuję.", {pedResponse = "Nie ma sprawy. Do zobaczenia.", responseTo = "Dzień dobry."})
    exports.TR_npc:addDialogueText(dialogueBar, "Do widzenia.", {pedResponse = "Do widzenia."})

    local dialogueChip = exports.TR_npc:createDialogue()
    exports.TR_npc:addDialogueText(dialogueChip, "Dzień dobry.", {pedResponse = "Dzień dobry. W czym mogę służyć?"})
    exports.TR_npc:addDialogueText(dialogueChip, "Chciałbym kupić żetony.", {pedResponse = "Oczywiście. Jaką ilość?", responseTo = "Dzień dobry.", icon = "casino"})
    exports.TR_npc:addDialogueText(dialogueChip, "Chciałbym wymienić żetony.", {pedResponse = "Oczywiście. Jaka kwota interesuje?", responseTo = "Dzień dobry.", icon = "casino"})
    exports.TR_npc:addDialogueText(dialogueChip, "Czy mogę zakupić żetony kartą?", {pedResponse = "Jest to niestety niemożliwe. Żetony można kupić tylko za gotówkę.", responseTo = "Dzień dobry."})

    exports.TR_npc:addDialogueText(dialogueChip, "100 żetonów [$100]", {pedResponse = "", responseTo = "Chciałbym kupić żetony.", img = "casino", trigger = "buyCasinoCoins", triggerData = {100}})
    exports.TR_npc:addDialogueText(dialogueChip, "500 żetonów [$500]", {pedResponse = "", responseTo = "Chciałbym kupić żetony.", img = "casino", trigger = "buyCasinoCoins", triggerData = {500}})
    exports.TR_npc:addDialogueText(dialogueChip, "1000 żetonów [$1000]", {pedResponse = "", responseTo = "Chciałbym kupić żetony.", img = "casino", trigger = "buyCasinoCoins", triggerData = {1000}})
    exports.TR_npc:addDialogueText(dialogueChip, "5000 żetonów [$5000]", {pedResponse = "", responseTo = "Chciałbym kupić żetony.", img = "casino", trigger = "buyCasinoCoins", triggerData = {5000}})
    exports.TR_npc:addDialogueText(dialogueChip, "10000 żetonów [$10000]", {pedResponse = "", responseTo = "Chciałbym kupić żetony.", img = "casino", trigger = "buyCasinoCoins", triggerData = {10000}})
    exports.TR_npc:addDialogueText(dialogueChip, "50000 żetonów [$50000]", {pedResponse = "", responseTo = "Chciałbym kupić żetony.", img = "casino", trigger = "buyCasinoCoins", triggerData = {50000}})
    exports.TR_npc:addDialogueText(dialogueChip, "Jednak podziękuję.", {pedResponse = "Nie ma za co. Jestem zawsze do dyspozycji.", responseTo = "Chciałbym kupić żetony."})

    exports.TR_npc:addDialogueText(dialogueChip, "$100 [100 żetonów]", {pedResponse = "", responseTo = "Chciałbym wymienić żetony.", img = "casino", trigger = "sellCasinoCoins", triggerData = {100}})
    exports.TR_npc:addDialogueText(dialogueChip, "$500 [500 żetonów]", {pedResponse = "", responseTo = "Chciałbym wymienić żetony.", img = "casino", trigger = "sellCasinoCoins", triggerData = {500}})
    exports.TR_npc:addDialogueText(dialogueChip, "$1000 [1000 żetonów]", {pedResponse = "", responseTo = "Chciałbym wymienić żetony.", img = "casino", trigger = "sellCasinoCoins", triggerData = {1000}})
    exports.TR_npc:addDialogueText(dialogueChip, "$5000 [5000 żetonów]", {pedResponse = "", responseTo = "Chciałbym wymienić żetony.", img = "casino", trigger = "sellCasinoCoins", triggerData = {5000}})
    exports.TR_npc:addDialogueText(dialogueChip, "$10000 [10000 żetonów]", {pedResponse = "", responseTo = "Chciałbym wymienić żetony.", img = "casino", trigger = "sellCasinoCoins", triggerData = {10000}})
    exports.TR_npc:addDialogueText(dialogueChip, "$50000 [50000 żetonów]", {pedResponse = "", responseTo = "Chciałbym wymienić żetony.", img = "casino", trigger = "sellCasinoCoins", triggerData = {50000}})
    exports.TR_npc:addDialogueText(dialogueChip, "Jednak je sobie zatrzymam.", {pedResponse = "Nie ma problemu. Jestem zawsze do dyspozycji.", responseTo = "Chciałbym wymienić żetony."})

    exports.TR_npc:addDialogueText(dialogueChip, "Jednak w niczym. Dziękuję.", {pedResponse = "Nie ma sprawy. Do zobaczenia.", responseTo = "Dzień dobry."})
    exports.TR_npc:addDialogueText(dialogueChip, "Do widzenia.", {pedResponse = "Do widzenia."})

    for i, v in pairs(NPCs) do
        local ped = exports.TR_npc:createNPC(v.skin, v.pos.x, v.pos.y, v.pos.z, v.rot, v.name, v.role, "dialogue")
        setElementInterior(ped, v.int)
        setElementDimension(ped, v.dim)

        if v.type == "chip" then
            exports.TR_npc:setNPCDialogue(ped, dialogueChip)
        elseif v.type == "bar" then
            exports.TR_npc:setNPCDialogue(ped, dialogueBar)
        end
    end
end
createNpcs()

function buyCasinoCoins(npc, data)
    local uid = getElementData(client, "characterUID")
    local amount = data[1]

    if exports.TR_core:takeMoneyFromPlayer(client, amount) then
        exports.TR_mysql:querry("UPDATE tr_accounts SET `casinoChips` = `casinoChips` + ? WHERE UID = ? LIMIT 1", amount, uid)
        exports.TR_noti:create(client, string.format("Pomyślnie zakupiłeś %d żetonów.", amount), "success")

        local casinoCount = exports.TR_mysql:querry("SELECT casinoChips FROM tr_accounts WHERE UID = ? LIMIT 1", uid)
        triggerClientEvent(client, "updateCasinoCount", resourceRoot, casinoCount[1].casinoChips)
    else
        exports.TR_noti:create(client, "Nie posiadasz przy sobie tyle pieniędzy.", "error")
    end
end
addEvent("buyCasinoCoins", true)
addEventHandler("buyCasinoCoins", root, buyCasinoCoins)

function sellCasinoCoins(npc, data)
    local uid = getElementData(client, "characterUID")
    local amount = data[1]

    local casinoCount = exports.TR_mysql:querry("SELECT casinoChips FROM tr_accounts WHERE UID = ? LIMIT 1", uid)
    if tonumber(casinoCount[1].casinoChips) < amount then exports.TR_noti:create(client, "Nie posiadasz tyle żetonów.", "error") return end

    if exports.TR_core:giveMoneyToPlayer(client, amount) then
        exports.TR_mysql:querry("UPDATE tr_accounts SET `casinoChips` = `casinoChips` - ? WHERE UID = ? LIMIT 1", amount, uid)
        exports.TR_noti:create(client, string.format("Pomyślnie wymieniłeś %d żetonów.", amount), "success")

        triggerClientEvent(client, "updateCasinoCount", resourceRoot, casinoCount[1].casinoChips - amount)
    else

    end
end
addEvent("sellCasinoCoins", true)
addEventHandler("sellCasinoCoins", root, sellCasinoCoins)