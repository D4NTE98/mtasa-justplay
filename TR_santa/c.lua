local maxHP = 5
local sx, sy = guiGetScreenSize()

local fonts = {
	title = exports.TR_dx:getFont(14),
	text = exports.TR_dx:getFont(13)
}

local tick = getTickCount()

local currentPed = nil

function render()
	for i, ped in ipairs(getElementsByType("ped")) do
		local data = getElementData(ped, "santaData")
		if data then
            if not currentPed or currentPed and not isElement(currentPed) then
            	iprint("DODAJ")
                addEventHandler("onClientPedDamage", ped, onDamage)
                addEventHandler("onClientPedWasted", ped, onWasted)
                currentPed = ped
            end
			local plrPos = Vector3(getElementPosition(localPlayer))

	    	local pos = Vector3(getPedBonePosition(ped, 1))
            local dist = getDistanceBetweenPoints3D(plrPos, pos)

            if dist > 10 then return end

            local alpha = 1/dist * 1

        	local cx, cy = getScreenFromWorldPosition(pos)
        	if cx and cy then
            	dxDrawRoundedRectangle(cx - 115, cy - 25, 230, 50, tocolor(23,25,31, 255 * alpha), 5)
            	dxDrawRoundedRectangle(cx - 110, cy - 20, 220, 40, tocolor(34,36,43, 255 * alpha), 5)
            	dxDrawRoundedRectangle(cx - 110, cy - 20, (220 * data.health/maxHP), 40, tocolor(44,183,236, 255 * alpha), 5)
            	dxDrawText(math.floor( maxHP - (maxHP-data.health) ).."/"..maxHP, cx - 115, cy - 25, cx - 115+230, cy - 25+50, tocolor(255, 255, 255, 255 * alpha), 1, fonts.text, "center", "center", false, false, false, true)
        	end
        end
	end
end

function onDamage(attacker, weapon, bodypart, loss)
    if weapon ~= 0 then return end
    if getTickCount() < tick then return end

    tick = getTickCount() + 2000

    local data = getElementData(source, "santaData")
    if not data then return end
    if data and type(data) == "table" then
        iprint(data.health)
        data.health = data.health - 1

        if not data.points[attacker] then
            data.points[attacker] = 0
        end
        data.points[attacker] = data.points[attacker] + 1

    end

    setElementData(source, "santaData", data)

    if data.health <= 0 then
        triggerServerEvent("santaWasted", root, source)
    end
end

function onWasted()
    cancelEvent()
end

addEvent("destroySanta", true)
addEventHandler("destroySanta", localPlayer,
	function()
		if not currentPed or currentPed and not isElement(currentPed) then return end
		removeEventHandler("onClientPedDamage", currentPed, onDamage)
        removeEventHandler("onClientPedWasted", currentPed, onWasted)

        currentPed = nil
	end
)

addEventHandler("onClientResourceStart", resourceRoot,
	function()
		addEventHandler("onClientRender", root, render)
        addEventHandler("onClientPlayerStealthKill", localPlayer, 
            function(target)
                if target and currentPed and target == currentPed then
                    cancelEvent()
                end
            end
        )
	end
)

function dxDrawRoundedRectangle(x, y, rx, ry, color, radius, post)
    rx = rx - radius * 2
    ry = ry - radius * 2
    x = x + radius
    y = y + radius

    if (rx >= 0) and (ry >= 0) then
        dxDrawRectangle(x, y, rx, ry, color, post)
        dxDrawRectangle(x, y - radius, rx, radius, color, post)
        dxDrawRectangle(x, y + ry, rx, radius, color, post)
        dxDrawRectangle(x - radius, y, radius, ry, color, post)
        dxDrawRectangle(x + rx, y, radius, ry, color, post)

        dxDrawCircle(x, y, radius, 180, 270, color, color, 7, 1, post)
        dxDrawCircle(x + rx, y, radius, 270, 360, color, color, 7, 1, post)
        dxDrawCircle(x + rx, y + ry, radius, 0, 90, color, color, 7, 1, post)
        dxDrawCircle(x, y + ry, radius, 90, 180, color, color, 7, 1, post)
    end
end