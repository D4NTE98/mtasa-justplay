local mechanics = {}

function repair()
    if exports.TR_core:takeMoneyFromPlayer(client, 30) then
        triggerClientEvent(client, "responseRepair", resourceRoot, true)
        local veh = getPedOccupiedVehicle(client)
        fixVehicle(veh)
        setElementHealth(veh, 1000)
        setVehicleLightState(veh, 0, 0)
        setVehicleLightState(veh, 1, 0)
        exports.TR_noti:create(client, "Pomyślnie naprawiono twój pojazd, pobrano ci 100$ z konta.", "info")
    else
        triggerClientEvent(client, "responseRepair", resourceRoot, false)
        exports.TR_noti:create(client, "Nie posiadasz przy sobie tyle pieniędzy na naprawę!", "error")
    end
end
addEvent("repair", true)
addEventHandler("repair", resourceRoot, repair)