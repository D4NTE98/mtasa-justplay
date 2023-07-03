local sx, sy = guiGetScreenSize()
local zoom = 1
local baseX = 1900
local minZoom = 2
if sx < baseX then
  zoom = math.min(minZoom, baseX/sx)
end

local guiInfo = {
    capcity = {
        x = sx - 300/zoom + (300/zoom - 128/zoom)/2,
        y = sy/2 - 45/zoom,
        w = 128/zoom,
        h = 128/zoom,
    },

    loadingPoints = {
        {
            pos = Vector3(-2727.298828125, 74.7177734375, 4.3359375),
            rot = 0,
        },
        {
            pos = Vector3(-1843.5263671875, 114.69, 15.1171875),
            rot = 0,
        },
        {
            pos = Vector3(-1852.2626953125, 114.69, 15.1171875),
            rot = 0,
        },
        {
            pos = Vector3(-1860.9345703125, 114.69, 15.1171875),
            rot = 0,
        },
    },

    vehicleSpawns = {
        Vector3(-2727.298828125, 74.7177734375, 4.3359375),
        Vector3(-2730.298828125, 74.7177734375, 4.3359375),
        Vector3(-2733.298828125, 74.7177734375, 4.3359375),
    },

    models = {2840, 2856, 2821, 2861, 2866, 2858, 2867, 926, 928},
    trashCapacity = {
        [2840] = 0.5,
        [2856] = 0.8,
        [2821] = 0.9,
        [2861] = 0.4,
        [2866] = 1.2,
        [2858] = 1.0,
        [2867] = 0.9,
        [926] = 1.4,
        [928] = 2.3,
    },
    objectOffsets = {
        [2840] = 0.05,
        [2856] = 0.05,
        [2821] = 0.05,
        [2861] = 0.05,
        [2866] = 0.05,
        [2858] = 0.05,
        [2867] = 0.05,
        [926] = 0.1,
        [928] = 0.1,
    },
}

Sweepers = {}
Sweepers.__index = Sweepers

function Sweepers:create(...)
    local instance = {}
    setmetatable(instance, Sweepers)
    if instance:constructor(...) then
        return instance
    end
    return false
end

function Sweepers:constructor(...)
    self.ownedUpgrades = arg[1]

    self.trashPicked = 0
    self.objects = {}
    self.markers = {}
    self.blips = {}
    self.capacity = 0
    self.totalCapacity = self.ownedUpgrades[1] and 200 or 100
    self.inVehicle = false
    self.sweeperImg = dxCreateTexture("files/images/sweeper.png", "argb", true, "clamp")

    self.marker = createMarker(-2737.90625, 75.298828125, 3.4758253097534, "cylinder", 2, 136, 125, 90, 0)
    setElementData(self.marker, "markerData", {
        title = "Punkt rozładunku śmieci",
        desc = "Wejdź w marker aby rozładować zebrane śmieci.",
    }, false)
    setElementData(self.marker, "markerIcon", "sanddune", false)

    self.emptyBlip = createBlip(-2737.90625, 75.298828125, 3.4758253097534, 0, 1, 255, 60, 60, 255)
    setElementData(self.emptyBlip, "icon", 22, false)

    self.fonts = {}
    self.fonts.percent = exports.TR_dx:getFont(12)

    self.func = {}
    self.func.render = function() self:render() end
    self.func.pickupTrash = function(...) self:pickupTrash(source, ...) end
    self.func.onMarkerEmpty = function(...) self:onMarkerEmpty(source, ...) end

    if self:createJobVehicle() then return end

    exports.TR_noti:create("Rozpocząłeś pracę jako czyściciel ulic.", "job")
    exports.TR_jobs:createInformation(jobSettings.name, "Wsiądź do swojego sweepera i zacznij zbierać śmieci.")
    exports.TR_jobs:setPlayerTargetPos(-2737.90625, 75.298828125, 3.4758253097534, 0, 0, "Miejsce rozładunku")
    exports.TR_jobs:closeJobWindow()
    exports.TR_weather:setCustomWeather(false)
    exports.TR_hud:setRadarCustomLocation(false)

    addEventHandler("onClientRender", root, self.func.render)
    addEventHandler("onClientMarkerHit", self.marker, self.func.onMarkerEmpty)
    return true
end

function Sweepers:destroy()
    self:destroyPoints()

    if isElement(self.sweeperImg) then destroyElement(self.sweeperImg) end
    if isElement(self.marker) then destroyElement(self.marker) end
    if isElement(self.emptyBlip) then destroyElement(self.emptyBlip) end

    setElementPosition(localPlayer, -2726.994140625, 77.275390625, 4.335)
    setElementInterior(localPlayer, 0)
    setElementDimension(localPlayer, 0)

    exports.TR_jobs:resetPaymentTime()
    exports.TR_jobs:setPlayerJob(false)
    exports.TR_jobs:removeInformation()
    exports.TR_jobs:setPlayerTargetPos(false)
    exports.TR_noti:create("Pomyślnie zakończyłeś swoją pracę.", "job")

    triggerServerEvent("removePlayerFromJobVehicle", resourceRoot, -2726.994140625, 77.275390625, 4.335, 0, 0)
    removeEventHandler("onClientRender", root, self.func.render)
    triggerServerEvent("removeAttachedObject", resourceRoot, 574)

    jobSettings.work = nil
    self = nil
end

function Sweepers:render()
    self.vehicle = getPedOccupiedVehicle(localPlayer)
    if not self.vehicle then
        self.lastPos = Vector3(getElementPosition(localPlayer))

        if self.inVehicle then
            exports.TR_jobs:createInformation(jobSettings.name, "Wsiądź do swojego sweepera i zacznij zbierać śmieci.")
            self.inVehicle = nil
        end
        return
    end
    if getElementModel(self.vehicle) ~= 574 then
        self.lastPos = Vector3(getElementPosition(localPlayer))

        if self.inVehicle then
            exports.TR_jobs:createInformation(jobSettings.name, "Wsiądź do swojego sweepera i zacznij zbierać śmieci.")
            self.inVehicle = nil
        end
        return
    end

    if not self.inVehicle then
        exports.TR_jobs:createInformation(jobSettings.name, "Jeździj sweeperem po mieście i zbieraj śmieci. \nPoziom zapełnienia:", 170/zoom)
        self.inVehicle = true
    end

    if self.inVehicle then
        local percent = self.capacity/self.totalCapacity
        dxDrawImage(guiInfo.capcity.x, guiInfo.capcity.y, guiInfo.capcity.w, guiInfo.capcity.h, self.sweeperImg, 0, 0, 0, tocolor(42,45,51, 255))
        dxDrawImageSection(guiInfo.capcity.x, guiInfo.capcity.y + guiInfo.capcity.h - guiInfo.capcity.h * percent, guiInfo.capcity.w, guiInfo.capcity.h * percent, 0, 128 - 128 * percent, 128, 128 * percent, self.sweeperImg, 0, 0, 0, tocolor(44,181,233, 255))
        dxDrawText(string.format("Zapełnienie: %.1f/%dkg", self.capacity, self.totalCapacity), guiInfo.capcity.x, guiInfo.capcity.y + guiInfo.capcity.h + 5/zoom, guiInfo.capcity.x + guiInfo.capcity.w, guiInfo.capcity.y + guiInfo.capcity.h - 20/zoom, tocolor(170, 170, 170, 255), 1/zoom, self.fonts.percent, "center", "top")
    end


    local pos = Vector3(getElementPosition(self.vehicle))
    if getDistanceBetweenPoints3D(pos, self.lastPos) > 26 then
        local _, _, rot = getElementRotation(self.vehicle)
        self:createNewPoints(pos, rot)
    end
end

function Sweepers:destroyPoints()
    for i, v in pairs(self.objects) do
        if isElement(v) then destroyElement(v) end
    end
    self.objects = {}
end

function Sweepers:pickupTrash(source, plr, md)
    if plr ~= localPlayer or not md then return end
    local veh = getPedOccupiedVehicle(localPlayer)
    if not veh then return end
    if getElementModel(veh) ~= 574 then return end

    if self.capacity >= self.totalCapacity then return end

    local model = getElementData(source, "modelID")
    self.capacity = math.min(self.capacity + guiInfo.trashCapacity[model], self.totalCapacity)

    for i, v in pairs(self.objects) do
        if v == source then
            destroyElement(v)
            table.remove(self.objects, i)
            break
        end
    end

    self.trashPicked = self.trashPicked + 1
    if self.trashPicked >= 5 then
        self.trashPicked = 0
        triggerServerEvent("givePlayerJobPoints", resourceRoot, getResourceName(getThisResource()), 5, "punktów")
    end

    local rnd = math.random(1,25)
    local ile = math.random(1,3)
    if rnd == 6 then
        setElementData(localPlayer, "characterPoints", getElementData(localPlayer, "characterPoints") + ile)
        exports.TR_noti:create("Otrzymujesz dodatkowe "..ile.." punktów doświadczenia.", "info")
    end
end

function Sweepers:onMarkerEmpty(source, plr, md)
    if plr ~= localPlayer or not md then return end
    local veh = getPedOccupiedVehicle(localPlayer)
    if not veh then return end
    if getElementModel(veh) ~= 574 then return end

    if self.capacity < 10 then
        exports.TR_noti:create("Nie możesz wysypać mniej niż 10kg śmieci.", "error")
        return
    end

    triggerServerEvent("onPlayerSweeperJobTakout", resourceRoot, self.capacity)
    exports.TR_noti:create(string.format("Wysypano %.1fkg śmieci.", self.capacity), "success")
    self.capacity = 0
end

function Sweepers:createNewPoints(pos, rot)
    self:destroyPoints()

    local fx, fy = self:getPointFromDistanceRotation(pos.x, pos.y, 12, -rot)

    local plrPos = Vector3(getElementPosition(localPlayer))
    local howManyPoints = self.ownedUpgrades[2] and 4 or 3
    local tries = 0
    while (#self.objects < howManyPoints and tries <= howManyPoints * 2) do
        local px, py = self:getPointFromDistanceRotation(fx, fy, math.random(2, 7), math.random(0, 359))
        local pz = getGroundPosition(px, py, 1000)

        if pz >= plrPos.z - 2 and pz <= plrPos.z + 2 then
            local model = guiInfo.models[math.random(1, #guiInfo.models)]
            local sphere = createColSphere(px, py, pz + 1, 1.5)

            local object = createObject(model, px, py, pz + guiInfo.objectOffsets[model])
            setElementCollisionsEnabled(object, false)

            local marker = createMarker(px, py, pz + guiInfo.objectOffsets[model] + 1.5, "arrow", 1, 0, 144, 255, math.random(45, 120))
            setElementParent(marker, object)
            setElementParent(object, sphere)
            setElementData(source, "modelID", model, false)

            table.insert(self.objects, sphere)

            addEventHandler("onClientColShapeHit", sphere, self.func.pickupTrash)
        end

        tries = tries + 1
    end
    self.lastPos = Vector3(getElementPosition(localPlayer))
end

function Sweepers:createJobVehicle()
    local respIndex = self:getFreeRespawn()
    if not respIndex then
        exports.TR_noti:create("Na podjeździe nie ma żadnego wolnego miejsca. Poczekaj aż jakieś się zwolni.", "error")
        exports.TR_jobs:responseJobWindow(true)
        self:destroy()
        return true
    end

    local pos = guiInfo.vehicleSpawns[respIndex]
    triggerServerEvent("createSweeperVehicle", resourceRoot, {pos.x, pos.y, pos.z}, self.ownedUpgrades[3])
    exports.TR_jobs:responseJobWindow()
end

function Sweepers:getFreeRespawn()
    local freeResp = false

    for i, spawnPos in pairs(guiInfo.vehicleSpawns) do
        local clear = true
        for _, v in pairs(getElementsByType("vehicle", root)) do
            local pos = Vector3(getElementPosition(v))
            if getDistanceBetweenPoints3D(spawnPos, pos) < 5 then clear = false break end
        end
        if clear then freeResp = i end
    end

    return freeResp
end

function Sweepers:getPointFromDistanceRotation(x, y, dist, angle)
    local a = math.rad(90 - angle);
    local dx = math.cos(a) * dist;
    local dy = math.sin(a) * dist;
    return x+dx, y+dy;
end


function startJob(...)
    if jobSettings.work then return end
    jobSettings.work = Sweepers:create(...)
end

function endJob()
    exports.TR_jobs:responseJobWindow()

    if not jobSettings.work then return end
    jobSettings.work:destroy()
end

-- exports.TR_jobs:createInformation(jobSettings.name, string.format("Udaj się do %s aby dostarczyć kontener.\nUszkodzenia ładunku:", "Market Vinience Station"), guiInfo.capcity.h)
-- local trailer = dxCreateTexture("files/images/trailer.png", "argb", true, "clamp")
-- local percentFont = exports.TR_dx:getFont(12)
-- local testHP = 1000
-- function render()
--     testHP = testHP - 1
--     local percent = math.min((1000 - testHP)/1000, 1)

--     dxDrawImage(guiInfo.capcity.x, guiInfo.capcity.y, guiInfo.capcity.w, guiInfo.capcity.h, trailer, 0, 0, 0, tocolor(47, 47, 47, 255))
--     dxDrawImageSection(guiInfo.capcity.x, guiInfo.capcity.y + guiInfo.capcity.h - guiInfo.capcity.h * percent, guiInfo.capcity.w, guiInfo.capcity.h * percent, 0, 68 - 68 * percent, 128, 68 * percent, trailer, 0, 0, 0, tocolor(124, 0, 0, 255))
--     dxDrawText(string.format("%.1f%%", 100 * percent), guiInfo.capcity.x, guiInfo.capcity.y, guiInfo.capcity.x + guiInfo.capcity.w, guiInfo.capcity.y + guiInfo.capcity.h - 20/zoom, tocolor(170, 170, 170, 255), 1/zoom, percentFont, "center", "center")
-- end
-- addEventHandler("onClientRender", root, render)

-- setCameraTarget(localPlayer)
-- setElementFrozen(localPlayer, false)
-- triggerServerEvent("setContainerFrozen", resourceRoot, veh, false)
-- toggleControl("accelerate", true)
-- toggleControl("brake_reverse", true)
-- toggleControl("enter_exit", true)