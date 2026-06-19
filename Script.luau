-- Roblox Godmode Script v4: EXTRA UNKILLABLE Edition
-- True godmode by deleting old Humanoid (replicates to server)
-- Extra layers: Disable Dead state, HealthChanged protection, auto-revive on low HP

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Функция для применения godmode
local function applyGodmode(character)
    if not character then return end

    -- Небольшая задержка для полной загрузки персонажа
    task.wait(1.0)

    -- Шаг 1: Удаляем старый Humanoid (основа godmode)[reference:10]
    local oldHumanoid = character:FindFirstChildOfClass("Humanoid")
    if oldHumanoid then
        oldHumanoid:Destroy()
    end

    -- Шаг 2: Создаем новый Humanoid[reference:11]
    local newHumanoid = Instance.new("Humanoid")
    newHumanoid.Parent = character

    -- Настройки godmode[reference:12]
    newHumanoid.MaxHealth = math.huge
    newHumanoid.Health = math.huge
    newHumanoid.WalkSpeed = 50
    newHumanoid.JumpPower = 50

    -- Шаг 3: Отключаем состояние "Мертв"[reference:13]
    newHumanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)

    -- Шаг 4: Защита от потери здоровья[reference:14]
    newHumanoid.HealthChanged:Connect(function(health)
        if health < newHumanoid.MaxHealth * 0.9 then
            newHumanoid.Health = newHumanoid.MaxHealth
            newHumanoid:ChangeState(Enum.HumanoidStateType.Running)
        end
    end)
end

-- Применяем при появлении персонажа
player.CharacterAdded:Connect(function(character)
    character:WaitForChild("Humanoid")
    applyGodmode(character)
end)

-- Если персонаж уже существует
if player.Character then
    applyGodmode(player.Character)
end
