jobSettings = {
    name = "Praca koszenia trawy",
    desc = "Praca polega na utrzymaniu czystości i estetyki Juniper Hill. Aby park zawsze prezentował się wspaniale i mógł być chlubą miasta San Fierro należy pilnować, aby jego trawa była jednolitej i odpowiedniej wysokości.\nTo będzie twoje zadanie!",
    earnings = "$3500",
    require = false,

    upgrades = {
        {
            name = "Gęstsza trawa",
            desc = "Podwaja ilość zbieranej trawy.",
            price = 300,
            type = "grass",
            additionalMoney = {400, 1000},
        },
        {
            name = "Szybki wysyp",
            desc = "Czas wysypywania trawy jest krótszy.",
            price = 80,
            type = "bag",
            additionalMoney = {100, 350},
        },
        {
            name = "Szybsza kosiarka",
            desc = "Prędkość maksymalna kosiarki zostaje zwiększona.",
            price = 250,
            type = "landmower",
            additionalMoney = {450, 700},
        },
    },
}

function getJobDetails()
    return jobSettings
end