local time = 5 * 1000 -- czas respu

local positions = {
	{-2082.3251953125, 257.2119140625, 35.838642120361, 357.77249145508},
}

local santaPed = nil
local santaBlip = nil

local startSettings = {
	health = 5,
	points = {}
}

function createSanta()
	local x, y, z, rot = unpack(positions[math.random(1, #positions)])

	santaPed = exports.TR_npc:createNPC(308, x, y, z, rot, "Święty Mikołaj", "Ma przy sobie cenne prezenty")
    setTimer(setPedAnimation, 100, 1, santaPed, "ON_LOOKERS", "wave_loop")
    setElementData(santaPed, "animation", {"ON_LOOKERS", "wave_loop"})
    setElementData(santaPed, "blockAction", true)
    setElementData(santaPed, "santaData", startSettings)

    santaBlip = createBlip(x, y, z)
end

function destroySanta()
	if santaPed and isElement(santaPed) then
		exports.TR_npc:destroyNPC(santaPed)
		santaPed = nil
	end
	if santaBlip and isElement(santaBlip) then
		destroyElement(santaBlip)
		santaBlip = nil
	end

	triggerClientEvent(root, "destroySanta", root)
end

local podium = {
	[1] = 1,
	[2] = 1,
	[3] = 2,
	[4] = 2,
	[5] = 3,
	[6] = 3,
	[7] = 4,
	[8] = 4
}

function ranking(a)
   local values = {}

   local n = 0
   for k,v in pairs(a) do
   	   n = n + 1
       values[#values+1] = {value = v, key = k}
   end
   table.sort(values, function(a, b) return a.value > b.value end)

   local b = 1
   if podium[n] then
   	  b = podium[n]
   else
   	  b = 5
   end

   local top = {}
   for i = 1, b do
   	   i = i - 1

   	   local index = #values - i
   	   local tbl = values[index]
   	   local value = tbl.value
   	   local key = tbl.key
   	   top[key] = value
   end

   return top
end

iprint(ranking({["x"] = 10, ["y"] = 10, ["z"] = 10, ["a"] = 10}))

addEvent("santaWasted", true)
addEventHandler("santaWasted", root,
	function(ped)
		if not santaPed or santaPed and not isElement(santaPed) then return end
		if ped == santaPed then
			killPed(santaPed)

			local data = getElementData(santaPed, "santaData")
			if data and type(data) == "table" then

				-- Mały prezent dla każdego
				for k, v in pairs(data.points) do
					if k and isElement(k) then
						local uid = getElementData(k, "characterUID")
						if uid then
							exports.TR_noti:create(k, "Do twojego ekwipunku trafił Prezent Świąteczny", "gift")
							exports.TR_mysql:querry("INSERT INTO `tr_items`(`owner`, `type`, `variant`, `variant2`, `value`, `used`, `favourite`) VALUES (?,?,?,?,?,NULL,NULL)", uid, 15, 0, 0, 1)
						end
					end
				end

				-- Duży prezent dla topki
				local r = ranking(data.points)
				if r then
					for k, v in pairs(r) do
						if k and isElement(k) then
							local uid = getElementData(k, "characterUID")
							if uid then
								exports.TR_noti:create(k, "Udało Ci się zadać wiele ciosów Mikołajowi, otrzymujesz Duży Prezent Świąteczny.", "gift")
								exports.TR_mysql:querry("INSERT INTO `tr_items`(`owner`, `type`, `variant`, `variant2`, `value`, `used`, `favourite`) VALUES (?,?,?,?,?,NULL,NULL)", uid, 15, 0, 1, 1)
							end
						end
					end
				end

				destroySanta()
				setTimer(createSanta, time, 1)

			end
		end
	end
)

addEventHandler("onResourceStart", resourceRoot,
	function()
		createSanta()
	end
)
