dxTexture = dxCreateTexture;

local textures = {
	blip_0 = 'assets/blip/0.png',
	blip_1 = 'assets/blip/1.png',
	blip_2 = 'assets/blip/2.png',
	blip_3 = 'assets/blip/3.png',
	blip_4 = 'assets/blip/4.png',
	blip_5 = 'assets/blip/5.png',
	blip_6 = 'assets/blip/6.png',
	blip_7 = 'assets/blip/7.png',
	blip_8 = 'assets/blip/8.png',
	blip_9 = 'assets/blip/9.png',
	blip_10 = 'assets/blip/10.png',
	blip_11 = 'assets/blip/11.png',
	blip_12 = 'assets/blip/12.png',
	blip_13 = 'assets/blip/13.png',
	blip_14 = 'assets/blip/14.png',
	blip_15 = 'assets/blip/15.png',
	blip_16 = 'assets/blip/16.png',
	blip_17 = 'assets/blip/17.png',
	blip_18 = 'assets/blip/18.png',
	blip_19 = 'assets/blip/19.png',
	blip_20 = 'assets/blip/20.png',
	blip_21 = 'assets/blip/21.png',
	blip_22 = 'assets/blip/22.png',
	blip_23 = 'assets/blip/23.png',
	blip_24 = 'assets/blip/24.png',
	blip_25 = 'assets/blip/25.png',
	blip_26 = 'assets/blip/26.png',
	blip_27 = 'assets/blip/27.png',
	blip_28 = 'assets/blip/28.png',
	blip_29 = 'assets/blip/29.png',
	blip_30 = 'assets/blip/30.png',
	blip_31 = 'assets/blip/31.png',
	blip_32 = 'assets/blip/32.png',
	blip_33 = 'assets/blip/33.png',
	blip_34 = 'assets/blip/34.png',
	blip_35 = 'assets/blip/35.png',
	blip_36 = 'assets/blip/36.png',
	blip_37 = 'assets/blip/37.png',
	blip_38 = 'assets/blip/38.png',
	blip_39 = 'assets/blip/39.png',
	blip_40 = 'assets/blip/40.png',
	blip_41 = 'assets/blip/41.png',
	blip_42 = 'assets/blip/42.png',
	blip_43 = 'assets/blip/43.png',
	blip_44 = 'assets/blip/44.png',
	blip_45 = 'assets/blip/45.png',
	blip_46 = 'assets/blip/46.png',
	blip_47 = 'assets/blip/47.png',
	blip_48 = 'assets/blip/48.png',
	blip_49 = 'assets/blip/49.png',
	blip_50 = 'assets/blip/50.png',
	blip_51 = 'assets/blip/51.png',
	blip_52 = 'assets/blip/52.png',
	blip_53 = 'assets/blip/53.png',
	blip_54 = 'assets/blip/54.png',
	blip_55 = 'assets/blip/55.png',
	blip_56 = 'assets/blip/56.png',
	blip_57 = 'assets/blip/57.png',
	blip_58 = 'assets/blip/58.png',
	blip_59 = 'assets/blip/59.png',
	blip_60 = 'assets/blip/60.png',
	blip_61 = 'assets/blip/61.png',
	blip_62 = 'assets/blip/62.png',
	blip_63 = 'assets/blip/63.png',
	blip_64 = 'assets/blip/64.png',
	blip_65 = 'assets/blip/65.png',
};

--[[
for i=1,65 do
	outputConsole("blip_"..i.." = 'assets/blip/"..i..".png',");
end;]]

local textures_cache = {};

function getTexture(name)
	assert(type(name) == "string", "TR_textures: argument 'name' must be string");

	local names = textures[name];
	if names then
		if not textures_cache[names] then
			textures_cache[names] = dxCreateTexture(names);
		end;

		return textures_cache[names];
	end;
	return false;
end;

--[[
function getTextures()
	for i = 1,65 do
		if not textures_cache[i] then
			textures_cache[i] = dxTexture('assets/blip/'..i..'.png');
		end;

		return textures_cache[i];
	end;
end;

function destroyAllTextures()
	for i,v in ipairs(textures_cache) do
		destroyElement(v);
	end;
end;

function destroyTexture(name)
	assert(type(name) == "string", "TR_textures: argument 'name' must be string");

	local texture = textures_cache[name];
	if texture then
		destroyElement(texture);

		print('[TR_textures] Usunięto teksture o nazwie '..name);
	end;
end;
]]