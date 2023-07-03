jobSettings = {
    name = "Praca w kamieniołomie",
    desc = "Praca polega na drążeniu tunelu i wydobyciu kamienia. Nie przy wszystkich operacjach może brać udział maszyna. W takim miejscu w jakim drążony jest tunel należy zachować szczególną ostrożność aby nie zawaliła się droga dojazdowa powyżej. Twoim zadaniem będzie umieszczanie ładunków wybuchowych w ścianie i zbieranie ukruszonych kamieni.",
    require = "Doświadczenie: 600pkt",
    earnings = "$6000",

    upgrades = {
        {
            name = "Silniejszy dynamit",
            desc = "Ulepszenie to sprawi, że będziesz musiał umieścić w ścianie mniej lasek dynamitu.",
            price = 500,
            type = "dynamite",
            additionalMoney = {300, 400},
        },
        {
            name = "Precyzyjny zapalnik",
            desc = "Ulepszenie to sprawi, że ze ściany odpadnie mniej kawałków skał.",
            price = 900,
            type = "igniter",
            additionalMoney = {500, 600},
        },
    },
}

function getJobDetails()
    return jobSettings
end