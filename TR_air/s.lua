function addAdminLogFlight(inVeh, start, stop, distance, nearCollectible)
    
end
addEvent("addAdminLogFlight", true)
addEventHandler("addAdminLogFlight", resourceRoot, addAdminLogFlight)


function givePlayerJobScore(jobID, points, plural)
    local uid = getElementData(client, "characterUID")
    if not uid then return end

    exports.TR_noti:create(client, string.format("Otrzymujesz %d %s. Za zdobyte punkty możesz zakupić ulepszenia w pracy.", points and tonumber(points) or 1, plural and plural or "punkt"), "success")
    exports.TR_mysql:querry(string.format("UPDATE tr_jobsPlayers SET points = points + %d WHERE playerUID = ? AND jobID = ? LIMIT 1", points and tonumber(points) or 1), uid, jobID)
end
addEvent("givePlayerJobScore", true)
addEventHandler("givePlayerJobScore", root, givePlayerJobScore)