itemTypes = {
    weapon = 1,
    food = 2,
    clothes = 3,
    keys = 4,
    documents = 5,
    cigarettes = 6,
    joints = 7,
    alcohol = 8,
    mask = 9,
    ammo = 10,
    armor = 11,
    armorplate = 12,
    fishingbait = 13,
    premium = 14,
    gift = 15,
    autograph = 16,
    spray = 17,
    drugs = 18,
    paperSheet = 19,
    boombox = 20,
    flowers = 21,
    diverChest = 22,
    neon = 23,
}

itemCategories = {
    [1] = "weapons",
    [2] = "food",
    [3] = "clothes",
    [4] = "keys",
    [5] = "other",
    [6] = "other",
    [7] = "other",
    [8] = "food",
    [9] = "weapons",
    [10] = "weapons",
    [11] = "weapons",
    [12] = "weapons",
    [13] = "other",
    [14] = "other",
    [15] = "other",
    [16] = "other",
    [17] = "other",
    [18] = "other",
    [19] = "other",
    [20] = "other",
    [21] = "other",
    [22] = "other",
    [23] = "other",
}

weaponsWithoutAmmo = {
    [1] = true,
    [2] = true,
    [3] = true,
    [4] = true,
    [5] = true,
    [6] = true,
    [7] = true,
    [8] = true,
    [9] = true,
}

weaponAmmoType = {
    [31] = 0, -- 5.56
    [23] = 0, -- 5.56
    [33] = 1, -- 6
    [34] = 1, -- 6
    [30] = 2, -- 7.62
    [28] = 3, -- 9
    [29] = 3, -- 9
    [32] = 3, -- 9
    [22] = 4, -- 11.43
    [25] = 5, -- 12
    [26] = 5, -- 12
    [24] = 6, -- 12.7
}

weaponDurability = {
    [22] = 300, -- Colt
    [23] = 400, -- Silenced
    [24] = 200, -- Deagle
    [25] = 100, -- Shotgun
    [26] = 100, -- Sawed-off
    [28] = 600, -- Uzi
    [29] = 500, -- MP5
    [30] = 600, -- AK
    [31] = 900, -- M4
    [32] = 400, -- Tec-9
    [33] = 100, -- Small Sniper
    [34] = 100, -- Sniper
}

weaponSlots = {
    [2] = 1,
    [3] = 1,
    [4] = 1,
    [5] = 1,
    [6] = 1,
    [7] = 1,
    [8] = 1,
    [9] = 1,
    [22] = 2,
    [23] = 2,
    [24] = 2,
    [25] = 3,
    [26] = 3,
    [27] = 3,
    [28] = 4,
    [29] = 4,
    [32] = 4,
    [30] = 5,
    [31] = 5,
    [33] = 6,
    [34] = 6,
    [35] = 7,
    [36] = 7,
    [37] = 7,
    [38] = 7,
    [10] = 10,
    [11] = 10,
    [12] = 10,
    [13] = 10,
    [14] = 10,
    [15] = 10,
    [44] = 11,
    [45] = 11,
    [46] = 11,
}

shootAnim = {
    [3] = { -- Torso
        front = "dam_stomach_frmft",
        back = "dam_stomach_frmbk",
        left = "dam_stomach_frmlt",
        right = "dam_stomach_frmrt",
    },
    [4] = { -- Ass
        front = "dam_stomach_frmft",
        back = "dam_stomach_frmbk",
        left = "dam_stomach_frmlt",
        right = "dam_stomach_frmrt",
    },
    [5] = { -- Left arm
        front = "dam_arml_frmft",
        back = "dam_arml_frmbk",
        left = "dam_arml_frmlt",
    },
    [6] = { -- Right arm
        front = "dam_armr_frmft",
        back = "dam_armr_frmbk",
        right = "dam_armr_frmrt",
    },
    [7] = { -- Left leg
        front = "dam_legl_frmft",
        back = "dam_legl_frmbk",
        left = "dam_legl_frmlt",
    },
    [8] = { -- Right leg
        front = "dam_legr_frmft",
        back = "dam_legr_frmbk",
        right = "dam_legr_frmrt",
    },
}

itemDetails = {
    -- Weapons
    {type = 1, variant = 1, variant2 = 0, name = "Tonfa policyjna", description = "Twarda gumowa pałka. Pomimo wykonania z gumy może zaboleć.", icon = "baton", weight = 460, defaultAdminValue = 3},
    {type = 1, variant = 1, variant2 = 1, name = "Nóż wojskowy", description = "Bardzo ostry nóż mogący bez problemu rozciąć plastik.", icon = "knife", weight = 400, defaultAdminValue = 4},
    {type = 1, variant = 1, variant2 = 2, name = "Kij baseballowy", description = "Służy do gry w baseball, lecz można nim mocno przywalić.", icon = "baseball", weight = 1300, defaultAdminValue = 5},
    {type = 1, variant = 1, variant2 = 3, name = "Katana", description = "Bardzo ostra. Bez problemu może przeciąć gruby kawałek drewna.", icon = "katana", weight = 1000, defaultAdminValue = 8},
    {type = 1, variant = 1, variant2 = 4, name = "Wędka +1", description = "Wędka z siatką idealną do przechowywania ryb.", icon = "fishingrod", weight = 300, defaultAdminValue = 0},
    {type = 1, variant = 1, variant2 = 5, name = "Wędka +2", description = "Wędka z siatką idealną do przechowywania ryb.", icon = "fishingrod", weight = 300, defaultAdminValue = 0},
    {type = 1, variant = 1, variant2 = 6, name = "Wędka +3", description = "Wędka z siatką idealną do przechowywania ryb.", icon = "fishingrod", weight = 300, defaultAdminValue = 0},
    {type = 1, variant = 1, variant2 = 7, name = "Wędka +4", description = "Wędka z siatką idealną do przechowywania ryb.", icon = "fishingrod", weight = 300, defaultAdminValue = 0},
    {type = 1, variant = 1, variant2 = 8, name = "Wędka +5", description = "Wędka z siatką idealną do przechowywania ryb.", icon = "fishingrod", weight = 300, defaultAdminValue = 0},
    {type = 1, variant = 1, variant2 = 9, name = "Wędka +6", description = "Wędka z siatką idealną do przechowywania ryb.", icon = "fishingrod", weight = 300, defaultAdminValue = 0},
    {type = 1, variant = 1, variant2 = 10, name = "Wędka +7", description = "Wędka z siatką idealną do przechowywania ryb.", icon = "fishingrod", weight = 300, defaultAdminValue = 0},
    {type = 1, variant = 1, variant2 = 11, name = "Wędka +8", description = "Wędka z siatką idealną do przechowywania ryb.", icon = "fishingrod", weight = 300, defaultAdminValue = 0},
    {type = 1, variant = 1, variant2 = 12, name = "Wędka +9", description = "Wędka z siatką idealną do przechowywania ryb.", icon = "fishingrod", weight = 300, defaultAdminValue = 0},

    {type = 1, variant = 2, variant2 = 0, name = "Glock 19", description = "Standardowy pistolet służacy do obrony.", icon = "glock", weight = 625, preview = {{title = "Kaliber", value = "11.43mm"}, {title = "Pojemność magazynka", value = "17 naboi"}}, defaultAdminValue = 22},
    {type = 1, variant = 2, variant2 = 1, name = "Desert Eagle", description = "Silny pistolet mogący bez problemu urwać rękę.", weight = 450, icon = "deserteagle", preview = {{title = "Kaliber", value = "12.7mm"}, {title = "Pojemność magazynka", value = "7 naboi"}}, defaultAdminValue = 24},
    {type = 1, variant = 2, variant2 = 2, name = "SIG Mosquito", description = "Wyciszony pistolet idealny do walki po cichu.", weight = 450, icon = "glock", preview = {{title = "Kaliber", value = "12.7mm"}, {title = "Pojemność magazynka", value = "7 naboi"}}, defaultAdminValue = 24},
    {type = 1, variant = 3, variant2 = 0, name = "Remington 870", description = "Jedno pociskowa strzelba o ogromnej sile rażenia.", icon = "shotgun", weight = 2200, preview = {{title = "Kaliber", value = "12mm"}, {title = "Pojemność magazynka", value = "1 nabój"}}, defaultAdminValue = 25},
    {type = 1, variant = 3, variant2 = 1, name = "Sawed-off Remington 870", description = "Potężna dwururka z dużą siłą rażenia.", icon = "sawedoff", weight = 2600, preview = {{title = "Kaliber", value = "12mm"}, {title = "Pojemność magazynka", value = "2 naboje"}}, defaultAdminValue = 26},
    {type = 1, variant = 4, variant2 = 0, name = "Mac-10", description = "Pistolet maszynowy o ogromnej szybkostrzelności.", icon = "mac10", weight = 2800, preview = {{title = "Kaliber", value = "9mm"}, {title = "Pojemność magazynka", value = "50 naboi"}}, defaultAdminValue = 28},
    {type = 1, variant = 4, variant2 = 1, name = "HK MP5", description = "Pistolet maszynowy z tłumikiem płomienia.", icon = "mp5", weight = 2500, preview = {{title = "Kaliber", value = "9mm"}, {title = "Pojemność magazynka", value = "30 naboi"}}, defaultAdminValue = 29},
    {type = 1, variant = 4, variant2 = 2, name = "Tec-9", description = "Kompaktowy pistolet samopowtarzalny.", icon = "tec", weight = 1200, preview = {{title = "Kaliber", value = "9mm"}, {title = "Pojemność magazynka", value = "50 naboi"}}, defaultAdminValue = 32},
    {type = 1, variant = 5, variant2 = 0, name = "AK-47", description = "Karabin automatyczny o bardzo dużej mocy.", icon = "ak47", weight = 3400, preview = {{title = "Kaliber", value = "7.62mm"}, {title = "Pojemność magazynka", value = "30 naboi"}}, defaultAdminValue = 30},
    {type = 1, variant = 5, variant2 = 1, name = "HK416", description = "Karabin automatyczny o dużej szybkostrzelności.", icon = "m4", weight = 3300, preview = {{title = "Kaliber", value = "5.56mm"}, {title = "Pojemność magazynka", value = "50 naboi"}}, defaultAdminValue = 31},
    {type = 1, variant = 6, variant2 = 0, name = "Blaser R93", description = "Karabin myśliwski idealny do polowań na zwierzynę.", icon = "smallsniper", weight = 4900, preview = {{title = "Kaliber", value = "6mm"}, {title = "Pojemność magazynka", value = "1 nabój"}}, defaultAdminValue = 33},
    {type = 1, variant = 6, variant2 = 1, name = "Remington Model 7400", description = "Potężny karabin snajperski z ogromną siłą rażenia.", icon = "sniper", weight = 3400, preview = {{title = "Kaliber", value = "6mm"}, {title = "Pojemność magazynka", value = "1 nabój"}}, defaultAdminValue = 34},

    -- Food
    {type = 2, variant = 0, variant2 = 0, name = "Snapz Crisps", description = "Chipsy jabłkowe i warzywne z niską zawartością tłuszczu.", icon = "chips", weight = 60, preview = {{title = "Leczy", value = "5%"}}},
    {type = 2, variant = 0, variant2 = 1, name = "Zone Perfect Nutrition", description = "Naturalny proteinowy baton przekładany masłem orzechowym.", icon = "chocolate", weight = 15, preview = {{title = "Leczy", value = "9%"}}},
    {type = 2, variant = 0, variant2 = 2, name = "Hawaiian Luau BBQ Chips", description = "Chawajskie solone chipsy ziemniaczane.", icon = "chips", weight = 60, preview = {{title = "Leczy", value = "5%"}}},
    {type = 2, variant = 0, variant2 = 3, name = "Mr. Nature Unsalted Trail Mix", description = "Mieszanka orzeszków, rodzynek, migdałów i ziaren słonecznika.", icon = "chips", weight = 100, preview = {{title = "Leczy", value = "7%"}}},
    {type = 2, variant = 0, variant2 = 4, name = "Miss Vickie's Smokehouse BBQ", description = "Chipsy ziemniaczane o smaku barbecue.", icon = "chips", weight = 60, preview = {{title = "Leczy", value = "5%"}}},
    {type = 2, variant = 0, variant2 = 5, name = "Fruit by the Foot", description = "Gumowaty smakołyk o smaku owocowym.", icon = "chocolate", weight = 25, preview = {{title = "Leczy", value = "5%"}}},
    {type = 2, variant = 0, variant2 = 6, name = "Bon Appetit Blueberry Muffin", description = "Słodka Muffinka z nadzieniem borówkowym.", icon = "cupcake", weight = 80, preview = {{title = "Leczy", value = "5%"}}},
    {type = 2, variant = 0, variant2 = 7, name = "Snickers", description = "Baton z nugatem, orzeszkami ziemnymi w karmelu i czekoladzie.", icon = "chocolate", weight = 40, preview = {{title = "Leczy", value = "5%"}}},
    {type = 2, variant = 0, variant2 = 8, name = "Peanut M&M's", description = "Cukierki z chrupiącym środkiem orzechowym otoczone czekoladą.", icon = "chips", weight = 110, preview = {{title = "Leczy", value = "5%"}}},
    {type = 2, variant = 0, variant2 = 9, name = "Takis Fuego", description = "Pikantne chipsy kukurydziane o smaku papryki chilli z limonką.", icon = "chips", weight = 60, preview = {{title = "Leczy", value = "5%"}}},
    {type = 2, variant = 0, variant2 = 10, name = "Flamin 'Hot Funyuns", description = "Znane i lubiane przez wszystkich krążki cebulowe.", icon = "chips", weight = 45, preview = {{title = "Leczy", value = "5%"}}},
    {type = 2, variant = 0, variant2 = 11, name = "Baby Ruth", description = "Batonik z orzeszków, karmelu i nugatu o smaku mlecznej czekolady.", icon = "chocolate", weight = 25, preview = {{title = "Leczy", value = "9%"}}},
    {type = 2, variant = 0, variant2 = 12, name = "Cliff Bar", description = "Batonik z białą czekoladą i orzechami Macadamia.", icon = "chocolate", weight = 20, preview = {{title = "Leczy", value = "5%"}}},

    {type = 2, variant = 1, variant2 = 0, name = "Sprunk", description = "Napój gazowany o smaku cytrynowo-limonkowym.", icon = "can", weight = 330, preview = {{title = "Leczy", value = "5%"}}},
    {type = 2, variant = 1, variant2 = 1, name = "Cola", description = "Słodki napój gazowany z dużą zawartością cukru.", icon = "can", weight = 330, preview = {{title = "Leczy", value = "5%"}}},
    {type = 2, variant = 1, variant2 = 9, name = "Fanta", description = "Napój gazowany o smaku owocowym.", icon = "can", weight = 330, preview = {{title = "Leczy", value = "5%"}}},
    {type = 2, variant = 1, variant2 = 2, name = "Vitamin water", description = "Woda mineralna z dodatkiem witamin.", icon = "bottle", weight = 500, preview = {{title = "Leczy", value = "5%"}}},
    {type = 2, variant = 1, variant2 = 3, name = "Mineral water", description = "Czysta woda mineralna.", icon = "bottle", weight = 500, preview = {{title = "Leczy", value = "5%"}}},
    {type = 2, variant = 1, variant2 = 4, name = "Hi-C", description = "Punch o smaku owocowym.", icon = "can", weight = 330, preview = {{title = "Leczy", value = "5%"}}},
    {type = 2, variant = 1, variant2 = 5, name = "Seagram's Ginger Ale", description = "Bezkofeinowy napój o smaku imbiru.", icon = "can", weight = 330, preview = {{title = "Leczy", value = "5%"}}},
    {type = 2, variant = 1, variant2 = 6, name = "FUZE Iced Tea", description = "Orzeźwiająca herbata mrożona.", icon = "bottle", weight = 500, preview = {{title = "Leczy", value = "5%"}}},
    {type = 2, variant = 1, variant2 = 7, name = "Powerade", description = "Napój izotoniczny.", icon = "bottle", weight = 500, preview = {{title = "Leczy", value = "5%"}}},
    {type = 2, variant = 1, variant2 = 8, name = "Mello yello", description = "Wysoko kofeinowy napój o smaku cytrusowym.", icon = "can", weight = 330, preview = {{title = "Leczy", value = "5%"}}},

    {type = 2, variant = 2, variant2 = 0, name = "Hamburger", description = "Pyszny hamburger ze świeżo wypieczonym mięsem.", icon = "burger", weight = 100, preview = {{title = "Leczy", value = "7%"}}},
    {type = 2, variant = 2, variant2 = 1, name = "Cheesburger", description = "Pyszny hamburger ze świeżo wypieczonym mięsem i serem.", icon = "burger", weight = 105, preview = {{title = "Leczy", value = "7%"}}},

    {type = 2, variant = 3, variant2 = 0, name = "Frytki bez soli", description = "Świeżo usmażone frytki.", icon = "fries", weight = 150, preview = {{title = "Leczy", value = "7%"}}},
    {type = 2, variant = 3, variant2 = 1, name = "Frytki z solą", description = "Świeżo usmażone frytki posypane solą.", icon = "fries", weight = 150, preview = {{title = "Leczy", value = "7%"}}},

    {type = 2, variant = 4, variant2 = 0, name = "Hot-dog", description = "Świeży hot-dog z ketchupem.", icon = "hotdog", weight = 155, preview = {{title = "Leczy", value = "9%"}}},
    {type = 2, variant = 4, variant2 = 1, name = "Hot-dog", description = "Świeży hot-dog z musztardą.", icon = "hotdog", weight = 150, preview = {{title = "Leczy", value = "9%"}}},
    {type = 2, variant = 4, variant2 = 2, name = "Hot-dog", description = "Świeży hot-dog z musztardą i ketchupem.", icon = "hotdog", weight = 160, preview = {{title = "Leczy", value = "9%"}}},

    {type = 2, variant = 5, variant2 = 0, name = "Mały koszyczek owoców", description = "Mały koszyk wypchany pysznymi owocami.", icon = "fruits", weight = 160, preview = {{title = "Leczy", value = "5%"}}},
    {type = 2, variant = 5, variant2 = 1, name = "Średni koszyczek owoców", description = "Średni koszyk wypchany pysznymi owocami.", icon = "fruits", weight = 320, preview = {{title = "Leczy", value = "10%"}}},
    {type = 2, variant = 5, variant2 = 2, name = "Duży koszyczek owoców", description = "Duży koszyk wypchany pysznymi owocami.", icon = "fruits", weight = 480, preview = {{title = "Leczy", value = "15%"}}},
    {type = 2, variant = 5, variant2 = 3, name = "Mały koszyczek warzyw", description = "Mały koszyk wypchany pysznymi warzywami.", icon = "vegetables", weight = 160, preview = {{title = "Leczy", value = "5%"}}},
    {type = 2, variant = 5, variant2 = 4, name = "Średni koszyczek warzyw", description = "Średni koszyk wypchany pysznymi warzywami.", icon = "vegetables", weight = 320, preview = {{title = "Leczy", value = "10%"}}},
    {type = 2, variant = 5, variant2 = 5, name = "Duży koszyczek warzyw", description = "Duży koszyk wypchany pysznymi warzywami.", icon = "vegetables", weight = 480, preview = {{title = "Leczy", value = "15%"}}},

    -- Cluckin bell
    {type = 2, variant = 7, variant2 = 0, name = "Gdaczący ogromny zestaw", description = "Duży kubełek, podwójny Fowl Burger, duże frytki i Sprunk.", icon = "foodset", weight = 1300, preview = {{title = "Leczy", value = "32%"}}},
    {type = 2, variant = 7, variant2 = 1, name = "Gdaczący duży zestaw", description = "Duże frytki, Fillet Burger i Sprunk.", icon = "foodset", weight = 900, preview = {{title = "Leczy", value = "25%"}}},
    {type = 2, variant = 7, variant2 = 2, name = "Gdaczący mały zestaw", description = "Zestaw dla dzieci. Frytki, Sprunk i zabawkowy Bobby Broiler.", icon = "foodset", weight = 400, preview = {{title = "Leczy", value = "15%"}}},
    {type = 2, variant = 7, variant2 = 3, name = "Little Clucker", description = "Zestaw dla dzieci. Frytki, Small Wing Piece, Sprunk.", icon = "foodset", weight = 400, preview = {{title = "Leczy", value = "12%"}}},
    {type = 2, variant = 7, variant2 = 4, name = "Sałatka", description = "Pełnowartościowa sałatka warzywna z kurczakiem i Sprunk.", icon = "salad", weight = 500, preview = {{title = "Leczy", value = "9%"}}},
    {type = 2, variant = 7, variant2 = 5, name = "Small Wing Piece", description = "Mała porcja skrzydełek z sosem słodko-kwaśnym.", icon = "chickenwings", weight = 300, preview = {{title = "Leczy", value = "10%"}}},
    {type = 2, variant = 7, variant2 = 6, name = "Wing Piece", description = "Duża porcja skrzydełek z sosem słodko-kwaśnym.", icon = "chickenwings", weight = 500, preview = {{title = "Leczy", value = "8%"}}},
    {type = 2, variant = 7, variant2 = 7, name = "Fowl Burger", description = "Hamburger ze świeżo wypieczonym mięsem.", icon = "burger", weight = 200, preview = {{title = "Leczy", value = "8%"}}},
    {type = 2, variant = 7, variant2 = 8, name = "Fillet Burger", description = "Hamburger z paluszkiem rybnym w środku.", icon = "burger", weight = 170, preview = {{title = "Leczy", value = "8%"}}},

    -- Burger Shot
    {type = 2, variant = 8, variant2 = 0, name = "Stos mięsa", description = "Duże frytki, podwójny Hamburger, duży Sprunk.", icon = "foodset", weight = 900, preview = {{title = "Leczy", value = "30%"}}},
    {type = 2, variant = 8, variant2 = 1, name = "Wołowa wieża", description = "Duże frytki, średni Hamburger, średni Sprunk.", icon = "foodset", weight = 750, preview = {{title = "Leczy", value = "24%"}}},
    {type = 2, variant = 8, variant2 = 2, name = "Porykujący zestaw dziecięcy", description = "Zestaw dla dzieci. Małe frytki, hamburger, mały Sprunk.", icon = "foodset", weight = 300, preview = {{title = "Leczy", value = "15%"}}},
    {type = 2, variant = 8, variant2 = 3, name = "Sałatka", description = "Pełnowartościowa sałatka warzywna z wołowiną i Sprunk.", icon = "salad", weight = 600, preview = {{title = "Leczy", value = "20%"}}},

    -- Pizza
    {type = 2, variant = 9, variant2 = 0, name = "Pełny stojak", description = "Bardzo duże frytki, cała pizza, duży Sprunk.", icon = "foodset", weight = 2000, preview = {{title = "Leczy", value = "40%"}}},
    {type = 2, variant = 9, variant2 = 1, name = "Podwójny D-Luxe", description = "Duże frytki, duży kawałek pizzy, mała sałatka, duży Sprunk.", icon = "foodset", weight = 1200, preview = {{title = "Leczy", value = "32%"}}},
    {type = 2, variant = 9, variant2 = 2, name = "Buster", description = "Małe Frytki, średni kawałek pizzy, mały Sprunk.", icon = "foodset", weight = 600, preview = {{title = "Leczy", value = "24%"}}},
    {type = 2, variant = 9, variant2 = 3, name = "Posiłek sałatkowy", description = "Pełnowartościowa sałatka warzywna z baraniną i sosem, Sprunk.", icon = "salad", weight = 500, preview = {{title = "Leczy", value = "18%"}}},
    {type = 2, variant = 9, variant2 = 4, name = "Cała pizza", description = "Pizza z pieczarkami, salami, cebulą i ogromną ilością sera.", icon = "pizza", weight = 1600, preview = {{title = "Leczy", value = "26%"}}},
    {type = 2, variant = 9, variant2 = 5, name = "Kawałek pizzy", description = "Kawałek pizzy z pieczarkami, salami, cebulą i ogromną ilością sera.", icon = "pizzaslice", weight = 200, preview = {{title = "Leczy", value = "12%"}}},

    -- Donuts
    {type = 2, variant = 10, variant2 = 0, name = "Rusty’s Huge Double", description = "Duże opakowanie pączków z lukrem i posypką, duża kawa.", icon = "donuts", weight = 3000, preview = {{title = "Leczy", value = "27%"}}},
    {type = 2, variant = 10, variant2 = 1, name = "Rusty’s Double Barrel", description = "Duże opakowanie pączków z lukrem, średnia kawa.", icon = "donuts", weight = 2700, preview = {{title = "Leczy", value = "18%"}}},
    {type = 2, variant = 10, variant2 = 2, name = "Rusty’s D-Luxe", description = "Czekoladowa muffinka, pączek z cukrem, mała kawa.", icon = "donuts", weight = 700, preview = {{title = "Leczy", value = "9%"}}},
    {type = 2, variant = 10, variant2 = 3, name = "Double Choc Whammy", description = "Podwójne czekoladowe pączki.", icon = "donut", weight = 500, preview = {{title = "Leczy", value = "6%"}}},
    {type = 2, variant = 10, variant2 = 4, name = "Fudge Packed Donuts ", description = "Krówkowe pączki.", icon = "donut", weight = 500, preview = {{title = "Leczy", value = "4%"}}},
    {type = 2, variant = 10, variant2 = 5, name = "Kawa parzona", description = "Czarna kawa parzona.", icon = "coffee", weight = 500, preview = {{title = "Leczy", value = "8%"}}},
    {type = 2, variant = 10, variant2 = 6, name = "Kawa rozpuszczalna", description = "Czarna kawa rozpuszczalna.", icon = "coffee", weight = 500, preview = {{title = "Leczy", value = "2%"}}},

    -- Clothes
    {type = 3, variant = 0, variant2 = 0, name = "Ubranie z Binco", description = "Standardowe ubranie nie wyróżniające się z tłumu.", icon = "clothes", weight = 1700},
    {type = 3, variant = 1, variant2 = 0, name = "Ubranie z Sub Urban", description = "Standardowe ubranie nie wyróżniające się z tłumu.", icon = "clothes", weight = 1700},
    {type = 3, variant = 2, variant2 = 0, name = "Ubranie z Victim", description = "Ubranie bardziej dostojne, tworzone przez projektantów.", icon = "zip", weight = 1600},
    {type = 3, variant = 3, variant2 = 0, name = "Ubranie z ZIP", description = "Ubranie lepszej jakości, wykonane z lepszego materiału.", icon = "zip", weight = 1600},
    {type = 3, variant = 4, variant2 = 0, name = "Ubranie z Dider Sachs", description = "Bardzo gustowne ubranie noszone przez elitę.", icon = "didier", weight = 1700},
    {type = 3, variant = 5, variant2 = 0, name = "Ubranie z ProLaps", description = "Ubranie sportowe noszone podczas treningów.", icon = "prolaps", weight = 1500},
    {type = 3, variant = 6, variant2 = 0, name = "Ubranie z Ranch", description = "Ubranie robocze typowe dla farmerów.", icon = "clothes", weight = 1900},
    {type = 3, variant = 7, variant2 = 0, name = "Ubranie z Kevin Clone", description = "Ubranie bardzo wysokiej jakości dla graczy Gold.", icon = "clothes", weight = 2000},
    {type = 3, variant = 8, variant2 = 0, name = "Ubranie z Gnocchi", description = "Ubranie bardzo wysokiej jakości dla graczy Diamond.", icon = "clothes", weight = 2000},
    {type = 3, variant = 9, variant2 = 0, name = "Strój Świąteczny", description = "Bardzo wyjątkowe ubranie podarowane przez samego Mikołaja.", icon = "christmasHat", weight = 1800},
    {type = 3, variant = 10, variant2 = 0, name = "Strój Pirata", description = "Bardzo wyjątkowe ubranie. Nawet drewniana noga jest w komplecie.", icon = "woodenLeg", weight = 2200},

    -- Documents
    {type = 4, variant = 0, variant2 = 0, name = "Klucz do pojazdu", description = "Klucz umożliwiający otworzenie twojego prywatnego pojazdu.", icon = "carkey", weight = 10, blockTrade = true},
    {type = 4, variant = 1, variant2 = 0, name = "Klucz do posiadłości", description = "Klucz umożliwiający otworzenie twojego wymarzonego domu.", icon = "housekey", weight = 10, blockTrade = true},

    -- Keys
    {type = 5, variant = 0, variant2 = 0, name = "Dowód osobisty", description = "Dokument potrzebny do załatwiania spraw urzędowych.", icon = "id", weight = 24, blockTrade = true},
    {type = 5, variant = 1, variant2 = 0, name = "Prawo jazdy", description = "Dokument uprawniający do prowadzenia pojazdów danej kategorii.", icon = "licence", weight = 24, blockTrade = true},
    {type = 5, variant = 1, variant2 = 1, name = "Licencja nurka", description = "Dokument uprawniający do nurkowania z butlą tlenową.", icon = "divingLicence", weight = 24, blockTrade = true},
    {type = 5, variant = 1, variant2 = 2, name = "Licencja żeglarska", description = "Dokument uprawniający do pływania łodziami.", icon = "boatLicence", weight = 24, blockTrade = true},
    {type = 5, variant = 2, variant2 = 0, name = "Karta płatnicza", description = "Karta umożliwiająca korzystanie z bankomatu i płatność zbliżeniową.", icon = "creditcard", weight = 32, blockTrade = true},
    {type = 5, variant = 3, variant2 = 0, name = "Telefon komórkowy", description = "Trochę stary model, ale można z niego dzwonić i wysyłać SMS.", icon = "phone", weight = 180, blockTrade = true},

    -- Cigarettes
    {type = 6, variant = 0, variant2 = 0, name = "Marlboro", description = "Wyrób tytoniowy.", icon = "cigarettes", weight = 180, defaultAdminValue = 10},

    -- Joints
    {type = 7, variant = 0, variant2 = 0, name = "Joint z Marihuaną", description = "Kilka buchów i człowiek pozamiatany.", icon = "joint", weight = 8, defaultAdminValue = 1},
    {type = 7, variant = 0, variant2 = 1, name = "Twoja działka od Dawn'a", description = "Kilka buchów i człowiek pozamiatany.", icon = "joint", weight = 8, canRemove = false, blockFavourite = true, fakeItem = true},
    {type = 7, variant = 0, variant2 = 2, name = "Działka dla przewoźnika od Dawn'a", description = "Kilka buchów i człowiek pozamiatany.", icon = "joint", weight = 8, canRemove = false, blockUse = true, blockFavourite = true, fakeItem = true},
    {type = 7, variant = 0, variant2 = 3, name = "Joint z Haszyszem", description = "Kilka buchów i człowiek pozamiatany.", icon = "joint", weight = 8, defaultAdminValue = 1},

    -- Alkohol
    {type = 8, variant = 0, variant2 = 0, name = "Anthem Vodka", description = "Standardowa butelka 0.7l wódki.", icon = "vodka", weight = 780, preview = {{title = "Stężenie alkoholu", value = "40%"}}},
    {type = 8, variant = 1, variant2 = 0, name = "Absolut Vodka", description = "Standardowa butelka 0.7l wódki.", icon = "vodka", weight = 780, preview = {{title = "Stężenie alkoholu", value = "44%"}}},
    {type = 8, variant = 2, variant2 = 0, name = "50 Bleu Ultra Premium Vodka", description = "Standardowa butelka 0.7l wódki.", weight = 780, icon = "vodka", preview = {{title = "Stężenie alkoholu", value = "48%"}}},

    {type = 8, variant = 0, variant2 = 1, name = "Modelo Especia", description = "Piwo warzone w Meksyku.", icon = "beer", weight = 510, preview = {{title = "Stężenie alkoholu", value = "8%"}}},
    {type = 8, variant = 1, variant2 = 1, name = "Pilsner Urquell", description = "Jasne piwo produkowane w Czechach.", weight = 510, icon = "beer", preview = {{title = "Stężenie alkoholu", value = "7%"}}},
    {type = 8, variant = 2, variant2 = 1, name = "Warstainer", description = "Piwo warzone w leśnym parku przyrody Arnsberg.", weight = 510, icon = "beer", preview = {{title = "Stężenie alkoholu", value = "9%"}}},
    {type = 8, variant = 3, variant2 = 1, name = "Heineken", description = "Piwo warzone w Holandii.", icon = "beer", weight = 510, preview = {{title = "Stężenie alkoholu", value = "5%"}}},
    {type = 8, variant = 4, variant2 = 1, name = "Budweiser", description = "Amerykańskie piwo z dodatkiem ryżu.", icon = "beer", weight = 510, preview = {{title = "Stężenie alkoholu", value = "7%"}}},

    -- Masks
    {type = 9, variant = 0, variant2 = 0, name = "Kominiarka", description = "Dzięki niej staniesz się anonimowy... No może nie do końca.", icon = "mask", weight = 150},

    -- Ammo
    {type = 10, variant = 0, variant2 = 0, name = "Amunicja 5.56mm (50 sztuk)", description = "Amunicja pasująca do HK416, SIG Mosquito.", icon = "6mm", weight = 500},
    {type = 10, variant = 1, variant2 = 0, name = "Amunicja 6mm (10 sztuk)", description = "Amunicja pasująca do Blaser R93 oraz Remington Model 7400.", icon = "6mm", weight = 180},
    {type = 10, variant = 2, variant2 = 0, name = "Amunicja 7.62mm (30 sztuk)", description = "Amunicja pasująca do AK-47.", icon = "6mm", weight = 450},
    {type = 10, variant = 3, variant2 = 0, name = "Amunicja 9mm (50 sztuk)", description = "Amunicja pasująca do Mac-10, HK MP5 oraz Tec-9.", icon = "11mm", weight = 790},
    {type = 10, variant = 4, variant2 = 0, name = "Amunicja 11.43mm (20 sztuk)", description = "Amunicja pasująca do Glock 19.", icon = "11mm", weight = 550},
    {type = 10, variant = 5, variant2 = 0, name = "Amunicja 12mm (20 sztuk)", description = "Amunicja pasująca do Remington 870 oraz wersji Sawed-off.", icon = "12mm", weight = 750},
    {type = 10, variant = 6, variant2 = 0, name = "Amunicja 12.7mm (10 sztuk)", description = "Amunicja pasująca do Desert Eagle.", icon = "6mm", 640},

    -- Armor
    {type = 11, variant = 0, variant2 = 0, name = "Kamizelka kuloodporna", description = "Dzięki niej staniesz się niewrażliwy na pociski... Prawie.", icon = "armor", weight = 11500, defaultAdminValue = 100},

    -- Armor plate
    {type = 12, variant = 0, variant2 = 0, name = "Płyta kuloodporna", description = "Wymieniając ją w kamizelce kuloodpornej możesz ją odnowić.", weight = 6500, icon = "armorplate", preview = {{title = "Odporność", value = "50%"}}},

    -- Fishing bait
    {type = 13, variant = 0, variant2 = 0, name = "Kukurydza", description = "Starcza na 30 zarzutów. Dostępne dla wędek +1.", icon = "fishingbait", weight = 300},
    {type = 13, variant = 1, variant2 = 0, name = "Robaki czerwone", description = "Starcza na 30 zarzutów. Dostępne dla wędek +7.", icon = "fishingbait", weight = 200},
    {type = 13, variant = 2, variant2 = 0, name = "Robaki białe", description = "Starcza na 30 zarzutów. Dostępne dla wędek +5.", icon = "fishingbait", weight = 180},
    {type = 13, variant = 3, variant2 = 0, name = "Pęczak", description = "Starcza na 30 zarzutów. Dostępne dla wędek +3.", icon = "fishingbait", weight = 340},
    {type = 13, variant = 4, variant2 = 0, name = "Żywe ryby", description = "Starcza na 15 zarzutów. Dostępne dla wędek +9.", icon = "fishingbait", weight = 650},

    -- Premium
    {type = 14, variant = 0, variant2 = 0, name = "Konto Gold", description = "Ten token pozwala na otrzymanie konta Gold.", icon = "crown", weight = 0, defaultAdminValue = 7},
    {type = 14, variant = 1, variant2 = 0, name = "Konto Diamond", description = "Ten token pozwala na otrzymanie konta Diamond.", icon = "diamond", weight = 0, defaultAdminValue = 7},

    -- Gifts
    {type = 15, variant = 0, variant2 = 0, name = "Prezent Świąteczny", description = "W środku znajduje się ciekawa nagroda.", icon = "gift", weight = 50},
    {type = 15, variant = 0, variant2 = 1, name = "Duży prezent świąteczny", description = "W środku znajduje się ciekawa nagroda.", icon = "gift", weight = 50},

    -- Autograph
    {type = 16, variant = 0, variant2 = 0, name = "Autograf DeMoNeK_", description = "Własnoręczny autograf pdpisany przez DeMoNeK_. Jego łaska potrafi uzdrowić.", icon = "xantris", weight = 10},
    {type = 16, variant = 1, variant2 = 0, name = "Autograf NyAngel", description = "Własnoręczny autograf samego NyAngela. Jego łaska potrafi uzdrowić.", icon = "wilku", weight = 10},
    {type = 16, variant = 2, variant2 = 0, name = "Autograf mAti", description = "Własnoręczny autograf samego mAtiego. Jego łaska potrafi uzdrowić.", icon = "vanze", weight = 10},
    {type = 16, variant = 3, variant2 = 0, name = "Autograf Tryptaminista", description = "Własnoręczny autograf samego Tryptaministe. Jego łaska potrafi uzdrowić.", icon = "moses", weight = 10},
    {type = 16, variant = 4, variant2 = 0, name = "Mała apteczka", description = "Pełna różnego rodzaju bandaży, leków i plastrów. Można użyć 1 raz.", icon = "firstAidKit", weight = 140},
    {type = 16, variant = 4, variant2 = 1, name = "Duża apteczka", description = "Pełna różnego rodzaju bandaży, leków i plastrów. Można użyć 5 razy.", icon = "firstAidKit", weight = 300},

    -- Spray
    {type = 17, variant = 0, variant2 = 0, name = "Puszka sprayu", description = "Idealnie nadaje się do sprayowania na murach.", icon = "sprayCan", weight = 500},

    -- Drugs
    {type = 18, variant = 0, variant2 = 0, name = "Haszysz", description = "Idealnie nadaje się do skręcenia jointa.", icon = "marijuana", weight = 1, blockUse = true, blockRemove = true, stackable = true},
    {type = 18, variant = 0, variant2 = 1, name = "Marihuana", description = "Idealnie nadaje się do skręcenia jointa.", icon = "marijuana", weight = 1, blockUse = true, blockRemove = true, stackable = true},

    {type = 18, variant = 1, variant2 = 0, name = "Heroina", description = "Narkotyk należący do grupy opioidów.", icon = "heroina", weight = 1, stackable = true, blockRemove = true},
    {type = 18, variant = 1, variant2 = 1, name = "LSD", description = "Jedna z najsilniejszych substancji halucynogennych.", icon = "pills", weight = 1, stackable = true, blockRemove = true},
    {type = 18, variant = 1, variant2 = 2, name = "MDMA", description = "Popularny klubowy narkotyk w czystej postaci.", icon = "pills", weight = 1, stackable = true, blockRemove = true},
    {type = 18, variant = 1, variant2 = 3, name = "DMT", description = "Psychodeliczna substancja psychoaktywna.", icon = "cocaine", weight = 1, stackable = true, blockRemove = true},
    {type = 18, variant = 1, variant2 = 4, name = "Crack", description = "Najtańsza i najbardziej uzależniającą postać kokainy.", icon = "cocaine", weight = 1, stackable = true, blockRemove = true},

    {type = 18, variant = 2, variant2 = 0, name = "Kokaina", description = "Kolumbijski śnieg.", icon = "cocaine", weight = 1, stackable = true, blockRemove = true},
    {type = 18, variant = 2, variant2 = 1, name = "Amfetamina", description = "Silny środek psychostymulujący, po użyciu zbieraj pieniądze na dentyste.", icon = "cocaine", weight = 1, stackable = true, blockRemove = true},
    {type = 18, variant = 2, variant2 = 2, name = "Metaamfetamina", description = "Pochodna amfetaminy o bardzo silnym działaniu pobudzającym.", icon = "cocaine", weight = 1, stackable = true, blockRemove = true},

    {type = 18, variant = 3, variant2 = 0, name = "Xanax", description = "Popularny lek psychotropowy, działa bardzo uspokająjąco.", icon = "xanax", weight = 1, stackable = true, blockRemove = true},
    {type = 18, variant = 3, variant2 = 1, name = "Adderall", description = "Lek stosowany w leczniu ADHD i ADD.", icon = "xanax", weight = 1, stackable = true, blockRemove = true},

    -- Paper sheet
    {type = 19, variant = 0, variant2 = 0, name = "Paczka bletek", description = "Kawałeczki papieru przygotowane do skręcania blantów z Haszyszu.", icon = "paperSheet", weight = 30, defaultAdminValue = 30},
    {type = 19, variant = 0, variant2 = 1, name = "Paczka bletek", description = "Kawałeczki papieru przygotowane do skręcania blantów z Marichuany.", icon = "paperSheet", weight = 30, defaultAdminValue = 30},

    -- Boombox
    {type = 20, variant = 0, variant2 = 0, name = "Boombox", description = "Radio idealne do słuchania muzyki wraz ze znajomymi.", icon = "boombox", weight = 3000},

    -- Flowers
    {type = 21, variant = 0, variant2 = 0, name = "Bukiet kwiatów", description = "Idealnie nadają się na prezent dla kobiety.", icon = "flowers", weight = 150, defaultAdminValue = 0, blockUse = true},

    -- Chest
    {type = 22, variant = 0, variant2 = 0, name = "Srebrna szkatułka", description = "Srebrna szkatułka zamknięta na klucz.", icon = "chest", weight = 350, blockUse = true},
    {type = 22, variant = 0, variant2 = 1, name = "Paczka złota", description = "Mieszek wypełniony starymi złotymi monetami.", icon = "goldBag", weight = 450, blockUse = true},
    {type = 22, variant = 0, variant2 = 2, name = "Stare szmaty", description = "Wygląda interesująco, może Jack zainteresuje się tym ubraniem...", icon = "cloth", weight = 80, blockUse = true},

    -- Neon
    {type = 23, variant = 0, variant2 = 0, name = "Unikalne neony", description = "Unikalne neony, które możesz zamontować w pojeździe.", icon = "neon", weight = 1000},

    -- Gang utils
    {type = 24, variant = 0, variant2 = 0, name = "Nasiono Marichuany", description = "Idealne do posadzenia własnego krzaka.", icon = "seedBag", weight = 1, blockUse = true, stackable = true},
    {type = 24, variant = 0, variant2 = 1, name = "Nasiono Haszyszu", description = "Idealne do posadzenia własnego krzaka.", icon = "seedBag", weight = 1, blockUse = true, stackable = true},
    {type = 24, variant = 0, variant2 = 2, name = "Nawóz organiczny", description = "Nawóz idealnie nadający się do roślin.", icon = "fertilizer", weight = 1, blockUse = true, stackable = true},

    {type = 24, variant = 1, variant2 = 0, name = "Fenyloaceton", description = "Silny środek chemiczny.", icon = "chemicalBottle", weight = 500, blockUse = true, stackable = true},
    {type = 24, variant = 1, variant2 = 1, name = "Metyloamina", description = "Silny środek chemiczny.", icon = "chemicalBottle", weight = 500, blockUse = true, stackable = true},
    {type = 24, variant = 1, variant2 = 2, name = "Liście Krasnodrzewu", description = "Zebrane prosto od farmerów z Kolumbii.", icon = "leaves", weight = 10, blockUse = true, stackable = true},

    {type = 24, variant = 2, variant2 = 0, name = "Części broni", description = "Kupka śrubek i narkętek. Pewnie można coś z tego zrobić.", icon = "nuts", weight = 20, blockUse = true, stackable = true},
    {type = 24, variant = 2, variant2 = 1, name = "Tłumik do broni", description = "Po nakręceniu na broń redukuje jej odgłos wystrzału.", icon = "suppressor", weight = 500, blockUse = true, stackable = true},
    {type = 24, variant = 2, variant2 = 2, name = "Kolba do broni", description = "Pomaga ustabilizować broń podczas strzelania serią.", icon = "attachmentWeapon", weight = 700, blockUse = true, stackable = true},

    -- RC Cars, added by DeMoNeK_
    {type = 25, variant = 0, variant2 = 0, name = "Samochodzik Witek", description = "Zdalnie sterowany samochodzik z kolorem od Witka", icon = "car", weight = 1, blockUse = true},
}


local itemFormat = [[%s    {
        "type": %d,
        "variant": %d,
        "variant2": %d,
        "name": "%s",
        "description": "%s",
        "icon": "%s"
    },
]]
function loadItemsToJSON()
    local text = ""
    local file = fileCreate("itemsList.json")

    for i, v in pairs(itemDetails) do
        text = string.format(itemFormat, text, v.type, v.variant, v.variant2, v.name, v.description, v.icon)
    end

    fileWrite(file, "[\n", string.sub(text, 0, string.len(text) - 2), "\n]")
    fileClose(file)
end
-- loadItemsToJSON()