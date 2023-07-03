-- autor: kkuba
-- dla Just Play 
-- 2021


local wykroczenia = {
    [15] = true, -- nie podpisane sterowniki(zazwyczaj uzywane do modyfikowania wejscia od klawiatury)
    [31] = true, -- Zmodyfikowane wejscie od klawiatury
    [32] = true -- Zmodyfikowane wejscie od myszki
}


local function banujBociarzy(tableAC)
    local plr = source
    local id = getElementData(plr, "ID")
   	if not id then return end
    if getPlayerName(plr) == "NyAngel" or getPlayerName(plr) == "kESji8" then return end

    for i,sd in ipairs(tableAC) do 
        if wykroczenia[sd] then
            --exports.TR_admin:warn(getElementData(plr, 'ID'), "Ho ho ho, troche się zapedziłeś, mikołaj apeluje o zaprzestanie użytkowania botów! ;) Następnym razem będziemy musieli się pożegnać.")
            local time = getRealTime()
            local tf = string.format("[%02d:%02d %02d.%02d]", time.hour, time.minute, time.monthday, time.month)
            exports.TR_discord:remoteDsc(tf.." | "..string.format("[SD %s] **%s** posiada prawdopodobnie bota na rybaka.", sd, getPlayerName(plr)), "ac")

            --exports.TR_admin:warnExport(getElementData(plr, 'ID'), "AntyCheat")


            --triggerClientEvent(root, "showCustomMessage", resourceRoot, "AntyCheat", ""..getPlayerName(plr).." nie ładnie korzystać z bota na rybaka.", "files/images/npc.png")
        end
    end
end
addEventHandler("onPlayerACInfo", root, banujBociarzy)

function resend()
	for _,plr in pairs( getElementsByType("player") ) do
        resendPlayerACInfo( plr )
    end
end

-- Ensure no one gets missed when the resource is (re)started
addEventHandler( "onResourceStart", resourceRoot,
    function()
    	resend()
    	setTimer(resend, 60000 * 5, 0)
    end
)

addCommandHandler("smigloxd",function(plr,cmd)
local veh = getPedOccupiedVehicle(plr)
if not veh then return end

setTimer(function()
    local rx,ry,rz = getElementRotation(veh)
setElementRotation(veh,rx-30,ry+50,rz+125)

end,1,0)
end)