function createTrainJobVehicle()
    local veh = createVehicle(538, -1947.83984375, 152.37890625, 25.710937, 0, 0, 177)
    setVehicleDamageProof(veh, true)
    setTrainDerailable(veh, false)

    setElementData(veh, "vehicleData", {
		fuel = 70,
		mileage = math.random(350000, 500000),
		engineType = "d",
	}, false)
    setElementData(veh, "vehicleOwner", client)
    setElementData(veh, "blockCollisions", true)
    setTrainDirection(veh, true)
    setVehicleOverrideLights(veh, 1)
    setTimer(setVehicleEngineState, 1500, 1, veh, true)

    local plr = client
    setTimer(function()
        warpPedIntoVehicle(plr, veh)
        setElementInterior(plr, 0)
        setElementDimension(plr, 0)
        setVehicleEngineState(veh, true)
    end, 100, 1)

    local veh2 = createVehicle(570, -1946.9609375, 171.8310546875, 25.7186183929, 0, 0, 177)
    attachTrailerToVehicle(veh, veh2)
    setTrainDerailable(veh2, false)
    setElementData(veh2, "blockCollisions", true)

    exports.TR_objectManager:attachObjectToPlayer(client, veh)
    exports.TR_objectManager:attachObjectToPlayer(client, veh2)
end
addEvent("createTrainJobVehicle2", true)
addEventHandler("createTrainJobVehicle2", resourceRoot, createTrainJobVehicle)

function onVehicleStartExit(plr)
    removePedFromVehicle(plr)
    triggerClientEvent(plr, "endTrainWork", resourceRoot)

    setTimer(setElementPosition, 100, 1, plr, -1971.248046875, 120.83984375, 27.68)
end
addEventHandler("onVehicleStartExit", resourceRoot, onVehicleStartExit)