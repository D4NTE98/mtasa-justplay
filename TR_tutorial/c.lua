local sx, sy = guiGetScreenSize()
local zoom = 1
local baseX = 1900
local minZoom = 2
if sx < baseX then
  zoom = math.min(minZoom, baseX/sx)
end

local guiInfo = {
    x = 0,
    y = (sy - 90/zoom)/2,
    w = 260/zoom,
    h = 90/zoom,

    buttonTime = 10,

    int = 0,
    dim = 0,
}

Tutorial = {}
Tutorial.__index = Tutorial

function Tutorial:create(...)
    local instance = {}
    setmetatable(instance, Tutorial)
    if instance:constructor(...) then
        return instance
    end
    return false
end

function Tutorial:constructor(...)
    self.alpha = 0
    self.tab = 0

    self.buttonTick = getTickCount()
    self.buttonTime = guiInfo.buttonTime

    self.fonts = {}
    self.fonts.title = exports.TR_dx:getFont(16)
    self.fonts.distance = exports.TR_dx:getFont(14)
    self.fonts.info = exports.TR_dx:getFont(12)
    self.fonts.action = exports.TR_dx:getFont(11)

    self.buttons = {}
    self.buttons.next = exports.TR_dx:createButton((sx - 200/zoom)/2, 580/zoom, 200/zoom, 40/zoom, string.format("%ss", self.buttonTime))

    self.func = {}
    self.func.renderHigh = function() self:renderHigh() end
    self.func.renderNormal = function() self:renderNormal() end
    self.func.markerEnter = function(...) self:markerEnter(...) end
    self.func.buttonClick = function(...) self:buttonClick(...) end

    self:open()
    return true
end

function Tutorial:open()
    exports.TR_dx:setOpenGUI(true)
    exports.TR_chat:setChatBlocked(true)

    exports.TR_hud:createGUI()
    exports.TR_chat:createChat(500)

    self.state = "opening"
    self.tick = getTickCount()

    self:setControl(false)

    showCursor(true)
    setCameraTarget(localPlayer)
    addEventHandler("onClientRender", root, self.func.renderHigh, false, "high+4")
    addEventHandler("onClientRender", root, self.func.renderNormal)
    addEventHandler("guiButtonClick", root, self.func.buttonClick)
    addEventHandler("onClientColShapeHit", resourceRoot, self.func.markerEnter)

    triggerServerEvent("spawnPlayerCharacter", resourceRoot, string.format("-4643.36,353.66,4.34,%d,%d", guiInfo.int, guiInfo.dim), 260)

    setTimer(function()
        exports.TR_dx:hideLoading()
    end, 4000, 1)
end

function Tutorial:close()
    self.state = "closing"
    self.tick = getTickCount()

    if isElement(self.marker) then destroyElement(self.marker) end

    showCursor(false)
    self:setControl(true)
end

function Tutorial:destroy()
    exports.TR_dx:setOpenGUI(false)
    exports.TR_chat:setChatBlocked(false)

    removeEventHandler("onClientRender", root, self.func.renderHigh)
    removeEventHandler("onClientRender", root, self.func.renderNormal)
    removeEventHandler("guiButtonClick", root, self.func.buttonClick)
    removeEventHandler("onClientColShapeHit", resourceRoot, self.func.markerEnter)
    guiInfo.tutorial = nil
    self = nil
end


function Tutorial:animate()
    if not self.tick then return end
    local progress = (getTickCount() - self.tick)/500
    if self.state == "opening" then
      self.alpha = interpolateBetween(0, 0, 0, 1, 0, 0, progress, "Linear")
      if progress >= 1 then
        self.alpha = 1
        self.state = "opened"
        self.tick = nil
      end

    elseif self.state == "closing" then
      self.alpha = interpolateBetween(1, 0, 0, 0, 0, 0, progress, "Linear")
      if progress >= 1 then
        self.alpha = 0
        self.state = "closed"
        self.tick = nil

        if self.tab == 28 then
            self:destroy()
            return true
        end
      end
    end
end

function Tutorial:renderNormal()
    if self.tab == 0 then
        dxDrawRectangle(0, 0, sx, sy, tocolor(7, 7, 7, 240 * self.alpha))

        dxDrawText("Pierwsze kroki", 0, 350/zoom, sx, sy, tocolor(212, 175, 55, 255 * self.alpha), 1/zoom, self.fonts.title, "center", "top")
        dxDrawText("Zanim rozpoczniesz rozgrywkę na naszym serwerze, chcielibyśmy nauczyć Cię podstawowych funkcji. Jeżeli jesteś nowy na tego typu serwerze, nic się nie bój, ponieważ wytłumaczymy Ci wszystkie podstawowe funkcje, a reszty możesz nauczyć się od innych graczy. Nie bój się pytać. Jeśli jednak jesteś już na kolejnym serwerze tego typu, poradnik ten pokaże Ci jak rozpocząć rozgrywkę i nie zgubić się w interfejsach i podstawowych systemach.", (sx - 500/zoom)/2, 390/zoom, (sx + 500/zoom)/2, sy, tocolor(180, 180, 180, 255 * self.alpha), 1/zoom, self.fonts.info, "center", "top", false, true)

    elseif self.tab == 1 then
        dxDrawRectangle(0, 0, sx - 340/zoom, 250/zoom, tocolor(7, 7, 7, 240 * self.alpha))
        dxDrawRectangle(0, 250/zoom, sx, sy, tocolor(7, 7, 7, 240 * self.alpha))

        dxDrawText("Główny interfejs", sx - 700/zoom, 20/zoom, sx - 340/zoom, guiInfo.y + 25/zoom, tocolor(212, 175, 55, 255 * self.alpha), 1/zoom, self.fonts.title, "center", "top")
        dxDrawText("W tym miejscu wyświetlane są najważniejsze informacje o naszej postaci. Znajdziesz tutaj między innymi:\n- Poziom życia\n- Stan kamizelki kuloodpornej\n- Ilość powietrza podczas nurkowania\n- Posiadane przy sobie pieniądze", sx - 700/zoom, 60/zoom, sx - 340/zoom, guiInfo.y + 25/zoom, tocolor(180, 180, 180, 255 * self.alpha), 1/zoom, self.fonts.info, "left", "top", false, true)

    elseif self.tab == 2 then
        dxDrawRectangle(0, 0, sx, sy - 250/zoom, tocolor(7, 7, 7, 240 * self.alpha))
        dxDrawRectangle(450/zoom, sy - 250/zoom, sx, 250/zoom, tocolor(7, 7, 7, 240 * self.alpha))

        dxDrawText("Minimapa", 450/zoom, sy - 320/zoom, 800/zoom, sy, tocolor(212, 175, 55, 255 * self.alpha), 1/zoom, self.fonts.title, "center", "top")
        dxDrawText("W tym miejscu znajduje się mapa okolicy, w której się aktualnie znajdujesz. Możesz ją dowolnie przybliżać bądź oddalać korzystając z klawiszy \"+\" oraz \"-\". Pomoże Ci ona w odnalezieniu się w aktualnej dzielnicy, jak i w znalezieniu najważniejszych obiektów, takich jak na przykład:\n- Wejścia do budynków\n- Rozpoczęcia prac\n- Postrunek policji, straży czy szpital. ", 450/zoom, sy - 280/zoom, 800/zoom, sy, tocolor(180, 180, 180, 255 * self.alpha), 1/zoom, self.fonts.info, "left", "top", false, true)

    elseif self.tab == 3 then
        dxDrawRectangle(570/zoom, 0, sx, 380/zoom, tocolor(7, 7, 7, 240 * self.alpha))
        dxDrawRectangle(0, 380/zoom, sx, sy, tocolor(7, 7, 7, 240 * self.alpha))

        dxDrawText("Chat", 550/zoom, 20/zoom, 1000/zoom, sy, tocolor(212, 175, 55, 255 * self.alpha), 1/zoom, self.fonts.title, "center", "top")
        dxDrawText("Tutaj znajduje się główny system komunikacji pomiędzy graczami. Wszystko co napiszesz na zwykłym chacie będzie widoczne dla ludzi znajdujących się wokoło. Aby skorzystać z jednej z dostępnych komend wystarczy rozpocząć wiadomość używając znaku \"/\". Po wpisaniu pierwszej litery, system podpowie nam pełną składnię danej komendy, oraz wytłumaczy nam co ona robi. Naciskając \"TAB\" podczas pisania komend system automatycznie uzupełni nam komendę do końca. W przypadku wpisywania nicku gracza w stosunku do którego chcemy wykonać komendę dokończy on za nas pisanie jego nicku.\nRodzajów chatu jest kilka, mianowicie:\n- T - podstawowy chat dla ludzi wokół ciebie\n- O - chat organizacyjny\n- Y - chat w obrębie swojej frakcji\n- U - chat międzyfrakcyjny", 550/zoom, 60/zoom, 1000/zoom, sy, tocolor(180, 180, 180, 255 * self.alpha), 1/zoom, self.fonts.info, "left", "top", false, true)

    elseif self.tab == 4 then
        dxDrawRectangle(0, 0, sx - 360/zoom, sy, tocolor(7, 7, 7, 240 * self.alpha))
        dxDrawRectangle(sx - 360/zoom, 0, 360, sy/2 - 150/zoom, tocolor(7, 7, 7, 240 * self.alpha))
        dxDrawRectangle(sx - 360/zoom, sy/2 + 150/zoom, 360, sy/2 - 150/zoom, tocolor(7, 7, 7, 240 * self.alpha))

        dxDrawText("Okno celu", sx - 740/zoom, sy/2 - 120/zoom, sx - 360/zoom, sy, tocolor(212, 175, 55, 255 * self.alpha), 1/zoom, self.fonts.title, "center", "top")
        dxDrawText("Może i brzmi groźnie, ale nie chodzi tu o przemoc. W tym oknie wyświetlany jest aktualny cel, np. podczas pracy. Jeśli nie będziesz wiedzieć co masz zrobić, spójrz w to miejsce a wszystkiego się dowiesz. Dodatkowo możesz sprawdzić ile czasu upłynęło od rozpoczęcia danej pracy.", sx - 740/zoom, sy/2 - 80/zoom, sx - 360/zoom, sy, tocolor(180, 180, 180, 255 * self.alpha), 1/zoom, self.fonts.info, "left", "top", false, true)

    elseif self.tab == 5 then
        dxDrawRectangle(0, 0, sx, sy, tocolor(7, 7, 7, 240 * self.alpha))

        dxDrawText("Oznaczenie celu", 0, sy/2 - 185/zoom, sx, sy, tocolor(212, 175, 55, 255 * self.alpha), 1/zoom, self.fonts.title, "center", "top")

        dxDrawImage((sx - 64/zoom)/2, sy/2 - 140/zoom, 64/zoom, 64/zoom, ":TR_jobs/files/images/target.png", 0, 0, 0, tocolor(255, 60, 60, 255 * self.alpha))
        dxDrawText("10m", (sx - 64/zoom)/2, sy/2 - 70/zoom, (sx + 64/zoom)/2, sy, tocolor(180, 180, 180, 255 * self.alpha), 1/zoom, self.fonts.distance, "center", "top", false, true)
        dxDrawText("Udaj się we wskazane miejsce", (sx - 300/zoom)/2, sy/2 - 48/zoom, (sx + 300/zoom)/2, sy, tocolor(180, 180, 180, 255 * self.alpha), 1/zoom, self.fonts.action, "center", "top", false, true)

        dxDrawText("Ten symbol oznacza aktualne miejsce docelowe. Będziesz go widzieć niezależnie od tego jak daleko się od niego znajdujesz. Dzięki niemu łatwiej będzie Ci odnaleźć trasę do punktu docelowego. Pod samym symbolem ujrzysz swoją odległość od celu oraz krótki tekst informujący o czynności.", (sx - 600/zoom)/2, sy/2 - 10/zoom, (sx + 600/zoom)/2, sy, tocolor(180, 180, 180, 255 * self.alpha), 1/zoom, self.fonts.info, "center", "top", false, true)


    elseif self.tab == 6 or self.tab == 7 then
        dxDrawRectangle(0, 0, sx, sy, tocolor(7, 7, 7, 240 * self.alpha))

        dxDrawText("Interaktywna nauka", 0, 370/zoom, sx, sy, tocolor(212, 175, 55, 255 * self.alpha), 1/zoom, self.fonts.title, "center", "top")
        dxDrawText("Najprościej jest się uczyć na własnych błędach. Teraz przeprowadzimy Cię przez interaktywny samouczek, który pokaże Ci jak korzystać z najważniejszych systemów na serwerze. Dzięki poświęceniu chwili w tym momencie, Twoja przyszła rozgrywka stanie się czystą przyjemnością. Wszystkie systemy zostały przygotowane właśnie z myślą o Tobie - graczu. Postawiliśmy na prostotę tak, aby wszystko co chcesz zrobić było dostępne w jednym miejscu, a ty nie musiał zaprzątać sobie głowy masą komend.", (sx - 500/zoom)/2, 410/zoom, (sx + 500/zoom)/2, sy, tocolor(180, 180, 180, 255 * self.alpha), 1/zoom, self.fonts.info, "center", "top", false, true)

    elseif self.tab == 8 then
        local anim, block = getPedAnimation(localPlayer)
        if anim and block then
            if string.lower(anim) == "" and string.lower(anim) == "" then
                self:setNextState()
            end
        end

    elseif self.tab == 16 or self.tab == 17 then -- Phone help
        dxDrawRectangle(550/zoom, 0, sx, sy, tocolor(7, 7, 7, 240 * self.alpha))
        dxDrawRectangle(0, sy/2, 550/zoom, sy/2, tocolor(7, 7, 7, 240 * self.alpha))

        dxDrawText("Telefon komórkowy", sx - 740/zoom, sy - 547/zoom, sx - 360/zoom, sy, tocolor(212, 175, 55, 255 * self.alpha), 1/zoom, self.fonts.title, "center", "top")
        dxDrawText("Może i posiadasz stary model telefonu, ale nie oznacza to, że jest on bezużyteczny. Poza wysyłaniem wiadomości SMS poprzez wykorzystanie chatu, możesz również do kogoś zadzwonić. Po co? Otóż przez połączenie można rozmawiać korzystając z wbudowanego chatu głosowego. Rozmowa z innymi graczami nie jest jednak jedyną opcją. W razie pożaru, strzelaniny czy wypadku samochodowego zawsze możesz wezwać odpowiednie służby. Jeśli natomiast okaże się, że nie masz żadnego pojazdu blisko siebie, możesz zadzwonić po taxi.", sx - 740/zoom, sy - 507/zoom, sx - 360/zoom, sy, tocolor(180, 180, 180, 255 * self.alpha), 1/zoom, self.fonts.info, "left", "top", false, true)

        dxDrawText("Interaktywny samouczek", sx - 740/zoom, sy - 200/zoom, sx - 360/zoom, sy, tocolor(212, 175, 55, 255 * self.alpha), 1/zoom, self.fonts.title, "center", "top")
        dxDrawText("Wybierz numer, który podał ci brat Dawn'a, naciskając LPM na przyciski znajdujące się na klawiaturze telefonu, aby pchnąć samouczek dalej. Jeśli nie wiesz gdzie go znaleźć spójrz na chat.", sx - 740/zoom, sy - 160/zoom, sx - 360/zoom, sy, tocolor(180, 180, 180, 255 * self.alpha), 1/zoom, self.fonts.info, "left", "top", false, true)


    elseif self.tab == 21 or self.tab == 22 then -- Eq help
        dxDrawRectangle(0, 0, sx, sy, tocolor(7, 7, 7, 240 * self.alpha))

        dxDrawText("Ekwipunek postaci", sx - 1050/zoom, (sy - 450/zoom)/2, sx - 650/zoom, sy, tocolor(212, 175, 55, 255 * self.alpha), 1/zoom, self.fonts.title, "center", "top")
        dxDrawText("Twoja postać wszystkie zdobyte/zakupione przedmioty przetrzymuje w ekwipunku. W każdej chwili możesz skorzystać z jednego z nich, jeśli tylko będzie ci potrzebny. Wszystkie przedmioty zostały podzielone na 5 kategorii tak, aby łatwiej było odnaleźć ten, na którym nam zależy. Dodatkowo jeśli chcesz mieć szybszy dostęp do przedmiotów, kórych używasz często, możesz je zawsze dodać do zakładki \"ulubione\", dzięki czemu ich znalezienie będzie super szybkie i wygodne. Aby zobaczyć wszystkie opcje danego przedmiotu wystarczy nacisnąć na niego PPM.", sx - 1050/zoom, (sy - 450/zoom)/2 + 40/zoom, sx - 650/zoom, sy, tocolor(180, 180, 180, 255 * self.alpha), 1/zoom, self.fonts.info, "left", "top", false, true)

        dxDrawText("Interaktywny samouczek", sx - 1050/zoom, (sy - 450/zoom)/2 + 350/zoom, sx - 650/zoom, sy, tocolor(212, 175, 55, 255 * self.alpha), 1/zoom, self.fonts.title, "center", "top")
        dxDrawText("Odnajdź twoją działkę w zakładce \"Inne\", naciśnij na nią PPM i wybierz opcję \"Użyj\".", sx - 1050/zoom, (sy - 450/zoom)/2 + 390/zoom, sx - 650/zoom, sy, tocolor(180, 180, 180, 255 * self.alpha), 1/zoom, self.fonts.info, "left", "top", false, true)


    elseif self.tab == 25 or self.tab == 26 then -- Trade help
        dxDrawRectangle(0, 0, sx, sy, tocolor(7, 7, 7, 240 * self.alpha))

        dxDrawText("Okno handlu", 300/zoom, (sy - 450/zoom)/2, sx/2 - 320/zoom, sy, tocolor(212, 175, 55, 255 * self.alpha), 1/zoom, self.fonts.title, "center", "top")
        dxDrawText("Jak sama nazwa wskazuje, jest to system handlu przedmiotami. Jeśli masz jakiś unikalny przedmiot bądź chcesz zakupić coś od gracza bez strachu, że oszuka cię na przedmioty - możesz to zrobić poprzez okno handlu. Po otwarciu okna należy w swoim ekwipunku odnaleźć przedmiot, który chcemy sprzedać, a następnie nacisnąć na niego PPM i wybrać opcję \"Zaoferuj przedmiot\". Aby zobaczyć szczegółowe informacje o przedmiocie wystawionym na handel naciśnij na niego PPM.\nPotwierdzenie transakcji odbywa się w dwóch etapach. Za pierwszym razem członkowie tracą możliwość edycji. Jest to idealna pora aby przejrzeć wszystkie przedmioty. Po następnym potwierdzeniu obu stron nie ma już odwrotu - transakcja zakończy się pomyślnie.", 300/zoom, (sy - 450/zoom)/2 + 40/zoom, sx/2 - 320/zoom, sy, tocolor(180, 180, 180, 255 * self.alpha), 1/zoom, self.fonts.info, "left", "top", false, true)

        dxDrawText("Interaktywny samouczek", sx - 600/zoom, (sy + 380/zoom)/2, sx, sy, tocolor(212, 175, 55, 255 * self.alpha), 1/zoom, self.fonts.title, "center", "top")
        dxDrawText("Wejdź w zakładkę \"Inne\", znajdź działkę która należy się przewoźnikowi, naciśnij PPM i wybierz opcję \"Zaoferuj przedmiot\". Teraz pozostało tylko zaakceptować transakcję, poczekać aż Matthew również ją zaakceptuje i dobić targu!", sx - 500/zoom, (sy + 380/zoom)/2 + 40/zoom, sx - 100/zoom, sy, tocolor(180, 180, 180, 255 * self.alpha), 1/zoom, self.fonts.info, "left", "top", false, true)


    -- Last
    elseif self.tab == 27 or self.tab == 28 then
        dxDrawRectangle(0, 0, sx, sy, tocolor(7, 7, 7, 240 * self.alpha))

        dxDrawText("Pora na przygodę", 0, 370/zoom, sx, sy, tocolor(212, 175, 55, 255 * self.alpha), 1/zoom, self.fonts.title, "center", "top")
        dxDrawText("To by było na tyle z podstawowych funkcji, jakie znajdziesz na serwerze. Mamy nadzieję, że ten krótki poradnik pomoże Ci postawić pierwsze kroki, oraz dzięki niemu nie zgubisz się nigdy w żadnym interfejsie. Oczywiście nie zostały tutaj przedstawione wszystkie dostępne na serwerze systemy, ale zostawiamy też coś Tobie do odkrycia samemu!\n\nNie pozostaje nam nic więcej niż życzyć Ci miłej rozgrywki.\nAdministracja, Just Play.", (sx - 500/zoom)/2, 410/zoom, (sx + 500/zoom)/2, sy, tocolor(180, 180, 180, 255 * self.alpha), 1/zoom, self.fonts.info, "center", "top", false, true)
    end

    self:checkButton()
end

function Tutorial:renderHigh()
    if self:animate() then return end

    if self.tab == 1 then -- HUD
        dxDrawRectangle(sx - 340/zoom, 0, 340/zoom, 250/zoom, tocolor(7, 7, 7, 240 * self.alpha))

    elseif self.tab == 2 then -- Minimap
        dxDrawRectangle(0, sy - 250/zoom, 450/zoom, 250/zoom, tocolor(7, 7, 7, 240 * self.alpha))

    elseif self.tab == 3 then -- Chat
        dxDrawRectangle(0, 0, 570/zoom, 380/zoom, tocolor(7, 7, 7, 240 * self.alpha))

    elseif self.tab == 4 then -- Work info
        dxDrawRectangle(sx - 360/zoom, sy/2 - 150/zoom, 360/zoom, 300/zoom, tocolor(7, 7, 7, 240 * self.alpha))

    elseif self.tab == 16 or self.tab == 17 then -- Phone help
        dxDrawRectangle(0, 0, 550/zoom, sy/2, tocolor(7, 7, 7, 240 * self.alpha))
    end

    -- exports.TR_dx:setOpenGUI(true)
    -- exports.TR_chat:setChatBlocked(true)
end


function Tutorial:checkButton()
    if not self.buttonTick or not isElement(self.buttons.next) then return end
    if (getTickCount() - self.buttonTick)/1000 >= 1 then
        self.buttonTime = self.buttonTime - 1
        self.buttonTick = nil

        if self.buttonTime == 0 then
            exports.TR_dx:setButtonText(self.buttons.next, self.tab == 27 and "Rozpocznij przygodę!" or "Rozumiem")

        else
            self.buttonTick = getTickCount()
            exports.TR_dx:setButtonText(self.buttons.next, self.tab == 27 and string.format("Rozpoczęcie przygody za %ss", self.buttonTime) or string.format("%ss", self.buttonTime))
        end
    end
end



function Tutorial:setNextState()
    self.tab = self.tab + 1

    self.buttonTime = guiInfo.buttonTime
    self.buttonTick = getTickCount()

    if isElement(self.marker) then destroyElement(self.marker) end
    if isElement(self.buttons.next) then exports.TR_dx:destroyButton(self.buttons.next) end
    self:createDataForState()
end

function Tutorial:createDataForState()
    if self.tab == 1 then
        self.buttons.next = exports.TR_dx:createButton(sx - 700/zoom - (sx - (sx + 700/zoom) + 200/zoom)/2, 230/zoom, 200/zoom, 40/zoom, string.format("%ss", self.buttonTime))
        exports.TR_hud:setGUITutorial(true)

    elseif self.tab == 2 then
        self.buttons.next = exports.TR_dx:createButton(450/zoom + 75/zoom, sy - 50/zoom, 200/zoom, 40/zoom, string.format("%ss", self.buttonTime))
        exports.TR_hud:setGUITutorial(false)

    elseif self.tab == 3 then
        self.buttons.next = exports.TR_dx:createButton(570/zoom + 125/zoom, 450/zoom, 200/zoom, 40/zoom, string.format("%ss", self.buttonTime))

        local plrUID = getElementData(localPlayer, "characterUID")
        setElementData(localPlayer, "tempUID", plrUID)
        setElementData(localPlayer, "characterUID", nil)
        exports.TR_dx:showLoading(9999999, "Wczytywanie wyboru spawnu")

        self:close()
        triggerServerEvent("endTutorial", resourceRoot, plrUID)
        triggerServerEvent("openPlayerSpawnSelect", resourceRoot)

    elseif self.tab == 4 then
        exports.TR_jobs:createInformation("Samouczek Interaktywny", "Ukończ samouczek.")
        self.buttons.next = exports.TR_dx:createButton(sx - (740 - 360)/2/zoom - 460/zoom, 610/zoom, 200/zoom, 40/zoom, string.format("%ss", self.buttonTime))

    elseif self.tab == 5 then
        exports.TR_jobs:removeInformation()
        self.buttons.next = exports.TR_dx:createButton((sx - 200/zoom)/2, 630/zoom, 200/zoom, 40/zoom, string.format("%ss", self.buttonTime))

    elseif self.tab == 6 then
        self.buttons.next = exports.TR_dx:createButton((sx - 200/zoom)/2, 620/zoom, 200/zoom, 40/zoom, string.format("%ss", self.buttonTime))

    elseif self.tab == 7 then
        self.state = "closing"
        self.tick = getTickCount()

        showCursor(false)
        setElementFrozen(localPlayer, false)
        self:setControl(true)

        exports.TR_jobs:setPlayerTargetPos(-4631.6708984375, 349.32421875, 3.6570091247559, guiInfo.int, guiInfo.dim, "Zejdź z werandy")
        exports.TR_jobs:createInformation("Samouczek Interaktywny", "Zejdź z werandy.")

        self.marker = createColSphere(-4631.6708984375, 349.32421875, 3.6570091247559, 2)
        setElementInterior(self.marker, guiInfo.int)
        setElementDimension(self.marker, guiInfo.dim)

    elseif self.tab == 8 then
        exports.TR_jobs:setPlayerTargetPos(-4608.9873046875, 338.814453125, 5.3641490936279, guiInfo.int, guiInfo.dim, "Podejdź do ogniska")
        exports.TR_jobs:createInformation("Samouczek Interaktywny", "Podejdź do ogniska.")

        self.marker = createColSphere(-4608.9873046875, 338.814453125, 5.3641490936279, 4)
        setElementInterior(self.marker, guiInfo.int)
        setElementDimension(self.marker, guiInfo.dim)

    elseif self.tab == 9 then
        exports.TR_jobs:setPlayerTargetPos(-4612.587890625, 340.77792358398, 5.232964515686, guiInfo.int, guiInfo.dim, "Usiądź na ławce")
        exports.TR_jobs:createInformation("Samouczek Interaktywny", "Otwórz panel interakcji naciskając klawisz \"e\" na klawiaturze. Następnie naciśnij \"LPM\" na obiekt ławki i wybierz opcję \"Usiądź\".")

    elseif self.tab == 10 then
        exports.TR_jobs:setPlayerTargetPos(false)
        exports.TR_jobs:createInformation("Samouczek Interaktywny", "Otwórz panel pomocy naciskając przycisk \"F1\" na klawiaturze. Znajdziesz tam wszystkie najważniejsze zakładki, takie jak: Poradnik, Ogólne informacje o serwerze, Regulamin, Aktualizacje oraz Informacje o kontach premium.")

    elseif self.tab == 11 then
        exports.TR_jobs:createInformation("Samouczek Interaktywny", "Teraz przyszedł czas na panel w którym znajdziesz wszystkie informacje o swoim koncie, pojazdach czy posiadłościach. Możesz go otworzyć przyciskiem \"F5\" na klawiaturze.")

    elseif self.tab == 12 then
        exports.TR_jobs:createInformation("Samouczek Interaktywny", "Skorzystaj ponownie z interakcji aby wstać z ławki. Naciśnij na ławkę na której siedzisz i wybierz opcję \"Zsiądź\".")

    elseif self.tab == 13 then
        exports.TR_jobs:createInformation("Samouczek Interaktywny", "Wejdź do środka budynku aby dowiedzieć się jak dostać się do miasta.")
        exports.TR_jobs:setPlayerTargetPos(-4622.4580078125, 351.3349609375, 3.4673318862915, guiInfo.int, guiInfo.dim, "Wejdź do środka")

    elseif self.tab == 14 then
        exports.TR_jobs:createInformation("Samouczek Interaktywny", "Dowiedz się od brata Dawn'a jak dotrzeć do miasta.")
        exports.TR_jobs:setPlayerTargetPos(2703.6733398438, -1427.5433349609, 62.531028747559, 0, 5, "Porozmawiaj z Dawn'em")

    elseif self.tab == 15 then
        exports.TR_jobs:createInformation("Samouczek Interaktywny", "Otwórz telefon przyciskiem \"END\" na klawiaturze lub komendą /phone.")
        exports.TR_jobs:setPlayerTargetPos(false)

    elseif self.tab == 16 then
        exports.TR_jobs:hideInformation()

        self.state = "opening"
        self.tick = getTickCount()

    elseif self.tab == 17 then
        self.state = "closing"
        self.tick = getTickCount()

        exports.TR_jobs:createInformation("Samouczek Interaktywny", "Podejdź do stołu aby zabrać towar.")
        exports.TR_jobs:setPlayerTargetPos(2701.9846191406, -1420.6787109375, 62.393749237061, 0, 5, "Podnieś towar")

        self.marker = createColSphere(2701.9846191406, -1420.6787109375, 62.393749237061, 1.2)
        setElementInterior(self.marker, 0)
        setElementDimension(self.marker, 5)

    elseif self.tab == 18 then
        setElementPosition(localPlayer, 2702.4641113281, -1421.0791015625, 62.39374923706)
        setElementRotation(localPlayer, 0, 0, 180)
        setPedAnimation(localPlayer, "BOMBER", "BOM_Plant", -1, false, false, false, false)

        exports.TR_jobs:createInformation("Samouczek Interaktywny", "Wyjdź z mieszkania.")
        exports.TR_jobs:setPlayerTargetPos(2704.8723144531, -1431.8681640625, 62.393749237061, 0, 5, "Wyjdź z mieszkania")

    elseif self.tab == 19 then
        exports.TR_jobs:createInformation("Samouczek Interaktywny", "Udaj się za budynek aby spalić swoją działkę.")
        exports.TR_jobs:setPlayerTargetPos(-4616.5927734375, 376.880859375, 3.8513860702515, guiInfo.int, guiInfo.dim, "Udaj się za budynek")

        self.marker = createColSphere(-4616.5927734375, 376.880859375, 3.8513860702515, 1.2)
        setElementInterior(self.marker, guiInfo.int)
        setElementDimension(self.marker, guiInfo.dim)

    elseif self.tab == 20 then
        setElementPosition(localPlayer, -4616.5927734375, 376.880859375, 3.8513860702515)
        setElementRotation(localPlayer, 0, 0, 350)

        exports.TR_jobs:createInformation("Samouczek Interaktywny", "Zapal swoją działkę, którą podarował ci Dawn. Aby to zrobić otwórz ekwipunek przyciskiem \"i\" na klawiaturze.")
        exports.TR_jobs:setPlayerTargetPos(false)

        self:setControl(false)

    elseif self.tab == 21 then
        self.state = "opening"
        self.tick = getTickCount()

    elseif self.tab == 22 then
        self.state = "closing"
        self.tick = getTickCount()

        exports.TR_jobs:createInformation("Samouczek Interaktywny", "Wypal swoją działkę albo ją wyrzuć.")

    elseif self.tab == 23 then
        exports.TR_jobs:createInformation("Samouczek Interaktywny", "Udaj się do portu aby popłynąć do miasta.")
        exports.TR_jobs:setPlayerTargetPos(-4578.083984375, 298.392578125, 1.7828483581543, guiInfo.int, guiInfo.dim, "Udaj się do portu")
        self:setControl(true)

        self.marker = createColSphere(-4578.083984375, 298.392578125, 1.7828483581543, 4)
        setElementInterior(self.marker, guiInfo.int)
        setElementDimension(self.marker, guiInfo.dim)

    elseif self.tab == 24 then
        exports.TR_jobs:createInformation("Samouczek Interaktywny", "Porozmawiaj z przewoźnikiem.")
        exports.TR_jobs:setPlayerTargetPos(-4573.20703125, 290.2080078125, 1.418750953674, guiInfo.int, guiInfo.dim, "Porozmawiaj z przewoźnikiem")

    elseif self.tab == 25 then
        self.state = "opening"
        self.tick = getTickCount()

        exports.TR_jobs:removeInformation()
        exports.TR_jobs:setPlayerTargetPos(false)

        setTimer(function()
            exports.TR_items:openTutorialTrade()
        end, 50, 1)

    elseif self.tab == 27 then
        showCursor(true)
        self.buttons.next = exports.TR_dx:createButton((sx - 250/zoom)/2, 620/zoom, 250/zoom, 40/zoom, string.format("Rozpoczęcie przygody za %ss", self.buttonTime))

    elseif self.tab == 28 then
        local plrUID = getElementData(localPlayer, "characterUID")
        setElementData(localPlayer, "tempUID", plrUID)
        setElementData(localPlayer, "characterUID", nil)
        exports.TR_dx:showLoading(9999999, "Wczytywanie wyboru spawnu")

        self:close()
        triggerServerEvent("endTutorial", resourceRoot, plrUID)
        triggerServerEvent("openPlayerSpawnSelect", resourceRoot)
    end
end

function Tutorial:tutorialTrade()
    if self.tab ~= 24 then
        exports.TR_chat:showCustomMessage("Matthew McGort", "Nie masz nic co by mogło mnie zainteresować.", "files/images/npc.png")
        return
    end
    exports.TR_chat:showCustomMessage("Matthew McGort", "Czuję, że coś paliłeś. Jeśli masz trochę towaru to myślę, że damy radę się dogadać. Ty mi dajesz towar a ja cię transportuje. Stoi?", "files/images/npc.png")
    self:setNextState()
end

function Tutorial:markerEnter(el, md)
    if el ~= localPlayer or not md then return end
    self:setNextState()
end

function Tutorial:getTutorialState()
    return self.tab
end


function Tutorial:setControl(state)
    toggleAllControls(state)
    toggleControl("fire", false)
    toggleControl("action", false)
    toggleControl("aim_weapon", false)
    exports.TR_hud:blockPlayerSprint(not state)
end

function Tutorial:buttonClick(...)
    if arg[1] == self.buttons.next then
        if self.buttonTime ~= 0 then return end
        self:setNextState()
    end
end

function createTutorial()
    if guiInfo.tutorial then return end
    guiInfo.tutorial = Tutorial:create()
end

function isTutorialOpen()
    if guiInfo.tutorial then return guiInfo.tutorial:getTutorialState() end
    return false
end

function setNextState(noTime)
    if not guiInfo.tutorial then return end

    if noTime then
        guiInfo.tutorial:setNextState()
    else
        setTimer(function()
            guiInfo.tutorial:setNextState()
        end, 600, 1)
    end
end

function tutorialTrade()
    if not guiInfo.tutorial then return end

    guiInfo.tutorial:tutorialTrade()
end
addEvent("tutorialTrade", true)
addEventHandler("tutorialTrade", root, tutorialTrade)

-- toggleAllControls(true)
-- toggleControl("fire", false)
-- toggleControl("action", false)
-- toggleControl("aim_weapon", false)

-- if getPlayerName(localPlayer) == "Xantris" then
    -- createTutorial()
-- end

-- exports.TR_dx:setOpenGUI(false)
-- exports.TR_chat:setChatBlocked(false)
-- exports.TR_dx:hideLoading()