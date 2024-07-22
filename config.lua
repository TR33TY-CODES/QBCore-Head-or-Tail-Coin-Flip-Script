Config = {}

Config.Framework = "QBCore" -- Set to "QBCore"
Config.ItemName = "coin" -- The item name for the coin

Config.Display3DTextEnabled = true -- Enable/Disable 3D Text Display
Config.DisplayTime = 5000 -- Time in milliseconds to display the 3D text
Config.DisplayRange = 5.0 -- Maximum distance to display 3D text

Config.NotifySelfEnabled = true -- Enable/Disable self notification
Config.NotifyNearbyEnabled = false -- Enable/Disable notification to nearby players   [NOT WORKING NOW]
Config.NotifyRange = 5.0 -- Range to notify nearby players

-- Localization
Config.Locale = {
    heads = "Heads",
    tails = "Tails",
    coin_flip = "You flipped a coin and got %s",
    notify_nearby = "A coin was flipped and landed on %s"
}

