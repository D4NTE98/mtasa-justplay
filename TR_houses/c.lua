local sx, sy = guiGetScreenSize()
local zoom = 1
local baseX = 1920
local minZoom = 2

if sx < baseX then
    zoom = math.min(minZoom, baseX/sx)
end

local guiInfo = {
    open = false,

    x = (sx - 844/zoom)/2,
    y = (sy - 510/zoom)/2,
    w = 844/zoom,
    h = 510/zoom,

    alpha = 0,

    images = {},
}

function render()
    renderAnim()

    drawBackground(guiInfo.x, guiInfo.y, guiInfo.w, guiInfo.h, tocolor(16,18,23, 255 * guiInfo.alpha), 15)
	dxDrawImage(guiInfo.x, guiInfo.y, guiInfo.w, 115/zoom, "files/images/head.png", 0, 0, 0, tocolor(255, 255, 255, 255 * guiInfo.alpha))

	if guiInfo.images.orgLogo then
		dxDrawImage(guiInfo.x + (guiInfo.w - 100/zoom)/2, guiInfo.y + 7/zoom, 100/zoom, 100/zoom, guiInfo.images.orgLogo, 0, 0, 0, tocolor(255, 255, 255, 255 * guiInfo.alpha))
	else
		dxDrawImage(guiInfo.x + (guiInfo.w - 100/zoom)/2, guiInfo.y + 7/zoom, 100/zoom, 100/zoom, "files/images/logo.png", 0, 0, 0, tocolor(255, 255, 255, 255 * guiInfo.alpha))
		dxDrawText(guiInfo.houseInfo.place, guiInfo.x, guiInfo.y + 70/zoom, guiInfo.x + guiInfo.w, guiInfo.y + guiInfo.h, tocolor(28,89,119, 255 * guiInfo.alpha), 1/zoom, guiInfo.fontLogo, "center", "top")
	end
	dxDrawText(guiInfo.houseInfo.name, guiInfo.x, guiInfo.y + 125/zoom, guiInfo.x + guiInfo.w, guiInfo.y + guiInfo.h, tocolor(44,181,233, 255 * guiInfo.alpha), 1/zoom, guiInfo.fontName, "center", "top")

    if guiInfo.houseMenu == "menu" then
        if not guiInfo.houseInfo.owner then
            if isCursorInPosition(guiInfo.x + guiInfo.w - 140/zoom, guiInfo.y + 95/zoom, 80/zoom, 80/zoom) then
                dxDrawImage(guiInfo.x + guiInfo.w - 140/zoom, guiInfo.y + 95/zoom, 80/zoom, 80/zoom, "files/images/buy.png", 0, 0, 0, tocolor(220, 220, 220, 255 * guiInfo.alpha))
                dxDrawText("Wynajmij posiadłość", guiInfo.x + guiInfo.w - 140/zoom, guiInfo.y + 175/zoom, guiInfo.x + guiInfo.w - 60/zoom, guiInfo.y + guiInfo.h, tocolor(220, 220, 220, 255 * guiInfo.alpha), 1/zoom, guiInfo.category, "center", "top")
            else
                dxDrawImage(guiInfo.x + guiInfo.w - 140/zoom, guiInfo.y + 95/zoom, 80/zoom, 80/zoom, "files/images/buy.png", 0, 0, 0, tocolor(170, 170, 170, 255 * guiInfo.alpha))
                dxDrawText("Wynajmij posiadłość", guiInfo.x + guiInfo.w - 140/zoom, guiInfo.y + 175/zoom, guiInfo.x + guiInfo.w - 60/zoom, guiInfo.y + guiInfo.h, tocolor(170, 170, 170, 255 * guiInfo.alpha), 1/zoom, guiInfo.category, "center", "top")
            end

        elseif guiInfo.houseInfo.isOwner then
            if isCursorInPosition(guiInfo.x + guiInfo.w - 140/zoom, guiInfo.y + 95/zoom, 80/zoom, 80/zoom) then
                dxDrawImage(guiInfo.x + guiInfo.w - 140/zoom, guiInfo.y + 95/zoom, 80/zoom, 80/zoom, "files/images/pay.png", 0, 0, 0, tocolor(220, 220, 220, 255 * guiInfo.alpha))
                dxDrawText("Opłać posiadłość", guiInfo.x + guiInfo.w - 140/zoom, guiInfo.y + 175/zoom, guiInfo.x + guiInfo.w - 60/zoom, guiInfo.y + guiInfo.h, tocolor(220, 220, 220, 255 * guiInfo.alpha), 1/zoom, guiInfo.category, "center", "top")

            else
                dxDrawImage(guiInfo.x + guiInfo.w - 140/zoom, guiInfo.y + 95/zoom, 80/zoom, 80/zoom, "files/images/pay.png", 0, 0, 0, tocolor(170, 170, 170, 255 * guiInfo.alpha))
                dxDrawText("Opłać posiadłość", guiInfo.x + guiInfo.w - 140/zoom, guiInfo.y + 175/zoom, guiInfo.x + guiInfo.w - 60/zoom, guiInfo.y + guiInfo.h, tocolor(170, 170, 170, 255 * guiInfo.alpha), 1/zoom, guiInfo.category, "center", "top")
            end

        else
            dxDrawImage(guiInfo.x + guiInfo.w - 140/zoom, guiInfo.y + 95/zoom, 80/zoom, 80/zoom, "files/images/sold.png", 0, 0, 0, tocolor(150, 150, 150, 255 * guiInfo.alpha))
            dxDrawText("Sprzedane", guiInfo.x + guiInfo.w - 140/zoom, guiInfo.y + 175/zoom, guiInfo.x + guiInfo.w - 60/zoom, guiInfo.y + guiInfo.h, tocolor(150, 150, 150, 255 * guiInfo.alpha), 1/zoom, guiInfo.category, "center", "top")
        end

        if not guiInfo.houseInfo.owner then
            dxDrawText("#aaaaaaWłaściciel: #2cb5e9Dom do kupna", guiInfo.x + 30/zoom, guiInfo.y + 170/zoom, guiInfo.x + guiInfo.w, guiInfo.y + guiInfo.h, tocolor(255, 255, 255, 255 * guiInfo.alpha), 1/zoom, guiInfo.normal, "left", "top", false, false, false, true)
            dxDrawText("#aaaaaaDzienna opłata: #2cb5e9$" .. guiInfo.houseInfo.price, guiInfo.x + 30/zoom, guiInfo.y + 195/zoom, guiInfo.x + guiInfo.w, guiInfo.y + guiInfo.h, tocolor(255, 255, 255, 255 * guiInfo.alpha), 1/zoom, guiInfo.normal, "left", "top", false, false, false, true)
            dxDrawText("#aaaaaaWielkość posiadłości: #2cb5e9" .. (guiInfo.houseInfo.interiorSize * guiInfo.houseInfo.interiorSize) .. "m²", guiInfo.x + 30/zoom, guiInfo.y + 220/zoom, guiInfo.x + guiInfo.w, guiInfo.y + guiInfo.h, tocolor(255, 255, 255, 255 * guiInfo.alpha), 1/zoom, guiInfo.normal, "left", "top", false, false, false, true)
            dxDrawText("#aaaaaaPosiadłość opłacona do: #2cb5e9Do wykupienia", guiInfo.x + 30/zoom, guiInfo.y + 245/zoom, guiInfo.x + guiInfo.w, guiInfo.y + guiInfo.h, tocolor(255, 255, 255, 255 * guiInfo.alpha), 1/zoom, guiInfo.normal, "left", "top", false, false, false, true)

        else
            dxDrawText("#aaaaaaWłaściciel: #2cb5e9" .. (guiInfo.houseInfo.orgName or guiInfo.houseInfo.ownerName), guiInfo.x + 30/zoom, guiInfo.y + 170/zoom, guiInfo.x + guiInfo.w, guiInfo.y + guiInfo.h, tocolor(255, 255, 255, 255 * guiInfo.alpha), 1/zoom, guiInfo.normal, "left", "top", false, false, false, true)
            dxDrawText("#aaaaaaDzienna opłata: #2cb5e9$" .. guiInfo.houseInfo.price, guiInfo.x + 30/zoom, guiInfo.y + 195/zoom, guiInfo.x + guiInfo.w, guiInfo.y + guiInfo.h, tocolor(255, 255, 255, 255 * guiInfo.alpha), 1/zoom, guiInfo.normal, "left", "top", false, false, false, true)
            dxDrawText("#aaaaaaWielkość posiadłości: #2cb5e9" .. (guiInfo.houseInfo.interiorSize * guiInfo.houseInfo.interiorSize) .. "m²", guiInfo.x + 30/zoom, guiInfo.y + 220/zoom, guiInfo.x + guiInfo.w, guiInfo.y + guiInfo.h, tocolor(255, 255, 255, 255 * guiInfo.alpha), 1/zoom, guiInfo.normal, "left", "top", false, false, false, true)
            dxDrawText("#aaaaaaPosiadłość opłacona do: #2cb5e9" .. guiInfo.houseInfo.date, guiInfo.x + 30/zoom, guiInfo.y + 245/zoom, guiInfo.x + guiInfo.w, guiInfo.y + guiInfo.h, tocolor(255, 255, 255, 255 * guiInfo.alpha), 1/zoom, guiInfo.normal, "left", "top", false, false, false, true)
        end

        drawRoundedBackground(guiInfo.x + (guiInfo.w - 590/zoom)/2, guiInfo.y + guiInfo.h - 220/zoom, 590/zoom, 140/zoom, tocolor(34,36,43, 255 * guiInfo.alpha), 15)

        if isCursorInPosition(guiInfo.x + (guiInfo.w - 570/zoom)/2 + 30/zoom, guiInfo.y + guiInfo.h - 205/zoom, 80/zoom, 110/zoom) then
            dxDrawImage(guiInfo.x + (guiInfo.w - 570/zoom)/2 + 30/zoom, guiInfo.y + guiInfo.h - 205/zoom, 80/zoom, 80/zoom, guiInfo.houseInfo.locked == 1 and "files/images/enter_block.png" or "files/images/enter.png", 0, 0, 0, tocolor(220, 220, 220, 255 * guiInfo.alpha))
            dxDrawText("Wejdź do środka", guiInfo.x + (guiInfo.w - 570/zoom)/2 + 30/zoom, guiInfo.y + guiInfo.h - 115/zoom, guiInfo.x + (guiInfo.w - 570/zoom)/2 + 110/zoom, guiInfo.y + guiInfo.h, tocolor(255, 255, 255, 255 * guiInfo.alpha), 1/zoom, guiInfo.category, "center", "top")
        else
            dxDrawImage(guiInfo.x + (guiInfo.w - 570/zoom)/2 + 30/zoom, guiInfo.y + guiInfo.h - 205/zoom, 80/zoom, 80/zoom, guiInfo.houseInfo.locked == 1 and "files/images/enter_block.png" or "files/images/enter.png", 0, 0, 0, tocolor(170, 170, 170, 255 * guiInfo.alpha))
            dxDrawText("Wejdź do środka", guiInfo.x + (guiInfo.w - 570/zoom)/2 + 30/zoom, guiInfo.y + guiInfo.h - 115/zoom, guiInfo.x + (guiInfo.w - 570/zoom)/2 + 110/zoom, guiInfo.y + guiInfo.h, tocolor(170, 170, 170, 255 * guiInfo.alpha), 1/zoom, guiInfo.category, "center", "top")
        end

        if guiInfo.houseInfo.isOwner then
            if isCursorInPosition(guiInfo.x + (guiInfo.w - 570/zoom)/2 + 170/zoom, guiInfo.y + guiInfo.h - 205/zoom, 80/zoom, 110/zoom) then
                dxDrawImage(guiInfo.x + (guiInfo.w - 570/zoom)/2 + 170/zoom, guiInfo.y + guiInfo.h - 205/zoom, 80/zoom, 80/zoom, "files/images/key.png", 0, 0, 0, tocolor(220, 220, 220, 255 * guiInfo.alpha))
                dxDrawText(guiInfo.houseInfo.locked == 1 and "Otwórz drzwi" or "Zamknij drzwi", guiInfo.x + (guiInfo.w - 570/zoom)/2 + 170/zoom, guiInfo.y + guiInfo.h - 115/zoom, guiInfo.x + (guiInfo.w - 570/zoom)/2 + 250/zoom, guiInfo.y + guiInfo.h, tocolor(255, 255, 255, 255 * guiInfo.alpha), 1/zoom, guiInfo.category, "center", "top")
            else
                dxDrawImage(guiInfo.x + (guiInfo.w - 570/zoom)/2 + 170/zoom, guiInfo.y + guiInfo.h - 205/zoom, 80/zoom, 80/zoom, "files/images/key.png", 0, 0, 0, tocolor(170, 170, 170, 255 * guiInfo.alpha))
                dxDrawText(guiInfo.houseInfo.locked == 1 and "Otwórz drzwi" or "Zamknij drzwi", guiInfo.x + (guiInfo.w - 570/zoom)/2 + 170/zoom, guiInfo.y + guiInfo.h - 115/zoom, guiInfo.x + (guiInfo.w - 570/zoom)/2 + 250/zoom, guiInfo.y + guiInfo.h, tocolor(170, 170, 170, 255 * guiInfo.alpha), 1/zoom, guiInfo.category, "center", "top")
            end

            if isCursorInPosition(guiInfo.x + (guiInfo.w - 570/zoom)/2 + 310/zoom, guiInfo.y + guiInfo.h - 205/zoom, 80/zoom, 110/zoom) then
                dxDrawImage(guiInfo.x + (guiInfo.w - 570/zoom)/2 + 310/zoom, guiInfo.y + guiInfo.h - 205/zoom, 80/zoom, 80/zoom, "files/images/settings.png", 0, 0, 0, tocolor(220, 220, 220, 255 * guiInfo.alpha))
                dxDrawText("Zarządzaj", guiInfo.x + (guiInfo.w - 570/zoom)/2 + 310/zoom, guiInfo.y + guiInfo.h - 115/zoom, guiInfo.x + (guiInfo.w - 570/zoom)/2 + 390/zoom, guiInfo.y + guiInfo.h, tocolor(255, 255, 255, 255 * guiInfo.alpha), 1/zoom, guiInfo.category, "center", "top")
            else
                dxDrawImage(guiInfo.x + (guiInfo.w - 570/zoom)/2 + 310/zoom, guiInfo.y + guiInfo.h - 205/zoom, 80/zoom, 80/zoom, "files/images/settings.png", 0, 0, 0, tocolor(170, 170, 170, 255 * guiInfo.alpha))
                dxDrawText("Zarządzaj", guiInfo.x + (guiInfo.w - 570/zoom)/2 + 310/zoom, guiInfo.y + guiInfo.h - 115/zoom, guiInfo.x + (guiInfo.w - 570/zoom)/2 + 390/zoom, guiInfo.y + guiInfo.h, tocolor(170, 170, 170, 255 * guiInfo.alpha), 1/zoom, guiInfo.category, "center", "top")
            end

            if isCursorInPosition(guiInfo.x + (guiInfo.w - 570/zoom)/2 + 450/zoom, guiInfo.y + guiInfo.h - 205/zoom, 80/zoom, 110/zoom) then
                dxDrawImage(guiInfo.x + (guiInfo.w - 570/zoom)/2 + 450/zoom, guiInfo.y + guiInfo.h - 205/zoom, 80/zoom, 80/zoom, "files/images/organization.png", 0, 0, 0, tocolor(220, 220, 220, 255 * guiInfo.alpha))
                dxDrawText("Organizacja", guiInfo.x + (guiInfo.w - 570/zoom)/2 + 450/zoom, guiInfo.y + guiInfo.h - 115/zoom, guiInfo.x + (guiInfo.w - 570/zoom)/2 + 530/zoom, guiInfo.y + guiInfo.h, tocolor(255, 255, 255, 255 * guiInfo.alpha), 1/zoom, guiInfo.category, "center", "top")
            else
                dxDrawImage(guiInfo.x + (guiInfo.w - 570/zoom)/2 + 450/zoom, guiInfo.y + guiInfo.h - 205/zoom, 80/zoom, 80/zoom, "files/images/organization.png", 0, 0, 0, tocolor(170, 170, 170, 255 * guiInfo.alpha))
                dxDrawText("Organizacja", guiInfo.x + (guiInfo.w - 570/zoom)/2 + 450/zoom, guiInfo.y + guiInfo.h - 115/zoom, guiInfo.x + (guiInfo.w - 570/zoom)/2 + 530/zoom, guiInfo.y + guiInfo.h, tocolor(170, 170, 170, 255 * guiInfo.alpha), 1/zoom, guiInfo.category, "center", "top")
            end

        else
            dxDrawImage(guiInfo.x + (guiInfo.w - 570/zoom)/2 + 170/zoom, guiInfo.y + guiInfo.h - 205/zoom, 80/zoom, 80/zoom, "files/images/key.png", 0, 0, 0, tocolor(170, 170, 170, 20 * guiInfo.alpha))
            dxDrawText(guiInfo.houseInfo.locked == 1 and "Otwórz drzwi" or "Zamknij drzwi", guiInfo.x + (guiInfo.w - 570/zoom)/2 + 170/zoom, guiInfo.y + guiInfo.h - 115/zoom, guiInfo.x + (guiInfo.w - 570/zoom)/2 + 250/zoom, guiInfo.y + guiInfo.h, tocolor(170, 170, 170, 20 * guiInfo.alpha), 1/zoom, guiInfo.category, "center", "top")

            dxDrawImage(guiInfo.x + (guiInfo.w - 570/zoom)/2 + 310/zoom, guiInfo.y + guiInfo.h - 205/zoom, 80/zoom, 80/zoom, "files/images/settings.png", 0, 0, 0, tocolor(170, 170, 170, 20 * guiInfo.alpha))
            dxDrawText("Zarządzaj", guiInfo.x + (guiInfo.w - 570/zoom)/2 + 310/zoom, guiInfo.y + guiInfo.h - 115/zoom, guiInfo.x + (guiInfo.w - 570/zoom)/2 + 390/zoom, guiInfo.y + guiInfo.h, tocolor(170, 170, 170, 20 * guiInfo.alpha), 1/zoom, guiInfo.category, "center", "top")

            dxDrawImage(guiInfo.x + (guiInfo.w - 570/zoom)/2 + 450/zoom, guiInfo.y + guiInfo.h - 205/zoom, 80/zoom, 80/zoom, "files/images/organization.png", 0, 0, 0, tocolor(170, 170, 170, 20 * guiInfo.alpha))
            dxDrawText("Organizacja", guiInfo.x + (guiInfo.w - 570/zoom)/2 + 450/zoom, guiInfo.y + guiInfo.h - 115/zoom, guiInfo.x + (guiInfo.w - 570/zoom)/2 + 530/zoom, guiInfo.y + guiInfo.h, tocolor(170, 170, 170, 20 * guiInfo.alpha), 1/zoom, guiInfo.category, "center", "top")

            dxDrawText("Aby mieć dostęp do panelu posiadłości musisz być jej właścicielem lub członkiem organizacji.", guiInfo.x + (guiInfo.w - 570/zoom)/2 + 160/zoom, guiInfo.y + guiInfo.h - 220/zoom, guiInfo.x + (guiInfo.w - 570/zoom)/2 + 520/zoom, guiInfo.y + guiInfo.h - 80/zoom, tocolor(220, 220, 220, 255 * guiInfo.alpha), 1/zoom, guiInfo.category, "left", "center", true, true)
        end

    elseif guiInfo.houseMenu == "pay" then
        dxDrawText("Wpisz liczbę dni, na jaką chcesz opłacić posiadłość.", guiInfo.x + 20/zoom, guiInfo.y + 180/zoom, guiInfo.x + guiInfo.w - 20/zoom, guiInfo.y + guiInfo.h, tocolor(170, 170, 170, 255 * guiInfo.alpha), 1/zoom, guiInfo.normal, "center", "top")
        dxDrawText("#aaaaaaKoszt za jeden dzień: #2cb5e9$" .. guiInfo.houseInfo.price, guiInfo.x + 20/zoom, guiInfo.y + 205/zoom, guiInfo.x + guiInfo.w - 20/zoom, guiInfo.y + guiInfo.h, tocolor(170, 170, 170, 255 * guiInfo.alpha), 1/zoom, guiInfo.normal, "center", "top", false, false, false, true)

        local days = guiGetText(guiInfo.houseBuyTime)
        if tonumber(days) ~= nil and tonumber(days) > 0 then
            local toPay = guiInfo.houseInfo.price * days
            dxDrawText("#999999Łączny koszt wynajmu: #2cb5e9$" .. toPay, guiInfo.x + 20/zoom, guiInfo.y + 310/zoom, guiInfo.x + guiInfo.w - 20/zoom, guiInfo.y + 295/zoom, tocolor(170, 170, 170, 255 * guiInfo.alpha), 1/zoom, guiInfo.category, "center", "bottom", false, false, false, true)
        else
            dxDrawText("#999999Wpisz ilość dni, aby zobaczyć kwotę.", guiInfo.x + 20/zoom, guiInfo.y + 310/zoom, guiInfo.x + guiInfo.w - 20/zoom, guiInfo.y + 295/zoom, tocolor(170, 170, 170, 255 * guiInfo.alpha), 1/zoom, guiInfo.category, "center", "bottom", false, false, false, true)
        end


    elseif guiInfo.houseMenu == "exit" then
        dxDrawText("Czy na pewno chcesz opuścić tę posiadłość?", guiInfo.x + 20/zoom, guiInfo.y + 260/zoom, guiInfo.x + guiInfo.w - 20/zoom, guiInfo.y + guiInfo.h, tocolor(170, 170, 170, 255 * guiInfo.alpha), 1/zoom, guiInfo.normal, "center", "top")

    elseif guiInfo.houseMenu == "settings" then
        dxDrawText("Wybierz interesującą cię opcję posiadłości.", guiInfo.x + 20/zoom, guiInfo.y + 170/zoom, guiInfo.x + guiInfo.w - 20/zoom, guiInfo.y + guiInfo.h, tocolor(170, 170, 170, 255 * guiInfo.alpha), 1/zoom, guiInfo.normal, "center", "top")

        drawRoundedBackground(guiInfo.x + (guiInfo.w - 500/zoom)/2, guiInfo.y + guiInfo.h - 270/zoom, 500/zoom, 140/zoom, tocolor(34,36,43, 255 * guiInfo.alpha), 5)

		if guiInfo.houseInfo.isOwner == "full" then
			if isCursorInPosition(guiInfo.x + (guiInfo.w - 500/zoom)/2 + 50/zoom, guiInfo.y + guiInfo.h - 255/zoom, 80/zoom, 110/zoom) then
				dxDrawImage(guiInfo.x + (guiInfo.w - 500/zoom)/2 + 50/zoom, guiInfo.y + guiInfo.h - 255/zoom, 80/zoom, 80/zoom, "files/images/remove.png", 0, 0, 0, tocolor(220, 220, 220, 255 * guiInfo.alpha))
				dxDrawText("Wyproś lokatorów", guiInfo.x + (guiInfo.w - 500/zoom)/2 + 50/zoom, guiInfo.y + guiInfo.h - 165/zoom, guiInfo.x + (guiInfo.w - 500/zoom)/2 + 130/zoom, guiInfo.y + guiInfo.h, tocolor(255, 255, 255, 255 * guiInfo.alpha), 1/zoom, guiInfo.category, "center", "top")
			else
				dxDrawImage(guiInfo.x + (guiInfo.w - 500/zoom)/2 + 50/zoom, guiInfo.y + guiInfo.h - 255/zoom, 80/zoom, 80/zoom, "files/images/remove.png", 0, 0, 0, tocolor(170, 170, 170, 255 * guiInfo.alpha))
				dxDrawText("Wyproś lokatorów", guiInfo.x + (guiInfo.w - 500/zoom)/2 + 50/zoom, guiInfo.y + guiInfo.h - 165/zoom, guiInfo.x + (guiInfo.w - 500/zoom)/2 + 130/zoom, guiInfo.y + guiInfo.h, tocolor(170, 170, 170, 255 * guiInfo.alpha), 1/zoom, guiInfo.category, "center", "top")
			end
			if isCursorInPosition(guiInfo.x + (guiInfo.w - 500/zoom)/2 + 210/zoom, guiInfo.y + guiInfo.h - 255/zoom, 80/zoom, 110/zoom) then
				dxDrawImage(guiInfo.x + (guiInfo.w - 500/zoom)/2 + 210/zoom, guiInfo.y + guiInfo.h - 255/zoom, 80/zoom, 80/zoom, "files/images/edit.png", 0, 0, 0, tocolor(220, 220, 220, 255 * guiInfo.alpha))
				dxDrawText("Edytuj wnętrze", guiInfo.x + (guiInfo.w - 500/zoom)/2 + 210/zoom, guiInfo.y + guiInfo.h - 165/zoom, guiInfo.x + (guiInfo.w - 500/zoom)/2 + 290/zoom, guiInfo.y + guiInfo.h, tocolor(255, 255, 255, 255 * guiInfo.alpha), 1/zoom, guiInfo.category, "center", "top")
			else
				dxDrawImage(guiInfo.x + (guiInfo.w - 500/zoom)/2 + 210/zoom, guiInfo.y + guiInfo.h - 255/zoom, 80/zoom, 80/zoom, "files/images/edit.png", 0, 0, 0, tocolor(170, 170, 170, 255 * guiInfo.alpha))
				dxDrawText("Edytuj wnętrze", guiInfo.x + (guiInfo.w - 500/zoom)/2 + 210/zoom, guiInfo.y + guiInfo.h - 165/zoom, guiInfo.x + (guiInfo.w - 500/zoom)/2 + 290/zoom, guiInfo.y + guiInfo.h, tocolor(170, 170, 170, 255 * guiInfo.alpha), 1/zoom, guiInfo.category, "center", "top")
			end
			if isCursorInPosition(guiInfo.x + (guiInfo.w - 500/zoom)/2 + 370/zoom, guiInfo.y + guiInfo.h - 255/zoom, 80/zoom, 110/zoom) then
				dxDrawImage(guiInfo.x + (guiInfo.w - 500/zoom)/2 + 370/zoom, guiInfo.y + guiInfo.h - 255/zoom, 80/zoom, 80/zoom, "files/images/exit.png", 0, 0, 0, tocolor(220, 220, 220, 255 * guiInfo.alpha))
				dxDrawText("Wyprowadź się", guiInfo.x + (guiInfo.w - 500/zoom)/2 + 370/zoom, guiInfo.y + guiInfo.h - 165/zoom, guiInfo.x + (guiInfo.w - 500/zoom)/2 + 450/zoom, guiInfo.y + guiInfo.h, tocolor(255, 255, 255, 255 * guiInfo.alpha), 1/zoom, guiInfo.category, "center", "top")
			else
				dxDrawImage(guiInfo.x + (guiInfo.w - 500/zoom)/2 + 370/zoom, guiInfo.y + guiInfo.h - 255/zoom, 80/zoom, 80/zoom, "files/images/exit.png", 0, 0, 0, tocolor(170, 170, 170, 255 * guiInfo.alpha))
				dxDrawText("Wyprowadź się", guiInfo.x + (guiInfo.w - 500/zoom)/2 + 370/zoom, guiInfo.y + guiInfo.h - 165/zoom, guiInfo.x + (guiInfo.w - 500/zoom)/2 + 450/zoom, guiInfo.y + guiInfo.h, tocolor(170, 170, 170, 255 * guiInfo.alpha), 1/zoom, guiInfo.category, "center", "top")
			end

		elseif guiInfo.houseInfo.isOwner == "org" then
			if isCursorInPosition(guiInfo.x + (guiInfo.w - 500/zoom)/2 + 50/zoom, guiInfo.y + guiInfo.h - 255/zoom, 80/zoom, 110/zoom) then
				dxDrawImage(guiInfo.x + (guiInfo.w - 500/zoom)/2 + 50/zoom, guiInfo.y + guiInfo.h - 255/zoom, 80/zoom, 80/zoom, "files/images/remove.png", 0, 0, 0, tocolor(220, 220, 220, 255 * guiInfo.alpha))
				dxDrawText("Wyproś lokatorów", guiInfo.x + (guiInfo.w - 500/zoom)/2 + 50/zoom, guiInfo.y + guiInfo.h - 165/zoom, guiInfo.x + (guiInfo.w - 500/zoom)/2 + 130/zoom, guiInfo.y + guiInfo.h, tocolor(255, 255, 255, 255 * guiInfo.alpha), 1/zoom, guiInfo.category, "center", "top")
			else
				dxDrawImage(guiInfo.x + (guiInfo.w - 500/zoom)/2 + 50/zoom, guiInfo.y + guiInfo.h - 255/zoom, 80/zoom, 80/zoom, "files/images/remove.png", 0, 0, 0, tocolor(170, 170, 170, 255 * guiInfo.alpha))
				dxDrawText("Wyproś lokatorów", guiInfo.x + (guiInfo.w - 500/zoom)/2 + 50/zoom, guiInfo.y + guiInfo.h - 165/zoom, guiInfo.x + (guiInfo.w - 500/zoom)/2 + 130/zoom, guiInfo.y + guiInfo.h, tocolor(170, 170, 170, 255 * guiInfo.alpha), 1/zoom, guiInfo.category, "center", "top")
			end

            dxDrawImage(guiInfo.x + (guiInfo.w - 500/zoom)/2 + 210/zoom, guiInfo.y + guiInfo.h - 255/zoom, 80/zoom, 80/zoom, "files/images/edit.png", 0, 0, 0, tocolor(120, 120, 120, 255 * guiInfo.alpha))
            dxDrawText("Edytuj wnętrze", guiInfo.x + (guiInfo.w - 500/zoom)/2 + 210/zoom, guiInfo.y + guiInfo.h - 165/zoom, guiInfo.x + (guiInfo.w - 500/zoom)/2 + 290/zoom, guiInfo.y + guiInfo.h, tocolor(120, 120, 120, 255 * guiInfo.alpha), 1/zoom, guiInfo.category, "center", "top")

            dxDrawImage(guiInfo.x + (guiInfo.w - 500/zoom)/2 + 370/zoom, guiInfo.y + guiInfo.h - 255/zoom, 80/zoom, 80/zoom, "files/images/exit.png", 0, 0, 0, tocolor(120, 120, 120, 255 * guiInfo.alpha))
            dxDrawText("Wyprowadź się", guiInfo.x + (guiInfo.w - 500/zoom)/2 + 370/zoom, guiInfo.y + guiInfo.h - 165/zoom, guiInfo.x + (guiInfo.w - 500/zoom)/2 + 450/zoom, guiInfo.y + guiInfo.h, tocolor(120, 120, 120, 255 * guiInfo.alpha), 1/zoom, guiInfo.category, "center", "top")
		end


    elseif guiInfo.houseMenu == "organization" then
        dxDrawText("Wybierz interesującą cię opcję organizacji.", guiInfo.x + 20/zoom, guiInfo.y + 170/zoom, guiInfo.x + guiInfo.w - 20/zoom, guiInfo.y + guiInfo.h, tocolor(170, 170, 170, 255 * guiInfo.alpha), 1/zoom, guiInfo.normal, "center", "top")

        drawRoundedBackground(guiInfo.x + (guiInfo.w - 340/zoom)/2, guiInfo.y + guiInfo.h - 270/zoom, 340/zoom, 140/zoom, tocolor(34,36,43, 255 * guiInfo.alpha), 15)

        if guiInfo.houseInfo.isOwner == "full" then
            if not guiInfo.houseInfo.orgID then
                if isCursorInPosition(guiInfo.x + (guiInfo.w - 340/zoom)/2 + 50/zoom, guiInfo.y + guiInfo.h - 255/zoom, 80/zoom, 110/zoom) then
                    dxDrawImage(guiInfo.x + (guiInfo.w - 340/zoom)/2 + 50/zoom, guiInfo.y + guiInfo.h - 255/zoom, 80/zoom, 80/zoom, "files/images/orgAdd.png", 0, 0, 0, tocolor(220, 220, 220, 255 * guiInfo.alpha))
                    dxDrawText("Przypisz posiadłość", guiInfo.x + (guiInfo.w - 340/zoom)/2 + 50/zoom, guiInfo.y + guiInfo.h - 165/zoom, guiInfo.x + (guiInfo.w - 340/zoom)/2 + 130/zoom, guiInfo.y + guiInfo.h, tocolor(255, 255, 255, 255 * guiInfo.alpha), 1/zoom, guiInfo.category, "center", "top")
                else
                    dxDrawImage(guiInfo.x + (guiInfo.w - 340/zoom)/2 + 50/zoom, guiInfo.y + guiInfo.h - 255/zoom, 80/zoom, 80/zoom, "files/images/orgAdd.png", 0, 0, 0, tocolor(170, 170, 170, 255 * guiInfo.alpha))
                    dxDrawText("Przypisz posiadłość", guiInfo.x + (guiInfo.w - 340/zoom)/2 + 50/zoom, guiInfo.y + guiInfo.h - 165/zoom, guiInfo.x + (guiInfo.w - 340/zoom)/2 + 130/zoom, guiInfo.y + guiInfo.h, tocolor(170, 170, 170, 255 * guiInfo.alpha), 1/zoom, guiInfo.category, "center", "top")
                end
            else
                if isCursorInPosition(guiInfo.x + (guiInfo.w - 340/zoom)/2 + 50/zoom, guiInfo.y + guiInfo.h - 255/zoom, 80/zoom, 110/zoom) then
                    dxDrawImage(guiInfo.x + (guiInfo.w - 340/zoom)/2 + 50/zoom, guiInfo.y + guiInfo.h - 255/zoom, 80/zoom, 80/zoom, "files/images/orgRemove.png", 0, 0, 0, tocolor(220, 220, 220, 255 * guiInfo.alpha))
                    dxDrawText("Odpisz posiadłość", guiInfo.x + (guiInfo.w - 340/zoom)/2 + 50/zoom, guiInfo.y + guiInfo.h - 165/zoom, guiInfo.x + (guiInfo.w - 340/zoom)/2 + 130/zoom, guiInfo.y + guiInfo.h, tocolor(255, 255, 255, 255 * guiInfo.alpha), 1/zoom, guiInfo.category, "center", "top")
                else
                    dxDrawImage(guiInfo.x + (guiInfo.w - 340/zoom)/2 + 50/zoom, guiInfo.y + guiInfo.h - 255/zoom, 80/zoom, 80/zoom, "files/images/orgRemove.png", 0, 0, 0, tocolor(170, 170, 170, 255 * guiInfo.alpha))
                    dxDrawText("Odpisz posiadłość", guiInfo.x + (guiInfo.w - 340/zoom)/2 + 50/zoom, guiInfo.y + guiInfo.h - 165/zoom, guiInfo.x + (guiInfo.w - 340/zoom)/2 + 130/zoom, guiInfo.y + guiInfo.h, tocolor(170, 170, 170, 255 * guiInfo.alpha), 1/zoom, guiInfo.category, "center", "top")
                end
            end

		elseif guiInfo.houseInfo.isOwner == "org" then
			dxDrawImage(guiInfo.x + (guiInfo.w - 340/zoom)/2 + 50/zoom, guiInfo.y + guiInfo.h - 255/zoom, 80/zoom, 80/zoom, "files/images/orgAdd.png", 0, 0, 0, tocolor(120, 120, 120, 255 * guiInfo.alpha))
			dxDrawText("Przypisz organizacji", guiInfo.x + (guiInfo.w - 340/zoom)/2 + 50/zoom, guiInfo.y + guiInfo.h - 165/zoom, guiInfo.x + (guiInfo.w - 340/zoom)/2 + 130/zoom, guiInfo.y + guiInfo.h, tocolor(120, 120, 120, 255 * guiInfo.alpha), 1/zoom, guiInfo.category, "center", "top")
		end

        dxDrawImage(guiInfo.x + (guiInfo.w - 340/zoom)/2 + 210/zoom, guiInfo.y + guiInfo.h - 255/zoom, 80/zoom, 80/zoom, "files/images/build.png", 0, 0, 0, tocolor(120, 120, 120, 255 * guiInfo.alpha))
        dxDrawText("W budowie", guiInfo.x + (guiInfo.w - 340/zoom)/2 + 210/zoom, guiInfo.y + guiInfo.h - 165/zoom, guiInfo.x + (guiInfo.w - 340/zoom)/2 + 290/zoom, guiInfo.y + guiInfo.h, tocolor(120, 120, 120, 255 * guiInfo.alpha), 1/zoom, guiInfo.category, "center", "top")
    end
end

function renderAnim()
    if not guiInfo.tick then return end
    local progress = (getTickCount() - guiInfo.tick)/500
    if guiInfo.state == "opening" then
        guiInfo.alpha = interpolateBetween(0, 0, 0, 1, 0, 0, progress, "Linear")
        if progress >= 1 then
            guiInfo.alpha = 1
            guiInfo.state = "opened"
            guiInfo.tick = nil
        end

    elseif guiInfo.state == "closing" then
        guiInfo.alpha = interpolateBetween(1, 0, 0, 0, 0, 0, progress, "Linear")
        if progress >= 1 then
            guiInfo.alpha = 0
            guiInfo.state = "closed"
            guiInfo.tick = nil

            removeGui()
        end
    end
end



function click(btn, state)
    if exports.TR_dx:isResponseEnabled() then return false end

    if btn == "left" and state == "down" then
        if guiInfo.houseMenu == "menu" then
            if isCursorInPosition(guiInfo.x + guiInfo.w - 140/zoom, guiInfo.y + 95/zoom, 80/zoom, 80/zoom) then
                if guiInfo.houseInfo.owner and not guiInfo.houseInfo.isOwner then return end
                openHouseGui("pay")

            elseif isCursorInPosition(guiInfo.x + (guiInfo.w - 570/zoom)/2 + 30/zoom, guiInfo.y + guiInfo.h - 205/zoom, 80/zoom, 110/zoom) and guiInfo.houseMenu == "menu" then
                exports.TR_dx:setResponseEnabled(true)
                triggerServerEvent("playerEnterHome", resourceRoot, guiInfo.houseInfo.id)

            elseif isCursorInPosition(guiInfo.x + (guiInfo.w - 570/zoom)/2 + 170/zoom, guiInfo.y + guiInfo.h - 205/zoom, 80/zoom, 110/zoom) and guiInfo.houseInfo.isOwner then
                exports.TR_dx:setResponseEnabled(true)
                triggerServerEvent("playerCloseHome", resourceRoot, guiInfo.houseInfo.id)

            elseif isCursorInPosition(guiInfo.x + (guiInfo.w - 570/zoom)/2 + 310/zoom, guiInfo.y + guiInfo.h - 205/zoom, 80/zoom, 110/zoom) and guiInfo.houseInfo.isOwner then
                openHouseGui("settings")

            elseif isCursorInPosition(guiInfo.x + (guiInfo.w - 570/zoom)/2 + 450/zoom, guiInfo.y + guiInfo.h - 205/zoom, 80/zoom, 110/zoom) and guiInfo.houseInfo.isOwner then
                openHouseGui("organization")
            end


        elseif guiInfo.houseMenu == "settings" then
            if isCursorInPosition(guiInfo.x + (guiInfo.w - 500/zoom)/2 + 50/zoom, guiInfo.y + guiInfo.h - 255/zoom, 80/zoom, 110/zoom) then
                exports.TR_dx:setResponseEnabled(true)
                triggerServerEvent("removeHouseVisitors", resourceRoot, guiInfo.houseInfo.id)

            elseif isCursorInPosition(guiInfo.x + (guiInfo.w - 500/zoom)/2 + 210/zoom, guiInfo.y + guiInfo.h - 255/zoom, 80/zoom, 110/zoom) and guiInfo.houseInfo.isOwner == "full" then
                if getElementData(localPlayer, "cuffed") then exports.TR_noti:create("Nie możesz edytować mieszkania, ponieważ posiadasz skutą osobę.") return end
                if isElement(getElementData(localPlayer, "cuffedBy")) then exports.TR_noti:create("Nie możesz edytować mieszkania, ponieważ jesteś zakuty kajdankami.") return end
                triggerServerEvent("playerEditHome", resourceRoot, guiInfo.houseInfo.id)

            elseif isCursorInPosition(guiInfo.x + (guiInfo.w - 500/zoom)/2 + 370/zoom, guiInfo.y + guiInfo.h - 255/zoom, 80/zoom, 110/zoom) and guiInfo.houseInfo.isOwner == "full" then
                openHouseGui("exit")
            end

        elseif guiInfo.houseMenu == "organization" then
            if isCursorInPosition(guiInfo.x + (guiInfo.w - 340/zoom)/2 + 50/zoom, guiInfo.y + guiInfo.h - 255/zoom, 80/zoom, 110/zoom) and guiInfo.houseInfo.isOwner == "full" then
				exports.TR_dx:setResponseEnabled(true)
                triggerServerEvent("bindHouseToOrganization", resourceRoot, guiInfo.houseInfo.id, guiInfo.houseInfo.orgID)
            end
        end


    -- if isCursorInPosition(guiInfo.x + guiInfo.w - 160/zoom, guiInfo.y + 50/zoom, 80/zoom, 80/zoom) and guiInfo.houseMenu == "menu" and (not guiInfo.houseInfo.owner or guiInfo.houseInfo.isOwner) then
    --   openHouseGui("pay")
    -- else
    -- elseif isCursorInPosition(guiInfo.x + 250/zoom, guiInfo.y + 190/zoom, 100/zoom, 100/zoom) and guiInfo.houseMenu == "menu" and guiInfo.houseInfo.isOwner then
    --   exports.TR_dx:setResponseEnabled(true)
    --   triggerServerEvent("playerCloseHome", resourceRoot, guiInfo.houseInfo.id)
    -- elseif isCursorInPosition(guiInfo.x + 425/zoom, guiInfo.y + 190/zoom, 100/zoom, 100/zoom) and guiInfo.houseMenu == "menu" and guiInfo.houseInfo.isOwner then
    --   openHouseGui("settings")
    -- elseif isCursorInPosition(guiInfo.x + 75/zoom, guiInfo.y + 130/zoom, 100/zoom, 100/zoom) and guiInfo.houseMenu == "settings" then
    --   exports.TR_dx:setResponseEnabled(true)
    --   triggerServerEvent("removeHouseVisitors", resourceRoot, guiInfo.houseInfo.id)
    -- elseif isCursorInPosition(guiInfo.x + 250/zoom, guiInfo.y + 130/zoom, 100/zoom, 100/zoom) and guiInfo.houseMenu == "settings" then
    --   exports.TR_dx:setResponseEnabled(true)
    --   triggerServerEvent("setHouseEmpty", resourceRoot, guiInfo.houseInfo.id)
    -- elseif isCursorInPosition(guiInfo.x + 425/zoom, guiInfo.y + 130/zoom, 100/zoom, 100/zoom) and guiInfo.houseMenu == "settings" then
    --   if getElementData(localPlayer, "cuffed") then exports.TR_noti:create("Nie możesz edytować mieszkania, ponieważ posiadasz skutą osobę.") return end
    --   if isElement(getElementData(localPlayer, "cuffedBy")) then exports.TR_noti:create("Nie możesz edytować mieszkania, ponieważ jesteś zakuty kajdankami.") return end
    --   triggerServerEvent("playerEditHome", resourceRoot, guiInfo.houseInfo.id)
    -- end
    end
end


function buyHouse()
    if guiInfo.houseInfo.owner and not guiInfo.houseInfo.isOwner then
        exports.TR_noti:create("Nie możesz przedłużyć tej posiadłości.", "error")
        return
    end

    local days = guiGetText(guiInfo.houseBuyTime)
    if tonumber(days) ~= nil and tonumber(days) > 0 then
        local toPay = guiInfo.houseInfo.price * days
        if not canBuyHouse() then return end
        if not canBuyMoreHouses() then return end

        exports.TR_dx:setResponseEnabled(true)
        triggerServerEvent("createPayment", resourceRoot, toPay, "playerPayForHome", {days, guiInfo.houseInfo.id})
    else
        exports.TR_noti:create("Wprowadzona ilość dni jest nieprawidłowa.", "error")
    end
end

function canBuyMoreHouses()
    if guiInfo.houseInfo.isOwner then return true end
    local plrData = getElementData(localPlayer, "characterData")
    local limit = guiInfo.houseLimit
    local text = "Osiągnąłeś limit posiadłości. Aby zakupić więcej, ulepsz swoje konto lub kup większą pojemność."

    if plrData.premium == "gold" then
        limit = limit + 3

    elseif plrData.premium == "diamond" then
        limit = limit + 5
        text = "Osiągnąłeś limit posiadłości."
    end

    if guiInfo.houseCount >= limit then
        exports.TR_noti:create(text, "error")
        return false
    end
    return true
end

function canBuyHouse()
    if guiInfo.houseInfo.premium then
        local plrData = getElementData(localPlayer, "characterData")
        if plrData.premium ~= "diamond" then
            exports.TR_noti:create("Ta posiadłość przeznaczona jest tylko dla graczy Diamond.", "error")
            return false
        end
    end
    return true
end

function buttonClick(btn)
    if exports.TR_dx:isResponseEnabled() then return end

    if btn == guiInfo.houseClose then
        closeGui()

    elseif btn == guiInfo.houseBuyButton then
        buyHouse()

    elseif btn == guiInfo.houseBack then
        openHouseGui("menu")

    elseif btn == guiInfo.exitBack then
        openHouseGui("settings")

    elseif btn == guiInfo.exitAccept then
        exports.TR_dx:setResponseEnabled(true)
        triggerServerEvent("setHouseEmpty", resourceRoot, guiInfo.houseInfo.id)
    end
end

function openGui(info, houses, houseLimit)
    if guiInfo.open then return end
    if not exports.TR_dx:canOpenGUI() then return end
    if isElement(getElementData(localPlayer, "cuffedBy")) then return end
    exports.TR_hud:setHudVisible(false)
    exports.TR_chat:showCustomChat(false)
    exports.TR_dx:setOpenGUI(true)

    guiInfo.open = true
    buildHouseInfo(info)
    guiInfo.houseLimit = houseLimit
    guiInfo.houseCount = houses

    guiInfo.fontName = exports.TR_dx:getFont(16)
    guiInfo.fontLogo = exports.TR_dx:getFont(14)
    guiInfo.normal = exports.TR_dx:getFont(13)
    guiInfo.category = exports.TR_dx:getFont(11)

    guiInfo.exitBack = exports.TR_dx:createButton(guiInfo.x + guiInfo.w/2 - 205/zoom, guiInfo.y + 300/zoom, 200/zoom, 40/zoom, "Anuluj", "grey")
    guiInfo.exitAccept = exports.TR_dx:createButton(guiInfo.x + guiInfo.w/2 + 5/zoom, guiInfo.y + 300/zoom, 200/zoom, 40/zoom, "Wyprowadź się", "blue")

    guiInfo.houseBuyTime = exports.TR_dx:createEdit(guiInfo.x + (guiInfo.w - 270/zoom)/2, guiInfo.y + 300/zoom, 270/zoom, 40/zoom, "Ilość dni", false)
    guiInfo.houseBuyButton = exports.TR_dx:createButton(guiInfo.x + (guiInfo.w - 200/zoom)/2, guiInfo.y + 350/zoom, 200/zoom, 40/zoom, "Zapłać", "blue")

    guiInfo.houseClose = exports.TR_dx:createButton(guiInfo.x + (guiInfo.w - 200/zoom)/2, guiInfo.y + guiInfo.h - 60/zoom, 200/zoom, 40/zoom, "Zamknij", "grey")
    guiInfo.houseBack = exports.TR_dx:createButton(guiInfo.x + (guiInfo.w - 200/zoom)/2, guiInfo.y + guiInfo.h - 60/zoom, 200/zoom, 40/zoom, "Wróć", "grey")

    exports.TR_dx:setEditVisible(guiInfo.houseBuyTime, false)
    exports.TR_dx:setEditLimit(guiInfo.houseBuyTime, 6)
    exports.TR_dx:setButtonVisible({guiInfo.houseBuyButton, guiInfo.houseClose, guiInfo.houseBack, guiInfo.exitBack, guiInfo.exitAccept}, false)
    exports.TR_dx:showButton(guiInfo.houseClose)

    guiInfo.houseMenu = "menu"
    guiInfo.houseMenuSelected = nil

    guiInfo.alpha = 0
    guiInfo.state = "opening"
    guiInfo.tick = getTickCount()

    addEventHandler("onClientRender", root, render)
    addEventHandler("onClientClick", root, click)
    addEventHandler("guiButtonClick", root, buttonClick)
    showCursor(true)
end
addEvent("openHouseGuiInfo", true)
addEventHandler("openHouseGuiInfo", root, openGui)

function closeGui(loading)
    if not guiInfo.open then return end
    if loading then exports.TR_dx:showLoading(5000, loading) end

    guiInfo.alpha = guiInfo.alpha
    guiInfo.state = "closing"
    guiInfo.tick = getTickCount()

    exports.TR_dx:hideEdit(guiInfo.houseBuyTime)
    exports.TR_dx:hideButton({guiInfo.houseBuyButton, guiInfo.houseClose, guiInfo.houseBack, guiInfo.exitBack, guiInfo.exitAccept})

	exports.TR_hud:setHudVisible(true)
	exports.TR_chat:showCustomChat(true)

    removeEventHandler("onClientClick", root, click)
    removeEventHandler("guiButtonClick", root, buttonClick)
end
addEvent("closeHouseGuiInfo", true)
addEventHandler("closeHouseGuiInfo", root, closeGui)

function removeGui()
    if not guiInfo.open then return end
    exports.TR_dx:setOpenGUI(false)

    guiInfo.open = nil

    setTimer(function()
        guiInfo.fontName = nil
        guiInfo.fontLogo = nil
        guiInfo.normal = nil
        guiInfo.category = nil
    end, 50, 1)

    for i, v in pairs(guiInfo.images) do
        destroyElement(v)
    end
    guiInfo.images = {}

    exports.TR_dx:destroyButton({guiInfo.houseBuyButton, guiInfo.houseClose, guiInfo.houseBack, guiInfo.exitBack, guiInfo.exitAccept})
    exports.TR_dx:destroyEdit(guiInfo.houseBuyTime)

    removeEventHandler("onClientRender", root, render)
    showCursor(false)
end


function openHouseGui(tab)
    exports.TR_dx:setEditVisible(guiInfo.houseBuyTime, false)
    exports.TR_dx:setButtonVisible({guiInfo.houseBuyButton, guiInfo.houseClose, guiInfo.houseBack, guiInfo.exitBack, guiInfo.exitAccept}, false)

    if tab == "menu" then
        exports.TR_dx:setButtonVisible(guiInfo.houseClose, true)

    elseif tab == "pay" then
        exports.TR_dx:setEditVisible(guiInfo.houseBuyTime, true)
        exports.TR_dx:setButtonVisible({guiInfo.houseBuyButton, guiInfo.houseBack}, true)

    elseif tab == "settings" then
        exports.TR_dx:setButtonVisible({guiInfo.houseBack}, true)

    elseif tab == "organization" then
        exports.TR_dx:setButtonVisible({guiInfo.houseBack}, true)

    elseif tab == "exit" then
        exports.TR_dx:setButtonVisible({guiInfo.exitBack, guiInfo.exitAccept}, true)
    end

    guiInfo.houseMenu = tab
end


function updateDataGui(info)
    if not guiInfo.open then return end
    if info == "close" then exports.TR_dx:setResponseEnabled(false); closeGui() return end
    if info then buildHouseInfo(info) end

    exports.TR_dx:setResponseEnabled(false)
    guiInfo.houseMenuSelected = nil
end
addEvent("updateHouseGuiInfo", true)
addEventHandler("updateHouseGuiInfo", root, updateDataGui)

function buildHouseInfo(info)
    guiInfo.houseInfo = {
        id = info.ID,
        name = getHouseNameFromSize(info.interiorSize),
        ownerName = info.owner and info.ownerName or "Brak",
        owner = info.owner,
        price = info.price,
        interiorSize = info.interiorSize,
        date = info.date and formatDate(info.date) or "",
        locked = info.locked,
        rent = info.rent,
        premium = info.premium,
        isOwner = isHouseOwner(info),
		place = getZoneName(Vector3(getElementPosition(localPlayer))),
		orgName = info.orgName or false,
		orgID = info.orgID or false,
    }

    if isElement(guiInfo.images.orgLogo) then
        destroyElement(guiInfo.images.orgLogo)
        guiInfo.images.orgLogo = nil
    end

	if guiInfo.houseInfo.orgID then
		local orgImg = exports.TR_orgLogos:getLogo(guiInfo.houseInfo.orgID)
        if not orgImg then return end
        if guiInfo.images.orgLogo then return end
		guiInfo.images.orgLogo = dxCreateTexture(orgImg, "argb", true, "clamp")
	end
end

function isHouseOwner(info)
    if tonumber(info.owner) == tonumber(getElementData(localPlayer, "characterUID")) then return "full" end

    local plrName = getPlayerName(localPlayer)
    for i, v in ipairs(info.rent) do
        if v.username == plrName then
            return "org"
        end
    end

	if getElementData(localPlayer, "characterOrgID") == info.orgID then return "org" end
	return false
end

function getHouseNameFromSize(interiorSize)
    interiorSize = tonumber(interiorSize)

    if interiorSize >= 15 then return "Willa" end
    if interiorSize >= 12 and interiorSize < 15 then return "Dom wielorodzinny" end
    if interiorSize >= 8 and interiorSize < 12 then return "Dom dwurodzinny" end
    if interiorSize < 8 then return "Dom jednorodzinny" end
end





-- Utils
function isCursorInPosition(psx, psy, pssx, pssy)
    if not isCursorShowing() then return end
    cx, cy = getCursorPosition()
    cx, cy = cx * sx, cy * sy
    if cx >= psx and cx <= psx + pssx and cy >= psy and cy <= psy + pssy then
        return true, cx, cy
    else
        return false
    end
end

function drawBackground(x, y, rx, ry, color, radius, post)
    rx = rx - radius * 2
    ry = ry - radius * 2
    x = x + radius
    y = y + radius

    if (rx >= 0) and (ry >= 0) then
        dxDrawRectangle(x, y, rx, ry, color, post)
        dxDrawRectangle(x, y + ry, rx, radius, color, post)
        dxDrawRectangle(x - radius, y, radius, ry, color, post)
        dxDrawRectangle(x + rx, y, radius, ry, color, post)

        dxDrawCircle(x + rx, y + ry, radius, 0, 90, color, color, 7, 1, post)
        dxDrawCircle(x, y + ry, radius, 90, 180, color, color, 7, 1, post)
    end
end

function drawRoundedBackground(x, y, rx, ry, color, radius, post)
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

function formatDate(date)
    local d = split(date, " ")
    local d1 = split(d[1], "-")
    local d2 = split(d[2], ":")
    return string.format("%s:%s %s.%s.%sr.", d2[1], d2[2], d1[3], d1[2], d1[1])
end


exports.TR_dx:setResponseEnabled(false)
exports.TR_dx:setOpenGUI(false)
