jobSettings = {
    name = "Praca w sadzie",
    desc = "Praca polega na zbieraniu dojrzałych jabłek z drzew znajdujących się w sadzie.\nPamiętaj, że twój koszyk ma ograniczoną pojemność, oraz powinieneś zbierać tylko te jabłka, które są dojrzałe. Za kolejne kursy otrzymasz więcej pieniędzy.",
    require = "Doświadczenie: 70pkt",
    earnings = "$4000",

    upgrades = {
        {
            name = "Większy koszyk",
            desc = "Ulepszenie to pozwala zbierać więcej jabłek.",
            price = 100,
            type = "box",
            additionalMoney = {400, 600}
        },
        {
            name = "Zdrowe życie",
            desc = "Ulepszenie to pozwala znajdować mniej zgniłych jabłek.",
            price = 300,
            type = "apple",
        },
        {
            name = "Szczęśliwe jabłko",
            desc = "Ulepszenie to pozwala ci odnaleźć złote jabłko (warte jest ono $500).",
            price = 450,
            type = "goldapple",
        },
    },
}

function getJobDetails()
    return jobSettings
end