function render()
	dxDrawImage(0, 0, sx, sy, assets.textures.bg, 0, 0, 0, tocolor(255, 255, 255, 255 * assets.alpha.bg))

	if assets.currentPage == "login" then
		dxDrawText("Logowanie", assets.positions.startX, assets.positions.startY, assets.positions.startX+170/zoom, assets.positions.startY + 35/zoom, tocolor(255, 255, 255, 255 * assets.alpha.main), 1/zoom, assets.fonts.tab, "left", "center")
  		dxDrawText("/", assets.positions.startX+184/zoom, assets.positions.startY, assets.positions.startX+197/zoom, assets.positions.startY + 35/zoom, tocolor(28, 89, 119, 255 * assets.alpha.main), 1/zoom, assets.fonts.tab, "left", "center")
  		dxDrawText("Rejestracja", assets.positions.startX+212/zoom, assets.positions.startY, assets.positions.startX+378/zoom, assets.positions.startY + 35/zoom, tocolor(38, 44, 56, 255 * assets.alpha.main), 1/zoom, assets.fonts.tab, "left", "center")
  		dxDrawText("Zaloguj się, by dołączyć do najlepszej społeczności uniwersum MTA!", assets.positions.startX, assets.positions.startY+57/zoom, assets.positions.startX+398/zoom, assets.positions.startY+57/zoom+38/zoom, tocolor(110, 119, 132, 255 * assets.alpha.main), 1/zoom, assets.fonts.desc, "left", "top", false, true)

  	elseif assets.currentPage == "register" then
  		dxDrawImage(0, 0, sx, sy, assets.textures.bg2, 0, 0, 0, tocolor(255, 255, 255, 255 * assets.alpha.main))
		dxDrawText("Rejestracja", assets.positions.startX, assets.positions.startY, assets.positions.startX+170/zoom, assets.positions.startY + 35/zoom, tocolor(255, 255, 255, 255 * assets.alpha.main), 1/zoom, assets.fonts.tab, "left", "center")
  		dxDrawText("/", assets.positions.startX+184/zoom, assets.positions.startY, assets.positions.startX+197/zoom, assets.positions.startY + 35/zoom, tocolor(28, 89, 119, 255 * assets.alpha.main), 1/zoom, assets.fonts.tab, "left", "center")
  		dxDrawText("Logowanie", assets.positions.startX+212/zoom, assets.positions.startY, assets.positions.startX+378/zoom, assets.positions.startY + 35/zoom, tocolor(38, 44, 56, 255 * assets.alpha.main), 1/zoom, assets.fonts.tab, "left", "center")
  		dxDrawText("Zarejestruj się, by dołączyć do najlepszej społeczności uniwersum MTA!", assets.positions.startX, assets.positions.startY+57/zoom, assets.positions.startX+398/zoom, assets.positions.startY+57/zoom+38/zoom, tocolor(110, 119, 132, 255 * assets.alpha.main), 1/zoom, assets.fonts.desc, "left", "top", false, true)
  	
  		dxDrawRoundedRectangle(sx/2-80/zoom, 100/zoom, 750/zoom, 875/zoom, tocolor(34, 36, 43, 255 * assets.alpha.main), 5)
  		dxDrawRoundedRectangle(sx/2-78/zoom, 102/zoom, 746/zoom, 871/zoom, tocolor(16, 18, 23, 255 * assets.alpha.main), 5)

  		dxDrawText(assets.rules and  "Zaakceptowany" or "Niezaakceptowany", sx/2+134/zoom, 912/zoom, sx/2+134/zoom+322/zoom, 912/zoom+40/zoom, tocolor(255, 255, 255, 255 * assets.alpha.main), 1/zoom, assets.fonts.desc, "center", "center")
  		dxDrawText("Regulamin", sx/2-48/zoom, 122/zoom, sx/2-48/zoom+746/zoom, 122/zoom+30/zoom, tocolor(255, 255, 255, 255 * assets.alpha.main), 1/zoom, assets.fonts.rules, "left", "center")
  	elseif assets.currentPage == "usernameSelect" then
  		dxDrawImage(0, 0, sx, sy, assets.textures.bg2, 0, 0, 0, tocolor(255, 255, 255, 255 * assets.alpha.main))
  		dxDrawRoundedRectangle(sx/2-175/zoom, sy/2-125/zoom, 350/zoom, 250/zoom, tocolor(23,25,31, 255 * assets.alpha.main), 5)

  		dxDrawText("Wybierz swój pseudonim w grze", sx/2-175/zoom, sy/2-120/zoom, sx/2-175/zoom+350/zoom, sy/2-120/zoom+40/zoom, tocolor(255, 255, 255, 255 * assets.alpha.main), 1/zoom, assets.fonts.desc, "center", "center")
  		if assets.username.state == "searching" then
  			dxDrawImage(sx/2-150/zoom, sy/2+7/zoom, 32/zoom, 32/zoom, assets.textures.search, 0, 0, 0, tocolor(255, 255, 255, 255 * assets.alpha.main))
  			dxDrawText("Sprawdzanie"..assets.username.dots, sx/2-100/zoom, sy/2+7/zoom, sx/2-100/zoom+100/zoom, sy/2+7/zoom+32/zoom, tocolor(255, 255, 255, 255 * assets.alpha.main), 1/zoom, assets.fonts.desc, "left", "center")
  		elseif assets.username.state == "found" then
  			dxDrawImage(sx/2-150/zoom, sy/2+7/zoom, 32/zoom, 32/zoom, assets.textures.accept, 0, 0, 0, tocolor(255, 255, 255, 255 * assets.alpha.main))
  			dxDrawText("Wolny", sx/2-100/zoom, sy/2+7/zoom, sx/2-100/zoom+100/zoom, sy/2+7/zoom+32/zoom, tocolor(255, 255, 255, 255 * assets.alpha.main), 1/zoom, assets.fonts.desc, "left", "center")
  		elseif assets.username.state == "invalid" then
  			dxDrawImage(sx/2-150/zoom, sy/2+7/zoom, 32/zoom, 32/zoom, assets.textures.decline, 0, 0, 0, tocolor(255, 255, 255, 255 * assets.alpha.main))
  			dxDrawText("Niepoprawny", sx/2-100/zoom, sy/2+7/zoom, sx/2-100/zoom+100/zoom, sy/2+7/zoom+32/zoom, tocolor(255, 255, 255, 255 * assets.alpha.main), 1/zoom, assets.fonts.desc, "left", "center")
  		else
  			dxDrawImage(sx/2-150/zoom, sy/2+7/zoom, 32/zoom, 32/zoom, assets.textures.decline, 0, 0, 0, tocolor(255, 255, 255, 255 * assets.alpha.main))
  			dxDrawText("Zajęty", sx/2-100/zoom, sy/2+7/zoom, sx/2-100/zoom+100/zoom, sy/2+7/zoom+32/zoom, tocolor(255, 255, 255, 255 * assets.alpha.main), 1/zoom, assets.fonts.desc, "left", "center")
  		end

  		if assets.username.tick then
    		if (getTickCount() - assets.username.tick)/400 > 1 then
      			assets.username.dots = assets.username.dots .. "."
     			assets.username.tick = getTickCount()
      			if string.len(assets.username.dots) > 3 then
        			assets.username.dots = ""
      			end
    		end
  		end
  	end

	dxDrawImage(assets.currentPage == "usernameSelect" and sx/2-113.5/zoom or assets.positions.startX_def, assets.positions.logoY, 227/zoom, 90/zoom, assets.textures.logo, 0, 0, 0, tocolor(255, 255, 255, 255 * assets.alpha.main))
	dxDrawImage(assets.currentPage == "usernameSelect" and sx/2-70.5/zoom or assets.positions.startX_def, assets.positions.discordY, 141/zoom, 39/zoom, assets.textures.discord, 0, 0, 0, tocolor(255, 255, 255, 255 * assets.alpha.main))
end

function showPanel()
  	fadeCamera(true, 0)
  	setPlayerHudComponentVisible("all", false)
  	setPlayerHudComponentVisible("crosshair", true)
  	setPedTargetingMarkerEnabled(false)

  	setElementDimension(localPlayer, 2)
  	setElementPosition(localPlayer, 1578.01171875, -685.05181884766, 26.637500762939)
 	setElementFrozen(localPlayer, true)

    setTimer(function()
    	exports.TR_dx:hideLoading()
		showCursor(true)
		addEventHandler("onClientRender", root, render)
		addEventHandler("onClientClick", root, click)
		addEventHandler("guiButtonClick", root, buttonClick)
        assets.music = playSound("assets/sound/login.mp3", true)
		animate({0}, {1}, "OutQuad", 500, function(v) assets.alpha.bg = v end)
		showPage("login")
    	local sLogin, sPassword, sChecked = getSavedLoginData()
   		if sLogin and sPassword and sChecked then
      		exports.TR_dx:setEditText(assets.components.login_user, sLogin)
      		exports.TR_dx:setEditText(assets.components.login_password, sPassword)
      		exports.TR_dx:setCheckSelected(assets.components.remember, sChecked)
    	end
    end, 5000, 1)
end

function hidePanel(onEnd)
    setElementFrozen(localPlayer, false)
    setCameraTarget(localPlayer)
    showCursor(false)

	animate({1}, {0}, "OutQuad", 500, function(v) assets.alpha.main = v assets.alpha.bg = v assets.alpha.bg2 = v end)
	hidePage(assets.currentPage,
		function()
			removeEventHandler("onClientRender", root, render)

			if onEnd and type(onEnd) == "function" then
				onEnd()
			end
		end
	)
end

function showPage(page)
	if page == "login" or page == "register" then
		assets.activeAnimation = true

		animate({0, -230/zoom, sy+40/zoom}, {1, assets.positions.logoY_def, assets.positions.discordY_def}, "OutQuad", 500,
			function(v1, v2, v3)
				assets.alpha.main = v1
				assets.positions.logoY = v2
				assets.positions.discordY = v3
			end,
			function()
				assets.activeAnimation = false
			end
		)
	end

	if page == "login" then
		assets.positions.startY = 415/zoom

		assets.components.login_user = exports.TR_dx:createEdit(assets.positions.startX, assets.positions.startY + 123/zoom, 252/zoom, 40/zoom, "Nazwa użytownika", false, false)
		assets.components.login_password = exports.TR_dx:createEdit(assets.positions.startX + 272/zoom, assets.positions.startY + 123/zoom, 252/zoom, 40/zoom, "Hasło", true, false)
		exports.TR_dx:setEditVisible({assets.components.login_user, assets.components.login_password})
		exports.TR_dx:showEdit({assets.components.login_user, assets.components.login_password})

		assets.components.login = exports.TR_dx:createButton(assets.positions.startX, assets.positions.startY + 243/zoom, 152/zoom, 40/zoom, "ZALOGUJ", "blue")
		exports.TR_dx:setButtonVisible({assets.components.login})
		exports.TR_dx:showButton({assets.components.login})

		assets.components.remember = exports.TR_dx:createCheck(assets.positions.startX, assets.positions.startY + 183/zoom, 40/zoom, 40/zoom, false, "Zapamiętaj mnie")
		exports.TR_dx:setCheckVisible({assets.components.remember})
		exports.TR_dx:showCheck({assets.components.remember})


		animate({-600/zoom}, {assets.positions.startX_def}, "OutQuad", 500,
			function(v1)
				assets.positions.startX = v1
				exports.TR_dx:setButtonX(assets.components.login, v1)
				exports.TR_dx:setEditX({
					{assets.components.login_user, v1},
					{assets.components.login_password, v1 + 272/zoom}
				})
				exports.TR_dx:setCheckX(assets.components.remember, v1-7/zoom)
			end
		)
	elseif page == "register" then
		assets.positions.startY = 364.5/zoom

		assets.components.register_user = exports.TR_dx:createEdit(assets.positions.startX, assets.positions.startY + 123/zoom, 252/zoom, 40/zoom, "Nazwa użytownika", false, false)
		assets.components.register_password = exports.TR_dx:createEdit(assets.positions.startX + 272/zoom, assets.positions.startY+ 123/zoom, 252/zoom, 40/zoom, "Hasło", true, false)
		assets.components.register_password_repeat = exports.TR_dx:createEdit(assets.positions.startX, assets.positions.startY + 183/zoom, 252/zoom, 40/zoom, "Potwórz hasło", true, false)
		assets.components.register_email = exports.TR_dx:createEdit(assets.positions.startX + 272/zoom, assets.positions.startY + 183/zoom, 252/zoom, 40/zoom, "E-mail", false, false)
		assets.components.register_code = exports.TR_dx:createEdit(assets.positions.startX, assets.positions.startY + 243/zoom, 252/zoom, 40/zoom, "Kod referencyjny", false, false)

		exports.TR_dx:setEditVisible({assets.components.register_user, assets.components.register_password, assets.components.register_password_repeat, assets.components.register_email, assets.components.register_code})
		exports.TR_dx:showEdit({assets.components.register_user, assets.components.register_password, assets.components.register_password_repeat, assets.components.register_email, assets.components.register_code})

		assets.components.register = exports.TR_dx:createButton(assets.positions.startX, assets.positions.startY + 303/zoom, 182/zoom, 40/zoom, "ZAREJESTRUJ SIĘ", "blue")
		assets.components.decline = exports.TR_dx:createButton(sx/2-48/zoom, 912/zoom, 182/zoom, 40/zoom, "ODRZUĆ")
		assets.components.accept = exports.TR_dx:createButton(sx/2+456/zoom, 912/zoom, 182/zoom, 40/zoom, "AKCEPTUJ", "blue")
		exports.TR_dx:setButtonVisible({assets.components.register, assets.components.decline, assets.components.accept})
		exports.TR_dx:showButton({assets.components.register, assets.components.decline, assets.components.accept})

		assets.components.scroll = exports.TR_dx:createScroll(sx/2-48/zoom, 172/zoom, 686/zoom, 699/zoom, 30, false)
		exports.TR_dx:setScrollBackground(assets.components.scroll, false)
		exports.TR_dx:setScrollText(assets.components.scroll, text)
		exports.TR_dx:setScrollVisible({assets.components.scroll})
		exports.TR_dx:showScroll({assets.components.scroll})

		animate({-600/zoom}, {assets.positions.startX_def}, "OutQuad", 500,
			function(v1)
				assets.positions.startX = v1
				exports.TR_dx:setButtonX(assets.components.register, v1)
				exports.TR_dx:setEditX({
					{assets.components.register_user, v1},
					{assets.components.register_password, v1 + 272/zoom},
					{assets.components.register_password_repeat, v1},
					{assets.components.register_email, v1 + 272/zoom},
					{assets.components.register_code, v1},
				})
			end,
			function()
				assets.passwordStrength = exports.TR_noti:create({"Siła hasła:", " 0%"}, "password", false, true)
    			assets.passwordStrengthUpdate = setTimer(updatePasswordStrength, 500, 0)
    			updatePasswordStrength()
			end
		)
	elseif page == "usernameSelect" then
		assets.activeAnimation = true

		animate({0, -230/zoom, sy+40/zoom}, {1, assets.positions.logoY_def, assets.positions.discordY_def}, "OutQuad", 500,
			function(v1, v2, v3)
				assets.alpha.main = v1
				assets.positions.logoY = v2
				assets.positions.discordY = v3
			end,
			function()
				assets.activeAnimation = false
			end
		)

		assets.components.usernameSelect_accept = exports.TR_dx:createButton(sx/2-150/zoom, sy/2+65/zoom, 300/zoom, 40/zoom, "AKCEPTUJ", "blue")
		assets.components.usernameSelect_name = exports.TR_dx:createEdit(sx/2-150/zoom, sy/2-60/zoom, 300/zoom, 40/zoom, "pseudonim", false, false)

		addEventHandler("guiButtonClick", root, checkUsernameClick)

  		assets.username.state = "decline"
 		assets.username.timer = setTimer(checkUsernameSelect, 400, 0)
	end

	assets.currentPage = page
end

function hidePage(page, onEnd)
	if page == "login" or page == "register" then
		assets.activeAnimation = true

		animate({1, assets.positions.logoY_def, assets.positions.discordY_def}, {0, -230/zoom, sy+40/zoom}, "OutQuad", 500,
			function(v1, v2, v3)
				assets.alpha.main = v1
				assets.positions.logoY = v2
				assets.positions.discordY = v3
			end,
			function()
				assets.activeAnimation = false
				assets.currentPage = false

				if type(onEnd) == "function" then
					onEnd()
				end
			end
		)
	end

	if page == "login" then
		exports.TR_dx:hideEdit({assets.components.login_user, assets.components.login_password})
		exports.TR_dx:hideButton({assets.components.login})
		exports.TR_dx:hideCheck({assets.components.remember})

		animate({assets.positions.startX_def}, {-600/zoom}, "OutQuad", 500,
			function(v1)
				assets.positions.startX = v1
				exports.TR_dx:setButtonX(assets.components.login, v1)
				exports.TR_dx:setEditX({
					{assets.components.login_user, v1},
					{assets.components.login_password, v1 + 272/zoom}
				})
				exports.TR_dx:setCheckX(assets.components.remember, v1-7/zoom)
			end
		)
	elseif page == "register" then
    	if isElement(assets.passwordStrength) then
      		killTimer(assets.passwordStrengthUpdate)
      		exports.TR_noti:destroy(assets.passwordStrength)
      		assets.passwordStrength = nil
    	end
		exports.TR_dx:hideEdit({assets.components.register_user, assets.components.register_password, assets.components.register_password_repeat, assets.components.register_email, assets.components.register_code})
		exports.TR_dx:hideButton({assets.components.register, assets.components.decline, assets.components.accept})
		exports.TR_dx:hideScroll({assets.components.scroll})

		animate({assets.positions.startX_def}, {-600/zoom}, "OutQuad", 500,
			function(v1)
				assets.positions.startX = v1
				exports.TR_dx:setButtonX(assets.components.register, v1)
				exports.TR_dx:setEditX({
					{assets.components.register_user, v1},
					{assets.components.register_password, v1 + 272/zoom},
					{assets.components.register_password_repeat, v1},
					{assets.components.register_email, v1 + 272/zoom},
					{assets.components.register_code, v1},
				})
			end
		)
	elseif page == "usernameSelect" then
		if isTimer(assets.username.timer) then killTimer(assets.username.timer) end
  		if isTimer(assets.username.updateState) then killTimer(assets.username.updateState) end
  		removeEventHandler("guiButtonClick", root, checkUsernameClick)
		exports.TR_dx:hideEdit({assets.components.usernameSelect_name})
		exports.TR_dx:hideButton({assets.components.usernameSelect_accept})
	end
end

function gotoPage(page)
	if page then
		hidePage(assets.currentPage, 
			function()
				showPage(page)
			end
		)
		return true
	end
end

function click(button, state)
	if assets.activeAnimation then return end
	if (button == "left") and (state == "up") then
		if assets.currentPage == "login" then
			if isMouseIn(362/zoom, assets.positions.startY, 170/zoom, 35/zoom) then
				gotoPage("register")
			end
		elseif assets.currentPage == "register" then
			if isMouseIn(362/zoom, assets.positions.startY, 166/zoom, 35/zoom) then
				gotoPage("login")
			end			
		end
	end
end

function buttonClick(btn)
  	if btn == assets.components.login then
    	performLogin()
  	elseif btn == assets.components.register then
    	performRegister()
    elseif btn == assets.components.accept then
    	assets.rules = true
    elseif btn == assets.components.decline then
    	assets.rules = false
	end
end

function performLogin()
  local login = guiGetText(assets.components.login_user)
  local password = guiGetText(assets.components.login_password)

  if not string.checkLen(login, 3, 20) then exports.TR_noti:create("Login powinien zawierać od 3 do 20 znaków. ", "error") return end
  if not string.checkLen(password, 3, 40) then exports.TR_noti:create("Hasło powinno zawierać od 3 do 40 znaków.", "error") return end
  saveLoginData()

  exports.TR_dx:setResponseEnabled(true)
  triggerServerEvent("loginAccount", resourceRoot, login, password)
end

function performRegister()
  local login = guiGetText(assets.components.register_user)
  local password = guiGetText(assets.components.register_password)
  local password_rep = guiGetText(assets.components.register_password_repeat)
  local email = guiGetText(assets.components.register_email)
  local reference = guiGetText(assets.components.register_code)
  local rules = assets.rules

  if not rules then exports.TR_noti:create("Aby stworzyć konto musisz wyrazić zgodę na przestrzeganie regulaminu.", "error") return end
  if not string.checkLen(login, 3, 20) then exports.TR_noti:create("Login powinien zawierać od 3 do 20 znaków.", "error") return end
  if not checkString(login) then exports.TR_noti:create("Login zawiera niedozwolone znaki.", "error") return end
  if not string.checkLen(password, 3, 40) then exports.TR_noti:create("Hasło powinno zawierać od 3 do 40 znaków.", "error") return end
  local strength, strengthText = calculateStrength(login, password)
  if strength <= 50 then exports.TR_noti:create("Hasło nie jest wystarczająco bezpieczne.", "error") return end
  if password ~= password_rep then exports.TR_noti:create("Hasła nie są identyczne.", "error") return end
  if not string.checkLen(email, 3, 40) then exports.TR_noti:create("Email powinien mieć od 3 do 60 znaków.", "error") return end
  if not isValidMail(email) then exports.TR_noti:create("Email ma niepoprawną składnię.", "error") return end
  if assets.registerLastLogin == login then exports.TR_noti:create("Użytkownik o takim loginie już istnieje.", "error") return end

  if string.len(reference) > 0 then
    reference = reference
  else
    reference = false
  end

  assets.registerLastLogin = login
  exports.TR_dx:setResponseEnabled(true)
  triggerServerEvent("registerAccount", resourceRoot, login, password, email, reference)
end

function loginPlayer(username)
  if username then
    local count = 0;
    setTimer(function()
      if count == 10 then
        destroyElement(assets.music)
      else
        setSoundVolume(assets.music, getSoundVolume(assets.music) - 0.1)
      end
      count = count + 1
    end, 100, 11)

    exports.TR_dx:showLoading(60000, "Wczytywanie modeli")
    exports.TR_dx:setResponseEnabled(true)

    exports.TR_models:loadModels(false)

    setTimer(function()
      hidePanel(
      	function()
       	 	exports.TR_dx:showLoading(9999999, "Wczytywanie wyboru spawnu")

        	triggerServerEvent("openPlayerSpawnSelect", resourceRoot)
        	exports.TR_dx:setResponseEnabled(false)
      	end
      )
    end, 5000, 1)

  else
    exports.TR_dx:showLoading(1000, "Wczytywanie wyboru nicku")
    exports.TR_dx:setResponseEnabled(true)

    setTimer(function()
      removeEventHandler("guiButtonClick", root, buttonClick)
      gotoPage("usernameSelect")
      exports.TR_dx:setResponseEnabled(false)
    end, 500, 1)
  end
end
addEvent("loginPlayer", true)
addEventHandler("loginPlayer", root, loginPlayer)

function loginResponseServer(text, type, specialData)
  setTimer(function()
    if text then exports.TR_noti:create(text, type) end

    if not specialData then
      exports.TR_dx:setResponseEnabled(false)

    else
      if specialData == "reference" then
        assets.registerLastLogin = nil
        exports.TR_dx:setResponseEnabled(false)

      elseif specialData == "accountCreate" then
        if isElement(assets.passwordStrength) then
          killTimer(assets.passwordStrengthUpdate)
          exports.TR_noti:destroy(assets.passwordStrength)
          assets.passwordStrength = nil
        end

        exports.TR_noti:create("Konto zostało poprawnie założone.\nZa chwilę nastąpi automatyczne zalogowanie.", "success", 5)
        local login = guiGetText(assets.components.register_user)
 		local password = guiGetText(assets.components.register_password)
        setTimer(function()
          triggerServerEvent("loginAccount", resourceRoot, login, password)
        end, 1000, 1)
      end

    end
  end, 500 ,1)
end
addEvent("loginResponseServer", true)
addEventHandler("loginResponseServer", root, loginResponseServer)


function updatePasswordStrength()
  local login = guiGetText(assets.components.register_user)
  local password = guiGetText(assets.components.register_password)
  local strength, strengthText = calculateStrength(login, password)

  local r, g, b = interpolateBetween(157, 28, 28, 41, 157, 28, strength/100, "Linear")
  exports.TR_noti:setColor(assets.passwordStrength, {r, g, b})
  exports.TR_noti:setText(assets.passwordStrength, {"Siła hasła:", string.format("%s%s", RGBToHex(r, g, b), strengthText)}, true)
end

function calculateStrength(login, password)
  local length = string.len(password)
  if length < 3 then return 0, "Bardzo słabe" end

  local score = 0
  local scoreText = "Bardzo słabe"
  if string.find(password, "%l") then -- lower
    score = score + 10
  end
  if string.find(password, "%u") then -- upper
    score = score + 20
  end
  if string.find(password, "%d") then -- digits
    score = score + 30
  end
  if string.find(password, "%W") then -- symbols
    score = score + 40
  end
  if login and login ~= "" then
    local f, l = string.find(password, login)
    if f and l then
      local len = l - f
      score = score - ((len / length) * score)
    end
  end
  if login == password then score = 0 end

  if score >= 20 and score <= 50 then
    scoreText = "Słabe"
  elseif score > 50 and score <= 70 then
    scoreText = "Silne"
  elseif score > 70 then
    scoreText = "Bardzo silne"
  end

  return score, scoreText
end

-- Ban data
function formatBanData(data)
  local banData = {
    admin = data.admin,
    username = data.username,
    serial = data.serial,
    reason = data.reason,
    time = formatDate(data.time),
    timeEnd = formatDate(data.timeEnd),
    timeToKick = 65,
  }
  return banData
end

function formatDate(date)
  local forms = split(date, " ")
  local date = split(forms[1], "-")

  return string.format("%s %02d.%02d.%d", forms[2], date[3], date[2], date[1])
end

function createBanWindow()
  assets.banInfo = {
    x = (sx - 900/zoom)/2,
    y = (sy - 200/zoom)/2,
    w = 900/zoom,
    h = 320/zoom,

    sad = dxCreateTexture("assets/images/sad.png", "argb", true, "clamp"),
    sadText = "Jest nam bardzo przykro, że zachowywałeś się nieodpowiednio i musiała zostać nałożona na ciebie kara w postaci bana.",
  }
  assets.fonts.title = exports.TR_dx:getFont(16)
  assets.fonts.text = exports.TR_dx:getFont(13)
  assets.fonts.sad = exports.TR_dx:getFont(11)
  assets.banTick = getTickCount()

  setTimer(function()
    assets.music = playSound("assets/sound/login.mp3", true)
    exports.TR_dx:hideLoading()
  end, 5000, 1)
  addEventHandler("onClientRender", root, renderBanWindow)
end

function renderBanWindow()
  dxDrawImage(0, 0, sx, sy, "assets/images/bg2.png")
  dxDrawImage((sx - 227/zoom)/2, assets.banInfo.y - 250/zoom, 227/zoom, 90/zoom, assets.textures.logo, 0, 0, 0, tocolor(255, 255, 255, 255))

  dxDrawRoundedRectangle(assets.banInfo.x, assets.banInfo.y, assets.banInfo.w, assets.banInfo.h, tocolor(23,25,31, 255), 5)
  dxDrawImage(assets.banInfo.x + assets.banInfo.w - (400/zoom - 128/zoom)/2 - 128/zoom, assets.banInfo.y + 60/zoom, 128/zoom, 128/zoom, assets.banInfo.sad, 0, 0, 0, tocolor(100, 100, 100, 255))
  dxDrawText(assets.banInfo.sadText, assets.banInfo.x + assets.banInfo.w - 390/zoom, assets.banInfo.y + 198/zoom, assets.banInfo.x + assets.banInfo.w - 10/zoom, 0, tocolor(100, 100, 100, 255), 1/zoom, assets.fonts.sad, "center", "top", false, true)

  dxDrawText("ZOSTAŁEŚ ZBANOWANY", assets.banInfo.x, assets.banInfo.y + 10/zoom, assets.banInfo.x + assets.banInfo.w, assets.banInfo.y + 30/zoom, tocolor(44,183,236, 255), 1/zoom, assets.fonts.title, "center", "center")

  dxDrawText(string.format("Nałożony na gracza: #999999%s", assets.banData.username), assets.banInfo.x + 10/zoom, assets.banInfo.y + 70/zoom, 0, assets.banInfo.y + 30/zoom, tocolor(255, 255, 255, 150), 1/zoom, assets.fonts.text, "left", "top", false, false, false, true)
  dxDrawText(string.format("Nałożony na serial: #999999%s", assets.banData.serial), assets.banInfo.x + 10/zoom, assets.banInfo.y + 95/zoom, 0, assets.banInfo.y + 30/zoom, tocolor(255, 255, 255, 150), 1/zoom, assets.fonts.text, "left", "top", false, false, false, true)

  dxDrawText(string.format("Nałożony przez: #999999%s", assets.banData.admin), assets.banInfo.x + 10/zoom, assets.banInfo.y + 120/zoom, 0, assets.banInfo.y + 30/zoom, tocolor(255, 255, 255, 150), 1/zoom, assets.fonts.text, "left", "top", false, false, false, true)
  dxDrawText(string.format("Nałożony dnia: #999999%sr.", assets.banData.time), assets.banInfo.x + 10/zoom, assets.banInfo.y + 145/zoom, 0, assets.banInfo.y + 30/zoom, tocolor(255, 255, 255, 150), 1/zoom, assets.fonts.text, "left", "top", false, false, false, true)
  dxDrawText(string.format("Kończy się dnia: #999999%sr.", assets.banData.timeEnd), assets.banInfo.x + 10/zoom, assets.banInfo.y + 170/zoom, 0, assets.banInfo.y + 30/zoom, tocolor(255, 255, 255, 150), 1/zoom, assets.fonts.text, "left", "top", false, false, false, true)
  dxDrawText("Powód bana:", assets.banInfo.x + 10/zoom, assets.banInfo.y + 195/zoom, assets.banInfo.x + assets.banInfo.w/2, assets.banInfo.y + 30/zoom, tocolor(255, 255, 255, 150), 1/zoom, assets.fonts.text, "left", "top", false, false, false, true)
  dxDrawText(assets.banData.reason, assets.banInfo.x + 10/zoom, assets.banInfo.y + 220/zoom, assets.banInfo.x + assets.banInfo.w/2, assets.banInfo.y + 30/zoom, tocolor(104,112,125, 150), 1/zoom, assets.fonts.text, "left", "top", true, true, false, true)

  dxDrawText(string.format("Masz %ds aby zapoznać się z informacją na temat bana, po czym zostaniesz automatycznie wyrzucony.", assets.banData.timeToKick), assets.banInfo.x + 10/zoom, 0, assets.banInfo.x + assets.banInfo.w - 10/zoom, assets.banInfo.y + assets.banInfo.h - 10/zoom, tocolor(104,112,125, 250), 1/zoom, assets.fonts.sad, "center", "bottom")
  if assets.banTick then
    if (getTickCount() - assets.banTick)/1000 > 1 then
      assets.banTick = getTickCount()
      assets.banData.timeToKick = assets.banData.timeToKick - 1

      if assets.banData.timeToKick == 0 then
        triggerServerEvent("kickPlayer", resourceRoot, localPlayer, "ban info", "Czas na zapoznanie się z informacją minął.")
      end
    end
  end
end

function setPlayerBanData(haveBan, banData)
  if haveBan then
    setTimer(createBanWindow, 3000, 1)
    assets.banData = formatBanData(banData)
  else
    setTimer(showPanel, 3000, 1)
  end
end
addEvent("setPlayerBanData", true)
addEventHandler("setPlayerBanData", root, setPlayerBanData)

function checkUsernameSelect()
  local username = guiGetText(assets.components.usernameSelect_name)

  if assets.username.searched == username then return end
  if isTimer(assets.username.updateState) then killTimer(assets.username.updateState) end
  if assets.username.searching then return end

  if username == assets.username.lastUsername then
    if not string.checkLen(username, 3, 18) or not checkString(username) or tonumber(username) ~= nil then
      assets.username.searched = nil
      assets.username.state = "invalid"
      return
    end

    assets.username.dots = ""
    assets.username.tick = getTickCount()
    assets.username.state = "searching"

    triggerServerEvent("checkUsernameFree", resourceRoot, username)
    assets.username.searching = true
    return
  end
  assets.username.lastUsername = username
end

function checkUsernameValid(nick, state)
  if assets.username.lastUsername == nick then
    assets.username.updateState = setTimer(function()
      assets.username.state = state and "found" or false
    end, 2000, 1)
    assets.username.state = "searching"
  end
  assets.username.searching = false
  assets.username.searched = nick
end
addEvent("checkUsernameValid", true)
addEventHandler("checkUsernameValid", root, checkUsernameValid)

function checkUsernameClick(btn)
  if btn == assets.components.usernameSelect_accept then
    local username = guiGetText(assets.components.usernameSelect_name)

    if assets.username.searching then return end
    if assets.username.searched ~= username then return end
    if assets.username.state ~= "found" then return end
    triggerServerEvent("setPlayerUsername", resourceRoot, username)
    removeEventHandler("guiButtonClick", root, checkUsernameClick)
  end
end

function getSavedLoginData()
  local xml = xmlLoadFile("userdata.xml")
  if not xml then
    xml = xmlCreateFile("userdata.xml", "userdata")
    xmlCreateChild(xml, "login")
    xmlCreateChild(xml, "password")
    xmlSaveFile(xml)
    xmlUnloadFile(xml)

    return false, false, false
  end

  local loginChild = xmlFindChild(xml, "login", 0)
  local passwordChild = xmlFindChild(xml, "password", 0)
  local login = xmlNodeGetValue(loginChild)
  local password = teaDecodeBinary(xmlNodeGetValue(passwordChild), "eKXJmeNDR4cFs47q")

  xmlUnloadFile(xml)

  return login, password, string.len(login) > 0 and string.len(password) > 0 and true or false
end

function saveLoginData()
  local xml = xmlLoadFile("userdata.xml")
  if not xml then return end

  local login = guiGetText(assets.components.login_user)
  local password = guiGetText(assets.components.login_password)
  local remember = exports.TR_dx:isCheckSelected(assets.components.remember)

  local loginChild = xmlFindChild(xml, "login", 0)
  local passwordChild = xmlFindChild(xml, "password", 0)

  if remember then
    xmlNodeSetValue(loginChild, login)
    xmlNodeSetValue(passwordChild, teaEncodeBinary(password, "eKXJmeNDR4cFs47q"))
    xmlSaveFile(xml)
  else
    xmlNodeSetValue(loginChild, "")
    xmlNodeSetValue(passwordChild, "")
    xmlSaveFile(xml)
  end

  xmlUnloadFile(xml)
end
function teaEncodeBinary(data, key)
  return teaEncode(base64Encode(data), key)
end
function teaDecodeBinary(data, key)
  return base64Decode(teaDecode(data, key))
end

function openLoginPanel()
   triggerServerEvent("getBanData", resourceRoot)
end

if not getElementData(localPlayer, "characterUID") then openLoginPanel() end