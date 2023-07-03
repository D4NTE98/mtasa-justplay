local sx, sy = guiGetScreenSize()
local zoom = 1920/sx
local data = {
    size = 20,
    state = false,
}

_, data.stats = getPerformanceStats("Lua timing")
function updateStats()
    _, data.stats = getPerformanceStats("Lua timing")
end
setTimer(updateStats, 1000, 0)

function render()
    local count = #data.stats
    local height = count * data.size
    local topY = sy/2 - 60 - height/2


    local i = 0
    for _, v in pairs(data.stats) do
        -- if string.find(v[1], "hud") or string.find(v[1], "radar") then
            dxDrawText(string.format("%s  %s  %s", v[1], v[2], v[3]), sx - 495/2, topY + data.size * i + 2, sx - 300, topY + data.size * (i+1), tocolor(255, 255, 255, 255), 1, "default", "left", "center", false, false, true)
            i = i + 1
        -- end
    end
    dxDrawRectangle(sx - 500/2, topY, 200, i * data.size, tocolor(17, 17, 17, 255))

end

bindKey('B', 'down', function()
    if (data.state) then
        data.state = false
        if getPlayerName(localPlayer) == "NyAngel" or getPlayerName(localPlayer) == "DeMoNeK_" or getPlayerName(localPlayer) == "mAti" then
            removeEventHandler("onClientRender", root, render)
        end
    else
        data.state = true
        if getPlayerName(localPlayer) == "NyAngel" or getPlayerName(localPlayer) == "DeMoNeK_" or getPlayerName(localPlayer) == "mAti" then
            addEventHandler("onClientRender", root, render)
        end
    end
end)