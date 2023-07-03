jobSettings = {
    name = "Praca odśnieżania",
    desc = "W mieście Angel Pine i okolicach wiecznie pada śnieg i jest ślisko. Twoim zadaniem będzie odśnieżanie ulic tego miasta, aby zwykłe pojazdy mogły bezpiecznie podróżować po naszych drogach.\nNiestety nie posiadamy maszyn najwyższej technologii więc do pracy potrzebne są dwie osoby.",
    require = "Prawo jazdy kat. B\nDoświadczenie: 80pkt",
    earnings = "$4000",

    -- Multipe work
    minPlayers = 2,
    workers = {"snowPlow", "sand"},
    ----

    upgrades = {
        {
            name = "Większe zaufanie",
            desc = "Ulepszenie to sprawi, że będziesz mógł utrzymywać większą odległosć.",
            price = 50,
            type = "distance",
        },
        {
            name = "Mocny silnik",
            desc = "Ulepszenie to sprawi, że traktor będzie jeździł szybciej.",
            price = 80,
            type = "tractor",
            additionalMoney = {150, 400},
        },
        {
            name = "Większa ładowność",
            desc = "Ulepszenie to sprawi, że będziesz mógł przewozić więcej piasku na pace.",
            price = 150,
            type = "pickup",
            additionalMoney = {400, 650},
        },
    },
}

function getJobDetails()
    return jobSettings
end