jobSettings = {
    name = "Praca magazyniera",
    desc = "Praca magazyniera polega na rozładunku pojazdów przyjeżdżających do magazynu.\nZdjętą skrzynię z naczepy należy zanieść na regał. Ładunek należy posortować zgodnie z oznaczeniami na skrzyni i półce w magazynie.",
    require = false,
    earnings = "$3500",

    upgrades = {
        {
            name = "Większa stabilność",
            desc = "Ulepszenie to sprawi, że przestaniesz się chwiać i upuszczać paczki.",
            price = 100,
            type = "stability",
        },
        {
            name = "Szybsza dostawa",
            desc = "Ulepszenie to sprawi, że następna ciężarówka będzie przyjeżdżać szybciej.",
            price = 350,
            type = "truck",
            additionalMoney = {500, 700},
        },
        {
            name = "Silne nogi",
            desc = "Ulepszenie to sprawi, że będziesz mógł truchtać nosząc paczki.",
            price = 700,
            type = "running",
            additionalMoney = {800, 1200},
        },
    },
}

function getJobDetails()
    return jobSettings
end