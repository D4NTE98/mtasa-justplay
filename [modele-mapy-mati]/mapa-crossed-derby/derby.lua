local data = {
    ["monsterDerby"] = {
        fallCol = createColCuboid(4108.2841796875, -1683.5920410156, 208.523712158, 210, 160, 15),
        centerPos = Vector2(4215.4467773438, -1601.4320068359),
        distance = 34,
        model = 444,
    },

    ["standardDerby"] = {
        fallCol = createColCuboid(6020.3828125, -706.70111083984, 20.493709564209, 280, 350, 15),
        model = 415,
        pos = {
            Vector3(2997.6005859375, 424.7001953125, 16.799999237061),
            Vector3(3038.2001953125, 425.2998046875, 16.799999237061),
            Vector3(2999.2998046875, 385.099609375, 16.799999237061),
            Vector3(2998, 349.900390625, 16.799999237061),
            Vector3(3038.5, 350.400390625, 16.799999237061),
            Vector3(3132.6005859375, 350.2001953125, 16.799999237061),
            Vector3(2997.6005859375, 424.7001953125, 16.799999237061),
            Vector3(2999.2998046875, 385.099609375, 16.799999237061),
            Vector3(2998, 349.900390625, 16.799999237061),
            Vector3(3038.5, 350.400390625, 16.799999237061),
            Vector3(3033.400390625, 337.5, 3.4000000953674,
            Vector3(3038.2998046875, 332.400390625, 3.4000000953674),
            Vector3(3079, 332, 3.4000000953674),
            Vector3(3097.400390625, 332, 3.4000000953674),
            Vector3(3137.7001953125, 332, 3.4000000953674),
            Vector3(3154.2998046875, 332.400390625, 3.4000000953674),
            Vector3(3159.7998046875, 337.400390625, 3.4000000953674),
            Vector3(3132.5, 367.599609375, 3.4000000953674),

            Vector3(3099.5, 372.89999389648, 9.1999998092651),
            Vector3(3099.5, 413.2998046875, 9.1999998092651),
            Vector3(3097, 419.2001953125, 3.4000000953674),
            Vector3(3073.7001953125, 448.400390625, 3.4000000953674),

            Vector3(3038.5, 448.2998046875, 3.4000000953674),
            Vector3(3033.2001953125, 443.2998046875, 3.4000000953674),
            Vector3(3154.7001953125, 448.5, 3.4000000953674),
            Vector3(3159.7998046875, 443.400390625, 3.4000000953674),
            Vector3(3137.900390625, 442.2998046875, 3.4000000953674),
            Vector3(3149.400390625, 418.7998046875, 3.4000000953674),
            Vector3(3112.3000488281, 389, 7.3000001907349),
            Vector3(3126.3999023438, 388.60000610352, 4.8000001907349),
        },
    },

}

function createMonsterDerbyVehicles()
    local angleSwitch = 360 / eventData.playerCount
    local index = 0

    for i, v in pairs(eventData.playersLeft) do
        local x, y = getPointFromDistanceRotation(data.monsterDerby.centerPos.x, data.monsterDerby.centerPos.y, data.monsterDerby.distance, angleSwitch * index)
        local rot = findRotation(x, y, data.monsterDerby.centerPos.x, data.monsterDerby.centerPos.y)

        setElementInterior(i, 0)
        setElementDimension(i, 0)

        local veh = createVehicle(data.monsterDerby.model, x, y, 237, 0, 0, rot)
        setElementData(veh, "vehicleData", {
            fuel = 80,
            mileage = math.random(20000, 50000)
        }, false)
        setElementData(i, "engineState", true, false)
        setElementData(veh, "blockAction", true)
        setVehicleEngineState(veh, true)

        local rnd = math.random(0,255)

        setVehicleColor(veh, rnd, rnd, rnd, rnd, rnd)

        warpPedIntoVehicle(i, veh)
        index = index + 1
    end
end

function createCrossedDerbyVehicles()
    local index = 1

    for i, v in pairs(eventData.playersLeft) do
        local pos = data.standardDerby.pos[index]

        setElementInterior(i, 0)
        setElementDimension(i, 0)

        local veh = createVehicle(data.standardDerby.model, pos.x, pos.y, 41, 0, 0, pos.z)
        setElementData(veh, "vehicleData", {
            fuel = 80,
            mileage = math.random(20000, 50000),
        }, false)
        setElementData(i, "engineState", true, false)
        setElementData(veh, "blockAction", true)
        setVehicleEngineState(veh, true)

        local rnd = math.random(0,255)

        setVehicleColor(veh, rnd, rnd, rnd, rnd, rnd)

        warpPedIntoVehicle(i, veh)
        index = index + 1
    end
end

function createDerbyVehicles()
    if eventData.events[eventData.selectedEvent].type == "monsterDerby" then
        createMonsterDerbyVehicles()

    elseif eventData.events[eventData.selectedEvent].type == "crossedDerby" then
        createCrossedDerbyVehicles()
    end
end


function getPointFromDistanceRotation(x, y, dist, angle)
    local a = math.rad(90 - angle);
    local dx = math.cos(a) * dist;
    local dy = math.sin(a) * dist;
    return x+dx, y+dy;
end

function findRotation( x1, y1, x2, y2 )
    local t = -math.deg( math.atan2( x2 - x1, y2 - y1 ) )
    return t < 0 and t + 360 or t
end