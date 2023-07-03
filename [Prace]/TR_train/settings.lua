jobSettings = {
    name = "Praca maszynisty",
    desc = "Praca polega na prowadzeniu pociągu po stanie San Andreas. Musisz zatrzymywać się na wszystkich przystankach na swojej trasie i czekać aż wszyscy pasażerowie wsiądą i wysiądą z pociągu. Każdy pasażer musi mieć bilet więc będą je od ciebie kupywać. Pamiętaj, że pasażerowie korzystają z dwóch rodzajów biletów. Nie pomyl się przy ich wydawaniu!",
    require = "Doświadczenie: 0pkt",
    earnings = "Miliony kurwa",

    upgrades = {
        {
            name = "Większy stan",
            desc = "Ulepszenie to sprawi, że na stacjach będzie czekać więcej pasażerów.",
            price = 1,
            type = "people",
            additionalMoney = {70, 120}
        },
        {
            name = "Mocniejsza lokomotywa",
            desc = "Ulepszenie to sprawi, że pociąg będzie mógł rozwijać większe prędkości.",
            price = 1,
            type = "tram",
            additionalMoney = {350, 550}
        },
    },
}

function getJobDetails()
    return jobSettings
end

-- Stops
targetPoints = {
    {
        marker = Vector3(1432.3515625, 2632.291015625, 10.82031),
        npcs = {
            {
                pos = Vector3(1429.1884765625, 2628.09765625, 11.39261245),
                rot = 0,
            },
            {
                pos = Vector3(1432.109375, 2628.2802734375, 11.39261),
                rot = 0,
            },
            {
                pos = Vector3(1436.109375, 2628.2802734375, 11.39261),
                rot = 0,
            },
            {
                pos = Vector3(1439.109375, 2628.2802734375, 11.39261),
                rot = 0,
            },
            {
                pos = Vector3(1443.109375, 2628.2802734375, 11.39261),
                rot = 0,
            },
        },
    },

    { 
        marker = Vector3(2864.6826171875, 1301.046875, 10.820),
        npcs = {
            {
                pos = Vector3(2859.70703125, 1303.173828125, 11.3),
                rot = 270,
            },
            {
                pos = Vector3(2860.3583984375, 1300.583984375, 11.39),
                rot = 270,
            },
            {
                pos = Vector3(2860.396484375, 1297.1728515625, 11.390),
                rot = 270,
            },
            {
                pos = Vector3(2860.396484375, 1293.1728515625, 11.390),
                rot = 270,
            },
            {
                pos = Vector3(2860.396484375, 1281.1728515625, 11.390),
                rot = 270,
            },
        },
    },

    { 
        marker = Vector3(1742.3544921875, -1954.236328125, 13.5468),
        npcs = {
            {
                pos = Vector3(1741.8525390625, -1950.0947265625, 14.11),
                rot = 180,
            },
            {
                pos = Vector3(1739.3759765625, -1950.458984375, 14.117),
                rot = 180,
            },
            {
                pos = Vector3(1745.3759765625, -1950.458984375, 14.117),
                rot = 180,
            },
            {
                pos = Vector3(1734.3759765625, -1950.458984375, 14.117),
                rot = 180,
            },
            {
                pos = Vector3(1730.3759765625, -1950.458984375, 14.117),
                rot = 180,
            },
        },
    },

    { 
        marker = Vector3(820.4228515625, -1370.822265625, -1.679921627),
        npcs = {
            {
                pos = Vector3(824.3271484375, -1371.1025390625, -0.9941859245),
                rot = 137,
            },
            {
                pos = Vector3(822.9677734375, -1369.998046875, -1.082578),
                rot = 137,
            },
            {
                pos = Vector3(821.275390625, -1368.560546875, -1.1314501762),
                rot = 137,
            },
            {
                pos = Vector3(818.888671875, -1366.814453125, -1.1484),
                rot = 137,
            },
            {
                pos = Vector3(817.1572265625, -1365.013671875, -1.1484),
                rot = 137,
            },
        },
    },
}