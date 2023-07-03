local settings = {
	loadingResumeTime = 100,
	loadingCount = 100,

	checkResumeTime = 1000,
	checkCount = 2,
	checkTime = 60 * 1000,

	boughtColor = {200, 0, 0},
	freeColor = {0, 200, 0},
}

function loadHomeCoroutine()
	local count = 0
	local totalCount = 0
	local startTime = getTickCount()

	local querry = exports.TR_mysql:querry("SELECT ID, owner, pos FROM `tr_houses`")
	if #querry > 0 then
		for i, v in pairs(querry) do
			local pos = split(v.pos, ",")
			local marker = createMarker(pos[1], pos[2], pos[3] - 0.99, "cylinder", 1.2, settings.boughtColor[1], settings.boughtColor[2], settings.boughtColor[3], 0)
			setElementData(marker, "markerIcon", "house-bought")
			setElementData(marker, "homeData", {
				ID = v.ID,
			}, false)
			setElementID(marker, "homeID"..(v.ID))
			addEventHandler("onMarkerHit", marker, enterMarker)

			if not v.owner then
				setMarkerColor(marker, settings.freeColor[1], settings.freeColor[2], settings.freeColor[3], 0)
				setElementData(marker, "markerIcon", "house-free")
			end

			count = count + 1
			totalCount = totalCount + 1

			if count >= settings.loadingCount then
				count = 0
				setTimer(function()
					coroutine.resume(settings.loadingCoroutine)
				end, settings.loadingResumeTime, 1)
				coroutine.yield()
			end
		end

		print("[TR_houses] Załadowano " .. totalCount .. " domów w czasie " .. getTickCount() - startTime .. "ms.")

		loadOrgnizationsToHouses()
		checkHouseStatus()
		setTimer(checkHouseStatus, settings.checkTime, 1)
	else
		print("[TR_houses] Nie znaleziono żadnego domu.")
	end
end

function loadOrgnizationsToHouses()
	local querry = exports.TR_mysql:querry("SELECT tr_houses.ID, tr_organizations.ID as orgID FROM `tr_houses` LEFT JOIN tr_organizations ON tr_organizations.ID = tr_houses.ownedOrg WHERE ownedOrg IS NOT NULL")
	if querry and querry[1] then
		for i, v in pairs(querry) do
			local marker = getElementByID("homeID"..v.ID)
			setMarkerColor(marker, 255, 255, 255, 0)
			setElementData(marker, "orgID", v.orgID)
		end
	end
end

function loadHomes()
	settings.loadingCoroutine = coroutine.create(loadHomeCoroutine)
	coroutine.resume(settings.loadingCoroutine)
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), loadHomes)


function enterMarker(el, dm)
	if not dm then return end
	if getElementType(el) ~= "player" then return end
	if getPedOccupiedVehicle(el) then return end
	if not getElementData(el, "characterUID") then return end

	local homeData = getElementData(source, "homeData")
	local dataHome = getHomeData(homeData.ID)
	if not dataHome then return end

	local houses, limit = getHousesCount(el)
	triggerClientEvent(el, "openHouseGuiInfo", resourceRoot, dataHome, houses, limit)
end


function playerPayForHome(state, data)
	local days, id = data[1], data[2]

	if state then
		local plrUID = getElementData(source, "characterUID")
		local homeData = getHomeData(id)

		if homeData.owner then
			local querryPayHome = exports.TR_mysql:querry("UPDATE `tr_houses` SET `date`= DATE_ADD(date, INTERVAL ? DAY) WHERE `ID` = ? LIMIT 1", days, id)

			if tonumber(days) >= 10 then
				triggerClientEvent(source, "addAchievements", resourceRoot, "houseRent10")
			end
			if tonumber(days) >= 30 then
				triggerClientEvent(source, "addAchievements", resourceRoot, "houseRent30")
			end

			homeData = getHomeData(id)
			triggerClientEvent(source, "updateHouseGuiInfo", resourceRoot, homeData)
			exports.TR_noti:create(source, "Czynsz za dom został przedłużony.", "success")
			return

		elseif not homeData.owner then
			local querryPayHome = exports.TR_mysql:querry("UPDATE `tr_houses` SET `date`= DATE_ADD(NOW(), INTERVAL ? DAY), `owner`= ? WHERE ID = ? LIMIT 1", days, plrUID, id)

			homeData = getHomeData(id)
			triggerClientEvent(source, "updateHouseGuiInfo", resourceRoot, homeData)
			triggerClientEvent(source, "addAchievements", resourceRoot, "houseRent")

			exports.TR_noti:create(source, "Dom został pomyślnie kupiony. Pamiętaj, aby zapłacić następny czynsz w terminie.", "success")
			local marker = getElementByID("homeID"..id)
			if marker then
				local data = getElementData(marker, "homeData")
				setMarkerColor(marker, settings.boughtColor[1], settings.boughtColor[2], settings.boughtColor[3], 0)
				setElementData(marker, "markerIcon", "house-bought")
			end
		end
	end
	triggerClientEvent(source, "updateHouseGuiInfo", resourceRoot, false)
end
addEvent("playerPayForHome", true)
addEventHandler("playerPayForHome", root, playerPayForHome)


function getHousesCount(plr)
	local plrUID = getElementData(plr, "characterUID")
	local plrData = getElementData(plr, "characterData")

	local houseLimit = exports.TR_mysql:querry("SELECT houseLimit FROM `tr_accounts` WHERE `UID` = ? LIMIT 1", plrUID)

	if plrData.premium == "gold" then
		local houseCount = exports.TR_mysql:querry("SELECT ID FROM `tr_houses` WHERE `owner` = ?", plrUID)
		return #houseCount, houseLimit[1].houseLimit

	elseif plrData.premium == "diamond" then
		local houseCount = exports.TR_mysql:querry("SELECT ID FROM `tr_houses` WHERE `owner` = ?", plrUID)
		return #houseCount, houseLimit[1].houseLimit

	else
		local houseCount = exports.TR_mysql:querry("SELECT ID FROM `tr_houses` WHERE `owner` = ?", plrUID)
		return #houseCount, houseLimit[1].houseLimit
	end

	return 0, houseLimit[1].houseLimit
end


function enterHome(id)
	if not client then return end
	local homeData = getHomeData(id)

	if homeData.owner == getElementData(client, "characterUID") or homeData.orgID == getElementData(client, "characterOrgID") then
		enterHomeLoadInterior(client, id)
		setElementData(client, "canUseHouseStash", id)

	else
		if homeData.locked == 1 then
			local name = getPlayerName(client)
			if type(homeData.rent) == 'table' then rent = homeData.rent else
				rent = homeData.rent and fromJSON(homeData.rent) or {}
			end

			for i, v in ipairs(rent) do
				if v == name then
					enterHomeLoadInterior(client, id)
					setElementData(client, "canUseHouseStash", nil)
					return
				end
			end
			exports.TR_noti:create(client, "Nie możesz wejść do środka, ponieważ drzwi są zamknięte na klucz.", "error")
			triggerClientEvent(client, "updateHouseGuiInfo", resourceRoot)
		else
			enterHomeLoadInterior(client, id)
			setElementData(client, "canUseHouseStash", nil)
		end
	end
end
addEvent("playerEnterHome", true)
addEventHandler("playerEnterHome", resourceRoot, enterHome)

function enterHomeLoadInterior(plr, homeID)
	if not plr or not homeID then exports.TR_noti:create(plr, "[H_1] Wystąpił błąd.", "error") return end
	local homeFurniture = exports.TR_mysql:querry("SELECT tr_accounts.username as ownerName, interiorFloor, interiorWalls, interiorObjects, interiorSize FROM `tr_houses` LEFT JOIN tr_accounts ON tr_houses.owner = tr_accounts.UID WHERE `ID` = ? LIMIT 1", homeID)
	if homeFurniture and #homeFurniture > 0 then
		local gangDrugs = exports.TR_mysql:querry("SELECT objectIndex, plantType, TIMESTAMPDIFF(SECOND, NOW(), growth) as growth, TIMESTAMPDIFF(SECOND, NOW(), fertilizer) as fertilizer FROM tr_gangHouseDrugs WHERE homeID = ?", homeID)

		local marker = getElementByID("homeID"..homeID)
		local x, y, z = getElementPosition(marker)
		local int = getElementInterior(marker)
		local dim = getElementDimension(marker)

		local posInt = string.format("%.2f,%.2f,%.2f,%d,%d", x, y, z + 400, 100, 0 + homeID)
		local posHome = string.format("%.2f,%.2f,%.2f,%d,%d", x, y, z + 0.5, int, dim)

		local ownerName = homeFurniture[1].ownerName or "Do kupienia"

		setElementData(plr, "characterHomeID", homeID, ownerName ~= "Do kupienia" and true or false)
		setElementData(plr, "characterQuit", {x, y, z, 0, 0}, false)

		triggerClientEvent(plr, "closeHouseGuiInfo", resourceRoot, "Wczytywanie posiadłości")

		local attachments = getAttachedElements(plr)
		if attachments then
			for i, v in pairs(attachments) do
				if getElementType(v) == "player" then
					triggerClientEvent(v, "setInteriorLoading", resourceRoot, "Wczytywanie posiadłości", 5)
					triggerClientEvent(v, "setRadarCustomLocation", resourceRoot, "Posiadłość | "..ownerName, true)
					setTimer(function()
						triggerClientEvent(v, "interiorLoadObjects", resourceRoot, homeFurniture[1].interiorSize, homeID, homeFurniture[1].interiorObjects, posInt, posHome, homeFurniture[1].interiorWalls, homeFurniture[1].interiorFloor, gangDrugs)
					end, 1000, 1)
				end
			end
		end

		triggerClientEvent(plr, "setRadarCustomLocation", resourceRoot, "Posiadłość | "..ownerName, true)
		setTimer(function()
			triggerClientEvent(plr, "interiorLoadObjects", resourceRoot, homeFurniture[1].interiorSize, homeID, homeFurniture[1].interiorObjects, posInt, posHome, homeFurniture[1].interiorWalls, homeFurniture[1].interiorFloor, gangDrugs)
		end, 1000, 1)
	else
		exports.TR_noti:create(plr, "[H_2] Wystąpił błąd.", "error")
	end
end

function playerCloseHome(homeID)
	if not homeID then exports.TR_noti:create(client, "[H_3] Wystąpił błąd.", "error") return end
	local homeData = getHomeData(homeID)

	local locked = tonumber(homeData.locked) == 1 and 0 or 1
	exports.TR_mysql:querry("UPDATE `tr_houses` SET locked = ? WHERE `ID` = ?", locked, homeID)
	homeData.locked = locked

	triggerClientEvent(client, "updateHouseGuiInfo", resourceRoot, homeData)
end
addEvent("playerCloseHome", true)
addEventHandler("playerCloseHome", resourceRoot, playerCloseHome)

function bindHouseToOrganization(homeID, bound)
	if not homeID then exports.TR_noti:create(client, "[H_3] Wystąpił błąd.", "error") return end
	local homeData = getHomeData(homeID)

	if not bound then
		local orgID = getElementData(client, "characterOrgID")
		if not orgID then
			triggerClientEvent(client, "updateHouseGuiInfo", resourceRoot)
			exports.TR_noti:create(client, "Nie jesteś właścicielem żadnej organizacji.", "error")
			return
		end

		local hasOrg = exports.TR_mysql:querry("SELECT ID, name FROM `tr_organizations` WHERE `owner` = ? LIMIT 1", getElementData(client, "characterUID"))
		if not hasOrg or not hasOrg[1] then
			triggerClientEvent(client, "updateHouseGuiInfo", resourceRoot)
			exports.TR_noti:create(client, "Nie jesteś właścicielem żadnej organizacji.", "error")
			return
		end

		if tonumber(homeData.owner) == getElementData(client, "characterUID") then
			local bounded = exports.TR_mysql:querry("SELECT ID FROM `tr_houses` WHERE `ownedOrg` = ? LIMIT 1", orgID)
			if bounded and bounded[1] then
				triggerClientEvent(client, "updateHouseGuiInfo", resourceRoot, homeData)
				exports.TR_noti:create(client, "Masz już przypisaną jedną posiadłość do organizacji.", "error")

			else
				exports.TR_mysql:querry("UPDATE `tr_houses` SET ownedOrg = ? WHERE `ID` = ?", orgID, homeID)

				local marker = getElementByID("homeID"..homeID)
				setMarkerColor(marker, 255, 255, 255, 0)
				setElementData(marker, "orgID", orgID)

				homeData.orgID = orgID
				homeData.orgName = hasOrg[1].name
				homeData.orgOwner = getPlayerName(client)

				triggerClientEvent(client, "updateHouseGuiInfo", resourceRoot, homeData)
				exports.TR_noti:create(client, "Posiadłość została pomyślnie przypisana do organizacji.", "success")
			end
		else
			triggerClientEvent(client, "updateHouseGuiInfo", resourceRoot)
			exports.TR_noti:create(client, "Nie jesteś właścicielem tego domu i nie możesz przypisać go do organizacji.", "error")
		end
	else
		local marker = getElementByID("homeID"..homeID)
		setMarkerColor(marker, settings.boughtColor[1], settings.boughtColor[2], settings.boughtColor[3], 0)
		removeElementData(marker, "orgID")

		exports.TR_mysql:querry("UPDATE `tr_houses` SET ownedOrg = NULL WHERE `ID` = ?", homeID)
		homeData.orgID = nil
		homeData.orgName = nil
		homeData.orgOwner = nil

		triggerClientEvent(client, "updateHouseGuiInfo", resourceRoot, homeData)
		exports.TR_noti:create(client, "Posiadłość została pomyślnie odpisana od organizacji.", "success")
	end
end
addEvent("bindHouseToOrganization", true)
addEventHandler("bindHouseToOrganization", resourceRoot, bindHouseToOrganization)

function setHouseEmpty(homeID)
	if not homeID then exports.TR_noti:create(client, "[H_3] Wystąpił błąd.", "error") return end
	local homeData = getHomeData(homeID)

	if homeData.owner == getElementData(client, "characterUID") then
		exports.TR_mysql:querry("UPDATE `tr_houses` SET owner = NULL, ownedOrg = NULL, locked = 0 WHERE `ID` = ? LIMIT 1", homeID)
		triggerClientEvent(client, "addAchievements", resourceRoot, "houseLeave")

		local marker = getElementByID("homeID"..homeID)
		if marker then
			setMarkerColor(marker, settings.freeColor[1], settings.freeColor[2], settings.freeColor[3], 0)
			setElementData(marker, "markerIcon", "house-free")
		end

		triggerClientEvent(client, "updateHouseGuiInfo", resourceRoot, "close")

	else
		triggerClientEvent(client, "updateHouseGuiInfo", resourceRoot)
		exports.TR_noti:create(client, "Nie jesteś właścicielem tego domu i nie możesz go opuścić.", "error")
	end
end
addEvent("setHouseEmpty", true)
addEventHandler("setHouseEmpty", resourceRoot, setHouseEmpty)

function playerEditHome(homeID)
	if not homeID then exports.TR_noti:create(client, "[H_3] Wystąpił błąd.", "error"); triggerClientEvent(client, "closeHouseGuiInfo", resourceRoot) return end
	local homeData = getHomeData(homeID)
	if homeData.owner == getElementData(client, "characterUID") then
		local homeFurnitures = exports.TR_mysql:querry("SELECT interiorFloor, interiorWalls, interiorObjects, interiorSize, pos FROM `tr_houses` WHERE `id` = ? LIMIT 1", homeID)
		if homeFurnitures and #homeFurnitures > 0 then
			local gangDrugs = exports.TR_mysql:querry("SELECT * FROM tr_gangHouseDrugs WHERE homeID = ?", homeID)

			local marker = getElementByID("homeID"..homeID)
			local x, y, z = getElementPosition(marker)
			local int = getElementInterior(marker)
			local dim = getElementDimension(marker)

			setElementData(client, "characterQuit", {x, y, z, 0, 0}, false)
			local posInt = string.format("%.2f,%.2f,%.2f,%d,%d", x, y, z + 400, 100, 0 + homeID)
			local posHome = string.format("%.2f,%.2f,%.2f,%d,%d", x, y, z + 0.5, int, dim)

			triggerClientEvent(client, "interiorsBuilderOpen", resourceRoot, homeFurnitures[1].interiorSize, homeID, homeFurnitures[1].interiorObjects, posInt, homeFurnitures[1].interiorWalls, homeFurnitures[1].interiorFloor, posHome, gangDrugs)
			triggerClientEvent(client, "closeHouseGuiInfo", resourceRoot, "Wczytywanie edytora")
		end
	else
		triggerClientEvent(client, "closeHouseGuiInfo", resourceRoot)
		exports.TR_noti:create(client, "Nie jesteś właścicielem tego domu.", "error")
	end
end
addEvent("playerEditHome", true)
addEventHandler("playerEditHome", resourceRoot, playerEditHome)

function playerAddPlayerToRentHome(homeID, targetID)
	if not client then return end

	local homeData = getHomeData(homeID)
	if homeData.owner ~= getElementData(client, "characterUID") then return end

	local target = getElementByID("ID"..targetID)
	if target then
		local rentedPeople = exports.TR_mysql:querry("SELECT ID, plrUID FROM tr_housesRent WHERE houseID = ? LIMIT 6", homeID)
		if #rentedPeople >= 6 then
			exports.TR_noti:create(client, "Nie możesz dodać więcej współlokatorów.", "error")
			triggerClientEvent(client, "updateHouseGuiInfo", resourceRoot)
			return
		end

		local isAlreadyRented = exports.TR_mysql:querry("SELECT ID FROM tr_housesRent WHERE houseID = ? AND plrUID = ? LIMIT 1", homeID, targetID)
		if isAlreadyRented and isAlreadyRented[1] then
			exports.TR_noti:create(client, "Ta osoba jest już dodana jako współlokator.", "error")
			triggerClientEvent(client, "updateHouseGuiInfo", resourceRoot)
			return
		end

		local targetName = getPlayerName(target)
		exports.TR_mysql:querry("INSERT INTO `tr_housesRent`(`plrUID`, `houseID`) VALUES (?, ?)", targetID, homeID)
		exports.TR_noti:create(client, "Pomyślnie dodano "..targetName.." do listy współlokatorów.", "success")
		triggerClientEvent(client, "updateHouseGuiInfo", resourceRoot, homeData)
	else
		exports.TR_noti:create(client, "Nie odnaleziono takiego gracza.", "error")
		triggerClientEvent(client, "updateHouseGuiInfo", resourceRoot)
	end
end
addEvent("playerAddPlayerToRentHome", true)
addEventHandler("playerAddPlayerToRentHome", resourceRoot, playerAddPlayerToRentHome)

function playerRemovePlayerFromRentHome(homeID, targetID)
	if not client then return end
	local homeData = getHomeData(homeID)
	if homeData.owner ~= getElementData(client, "characterUID") then return end

	exports.TR_mysql:querry("DELETE FROM `tr_housesRent` WHERE plrUID = ? AND houseID = ? LIMIT 1", targetID, homeID)

	triggerClientEvent(client, "updateHouseGuiInfo", resourceRoot, homeData)
	exports.TR_noti:create(client, "Współlokator został pomyślnie usunięty.", "success")
end
addEvent("playerRemovePlayerFromRentHome", true)
addEventHandler("playerRemovePlayerFromRentHome", resourceRoot, playerRemovePlayerFromRentHome)

function removeHouseVisitors(houseID)
	for i, v in pairs(getElementsByType("player")) do
		if v ~= client then
			local homeID = getElementData(v, "characterHomeID")
			if homeID and homeID == houseID then
				triggerClientEvent(v, "removePlayerFromBuildedInterior", resourceRoot, true)
			end
		end
	end
	exports.TR_noti:create(client, "Wszyscy odwiedzający twoją posiadłość zostali wyproszeni.", "success")
	triggerClientEvent(client, "updateHouseGuiInfo", resourceRoot)
end
addEvent("removeHouseVisitors", true)
addEventHandler("removeHouseVisitors", resourceRoot, removeHouseVisitors)


-- Check house status
function checkHouseStatus()
	settings.checkCoroutine = coroutine.create(checkCoroutine)
	coroutine.resume(settings.checkCoroutine)
end

function checkCoroutine()
	local count = 0
	local querry = exports.TR_mysql:querry("SELECT ID FROM `tr_houses` WHERE owner IS NOT NULL AND date < NOW()")
	if #querry > 0 then
		for i, v in pairs(querry) do
			local marker = getElementByID("homeID"..v.ID)
			if marker then
				setMarkerColor(marker, settings.freeColor[1], settings.freeColor[2], settings.freeColor[3], 0)
				setElementData(marker, "markerIcon", "house-free")
				removeElementData(marker, "orgID")
			end

			count = count + 1
			if count >= settings.checkCount then
				setTimer(function()
					coroutine.resume(settings.checkCoroutine)
					count = 0
				end, settings.checkResumeTime, 1)
				coroutine.yield()
			end
		end
	end
	exports.TR_mysql:querry("UPDATE `tr_houses` SET owner = NULL, ownedOrg = NULL, locked = 0 WHERE `date` < NOW()")
	setTimer(checkHouseStatus, settings.checkTime, 1)
end



-- Utils
function getHomeData(id)
	local info = exports.TR_mysql:querry("SELECT *, tr_accounts.username as ownerName FROM `tr_houses` LEFT JOIN tr_accounts ON tr_houses.owner = tr_accounts.UID WHERE ID = ? LIMIT 1", id)
	if #info < 1 then return false end

	local rentPlayers = exports.TR_mysql:querry("SELECT ID, tr_accounts.username as username FROM `tr_housesRent` LEFT JOIN tr_accounts ON tr_housesRent.plrUID = tr_accounts.UID WHERE houseID = ? LIMIT 6", id)
	local data = {
		ID = id,
		owner = tonumber(info[1].owner),
		ownerName = info[1].ownerName,
		price = info[1].price,
		date = info[1].date,
		interiorSize = info[1].interiorSize,
		locked = tonumber(info[1].locked),
		rent = rentPlayers,
		premium = info[1].premium,
		orgID = tonumber(info[1].ownedOrg),
	}

	if info[1].ownedOrg then
		local orgData = exports.TR_mysql:querry("SELECT name, owner FROM `tr_organizations` WHERE ID = ? LIMIT 1", info[1].ownedOrg)
		if orgData and orgData[1] then
			data.orgName = orgData[1].name
			data.orgOwner = orgData[1].owner
		end
	end
	return data
end