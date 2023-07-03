local NPCs = {
    -- LS
    {
        skin = 76,
        pos = Vector3(1422.3033447266, -2552.0017089844, 70.645309448242),
        int = 0,
        dim = 2,
        rot = 88,
        name = "Emily Tracko",
        role = "Pracownica banku",
    },
    {
        skin = 141,
        pos = Vector3(1422.2052001953, -2556.8645019531, 70.645309448242),
        int = 0,
        dim = 2,
        rot = 88,
        name = "Ana Harten",
        role = "Pracownica banku",
    },
    {
        skin = 150,
        pos = Vector3(1422.1984863281, -2561.9626464844, 70.645309448242),
        int = 0,
        dim = 2,
        rot = 88,
        name = "Lillia Trah",
        role = "Pracownica banku",
    },
    {
        skin = 17,
        pos = Vector3(1422.1047363281, -2567.0715332031, 70.645309448242),
        int = 0,
        dim = 2,
        rot = 88,
        name = "Walter Gart",
        role = "Pracownik banku",
    },

    -- SF
    {
        skin = 148,
        pos = Vector3(1422.3033447266, -2552.0017089844, 70.645309448242),
        int = 0,
        dim = 3,
        rot = 88,
        name = "Janna Gert",
        role = "Pracownica banku",
    },
    {
        skin = 216,
        pos = Vector3(1422.2052001953, -2556.8645019531, 70.645309448242),
        int = 0,
        dim = 3,
        rot = 88,
        name = "Ana Klain",
        role = "Pracownica banku",
    },
    {
        skin = 187,
        pos = Vector3(1422.1984863281, -2561.9626464844, 70.645309448242),
        int = 0,
        dim = 3,
        rot = 88,
        name = "Joseph Lart",
        role = "Pracownik banku",
    },
    {
        skin = 46,
        pos = Vector3(1422.1047363281, -2567.0715332031, 70.645309448242),
        int = 0,
        dim = 3,
        rot = 88,
        name = "Henry Ters",
        role = "Pracownik banku",
    },

    -- FC
    {
        skin = 46,
        pos = Vector3(2031.9924316406, -1987.9986572266, 90.800003051758),
        int = 0,
        dim = 3,
        rot = 270,
        name = "Thomas Ters",
        role = "Pracownik banku",
    },
    {
        skin = 216,
        pos = Vector3(2031.8850097656, -1984.7047119141, 90.800003051758),
        int = 0,
        dim = 3,
        rot = 270,
        name = "Kayle Jenson",
        role = "Pracownica banku",
    },
}

function createBankNPC()
    local dialogue = exports.TR_npc:createDialogue()
    exports.TR_npc:addDialogueText(dialogue, "Chciałbym założyć konto w banku.", {pedResponse = "Zobaczymy co da się zrobić.", img = "bank", trigger = "createBankAccount"})
    exports.TR_npc:addDialogueText(dialogue, "Do widzenia.", {pedResponse = "Do widzenia."})

    for i, v in pairs(NPCs) do
        local ped = exports.TR_npc:createNPC(v.skin, v.pos.x, v.pos.y, v.pos.z, v.rot, v.name, v.role, "dialogue")
        setElementInterior(ped, v.int)
        setElementDimension(ped, v.dim)

        exports.TR_npc:setNPCDialogue(ped, dialogue)
    end
end
createBankNPC()


function createBankAccount()
    local uid = getElementData(client, "characterUID")
    if not uid then return end

    local plrData = getElementData(client, "characterData")
    if plrData.bankcode then
        exports.TR_noti:create(client, "Posiadasz już konto w banku i nie możesz założyć kolejnego.", "error")
        return
    end

    triggerClientEvent(client, "createBankAccount", resourceRoot)
end
addEvent("createBankAccount", true)
addEventHandler("createBankAccount", root, createBankAccount)