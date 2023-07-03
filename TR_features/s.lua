local NPCs = {
    {
        skin = 9,
        pos = Vector3(-2428.1064453125, 829.07946777344, 66.400001525879),
        int = 0,
        dim = 4,
        rot = 182,
        name = "Liyana Dyer",
    },
}

function speakToTherapist(ped, data)
    triggerClientEvent(client, "onTherapistSelect", resourceRoot, data)
end
addEvent("speakToTherapist", true)
addEventHandler("speakToTherapist", root, speakToTherapist)

function onTherapistPay(state, data)
    triggerClientEvent(source, "therapistResponse", resourceRoot, data, state)
end
addEvent("onTherapistPay", true)
addEventHandler("onTherapistPay", root, onTherapistPay)

function createTherapists()
    local dialogue = exports.TR_npc:createDialogue()
    exports.TR_npc:addDialogueText(dialogue, "Witam. Chciałbym odbyć leczenie.", {pedResponse = "Witam. Leczenie nie jest tanie, lecz na pewno pomoże. Akurat mam wolny termin teraz. Co dolega?"})

    exports.TR_npc:addDialogueText(dialogue, "Chce się wyleczyć z hazardu.", {pedResponse = "Zobaczymy co da się zrobić.", responseTo = "Witam. Chciałbym odbyć leczenie.", img = "quest", trigger = "speakToTherapist", triggerData = "casino"})
    exports.TR_npc:addDialogueText(dialogue, "Chce się wyleczyć z alkoholizmu", {pedResponse = "Zobaczymy co da się zrobić.", responseTo = "Witam. Chciałbym odbyć leczenie.", img = "quest", trigger = "speakToTherapist", triggerData = "cheers"})
    exports.TR_npc:addDialogueText(dialogue, "Chce się wyleczyć z nikotynizmu", {pedResponse = "Zobaczymy co da się zrobić.", responseTo = "Witam. Chciałbym odbyć leczenie.", img = "quest", trigger = "speakToTherapist", triggerData = "smoking"})
    exports.TR_npc:addDialogueText(dialogue, "Chce się wyleczyć z narkomanii", {pedResponse = "Zobaczymy co da się zrobić.", responseTo = "Witam. Chciałbym odbyć leczenie.", img = "quest", trigger = "speakToTherapist", triggerData = "pills"})

    exports.TR_npc:addDialogueText(dialogue, "Jak drogie to podziękuje.", {pedResponse = "Nie ma sprawy. Proszę tylko pamiętać, że później może nie być dogodnych terminów.", responseTo = "Witam. Chciałbym odbyć leczenie."})
    exports.TR_npc:addDialogueText(dialogue, "Do widzenia.", {pedResponse = "Do widzenia."})

    for i, v in pairs(NPCs) do
        local ped = exports.TR_npc:createNPC(v.skin, v.pos.x, v.pos.y, v.pos.z, v.rot, v.name, "Psycholog", "dialogue")
        setElementInterior(ped, v.int)
        setElementDimension(ped, v.dim)

        exports.TR_npc:setNPCDialogue(ped, dialogue)
    end
end
createTherapists()


-- Features
function updateFeatures(lungs, weapon)
    setPedStat(client, 22, lungs * 10)
    setPedStat(client, 225, lungs * 10)

    weapon= 90
    if weapon >= 90 then
        setPedStat(client, 70, 1000)
        setPedStat(client, 71, 1000)
        setPedStat(client, 76, 1000)
        setPedStat(client, 77, 1000)
        setPedStat(client, 78, 1000)
    end
end
addEvent("updateFeatures", true)
addEventHandler("updateFeatures", resourceRoot, updateFeatures)