local NPCs = {
    {
        skin = 155,
        pos = Vector3(373.33349609375, -117.27826690674, 1001.499511718),
        int = 5,
        dim = 1,
        rot = 181,
        name = "Thomas Borns",
    },
    {
        skin = 155,
        pos = Vector3(373.33349609375, -117.27826690674, 1001.499511718),
        int = 5,
        dim = 2,
        rot = 181,
        name = "Michael Wans",
    },
    {
        skin = 155,
        pos = Vector3(373.33349609375, -117.27826690674, 1001.499511718),
        int = 5,
        dim = 3,
        rot = 181,
        name = "David Banks",
    },
    {
        skin = 155,
        pos = Vector3(373.33349609375, -117.27826690674, 1001.499511718),
        int = 5,
        dim = 4,
        rot = 181,
        name = "Phillip Markes",
    },
    {
        skin = 155,
        pos = Vector3(373.33349609375, -117.27826690674, 1001.499511718),
        int = 5,
        dim = 5,
        rot = 181,
        name = "Elvis Monks",
    },
    {
        skin = 155,
        pos = Vector3(373.33349609375, -117.27826690674, 1001.499511718),
        int = 5,
        dim = 6,
        rot = 181,
        name = "Ryan Blank",
    },
    {
        skin = 155,
        pos = Vector3(373.33349609375, -117.27826690674, 1001.499511718),
        int = 5,
        dim = 7,
        rot = 181,
        name = "Jack Morris",
    },
    {
        skin = 155,
        pos = Vector3(373.33349609375, -117.27826690674, 1001.499511718),
        int = 5,
        dim = 8,
        rot = 181,
        name = "Henry Dabbers",
    },
    {
        skin = 155,
        pos = Vector3(373.33349609375, -117.27826690674, 1001.499511718),
        int = 5,
        dim = 9,
        rot = 181,
        name = "Logan Grant",
    },
    {
        skin = 155,
        pos = Vector3(373.33349609375, -117.27826690674, 1001.499511718),
        int = 5,
        dim = 10,
        rot = 181,
        name = "Nicolas Davern",
    },
}

function createPizzaNPC()
    local dialogue = exports.TR_npc:createDialogue()
    exports.TR_npc:addDialogueText(dialogue, "Dzień dobry. Poproszę...", {pedResponse = "", img = "shop", trigger = "openShopMenu", triggerData = {"pizza"}})
    exports.TR_npc:addDialogueText(dialogue, "Do widzenia.", {pedResponse = "Do widzenia."})

    for i, v in pairs(NPCs) do
        local ped = exports.TR_npc:createNPC(v.skin, v.pos.x, v.pos.y, v.pos.z, v.rot, v.name, "Pracownik Pizzeri", "dialogue")
        setElementInterior(ped, v.int)
        setElementDimension(ped, v.dim)

        exports.TR_npc:setNPCDialogue(ped, dialogue)
    end
end
createPizzaNPC()