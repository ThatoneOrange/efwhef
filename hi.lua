local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ThatoneOrange/LibraryFiffer/main/lib.lua"))()

local window = Library.new("FiveClient")

window:LockScreenBoundaries(true)

-- Tabs

local Self = window:Tab("Self")

-- Sections

local SelfSection = Self:Section("Player")

local EconomySection = Self:Section("Economy")

local TrollingSection = Self:Section("Trolling")

-- Tables & Variables

local Players = game:GetService('Players')
local Player = Players.LocalPlayer
local ReplicatedStorage = game:GetService('ReplicatedStorage')

local BankStat = Player.Economy:WaitForChild('Bank')

local Configuration = {
    ["Staff Group ID"] = 12536871
}

local EconomyHack = {
     ["Bank Limiet"] = 9999999
}

--[[
    local TeamWapens = {
    [1] = Teams["Koninklijke Landmacht"]["C7 NLD"],
    [2] = Teams["Koninklijke Landmacht"]["Glock 17"],
    [3] = Teams["Politie"]["Walther P99Q NL"],
    [4] = Teams["Dienst Speciale Interventies"]["Glock 17 DSI"],
    [5] = Teams["Dienst Speciale Interventies"]["HK G28"],
    [6] = Teams["Dienst Speciale Interventies"]["HK416"],
    [7] = Teams["Dienst Speciale Interventies"]["M870"],
    [8] = Teams["Dienst Speciale Interventies"]["MP5A4"],
    [9] = Teams["Dienst Speciale Interventies"]["SIG MCX"],
    [10] = Teams["Dienst Speciale Interventies"]["Shield"]
}
]]

-- Toggles / Globals

_G.FrozenMoney = false
_G.MoneyAmount = 0



_G.connection = nil

-- Functions

function returnStaffleden()
    local staff = {}
    for _,v in pairs(Players:GetPlayers()) do
        if v:IsInGroup(Configuration["Staff Group ID"]) then
            table.insert(staff, v)
        end
    end
    return staff
end

function StaffCounter()
    local count = 0
    for _,v in pairs(Players:GetPlayers()) do
        if v:IsInGroup(Configuration["Staff Group ID"]) then
            count += 1
        end
    end
    return count
end

-- Main

local amount1 = 0

EconomySection:Slider("Amount", 9999999, 1000, function(val)
    amount1 = val
end)

EconomySection:Button("Add Money", function()
    ReplicatedStorage.Belastingdienst.Belasting:FireServer(-amount1)
end)

local Frozenmoneyhack = EconomySection:Toggle("Frozen Money", function(bool)
    if bool then
        ReplicatedStorage.Belastingdienst.Belasting:FireServer(-math.huge)
        ReplicatedStorage.Belastingdienst.Belasting:FireServer(-EconomyHack["Bank Limiet"])
        _G.connection = BankStat.Changed:Connect(function()
            local bedrag = (EconomyHack["Bank Limiet"] - BankStat.Value)
            ReplicatedStorage.Belastingdienst.Belasting:FireServer(-bedrag)
        end)
    else
        _G.connection:Disconnect()
    end
end)
Frozenmoneyhack:Set(false)
