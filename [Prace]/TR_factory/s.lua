--[[
    @project: TR_factory
    @for: InsideMTA / Just Play
    @author: DeMoNeK_ (ძ૯ɱ૦Ո૯қ_#5350)
]]

local NPCs = {
    {
        pos = Vector3(2399.6875, 1509.6015625, 10.8199996948),
        rot = 225,
        name = "Brek",
    },
};

addEvent('TR_factory -> startJob');

function createNpcs()
    local dialogue = exports.TR_npc:createDialogue();
    exports.TR_npc:addDialogueText(dialogue, "Znajdzie się jakaś praca dla mnie?", {pedResponse = "Pewnie, mam tu taką fabrykę jaboli, chodź do środka."});
    exports.TR_npc:addDialogueText(dialogue, "Wrócę później.", {pedResponse = "Do zobaczenia."});

    for i, v in pairs(NPCs) do
        local ped = exports.TR_npc:createNPC(230, v.pos.x, v.pos.y, v.pos.z, v.rot, v.name, "Zarządca fabryki jaboli", "dialogue");

        exports.TR_npc:setNPCDialogue(ped, dialogue);
    end;
end;
createNpcs();

addEventHandler('TR_factory -> startJob', resourceRoot, 
    function()
        
    end
);