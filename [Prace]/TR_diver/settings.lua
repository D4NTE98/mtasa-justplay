jobSettings = {
    name = "Praca nurka",
    desc = "Wskocz w kostium nurka i przemierzaj głębiny ujścia Sherman w poszukiwaniu zaginionych artefaktów, które zatonęły tu wiele wieków temu w masakrze pirackiego statku, który płynął z różnymi dobrami materialnymi do San Fierro. Być może w głębinach wód Sherman znajdziesz jakieś interesujące XVII-wieczne przedmioty.",
    require = "Licencja nurka\nDoświadczenie: 800pkt",
    earnings = "$7500",

    upgrades = {
        {
            name = "Większy pakunek",
            desc = "Ulepszenie to pozwala zbierać więcej rzeczy.",
            price = 120,
            type = "backpack",
        },
        {
            name = "Głęboki wdech",
            desc = "Ulepszenie to pozwala nabić butlę do 25l.",
            price = 180,
            type = "tank",
            additionalMoney = {400, 700}
        },
        {
            name = "Szósty zmysł",
            desc = "Ulepszenie to pozwala ci lepiej przeszukiwać skrzynie.",
            price = 300,
            type = "brain",
            additionalMoney = {700, 800}
        },
        {
            name = "Szerokie płetwy",
            desc = "Ulepszenie to pozwala ci szybciej pływać.",
            price = 550,
            type = "flippers",
            additionalMoney = {800, 1000}
        },
    },
}

function getJobDetails()
    return jobSettings
end