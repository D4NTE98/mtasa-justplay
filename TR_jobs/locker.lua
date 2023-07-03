function getLockerOptions()
    local jobID, jobType = getPlayerJob()

    if jobType == "mechanic" then
        return {{"strój mechanika (m)", 50}, {"strój mechanika (k)", 192}, {"strój lakiernika", 305}}

    elseif jobType == "taxi" then
        return {{"strój taksówkarza (m)", 171}, {"strój taksówkarza (k)", 172}}

    -- Fractions
    elseif jobType == "fire" then
        return {{"ubranie koszarowe (m)", 279}, {"ubranie koszarowe (k)", 137}, {"ubranie specjalne (m)", 277}, {"ubranie specjalne (k)", 278}, {"ubranie techniczne (m)", 293}}

    elseif jobType == "police" then
        return {{"ubranie akademii (m)", 267}, {"ubranie akademii (k)", 265}, {"mundur policjantki (k)", 266}, {"mundur PO I (m)", 280}, {"mundur PO II (m)", 282}, {"mundur PO III (m)", 283}, {"mundur PO IV (m)", 284}, {"mundur SGT I (m)", 285}, {"mundur SGT II (m)", 286}, {"mundur Corporal I (m)", 287}, {"mundur Corporal III (m)", 288}, {"mundur SWAT (m)", 301}, {"mundur ACOP (m)", 246}, {"mundur Deputy Chief (m)", 238}, {"mundur Command (m)", 71}, {"mundur SuperVisor (m)", 257}, {"mundur TEU (m)", 256}, {"mundur Chief (m)", 245}}

    elseif jobType == "medic" then
        return {{"ubranie ratownika (m)", 302}, {"ubranie ratownika (k)", 303}, {"kitel lekarski (m)", 274}, {"strój chirurga (m)", 275}, {"strój laboranta (m)", 70}}

    elseif jobType == "news" then
        return {{"ubranie redaktora (m)", 17}, {"ubranie redaktora (k)", 219}, {"ubranie fotoreportera (m)", 120}, {"ubranie fotoreportera (k)", 91}, {"ubranie kamerzysty (m)", 217}}

    elseif jobType == "ers" then
        return {{"ubranie akademii (m)", 196}, {"ubranie akademii (k)", 298}, {"ubranie robocze (m)", 145}, {"ubranie robocze (m)", 177}, {"ubranie mechanika (m)", 190}}


    elseif jobID == "TR_warehouse" then
        return {{"ubranie robocze (m)", 16}, {"ubranie robocze (k)", 298}}

    elseif jobID == "TR_pizzaboy" then
        return {{"ubranie robocze (m)", 155}, {"ubranie robocze (k)", 304}}
    end
    return false
end

function updateLockerInfo()
    local jobID, jobType = getPlayerJob()
    local skin = getElementModel(localPlayer)

    if jobType == "fire" then
        if skin == 279 or skin == 137 or skin == 277 or skin == 278 then
            hideInformation()
        else
            createInformation("San Andreas Fire Department", "Udaj się do przebieralni i ubierz odpowiedniego skina.")
        end
        return

    elseif jobType == "medic" then
        if skin == 302 or skin == 303 or skin == 274 or skin == 275 or skin == 70 then
            hideInformation()
        else
            createInformation("Emergency Medical Services", "Udaj się do przebieralni i ubierz odpowiedniego skina.")
        end
        return

    elseif jobType == "police" then
        local weapons = getElementData(localPlayer, "weapons")
        if weapons then
            if #weapons > 0 then
                hideInformation()
                return
            end
        end

        if skin == 267 or skin == 265 or skin == 266 or skin == 280 or skin == 282 or skin == 283 or skin == 284 or skin == 285 or skin == 286 or skin == 287 or skin == 288 or skin == 301 or skin == 246 or skin == 238 or skin == 71 or skin == 257 or skin == 256 or skin == 245 then
            createInformation("San Andreas Police Department", "Udaj się na strzelnicę i odbierz swoje wyposażenie.")
        else
            createInformation("San Andreas Police Department", "Udaj się do przebieralni i ubierz odpowiedniego skina lub od razu wybierz się na strzelnicę i odbierz swoje wyposażenie.")
        end

    elseif jobType == "fractionc" then
        if skin == 46 or skin == 59 or skin == 185 or skin == 12 or skin == 216 or skin == 91 then
            hideInformation()
        else
            createInformation("San Andreas Fraction Center", "Udaj się do przebieralni i ubierz odpowiedniego skina.")
        end
        return

    elseif jobType == "ers" then
        if skin == 196 or skin == 298 or skin == 145 or skin == 177 or skin == 190 then
            hideInformation()
        else
            createInformation("Emergency Road Services", "Udaj się do przebieralni i ubierz odpowiedniego skina.")
        end
        return

    elseif jobType == "news" then
        if skin == 17 or skin == 219 or skin == 120 or skin == 91 or skin == 217 then
            hideInformation()
        else
            createInformation("Just News", "Udaj się do przebieralni i ubierz odpowiedniego skina.")
        end
        return
    end

    if skin == 50 then
        createInformation("Mechanik samochodowy", "Udaj się na wolne stanowisko i poczekaj na klienta, a następnie zaoferuj mu naprawę.")

    elseif skin == 305 then
        createInformation("Lakiernik samochodowy", "Udaj się na stanowisko malarskie i poczekaj na klienta, a następnie zaoferuj mu lakierowanie.")

    elseif skin == 171 or skin == 172 then
        createInformation("Taksówkarz", "Poczekaj na zgłoszenie, lub samemu udaj się w jakieś często odwiedzane miejsce aby zdobyć klientów. Panel ze zgłoszeniami znajdziesz pod przyciskiem F4.")

    elseif skin == 16 or skin == 298 then
        createInformation("Praca magazyniera", "Udaj się na rozładunek.")
        exports.TR_jobs:setPlayerTargetPos(2255.5432128906, -199.31307983398, 96.181617736816 - 0.5, 5, 1, "Podejdź aby rozładować paczkę")

    elseif skin == 155 or skin == 304 then
        createInformation("Rozwożenie pizzy", "Odbierz gotowe pizze do rozwiezienia z pieca.")
        setPlayerTargetPos(376.49130249023, -113.70402526855, 1001.4921875 - 0.5, 5, 1, "Odbierz zlecenia")
    else
        openLockerInfo()
    end

    exports.TR_weapons:updateWeapons()
end