/*

██╗░░░██╗███████╗░█████╗░██╗░░██╗███╗░░██╗██╗░░░░░██╗░░░██╗░█████╗░███╗░░░███╗███╗░░██╗███████╗░██████╗████████╗██╗░█████╗░░██████╗
██║░░░██║██╔════╝██╔══██╗██║░░██║████╗░██║██║░░░░░╚██╗░██╔╝██╔══██╗████╗░████║████╗░██║██╔════╝██╔════╝╚══██╔══╝██║██╔══██╗██╔════╝
╚██╗░██╔╝█████╗░░██║░░╚═╝███████║██╔██╗██║██║░░░░░░╚████╔╝░███████║██╔████╔██║██╔██╗██║█████╗░░╚█████╗░░░░██║░░░██║██║░░╚═╝╚█████╗░
░╚████╔╝░██╔══╝░░██║░░██╗██╔══██║██║╚████║██║░░░░░░░╚██╔╝░░██╔══██║██║╚██╔╝██║██║╚████║██╔══╝░░░╚═══██╗░░░██║░░░██║██║░░██╗░╚═══██╗
░░╚██╔╝░░███████╗╚█████╔╝██║░░██║██║░╚███║███████╗░░░██║░░░██║░░██║██║░╚═╝░██║██║░╚███║███████╗██████╔╝░░░██║░░░██║╚█████╔╝██████╔╝
░░░╚═╝░░░╚══════╝░╚════╝░╚═╝░░╚═╝╚═╝░░╚══╝╚══════╝░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░░░░╚═╝╚═╝░░╚══╝╚══════╝╚═════╝░░░░╚═╝░░░╚═╝░╚════╝░╚═════╝░

░█████╗░░█████╗░███╗░░██╗███████╗██╗░██████╗░
██╔══██╗██╔══██╗████╗░██║██╔════╝██║██╔════╝░
██║░░╚═╝██║░░██║██╔██╗██║█████╗░░██║██║░░██╗░
██║░░██╗██║░░██║██║╚████║██╔══╝░░██║██║░░╚██╗
╚█████╔╝╚█████╔╝██║░╚███║██║░░░░░██║╚██████╔╝
░╚════╝░░╚════╝░╚═╝░░╚══╝╚═╝░░░░░╚═╝░╚═════╝░

*/

-- Выбор языка: доступные варианты - "ru", "en", "fr" / Language selection: available options - "ru", "en", "fr"
AmnesticConfig = {}
AmnesticConfig.Language = "ru" -- Установите нужный язык / Set the desired language

-- Тексты на разных языках / Texts in different languages
AmnesticConfig.LanguageTexts = {
    ["ru"] = {
        LoadServer = "[VechnLY_amnestics] Серверная часть загружена!",
        ForgetHours = "Вы забыли последние 10 часов.",
        ClassA = "Амнезиак | Класс: A",
        ClassB = "Амнезиак | Класс: B",
        ClassC = "Амнезиак | Класс: C",
        ClassH = "Амнезиак | Класс: H",
        ClassO = "Амнезиак | Класс: O",
    },
    ["en"] = {
        LoadServer = "[VechnLY_amnestics] Server-side loaded!",
        ForgetHours = "You forgot the last 10 hours.",
        ClassA = "Amnestic | Class: A",
        ClassB = "Amnestic | Class: B",
        ClassC = "Amnestic | Class: C",
        ClassH = "Amnestic | Class: H",
        ClassO = "Amnestic | Class: O",
    },
    ["fr"] = {
        LoadServer = "[VechnLY_amnestics] Chargé côté serveur!",
        ForgetHours = "Tu as oublié les 10 dernières heures.",
        ClassA = "Amnésique | Classe: A",
        ClassB = "Amnésique | Classe: B",
        ClassC = "Amnésique | Classe: C",
        ClassH = "Amnésique | Classe: H",
        ClassO = "Amnésique | Classe: O",
    },
    ["de"] = {
        LoadServer = "[VechnLY_amnestics] Der Server ist geladen!",
        ForgetHours = "Sie haben die letzten 10 Stunden vergessen.",
        ClassA = "Amnesiak / Klasse: A",
        ClassB = "Amnesiak / Klasse: B",
        ClassC = "Amnesiak / Klasse: C",
        ClassH = "Amnesiak / Klasse: H",
        ClassO = "Amnesiak / Klasse: O",
    }
}

-- Получить текст на выбранном языке / Get the text in the selected language
function AmnesticConfig.GetText(key)
    local lang = AmnesticConfig.Language
    local langTable = AmnesticConfig.LanguageTexts[lang]

    if not langTable then
        print("[VechnLY_amnestics] Ошибка: INVALID_LANGUAGE - " .. tostring(lang))
        return "INVALID_LANGUAGE"
    end

    local text = langTable[key]
    if not text then
        print("[VechnLY_amnestics] Ошибка: Ключ '" .. tostring(key) .. "' отсутствует в языке '" .. tostring(lang) .. "'")
        return "TEXT_NOT_FOUND"
    end

    return text
end


-- Конфигурация таймеров и эффектов / Configuration of timers and effects
AmnesticConfig.Timers = {
    AmnesticD = {3, 9, 17, 27, 35}, -- Временные интервалы для Class D / Time intervals for Class D
    AmnesticA = {3, 9, 17, 25},     -- Временные интервалы для Class A / Time intervals for Class A
    AmnesticB = {3, 9, 17, 27, 35}, -- Временные интервалы для Class B / Time intervals for Class B
    AmnesticH = 343,                -- Продолжительность эффекта для Class H / Duration of the effect for Class H
}

-- RestrictedJobs
AmnesticConfig.RestrictedJobs = {
    ["TEAM_SCP131"] = true,
    ["TEAM_SCP863"] = true,
    ["TEAM_SCP912"] = true,
    ["TEAM_SCP999"] = true,
    ["TEAM_SCP008"] = true,
    ["TEAM_SCP049"] = true,
    ["TEAM_SCP056"] = true,
    ["TEAM_SCP066"] = true,
    ["TEAM_SCP082"] = true,
    ["TEAM_SCP096"] = true,
    ["TEAM_SCP166"] = true,
    ["TEAM_SCP173"] = true,
    ["TEAM_SCP239"] = true,
    ["TEAM_SCP457"] = true,
    ["TEAM_SCP811"] = true,
    ["TEAM_SCP966"] = true,
    ["TEAM_SCP1360"] = true,
    ["TEAM_SCP1471"] = true,
    ["TEAM_SCP058"] = true,
    ["TEAM_SCP076"] = true,
    ["TEAM_SCP106"] = true,
    ["TEAM_SCP682"] = true,
    ["TEAM_SCP939"] = true,
    ["TEAM_SCP953"] = true,
    ["TEAM_ROBOT2"] = true,
    ["TEAM_ROBOT"] = true,
    ["TEAM_ADMIN"] = true,
}

-- Настройка эффектов / Effect setting
AmnesticConfig.Effects = {
    ColorModify = {
        ["$pp_colour_addr"] = 0.01,
        ["$pp_colour_addg"] = 0,
        ["$pp_colour_addb"] = 0,
        ["$pp_colour_brightness"] = -0.001,
        ["$pp_colour_contrast"] = 0.7,
        ["$pp_colour_colour"] = 0.5,
        ["$pp_colour_mulr"] = 0.7,
        ["$pp_colour_mulg"] = 0,
        ["$pp_colour_mulb"] = 0
    },
    MotionBlur = {0.1, 0.9, 0.01},
    Bloom = {0.5, 0.5, 9, 9, 1, 1, 1, 1, 1},
    Overlay = "effects/tp_eyefx/tpeye3",
    HeartbeatSound = "amnestics/heartstartamnesiak.wav",
    BackgroundSound = {
        ["A"] = "amnestics/backgroundamnesiak1.wav",
        ["B"] = "amnestics/backgroundamnesiak.wav",
        ["D"] = "amnestics/backgroundamnesiak.wav",
        ["H"] = "amnestics/backhroundhsound.wav"
    },
    EndSound = "amnestics/endsoundplayamnesiak.wav"
}

-- Логика обработки печати / Print processing logic
print(AmnesticConfig.GetText("LoadServer"))
