local NPCs = {
    {
        skin = 217,
        pos = Vector3(1532.9587158203, -2229.1955175781, 92.678314208984),
        int = 0,
        dim = 15,
        rot = 96,
        name = "Mark Grone",
        animation = {"ped", "SEAT_idle"},
    },
}

function createRadioNPC()
    local dialogue = exports.TR_npc:createDialogue()
    exports.TR_npc:addDialogueText(dialogue, "Dzień dobry. Mam kilka pytań.", {pedResponse = "Proszę mówić. Odpowiem na wszelkie pytania, na które będę znać odpowiedź."})
    exports.TR_npc:addDialogueText(dialogue, "Skąd siedziba radia w budynku telewizji?", {pedResponse = "Otóż firma Interglobal Television dzięki swoim programom stała się tak bardzo popularna, że postanowiliśmy także stworzyć własne radio. Skoro ludzie chcą nas oglądać to czemu mieliby nie móc nas słuchać podczas drogi np. do pracy?", responseTo = "Dzień dobry. Mam kilka pytań."})
    exports.TR_npc:addDialogueText(dialogue, "Ile kosztuje ogłoszenie?", {pedResponse = "Ze względu na to, że nasza telewizja chce, aby ludzie byli na bieżąco ze wszystkimi aktualnościami, ogłoszenia w naszym radiu są całkowicie darmowe.", responseTo = "Dzień dobry. Mam kilka pytań."})
    exports.TR_npc:addDialogueText(dialogue, "Jak mogę coś ogłosić?", {pedResponse = "To nic trudnego! Proszę wejść do tego pokoju, stanąć przy mikrofonie i coś powiedzieć. Ja zarejestruję całą wypowiedź i w odpowiednim momencie odtworzę.", responseTo = "Dzień dobry. Mam kilka pytań."})
    exports.TR_npc:addDialogueText(dialogue, "Chciałbym nagrać własną płytę.", {pedResponse = "Tworzenie muzyki to nic trudnego, lecz stworzenie hitu, który się przyjmie, jest już bardzo trudne. Wpadnij kiedyś jak będę mieć mniej na głowie to sprawdzę twoje umiejętności i pomyślimy.", responseTo = "Dzień dobry. Mam kilka pytań."})
    exports.TR_npc:addDialogueText(dialogue, "Jest coś, o czym nie mogę mówić?", {pedResponse = "Generalnie możesz ogłosić wszystko co chcesz, ale nie możesz poruszać tematów takich jak narkotyki czy broń.", responseTo = "Dzień dobry. Mam kilka pytań."})
    exports.TR_npc:addDialogueText(dialogue, "Do widzenia.", {pedResponse = "Do widzenia."})

    for i, v in pairs(NPCs) do
        local ped = exports.TR_npc:createNPC(v.skin, v.pos.x, v.pos.y, v.pos.z, v.rot, v.name, "Pracownik radiostacji", "dialogue")
        setElementInterior(ped, v.int)
        setElementDimension(ped, v.dim)
        if v.animation then setElementData(ped, "animation", v.animation) end

        exports.TR_npc:setNPCDialogue(ped, dialogue)
    end
end
createRadioNPC()