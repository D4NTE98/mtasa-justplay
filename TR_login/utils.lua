sx, sy = guiGetScreenSize()

zoom = 1
local baseX = 1920
local minZoom = 2
if sx < baseX then
   zoom = math.min(minZoom, baseX/sx)
end

assets = {
	activeAnimation = false,
	currentPage = "login",

	components = {

	},

	alpha = {
		main = 0,
		bg = 0,
	},

    username = {},

    rules = false,

	positions = {
		startX_def = 150/zoom,
		startX = -600/zoom,
		startY_def = 415/zoom,
		startY = 415/zoom,

		logoY_def = 100/zoom,
		logoY = -230/zoom,

		discordY_def = sy-150/zoom-39/zoom,
		discordY = sy+40/zoom,
	},

	textures = {
		bg = dxCreateTexture("assets/images/bg.png", "argb", true, "clamp"),
		bg2 = dxCreateTexture("assets/images/bg2.png", "argb", true, "clamp"),
		logo = dxCreateTexture("assets/images/logo.png", "argb", true, "clamp"),		
		discord = dxCreateTexture("assets/images/discord.png", "argb", true, "clamp"),	
        search = dxCreateTexture("assets/images/search.png", "argb", true, "clamp"),
        accept = dxCreateTexture("assets/images/accept.png", "argb", true, "clamp"),        
        decline = dxCreateTexture("assets/images/decline.png", "argb", true, "clamp"),  
	},

	fonts = {
		tab = exports.TR_dx:getFont(24, "Lato-Regular"),
		desc = exports.TR_dx:getFont(13, "Lato-Regular"),
        rules = exports.TR_dx:getFont(14, "Lato-Regular"),
	},
}


local anims, animID = { }, 0
local rendering = false 

local function renderAnimations( )
    local now = getTickCount( )
    for k,v in ipairs(anims) do
        v.onChange(interpolateBetween(v.from[1], v.from[2], v.from[3], v.to[1], v.to[2], v.to[3], (now - v.start) / v.duration, v.easing))
        if now >= v.start+v.duration then
            table.remove(anims, k)
            if type(v.onEnd) == "function" then
                v.onEnd( )
            end
            if #anims == 0 then 
                rendering = false
                removeEventHandler("onClientRender", root, renderAnimations)
            end
        end
    end
end

function animate(f, t, easing, duration, onChange, onEnd)
    if #anims == 0 and not rendering then 
        addEventHandler("onClientRender", root, renderAnimations)
        rendering = true
    end
    assert(type(f) == "table", "Bad argument @ 'animate' [expected table at argument 1, got "..type(f).."]")
    assert(type(t) == "table", "Bad argument @ 'animate' [expected table at argument 2, got "..type(t).."]")
    assert(type(easing) == "string", "Bad argument @ 'animate' [Invalid easing at argument 3]")
    assert(type(duration) == "number", "Bad argument @ 'animate' [expected number at argument 4, got "..type(duration).."]")
    assert(type(onChange) == "function", "Bad argument @ 'animate' [expected function at argument 5, got "..type(onChange).."]")
    f = {f[1] or 0, f[2] or 0, f[3] or 0}
    t = {t[1] or 0, t[2] or 0, t[3] or 0}
    animID = animID+1
    table.insert(anims, {id=animID, from = f, to = t, easing = easing, duration = duration, start = getTickCount( ), onChange = onChange, onEnd = onEnd})
    return animID
end

function finishAnimation(anim)
    for k, v in ipairs(anims) do 
        if v.id == anim then 
            v.onChange(v.to[1], v.to[2], v.to[3])
            if v.onEnd then v.onEnd() end
            v.start = 0
            return true
        end
    end
end 

function deleteAnimation(anim)
    for k, v in ipairs(anims) do 
        if v.id == anim then 
            table.remove(anims, k)
            break
        end
    end
end 

function isMouseIn(x, y, width, height)
	if (not isCursorShowing()) then
		return false
	end
	local cx, cy = getCursorPosition()
	local cx, cy = (cx * sx), (cy * sy)
	
	return ( ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) )
end

function dxDrawRoundedRectangle(x, y, rx, ry, color, radius, post)
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

function isOnlyString(text)
  if string.find(text, "%c") then return false end
  if string.find(text, "%d") then return false end
  if string.find(text, "%p") then return false end
  if string.find(text, "%s") then return false end
  if string.find(text, "%z") then return false end
  return true
end

function checkString(text)
  if string.find(text, "%c") or string.find(text, "%p") or string.find(text, "%s") or string.find(text, "%z") then
    return false
  else
    return true
  end
end

function isValidMail(mail)
  assert(type(mail) == "string", "Bad argument @ isValidMail [string expected, got "..tostring(mail) .."]")
  return mail:match("[A-Za-z0-9%.%%%+%-]+@[A-Za-z0-9%.%%%+%-]+%.%w%w%w?%w?") ~= nil
end

function string.checkLen(text, minLen, maxLen)
  if string.len(text) >= minLen and string.len(text) <= maxLen then return true else return false end
end

function RGBToHex(red, green, blue, alpha)
    if( ( red < 0 or red > 255 or green < 0 or green > 255 or blue < 0 or blue > 255 ) or ( alpha and ( alpha < 0 or alpha > 255 ) ) ) then
        return nil
  end

    if alpha then
        return string.format("#%.2X%.2X%.2X%.2X", red, green, blue, alpha)
    else
        return string.format("#%.2X%.2X%.2X", red, green, blue)
    end
end

text = [[
1. OGÓLNE

§1.1 Wchodząc na serwer automatycznie akceptujesz tym samym nasz regulamin.

§1.2 Regulamin może w każdej chwili ulec zmianie.

2. ZAKAZY

§2.1 Nagość lub wyraźne treści jakiegokolwiek rodzaju - Zabrania się wysyłania nielegalnych treści, takie jak pornograficzne, religijne, naruszające prawa autorskie lub linki zawierające szkodliwe treści nie są u nas mile widziane.

§2.2 Niestestosowny język lub treści, które mogą obrazić inną osobę - Twoje posty na naszym serwerze discord nie powinny mieć na celu skrzywdzenia, zaatakowania, sprowokowania innych osób, nie nadużywaj wulgaryzmów.

§2.3 Avatary, pseudonimy - Zabrania się używania niestosownych, wulgarnych avatarów oraz pseudonimów.

§2.4 Reklamowanie - Zakaz reklamowania innych serwerów, grupek, social mediów. Natomiast możesz umieszczać rzeczy które są związane, z naszym serwerem na kanałach medialnych.

§2.5 Multikonta - Zabrania się tworzenia multikont.

§2.6 SPAM, Caps-Lock - Zabrania się masowego spamowania, nadmiernego używania Caps-Locka.
]]