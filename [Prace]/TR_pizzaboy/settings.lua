jobSettings = {
    name = "Rozwożenie pizzy",
    desc = "Praca polega na dowożeniu zamówień do klienta. Po otrzymaniu listy zamówień należy wsiąść na przygotowany przez obsługę restauracji motocykl a następnie dowieźć wszystkie zamówienie do odpowiednich klientów.",
    require = false,
    earnings = "$3500",

    upgrades = {
        {
            name = "Większa torba",
            desc = "Jesteś w stanie zabrać 2x więcej zamówień jednocześnie.",
            price = 35,
            type = "storage",
            additionalMoney = {350, 650},
        },
        {
            name = "Charyzma",
            desc = "Zwiększa szansę otrzymania napiwku.",
            price = 50,
            type = "tip",
        },
        {
            name = "Szybszy skuter",
            desc = "Zwiększa prędkość skutera dostawczego.",
            price = 80,
            type = "vehicle",
            additionalMoney = {450, 600},
        },
    },
}

function getJobDetails()
    return jobSettings
end