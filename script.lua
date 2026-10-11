--[[
PAINEL SCRIPTS MM2 - Petrova
✅ Delta SEM KEY | CÓDIGO DIRETO
✅ CROSSHAIR DO SEU REPOSITÓRIO NO BOTÃO 27 ⚪
✅ VELOCIDADE / SPEED CNP CONFIGURADO NO PAINEL 🚀
✅ EXTRA CNP NO BOTÃO 29 🌸
]]

local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local NetworkSettings = settings():GetService("NetworkSettings")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local camera = Workspace.CurrentCamera

-- ==========================================
-- CORES
-- ==========================================
local DESATIVADO = Color3.fromRGB(200, 50, 50) -- 🔴 Vermelho
local ATIVADO = Color3.fromRGB(46, 139, 87)     -- 🟢 Verde

-- ==========================================
-- TELA PRINCIPAL
-- ==========================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ControlPanelGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

if playerGui:FindFirstChild("ControlPanelGui") and playerGui.ControlPanelGui ~= screenGui then
    playerGui.ControlPanelGui:Destroy()
end

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 220, 0, 350) -- Altura fixa para caber na tela
mainFrame.Position = UDim2.new(0.5, -110, 0.5, -175)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -35, 0, 35)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Painel Petrova MM2"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = mainFrame

local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 25, 0, 25)
minimizeBtn.Position = UDim2.new(1, -30, 0, 5)
minimizeBtn.BackgroundColor3 = DESATIVADO
minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeBtn.Text = "-"
minimizeBtn.Font = Enum.Font.SourceSansBold
minimizeBtn.TextSize = 18
minimizeBtn.Parent = mainFrame
Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(0, 6)

-- ==========================================
-- SCROLLING FRAME + AUTOMATIC CANVAS
-- ==========================================
local contentFrame = Instance.new("ScrollingFrame")
contentFrame.Size = UDim2.new(1, 0, 1, -35)
contentFrame.Position = UDim2.new(0, 0, 0, 35)
contentFrame.BackgroundTransparency = 1
contentFrame.BorderSizePixel = 0
contentFrame.ScrollBarThickness = 6
contentFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
contentFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y -- Ajusta rolagem automaticamente
contentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
contentFrame.Parent = mainFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Parent = contentFrame
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Padding = UDim.new(0, 5)
listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local listPadding = Instance.new("UIPadding")
listPadding.Parent = contentFrame
listPadding.PaddingTop = UDim.new(0, 5)
listPadding.PaddingBottom = UDim.new(0, 5)

local painelAberto = true
minimizeBtn.MouseButton1Click:Connect(function()
    painelAberto = not painelAberto
    minimizeBtn.Text = painelAberto and "-" or "+"
    mainFrame.Size = painelAberto and UDim2.new(0, 220, 0, 350) or UDim2.new(0, 220, 0, 35)
    contentFrame.Visible = painelAberto
end)

local function criarBotao(nome)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 38)
    btn.BackgroundColor3 = DESATIVADO
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = nome .. ": Desativado"
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 15
    btn.Parent = contentFrame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    return btn
end

-- ==========================================
-- 1️⃣ OLD ANIMATION
-- ==========================================
local btnOldAnim = criarBotao("Old Animation")
local oldAnimAtivado = false
btnOldAnim.MouseButton1Click:Connect(function()
    oldAnimAtivado = not oldAnimAtivado
    game.Workspace.Retargeting = oldAnimAtivado and Enum.AnimatorRetargetingMode.Disabled or Enum.AnimatorRetargetingMode.Default
    btnOldAnim.Text = oldAnimAtivado and "Old Animation: Ativado" or "Old Animation: Desativado"
    btnOldAnim.BackgroundColor3 = oldAnimAtivado and ATIVADO or DESATIVADO
end)

-- ==========================================
-- 2️⃣ SPEED CANHÃO
-- ==========================================
local btnSpeed = criarBotao("Speed Canhão")
local speedAtivado = false
local speedConnections = {}
local function startSpeedSystem()
    local LocalPlayer = Players.LocalPlayer
    local v1, v2, v3 = nil, nil, nil
    local v4, v5, v6, v7 = 0, false, true, 0
    local WATER_JUMP_FORCE = 150

    local function handleAntiCoin(object)
        pcall(function()
            if object.Name == "Coin" or object.Name == "CoinContainer" or object:FindFirstChild("CoinVisual") then
                if object:IsA("BasePart") then object.CanTouch = false end
                for _, child in ipairs(object:GetDescendants()) do
                    if child:IsA("BasePart") then child.CanTouch = false end
                end
            end
        end)
    end

    task.spawn(function()
        pcall(function()
            for _, desc in ipairs(Workspace:GetDescendants()) do handleAntiCoin(desc) end
            speedConnections[#speedConnections+1] = Workspace.DescendantAdded:Connect(handleAntiCoin)
        end)
    end)

    local function getAveragePosition(p1)
        local sum, count = Vector3.new(0,0,0), 0
        for _, v in ipairs(p1:GetDescendants()) do
            if v:IsA("BasePart") and not v.Anchored and v.Name ~= "TrackerPart" and not v:FindFirstAncestorOfClass("Tool") then
                sum += v.Position; count += 1
            end
        end
        return count == 0 and v2.Position or sum / count
    end

    local function zeroOutCharacterMass()
        if not v1 then return end
        for _, v in ipairs(v1:GetDescendants()) do
            if v:IsA("BasePart") and v ~= v3 and not v:FindFirstAncestorOfClass("Tool") then
                v.CustomPhysicalProperties = PhysicalProperties.new(0.2, 0.3, 0.5, 1, 1)
            end
        end
    end

    local function waitForMass(part)
        local count = 0
        while part.AssemblyMass < 0.01 and count < 40 do task.wait(0.1); count += 1 end
        return part.AssemblyMass
    end

    local function updateTracker()
        if not v6 or not v1 or not v2 then return end
        if not v3 or not v3.Parent then
            local TrackerPart = Instance.new("Part")
            TrackerPart.Name = "TrackerPart"
            TrackerPart.Size = Vector3.new(2,2,2)
            TrackerPart.Transparency = 1
            TrackerPart.CanCollide = false
            TrackerPart.Anchored = false
            TrackerPart.Parent = v1
            local WeldConstraint = Instance.new("WeldConstraint")
            WeldConstraint.Part0 = TrackerPart
            WeldConstraint.Part1 = v2
            WeldConstraint.Parent = TrackerPart
            v3 = TrackerPart
        end
        local avgPos = getAveragePosition(v1)
        v3.Position = avgPos + (avgPos - v2.Position) * 0.35
        zeroOutCharacterMass()
        local volume = v3.Size.X * v3.Size.Y * v3.Size.Z
        v3.CustomPhysicalProperties = PhysicalProperties.new(
            math.clamp((volume > 0 and v4 / volume or 1), 0.1, 35), 0.3, 0.5, 1, 1
        )
    end

    local function safeUpdate()
        if not v6 then return end
        local now = os.clock()
        if now - v7 < 0.2 then return end
        v7 = now
        task.defer(updateTracker)
    end

    local function onCharacter(character)
        v1 = character
        if v3 then pcall(function() v3:Destroy() end); v3 = nil end
        local humanoid = character:WaitForChild("Humanoid", 5)
        local root = character:WaitForChild("HumanoidRootPart", 5)
        if not humanoid or not root then return end
        local swimming = false
        speedConnections[#speedConnections+1] = humanoid.StateChanged:Connect(function(old, new)
            swimming = new == Enum.HumanoidStateType.Swimming
            if old == Enum.HumanoidStateType.Swimming and new == Enum.HumanoidStateType.Jumping then
                pcall(function() humanoid:ChangeState(Enum.HumanoidStateType.Freefall) end)
            end
        end)
        speedConnections[#speedConnections+1] = UserInputService.JumpRequest:Connect(function()
            pcall(function()
                if swimming and root then
                    root.AssemblyLinearVelocity = Vector3.new(
                        root.AssemblyLinearVelocity.X, WATER_JUMP_FORCE, root.AssemblyLinearVelocity.Z
                    )
                end
            end)
        end)
        task.delay(1, function()
            if not v1 or v1 ~= character then return end
            v2 = root; v5 = true; v4 = waitForMass(v2)
            pcall(updateTracker)
            speedConnections[#speedConnections+1] = character.DescendantAdded:Connect(function(obj)
                if not obj:FindFirstAncestorOfClass("Tool") then safeUpdate() end
            end)
            speedConnections[#speedConnections+1] = character.DescendantRemoving:Connect(function(obj)
                if not obj:FindFirstAncestorOfClass("Tool") then safeUpdate() end
            end)
        end)
    end

    speedConnections[#speedConnections+1] = LocalPlayer.CharacterAdded:Connect(function(char)
        pcall(onCharacter, char)
    end)
    if LocalPlayer.Character then task.spawn(function() pcall(onCharacter, LocalPlayer.Character) end) end
end

local function stopSpeedSystem()
    for _, conn in ipairs(speedConnections) do if conn then conn:Disconnect() end end
    speedConnections = {}
end

btnSpeed.MouseButton1Click:Connect(function()
    speedAtivado = not speedAtivado
    btnSpeed.Text = speedAtivado and "Speed Canhão: Ativado" or "Speed Canhão: Desativado"
    btnSpeed.BackgroundColor3 = speedAtivado and ATIVADO or DESATIVADO
    if speedAtivado then startSpeedSystem() else stopSpeedSystem() end
end)

-- ==========================================
-- 3️⃣ SPEED STONE
-- ==========================================
local btnSpeedStone = criarBotao("Speed Stone")
local speedStoneAtivado = false
btnSpeedStone.MouseButton1Click:Connect(function()
    speedStoneAtivado = not speedStoneAtivado
    btnSpeedStone.Text = speedStoneAtivado and "Speed Stone: Ativado" or "Speed Stone: Desativado"
    btnSpeedStone.BackgroundColor3 = speedStoneAtivado and ATIVADO or DESATIVADO
    if speedStoneAtivado then
        loadstring(game:HttpGet("https://rawgithubusercontent.com/LiarRise/Speed/refs/heads/main/README.md"))()
    end
end)

-- ==========================================
-- 4️⃣ ARMA ANTIGA
-- ==========================================
local btnArma = criarBotao("Arma Antiga")
local armaAtivado = false
local thursGui = nil
btnArma.MouseButton1Click:Connect(function()
    armaAtivado = not armaAtivado
    btnArma.Text = armaAtivado and "Arma Antiga: Ativado" or "Arma Antiga: Desativado"
    btnArma.BackgroundColor3 = armaAtivado and ATIVADO or DESATIVADO
    if armaAtivado then
        local plr = Players.LocalPlayer
        local enabled = true
        thursGui = Instance.new("ScreenGui")
        thursGui.Name = "_thurs4x"
        thursGui.Parent = game.CoreGui
        local frame = Instance.new("Frame")
        frame.Parent = thursGui
        frame.Size = UDim2.new(0,120,0,28)
        frame.Position = UDim2.new(0.72,0,0.08,0)
        frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
        frame.BackgroundTransparency = 0.15
        frame.Active = true
        frame.Draggable = true
        Instance.new("UICorner", frame).CornerRadius = UDim.new(1,0)
        local title = Instance.new("TextLabel")
        title.Parent = frame
        title.BackgroundTransparency = 1
        title.Position = UDim2.new(0.06,0,0,0)
        title.Size = UDim2.new(0,60,1,0)
        title.Font = Enum.Font.GothamBold
        title.Text = "_thurs4x"
        title.TextScaled = true
        title.TextColor3 = Color3.fromRGB(255,255,255)
        local toggle = Instance.new("TextButton")
        toggle.Parent = frame
        toggle.Size = UDim2.new(0,40,0,18)
        toggle.Position = UDim2.new(0.63,0,0.18,0)
        toggle.BackgroundColor3 = Color3.fromRGB(0,255,120)
        toggle.Font = Enum.Font.GothamBold
        toggle.Text = "ON"
        toggle.TextScaled = true
        toggle.TextColor3 = Color3.fromRGB(255,255,255)
        Instance.new("UICorner", toggle).CornerRadius = UDim.new(1,0)
        local function setup(char)
            local hum = char:WaitForChild("Humanoid")
            hum.AnimationPlayed:Connect(function(track)
                if enabled and track.Priority == Enum.AnimationPriority.Action then
                    task.wait()
                    pcall(function() track:Stop() end)
                end
            end)
        end
        if plr.Character then setup(plr.Character) end
        plr.CharacterAdded:Connect(setup)
        toggle.MouseButton1Click:Connect(function()
            enabled = not enabled
            toggle.Text = enabled and "ON" or "OFF"
            toggle.BackgroundColor3 = enabled and Color3.fromRGB(0,255,120) or Color3.fromRGB(255,70,70)
        end)
    else
        if thursGui then thursGui:Destroy() thursGui = nil end
    end
end)

-- ==========================================
-- 5️⃣ BOMBA DOURADA ORIGINAL 💛
-- ==========================================
local btnBomba = criarBotao("Bomba Dourada")
local bombaAtivado = false
btnBomba.MouseButton1Click:Connect(function()
    bombaAtivado = not bombaAtivado
    btnBomba.Text = bombaAtivado and "Bomba Dourada: Ativado" or "Bomba Dourada: Desativado"
    btnBomba.BackgroundColor3 = bombaAtivado and ATIVADO or DESATIVADO
    if bombaAtivado then
        loadstring(game:HttpGet("https://tinyurl.com/BombGoldLoader"))()
    end
end)

-- ==========================================
-- 6️⃣ EMOTE TOOL
-- ==========================================
local btnEmote = criarBotao("Emote Tool")
local emoteAtivado = false
btnEmote.MouseButton1Click:Connect(function()
    emoteAtivado = not emoteAtivado
    btnEmote.Text = emoteAtivado and "Emote Tool: Ativado" or "Emote Tool: Desativado"
    btnEmote.BackgroundColor3 = emoteAtivado and ATIVADO or DESATIVADO
    if emoteAtivado then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ZoeWarOnTop/Emote-Tool/refs/heads/main/Emotes%20Tool"))()
    end
end)

-- ==========================================
-- 7️⃣ HEADLESS
-- ==========================================
local btnHeadless = criarBotao("Headless")
local headlessAtivado = false
btnHeadless.MouseButton1Click:Connect(function()
    headlessAtivado = not headlessAtivado
    btnHeadless.Text = headlessAtivado and "Headless: Ativado" or "Headless: Desativado"
    btnHeadless.BackgroundColor3 = headlessAtivado and ATIVADO or DESATIVADO
    if headlessAtivado then
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Headless-anh-idk-238257"))()
    end
end)

-- ==========================================
-- 8️⃣ OLD SHIFT
-- ==========================================
local btnOldShift = criarBotao("Old Shift")
local oldShiftAtivado = false
local shiftConn = nil
btnOldShift.MouseButton1Click:Connect(function()
    oldShiftAtivado = not oldShiftAtivado
    btnOldShift.Text = oldShiftAtivado and "Old Shift: Ativado" or "Old Shift: Desativado"
    btnOldShift.BackgroundColor3 = oldShiftAtivado and ATIVADO or DESATIVADO
    if oldShiftAtivado then
        shiftConn = RunService.RenderStepped:Connect(function()
            local char = player.Character
            if not char or not char:FindFirstChild("Humanoid") then return end
            char.Humanoid.CameraOffset = UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter 
                and Vector3.new(0.9,1.1,0) or Vector3.new(0,0,0)
        end)
    else
        if shiftConn then shiftConn:Disconnect() end
    end
end)

-- ==========================================
-- 9️⃣ CAMERA OLD
-- ==========================================
local btnCameraOld = criarBotao("Camera Old")
local cameraOldAtivado = false
local camConn = nil
btnCameraOld.MouseButton1Click:Connect(function()
    cameraOldAtivado = not cameraOldAtivado
    btnCameraOld.Text = cameraOldAtivado and "Camera Old: Ativado" or "Camera Old: Desativado"
    btnCameraOld.BackgroundColor3 = cameraOldAtivado and ATIVADO or DESATIVADO
    if cameraOldAtivado then
        camConn = RunService.RenderStepped:Connect(function()
            if (camera.Focus.Position - camera.CFrame.Position).Magnitude > 1 then
                camera.CFrame += Vector3.new(0, 0.3, 0)
            end
        end)
    else
        if camConn then camConn:Disconnect() end
    end
end)

-- ==========================================
-- 🔟 CONFETE / LAG
-- ==========================================
local btnConfete = criarBotao("Confete/Lag")
local confeteAtivado = false
btnConfete.MouseButton1Click:Connect(function()
    confeteAtivado = not confeteAtivado
    btnConfete.Text = confeteAtivado and "Confete/Lag: Ativado" or "Confete/Lag: Desativado"
    btnConfete.BackgroundColor3 = confeteAtivado and ATIVADO or DESATIVADO
end)
UserInputService.InputBegan:Connect(function(i,p)
    if not p and i.KeyCode == Enum.KeyCode.Y and confeteAtivado then
        pcall(function()
            NetworkSettings.IncomingReplicationLag = 5
            NetworkSettings.OutgoingReplicationLag = 5
            task.delay(1.5, function()
                NetworkSettings.IncomingReplicationLag = 0
                NetworkSettings.OutgoingReplicationLag = 0
            end)
        end)
    end
end)

-- ==========================================
-- 1️⃣1️⃣ ANTI-MOEDA
-- ==========================================
local btnAntiCoin = criarBotao("Anti-Moeda")
local antiCoinAtivado = false
btnAntiCoin.MouseButton1Click:Connect(function()
    antiCoinAtivado = not antiCoinAtivado
    btnAntiCoin.Text = antiCoinAtivado and "Anti-Moeda: Ativado" or "Anti-Moeda: Desativado"
    btnAntiCoin.BackgroundColor3 = antiCoinAtivado and ATIVADO or DESATIVADO
end)

-- ==========================================
-- 1️⃣2️⃣ CÉU CUSTOM
-- ==========================================
local btnSky = criarBotao("Céu Custom")
local skyAtivado = false
local skyOriginal = {Ambient=Lighting.Ambient, OutdoorAmbient=Lighting.OutdoorAmbient, Brightness=Lighting.Brightness}
btnSky.MouseButton1Click:Connect(function()
    skyAtivado = not skyAtivado
    btnSky.Text = skyAtivado and "Céu Custom: Ativado" or "Céu Custom: Desativado"
    btnSky.BackgroundColor3 = skyAtivado and ATIVADO or DESATIVADO
    if skyAtivado then
        Lighting.Ambient = Color3.fromRGB(100,80,150)
        Lighting.OutdoorAmbient = Color3.fromRGB(120,90,180)
        Lighting.Brightness = 2.5
        local Sky = Lighting:FindFirstChild("Sky") or Instance.new("Sky", Lighting)
        Sky.SkyColor = Color3.fromRGB(70,30,120)
        Sky.SkyGradient = Color3.fromRGB(138,43,226)
        Sky.CloudColor = Color3.fromRGB(200,160,255)
        Sky.CloudsEnabled = true
    else
        Lighting.Ambient = skyOriginal.Ambient
        Lighting.OutdoorAmbient = skyOriginal.OutdoorAmbient
        Lighting.Brightness = skyOriginal.Brightness
        if Lighting:FindFirstChild("Sky") then Lighting.Sky:Destroy() end
    end
end)

-- ==========================================
-- 1️⃣3️⃣ EQUALIZADOR
-- ==========================================
local btnEqualizador = criarBotao("Equalizador")
local equalizadorAtivado = false
btnEqualizador.MouseButton1Click:Connect(function()
    equalizadorAtivado = not equalizadorAtivado
    btnEqualizador.Text = equalizadorAtivado and "Equalizador: Ativado" or "Equalizador: Desativado"
    btnEqualizador.BackgroundColor3 = equalizadorAtivado and ATIVADO or DESATIVADO
    if equalizadorAtivado then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ZoeWarOnTop/Abafador-By-Zoewar/refs/heads/main/Equalizador-Zoewar"))()
    end
end)

-- ==========================================
-- 1️⃣5️⃣ SOUND GUN
-- ==========================================
local btnSoundGun = criarBotao("Sound Gun")
local soundGunAtivado = false
local actionSound = nil
btnSoundGun.MouseButton1Click:Connect(function()
    soundGunAtivado = not soundGunAtivado
    btnSoundGun.Text = soundGunAtivado and "Sound Gun: Ativado" or "Sound Gun: Desativado"
    btnSoundGun.BackgroundColor3 = soundGunAtivado and ATIVADO or DESATIVADO
    if soundGunAtivado and not actionSound then
        actionSound = Instance.new("Sound", SoundService)
        actionSound.SoundId = "rbxassetid://6968135315"
        actionSound.Volume = 1
    elseif actionSound then
        actionSound:Destroy()
        actionSound = nil
    end
end)
player.CharacterAdded:Connect(function(char)
    char.ChildAdded:Connect(function(c)
        if soundGunAtivado and c:IsA("Tool") and c.Name == "Gun" and actionSound then
            actionSound:Play()
        end
    end)
end)

-- ==========================================
-- 1️⃣6️⃣ ANTI-FLING
-- ==========================================
local btnFling = criarBotao("Anti-Fling")
local flingAtivado = false
btnFling.MouseButton1Click:Connect(function()
    flingAtivado = not flingAtivado
    btnFling.Text = flingAtivado and "Anti-Fling: Ativado" or "Anti-Fling: Desativado"
    btnFling.BackgroundColor3 = flingAtivado and ATIVADO or DESATIVADO
    if flingAtivado then
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-anti-fling-script-241540"))()
    end
end)

-- ==========================================
-- 1️⃣7️⃣ ANTI-CLICK + NO RELOAD
-- ==========================================
local btnAntiClick = criarBotao("Anti-Click + No Reload")
local antiClickAtivado = false
local antiClickGui = nil

btnAntiClick.MouseButton1Click:Connect(function()
    antiClickAtivado = not antiClickAtivado
    btnAntiClick.Text = antiClickAtivado and "Anti-Click: ABERTO" or "Anti-Click: FECHADO"
    btnAntiClick.BackgroundColor3 = antiClickAtivado and ATIVADO or DESATIVADO

    if antiClickAtivado then
        antiClickGui = Instance.new("ScreenGui")
        antiClickGui.Name = "Petrova_Hub"
        antiClickGui.ResetOnSpawn = false
        antiClickGui.Parent = playerGui

        local frame = Instance.new("Frame", antiClickGui)
        frame.Size = UDim2.new(0, 220, 0, 150)
        frame.Position = UDim2.new(0.5, -110, 0.4, 0)
        frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        frame.BorderSizePixel = 2
        frame.BorderColor3 = Color3.fromRGB(255, 0, 0)
        frame.Active = true
        frame.Draggable = true 
        Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

        local title = Instance.new("TextLabel", frame)
        title.Size = UDim2.new(1, 0, 0, 35)
        title.Position = UDim2.new(0, 0, 0, 0)
        title.Text = "PETROVA SUPREMACY"
        title.TextColor3 = Color3.new(1, 1, 1)
        title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        title.Font = Enum.Font.GothamBold
        title.TextSize = 14

        local btnAnti = Instance.new("TextButton", frame)
        btnAnti.Size = UDim2.new(0.9, 0, 0, 35)
        btnAnti.Position = UDim2.new(0.05, 0, 0.3, 0)
        btnAnti.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        btnAnti.Text = "ANTI-CLICK: OFF"
        btnAnti.TextColor3 = Color3.new(1, 1, 1)
        btnAnti.Font = Enum.Font.SourceSansBold
        btnAnti.TextSize = 16
        Instance.new("UICorner", btnAnti).CornerRadius = UDim.new(0, 8)

        local btnReload = Instance.new("TextButton", frame)
        btnReload.Size = UDim2.new(0.9, 0, 0, 35)
        btnReload.Position = UDim2.new(0.05, 0, 0.65, 0)
        btnReload.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        btnReload.Text = "NO RELOAD: OFF"
        btnReload.TextColor3 = Color3.new(1, 1, 1)
        btnReload.Font = Enum.Font.SourceSansBold
        btnReload.TextSize = 16
        Instance.new("UICorner", btnReload).CornerRadius = UDim.new(0, 8)

        local antiClickAtivoSub = false
        local noReloadAtivo = false
        local conexaoLoop = nil

        btnAnti.MouseButton1Click:Connect(function()
            antiClickAtivoSub = not antiClickAtivoSub
            btnAnti.Text = antiClickAtivoSub and "ANTI-CLICK: ON" or "ANTI-CLICK: OFF"
            btnAnti.BackgroundColor3 = antiClickAtivoSub and Color3.fromRGB(0, 120, 0) or Color3.fromRGB(50, 50, 50)
        end)

        btnReload.MouseButton1Click:Connect(function()
            noReloadAtivo = not noReloadAtivo
            btnReload.Text = noReloadAtivo and "NO RELOAD: ON" or "NO RELOAD: OFF"
            btnReload.BackgroundColor3 = noReloadAtivo and Color3.fromRGB(0, 120, 0) or Color3.fromRGB(50, 50, 50)
        end)

        conexaoLoop = RunService.RenderStepped:Connect(function()
            local char = player.Character
            if not char then return end
            local tool = char:FindFirstChildOfClass("Tool")
            if tool then
                if antiClickAtivoSub then
                    tool.Enabled = false
                    for _, v in pairs(tool:GetDescendants()) do
                        if v:IsA("BasePart") then v.CanTouch = false end
                    end
                else
                    tool.Enabled = true
                end
                if noReloadAtivo then
                    for _, obj in pairs(tool:GetDescendants()) do
                        if obj.Name == "Reloading" or obj.Name == "Debounce" or obj.Name == "Delay" then
                            if obj:IsA("BoolValue") then obj.Value = false end
                            if obj:IsA("NumberValue") then obj.Value = 0 end
                        end
                    end
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if hum then
                        for _, anim in pairs(hum:GetPlayingAnimationTracks()) do
                            if string.find(string.lower(anim.Name), "reload") then anim:Stop() end
                        end
                    end
                end
            end
        end)

        antiClickGui.Destroying:Connect(function()
            if conexaoLoop then conexaoLoop:Disconnect() end
        end)
    else
        if antiClickGui then antiClickGui:Destroy() antiClickGui = nil end
    end
end)

-- ==========================================
-- 1️⃣8️⃣ FACA RÁPIDA
-- ==========================================
local btnFaca = criarBotao("Faca Rápida")
local facaAtivado = false
btnFaca.MouseButton1Click:Connect(function()
    facaAtivado = not facaAtivado
    btnFaca.Text = facaAtivado and "Faca Rápida: Ativado" or "Faca Rápida: Desativado"
    btnFaca.BackgroundColor3 = facaAtivado and ATIVADO or DESATIVADO
    if facaAtivado then
        loadstring(game:HttpGet("https://pastefy.app/GyghlYOG/raw"))()
    end
end)

-- ==========================================
-- 🚀 SPEED CNP (INTEGRADO DIRETAMENTE)
-- ==========================================
local btnSpeedCNP = criarBotao("Speed CNP")
local speedCNPAtivado = false

local offsetAmount = Vector3.new(0, 0, 5.2) 
local weightMass = 20.6
local weightName = "CoMWeight_Object"
local lastJumpBoostTime = 0
local currentRotSpeed = 0
local lastLook = camera.CFrame.LookVector
local speedCNPConnections = {}

local function applyWeight(character)
    local root = character:FindFirstChild("HumanoidRootPart") or character:WaitForChild("HumanoidRootPart", 5)
    if not root then return end

    local existing = character:FindFirstChild(weightName)
    if existing then existing:Destroy() end

    local weight = Instance.new("Part")
    weight.Name = weightName
    weight.Size = Vector3.new(1, 1, 1)
    weight.Transparency = 1 
    weight.CanCollide = false
    weight.CanQuery = false
    weight.Parent = character

    local weld = Instance.new("Weld")
    weld.Part0 = root
    weld.Part1 = weight
    weld.C0 = CFrame.new(offsetAmount) 
    weld.Parent = weight

    weight.Massless = false
    weight.CustomPhysicalProperties = PhysicalProperties.new(weightMass, 0.3, 0.5)
end

local function isReallyInWater(humanoid, root)
    if not humanoid or not root then return false end
    if humanoid:GetState() == Enum.HumanoidStateType.Swimming then return true end
    if humanoid.FloorMaterial == Enum.Material.Water then return true end
    return false
end

local function tryWaterJumpBoost()
    if not speedCNPAtivado then return end
    local character = player.Character
    if not character then return end
    local root = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not root or not humanoid then return end

    if not isReallyInWater(humanoid, root) then return end

    local now = tick()
    if now - lastJumpBoostTime < 0.5 then return end
    lastJumpBoostTime = now

    local baseBoost = 29
    local flickBonus = math.clamp(currentRotSpeed * 1.35, 0, 16)
    local totalBoost = baseBoost + flickBonus

    local vel = root.AssemblyLinearVelocity
    root.AssemblyLinearVelocity = Vector3.new(vel.X, math.max(vel.Y, 0) + totalBoost, vel.Z)
end

btnSpeedCNP.MouseButton1Click:Connect(function()
    speedCNPAtivado = not speedCNPAtivado
    btnSpeedCNP.Text = speedCNPAtivado and "Speed CNP: Ativado" or "Speed CNP: Desativado"
    btnSpeedCNP.BackgroundColor3 = speedCNPAtivado and ATIVADO or DESATIVADO

    if speedCNPAtivado then
        local char = player.Character
        if char then applyWeight(char) end

        speedCNPConnections[#speedCNPConnections+1] = RunService.RenderStepped:Connect(function(dt)
            if not speedCNPAtivado then return end
            local cam = workspace.CurrentCamera
            local currentLook = cam.CFrame.LookVector
            currentRotSpeed = (currentLook - lastLook).Magnitude / math.max(dt, 0.001)
            lastLook = currentLook

            local character = player.Character
            if not character then return end
            local root = character:FindFirstChild("HumanoidRootPart")
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if not root or not humanoid then return end

            local moveDir = humanoid.MoveDirection
            if moveDir.Magnitude > 0.1 then
                local isMovingBack = moveDir:Dot(currentLook) < -0.35
                if isMovingBack and currentRotSpeed > 8 then
                    local boostPower = math.clamp(currentRotSpeed * 1.15, 0, 52)
                    root.AssemblyLinearVelocity = root.AssemblyLinearVelocity + (moveDir.Unit * boostPower * dt * 42)
                end
            end
        end)

        speedCNPConnections[#speedCNPConnections+1] = UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed or not speedCNPAtivado then return end
            if input.KeyCode == Enum.KeyCode.Space or input.KeyCode == Enum.KeyCode.ButtonA then
                tryWaterJumpBoost()
            end
        end)

        speedCNPConnections[#speedCNPConnections+1] = player.CharacterAdded:Connect(function(newChar)
            if speedCNPAtivado then
                task.wait(0.1)
                applyWeight(newChar)
                local hum = newChar:WaitForChild("Humanoid", 5)
                if hum then
                    hum.StateChanged:Connect(function(oldState, newState)
                        if oldState == Enum.HumanoidStateType.Swimming and 
                           (newState == Enum.HumanoidStateType.Jumping or newState == Enum.HumanoidStateType.Freefall) then
                            tryWaterJumpBoost()
                        end
                    end)
                end
            end
        end)

        if player.Character then
            local hum = player.Character:FindFirstChildOfClass("Humanoid")
            if hum then
                speedCNPConnections[#speedCNPConnections+1] = hum.StateChanged:Connect(function(oldState, newState)
                    if oldState == Enum.HumanoidStateType.Swimming and 
                       (newState == Enum.HumanoidStateType.Jumping or newState == Enum.HumanoidStateType.Freefall) then
                        tryWaterJumpBoost()
                    end
                end)
            end
        end
    else
        for _, conn in ipairs(speedCNPConnections) do
            if conn then conn:Disconnect() end
        end
        speedCNPConnections = {}

        local char = player.Character
        if char then
            local existing = char:FindFirstChild(weightName)
            if existing then existing:Destroy() end
        end
    end
end)

-- ==========================================
-- 1️⃣9️⃣ WEAPON EDITOR
-- ==========================================
local btnWeaponEditor = criarBotao("Weapon Editor")
local weaponEditorAtivado = false
local weaponGui = nil
btnWeaponEditor.MouseButton1Click:Connect(function()
    weaponEditorAtivado = not weaponEditorAtivado
    btnWeaponEditor.Text = weaponEditorAtivado and "Weapon Editor: Ativado" or "Weapon Editor: Desativado"
    btnWeaponEditor.BackgroundColor3 = weaponEditorAtivado and ATIVADO or DESATIVADO
    if weaponEditorAtivado then
        local MOVE_STEP = 0.2
        weaponGui = Instance.new("ScreenGui")
        weaponGui.Name = "WeaponEditor"
        weaponGui.ResetOnSpawn = false
        weaponGui.Parent = playerGui
        local frame = Instance.new("Frame", weaponGui)
        frame.Size = UDim2.new(0, 270, 0, 330)
        frame.Position = UDim2.new(0, 40, 0.5, -165)
        frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
        frame.Active = true
        frame.Draggable = true
        Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)
        local title = Instance.new("TextLabel", frame)
        title.Size = UDim2.new(1,0,0,30)
        title.Text = "MM2 Weapon Editor"
        title.TextColor3 = Color3.new(1,1,1)
        title.BackgroundTransparency = 1
        title.Font = Enum.Font.GothamBold
        title.TextSize = 14
        local function getGrip()
            local char = player.Character
            if not char then return end
            local arm = char:FindFirstChild("RightHand") or char:FindFirstChild("Right Arm")
            if not arm then return end
            for _,v in pairs(arm:GetChildren()) do
                if (v:IsA("Weld") or v:IsA("Motor6D")) and (v.Name == "RightGrip" or v.Name == "Grip") then
                    return v
                end
            end
        end
        local offset = CFrame.new()
        local originalC0 = nil
        local function apply()
            local grip = getGrip()
            if not grip then return end
            if not originalC0 then originalC0 = grip.C0 end
            grip.C0 = originalC0 * offset
        end
        local function btn(text, x, y, func)
            local b = Instance.new("TextButton", frame)
            b.Size = UDim2.new(0, 60, 0, 30)
            b.Position = UDim2.new(0, x, 0, y)
            b.Text = text
            b.Font = Enum.Font.Gotham
            b.TextSize = 12
            b.TextColor3 = Color3.new(1,1,1)
            b.BackgroundColor3 = Color3.fromRGB(35,35,35)
            Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
            b.MouseButton1Click:Connect(func)
        end
        btn("-X", 10, 40, function() offset *= CFrame.new(-MOVE_STEP,0,0) apply() end)
        btn("+X", 80, 40, function() offset *= CFrame.new(MOVE_STEP,0,0) apply() end)
        btn("-Y", 10, 75, function() offset *= CFrame.new(0,-MOVE_STEP,0) apply() end)
        btn("+Y", 80, 75, function() offset *= CFrame.new(0,MOVE_STEP,0) apply() end)
        btn("-Z", 10, 110, function() offset *= CFrame.new(0,0,-MOVE_STEP) apply() end)
        btn("+Z", 80, 110, function() offset *= CFrame.new(0,0,MOVE_STEP) apply() end)
        btn("🔒 TRAVAR", 150, 40, function() end)
        btn("↺ Reset", 150, 80, function() offset = CFrame.new() apply() end)
    else
        if weaponGui then weaponGui:Destroy() weaponGui = nil end
    end
end)

-- ==========================================
-- 2️⃣0️⃣ GAZE EMOTE
-- ==========================================
local btnGazeEmote = criarBotao("Gaze Emote")
local gazeEmoteAtivado = false
btnGazeEmote.MouseButton1Click:Connect(function()
    gazeEmoteAtivado = not gazeEmoteAtivado
    btnGazeEmote.Text = gazeEmoteAtivado and "Gaze Emote: Ativado" or "Gaze Emote: Desativado"
    btnGazeEmote.BackgroundColor3 = gazeEmoteAtivado and ATIVADO or DESATIVADO
    if gazeEmoteAtivado then
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Gaze-emote-74592"))()
    end
end)

-- ==========================================
-- 2️⃣1️⃣ GAE ANIMATION EDITOR
-- ==========================================
local btnGAE = criarBotao("GAE Animation Editor")
local gaeAtivado = false
btnGAE.MouseButton1Click:Connect(function()
    gaeAtivado = not gaeAtivado
    btnGAE.Text = gaeAtivado and "GAE Animation: Ativado" or "GAE Animation: Desativado"
    btnGAE.BackgroundColor3 = gaeAtivado and ATIVADO or DESATIVADO
    if gaeAtivado then
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-GAE-SIMPLIFIED-27193"))()
    end
end)

-- ==========================================
-- 2️⃣2️⃣ SPEED GLITCH
-- ==========================================
local btnSpeedGlitch = criarBotao("Speed Glitch")
local glitchAtivado = false
local speedGui = nil

btnSpeedGlitch.MouseButton1Click:Connect(function()
    glitchAtivado = not glitchAtivado
    btnSpeedGlitch.Text = glitchAtivado and "Speed Glitch: Ativado" or "Speed Glitch: Desativado"
    btnSpeedGlitch.BackgroundColor3 = glitchAtivado and ATIVADO or DESATIVADO

    if glitchAtivado then
        local function getHumanoid()
            local character = player.Character or player.CharacterAdded:Wait()
            return character:WaitForChild("Humanoid")
        end
        local humanoid = getHumanoid()
        local baseWalkSpeed = humanoid.WalkSpeed
        local speedBoost = 350
        local sistemaAtivo = false

        speedGui = Instance.new("ScreenGui")
        speedGui.Name = "SpeedGlitchGui"
        speedGui.ResetOnSpawn = false
        speedGui.Parent = playerGui

        local toggleButton = Instance.new("TextButton")
        toggleButton.Size = UDim2.new(0, 140, 0, 50)
        toggleButton.Position = UDim2.new(0.05, 0, 0.1, 0)
        toggleButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
        toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        toggleButton.Text = "Sistema: OFF"
        toggleButton.Font = Enum.Font.GothamBold
        toggleButton.TextSize = 14
        toggleButton.Parent = speedGui
        Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 8)
        toggleButton.Active = true
        toggleButton.Draggable = true

        local function atualizarBotao()
            if sistemaAtivo then
                toggleButton.Text = "Sistema: ON"
                toggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
            else
                toggleButton.Text = "Sistema: OFF"
                toggleButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
            end
        end

        toggleButton.MouseButton1Click:Connect(function()
            sistemaAtivo = not sistemaAtivo
            atualizarBotao()
            if not sistemaAtivo then
                pcall(function() humanoid.WalkSpeed = baseWalkSpeed end)
            end
        end)

        local function conectarHumanoid(hum)
            hum.StateChanged:Connect(function(_, newState)
                if sistemaAtivo then
                    if newState == Enum.HumanoidStateType.Jumping then
                        hum.WalkSpeed = baseWalkSpeed + speedBoost
                    elseif newState == Enum.HumanoidStateType.Landed then
                        hum.WalkSpeed = baseWalkSpeed
                    end
                end
            end)
        end

        conectarHumanoid(humanoid)

        player.CharacterAdded:Connect(function(char)
            humanoid = char:WaitForChild("Humanoid")
            baseWalkSpeed = humanoid.WalkSpeed
            conectarHumanoid(humanoid)
            if not sistemaAtivo then
                humanoid.WalkSpeed = baseWalkSpeed
            end
        end)

        atualizarBotao()
    else
        if speedGui then speedGui:Destroy() speedGui = nil end
    end
end)

-- ==========================================
-- 2️⃣3️⃣ BOMBA DOURADA V2
-- ==========================================
local btnBombaV2 = criarBotao("Bomba Dourada V2")
local bombaV2Ativado = false
btnBombaV2.MouseButton1Click:Connect(function()
    bombaV2Ativado = not bombaV2Ativado
    btnBombaV2.Text = bombaV2Ativado and "Bomba Dourada V2: Ativado" or "Bomba Dourada V2: Desativado"
    btnBombaV2.BackgroundColor3 = bombaV2Ativado and ATIVADO or DESATIVADO
    if bombaV2Ativado then
        loadstring(game:HttpGet("https://pastebin.com/raw/wv3yBxk8"))()
    end
end)

-- ==========================================
-- 2️⃣4️⃣ CÉUS PERSONALIZADOS
-- ==========================================
local btnSkyCustom = criarBotao("Céus Personalizados")
local skyCustomAtivado = false
btnSkyCustom.MouseButton1Click:Connect(function()
    skyCustomAtivado = not skyCustomAtivado
    btnSkyCustom.Text = skyCustomAtivado and "Céus Personalizados: Ativado" or "Céus Personalizados: Desativado"
    btnSkyCustom.BackgroundColor3 = skyCustomAtivado and ATIVADO or DESATIVADO
end)

-- ==========================================
-- 2️⃣5️⃣ SHIFT CUSTOM
-- ==========================================
local btnShiftCustom = criarBotao("Shift Custom")
local shiftCustomAtivado = false
btnShiftCustom.MouseButton1Click:Connect(function()
    shiftCustomAtivado = not shiftCustomAtivado
    btnShiftCustom.Text = shiftCustomAtivado and "Shift Custom: Ativado" or "Shift Custom: Desativado"
    btnShiftCustom.BackgroundColor3 = shiftCustomAtivado and ATIVADO or DESATIVADO
end)

-- ==========================================
-- 2️⃣6️⃣ ESP MM2/MMV
-- ==========================================
local btnESP = criarBotao("ESP MM2/MMV")
local espAtivado = false
btnESP.MouseButton1Click:Connect(function()
    espAtivado = not espAtivado
    btnESP.Text = espAtivado and "ESP MM2/MMV: Ativado" or "ESP MM2/MMV: Desativado"
    btnESP.BackgroundColor3 = espAtivado and ATIVADO or DESATIVADO
end)

-- ==========================================
-- 2️⃣7️⃣ MIRA BRANCA (CROSSHAIR) ⚪
-- ==========================================
local btnMira = criarBotao("Mira Branca")
local miraAtivada = false

btnMira.MouseButton1Click:Connect(function()
    miraAtivada = not miraAtivada
    btnMira.Text = miraAtivada and "Mira Branca: Ativado" or "Mira Branca: Desativado"
    btnMira.BackgroundColor3 = miraAtivada and ATIVADO or DESATIVADO

    if miraAtivada then
        pcall(function()
            loadstring(game:HttpGet("https://rawgithubusercontent.com/maconhacompresunto230-design/Cross-hair-mm2/refs/heads/main/Script.lua"))()
        end)
    end
end)

-- ==========================================
-- 2️⃣8️⃣ TIRAR ILUMINAÇÃO (OLD GRAPHIC) 🕹️
-- ==========================================
local btnTirarIlum = criarBotao("Tirar Iluminação")
local tirarIlumAtivado = false

btnTirarIlum.MouseButton1Click:Connect(function()
    tirarIlumAtivado = not tirarIlumAtivado
    btnTirarIlum.Text = tirarIlumAtivado and "Tirar Iluminação: Ativado" or "Tirar Iluminação: Desativado"
    btnTirarIlum.BackgroundColor3 = tirarIlumAtivado and ATIVADO or DESATIVADO

    if tirarIlumAtivado then
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/ZoeWarOnTop/Old-Graphic/refs/heads/main/Qualidade-Antiga"))()
        end)
    end
end)

-- ==========================================
-- 2️⃣9️⃣ EXTRA CNP 🌸
-- ==========================================
local btnExtraCNP = criarBotao("Extra CNP")
local extraCNPAtivado = false

btnExtraCNP.MouseButton1Click:Connect(function()
    extraCNPAtivado = not extraCNPAtivado
    btnExtraCNP.Text = extraCNPAtivado and "Extra CNP: Ativado" or "Extra CNP: Desativado"
    btnExtraCNP.BackgroundColor3 = extraCNPAtivado and ATIVADO or DESATIVADO

    if extraCNPAtivado then
        pcall(function()
            loadstring(game:HttpGet("https://pastefy.app/IOnZBrdF/raw"))()
        end)
    end
end)

print("✅ PAINEL PETROVA COM SCROLLING CARREGADO COM SUCESSO!")
