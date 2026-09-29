-- ============================================
-- UZIVERT HUB | v1.0.2
-- Parte 1/3: Config, UI con Luna y Componentes
-- ============================================

local Players = game:GetService("Players")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

LocalPlayer:WaitForChild("PlayerGui")
if not LocalPlayer.Character then
    LocalPlayer.CharacterAdded:Wait()
end

local VERSION = "v1.0.2"
local ESP_ACTIVO = true
local AUTOSHOOT_ACTIVO = false
local SILENT_AIM_ACTIVO = false
local GUN_ESP_ACTIVO = false
local GUN_AURA_ACTIVO = false
local ANTI_FLING_ACTIVO = false
local NOCLIP_ACTIVO = false
local WALKSPEED_VALOR = 16

local COLORES = {
    FondoPrincipal  = Color3.fromRGB(10, 15, 35),
    FondoSecundario = Color3.fromRGB(20, 30, 60),
    Acento          = Color3.fromRGB(80, 130, 255),
    AcentoBrillo    = Color3.fromRGB(120, 170, 255),
    Texto           = Color3.fromRGB(255, 255, 255),
    TextoSecundario = Color3.fromRGB(180, 200, 255),
    Rojo            = Color3.fromRGB(255, 60, 60),
    Verde           = Color3.fromRGB(60, 220, 120),
    Azul            = Color3.fromRGB(30, 140, 255),
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UzivertHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Botón flotante "U" (noche estrellada)
local BotonFlotante = Instance.new("TextButton")
BotonFlotante.Size = UDim2.new(0, 58, 0, 58)
BotonFlotante.Position = UDim2.new(0, 30, 0.5, -29)
BotonFlotante.BackgroundColor3 = Color3.fromRGB(8, 8, 20)
BotonFlotante.Text = ""
BotonFlotante.BorderSizePixel = 0
BotonFlotante.Active = true
BotonFlotante.Draggable = true
BotonFlotante.Parent = ScreenGui

local gradBoton = Instance.new("UIGradient")
gradBoton.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(5, 5, 25)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(25, 15, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 5, 25)),
})
gradBoton.Rotation = 45
gradBoton.Parent = BotonFlotante

local cBoton = Instance.new("UICorner")
cBoton.CornerRadius = UDim.new(1, 0)
cBoton.Parent = BotonFlotante

local sBoton = Instance.new("UIStroke")
sBoton.Color = Color3.fromRGB(120, 140, 255)
sBoton.Thickness = 1.5
sBoton.Transparency = 0.2
sBoton.Parent = BotonFlotante

for i = 1, 4 do
    local estrella = Instance.new("TextLabel")
    estrella.Size = UDim2.new(0, 10, 0, 10)
    estrella.Position = UDim2.new(math.random(10, 80)/100, 0, math.random(10, 80)/100, 0)
    estrella.BackgroundTransparency = 1
    estrella.Text = "✦"
    estrella.TextColor3 = Color3.fromRGB(200, 220, 255)
    estrella.TextSize = math.random(6, 10)
    estrella.Font = Enum.Font.GothamBold
    estrella.ZIndex = 2
    estrella.Parent = BotonFlotante
end

local LetraU = Instance.new("TextLabel")
LetraU.Size = UDim2.new(1, 0, 1, 0)
LetraU.BackgroundTransparency = 1
LetraU.Text = "U"
LetraU.TextColor3 = Color3.fromRGB(255, 255, 255)
LetraU.Font = Enum.Font.GothamBlack
LetraU.TextSize = 34
LetraU.ZIndex = 3
LetraU.Parent = BotonFlotante

-- ============================================
-- Panel Principal (diseño anterior con luna)
-- ============================================
local Panel = Instance.new("Frame")
Panel.Size = UDim2.new(0, 380, 0, 500)
Panel.Position = UDim2.new(0.5, -190, 0.5, -250)
Panel.BackgroundColor3 = COLORES.FondoPrincipal
Panel.BorderSizePixel = 0
Panel.Visible = false
Panel.Active = true
Panel.Draggable = true
Panel.Parent = ScreenGui

local gradPanel = Instance.new("UIGradient")
gradPanel.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(5, 8, 25)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(15, 25, 60)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 12, 35)),
})
gradPanel.Rotation = 90
gradPanel.Parent = Panel

local cP = Instance.new("UICorner")
cP.CornerRadius = UDim.new(0, 14)
cP.Parent = Panel

local sP = Instance.new("UIStroke")
sP.Color = COLORES.Acento
sP.Thickness = 1
sP.Transparency = 0.3
sP.Parent = Panel

-- Luna épica
local Luna = Instance.new("Frame")
Luna.Size = UDim2.new(0, 120, 0, 120)
Luna.Position = UDim2.new(1, -95, 0, -25)
Luna.BackgroundColor3 = Color3.fromRGB(220, 230, 255)
Luna.BorderSizePixel = 0
Luna.ZIndex = 0
Luna.Parent = Panel

local cLuna = Instance.new("UICorner")
cLuna.CornerRadius = UDim.new(1, 0)
cLuna.Parent = Luna

local gradLuna = Instance.new("UIGradient")
gradLuna.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.7, Color3.fromRGB(180, 200, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 150, 220)),
})
gradLuna.Rotation = 135
gradLuna.Parent = Luna

-- Cráteres
local function crearCrater(pos, size, trans)
    local crater = Instance.new("Frame")
    crater.Size = UDim2.new(0, size, 0, size)
    crater.Position = pos
    crater.BackgroundColor3 = Color3.fromRGB(150, 170, 220)
    crater.BackgroundTransparency = trans
    crater.BorderSizePixel = 0
    crater.ZIndex = 0
    crater.Parent = Luna
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(1, 0)
    c.Parent = crater
end

crearCrater(UDim2.new(0.2, 0, 0.25, 0), 18, 0.4)
crearCrater(UDim2.new(0.55, 0, 0.5, 0), 25, 0.3)
crearCrater(UDim2.new(0.3, 0, 0.65, 0), 14, 0.5)
crearCrater(UDim2.new(0.65, 0, 0.2, 0), 12, 0.5)

-- Título
local Titulo = Instance.new("TextLabel")
Titulo.Size = UDim2.new(1, 0, 0, 45)
Titulo.BackgroundTransparency = 1
Titulo.Text = "Uzivert Hub"
Titulo.TextColor3 = COLORES.Texto
Titulo.Font = Enum.Font.GothamBlack
Titulo.TextSize = 20
Titulo.ZIndex = 2
Titulo.Parent = Panel

local Subtitulo = Instance.new("TextLabel")
Subtitulo.Size = UDim2.new(1, 0, 0, 18)
Subtitulo.Position = UDim2.new(0, 0, 0, 40)
Subtitulo.BackgroundTransparency = 1
Subtitulo.Text = "| " .. VERSION .. " |"
Subtitulo.TextColor3 = COLORES.AcentoBrillo
Subtitulo.Font = Enum.Font.GothamMedium
Subtitulo.TextSize = 11
Subtitulo.ZIndex = 2
Subtitulo.Parent = Panel

-- Botones cerrar/minimizar
local BotonCerrar = Instance.new("TextButton")
BotonCerrar.Size = UDim2.new(0, 28, 0, 28)
BotonCerrar.Position = UDim2.new(1, -38, 0, 12)
BotonCerrar.BackgroundColor3 = COLORES.Rojo
BotonCerrar.Text = "✕"
BotonCerrar.TextColor3 = Color3.fromRGB(255, 255, 255)
BotonCerrar.Font = Enum.Font.GothamBold
BotonCerrar.TextSize = 14
BotonCerrar.BorderSizePixel = 0
BotonCerrar.ZIndex = 3
BotonCerrar.Parent = Panel

local cCerrar = Instance.new("UICorner")
cCerrar.CornerRadius = UDim.new(1, 0)
cCerrar.Parent = BotonCerrar

local BotonMin = Instance.new("TextButton")
BotonMin.Size = UDim2.new(0, 28, 0, 28)
BotonMin.Position = UDim2.new(1, -72, 0, 12)
BotonMin.BackgroundColor3 = Color3.fromRGB(200, 150, 50)
BotonMin.Text = "—"
BotonMin.TextColor3 = Color3.fromRGB(255, 255, 255)
BotonMin.Font = Enum.Font.GothamBold
BotonMin.TextSize = 14
BotonMin.BorderSizePixel = 0
BotonMin.ZIndex = 3
BotonMin.Parent = Panel

local cMin = Instance.new("UICorner")
cMin.CornerRadius = UDim.new(1, 0)
cMin.Parent = BotonMin

BotonCerrar.MouseButton1Click:Connect(function()
    Panel.Visible = false
    BotonFlotante.Visible = true
end)

BotonMin.MouseButton1Click:Connect(function()
    Panel.Visible = false
    BotonFlotante.Visible = true
end)

BotonFlotante.MouseButton1Click:Connect(function()
    Panel.Visible = not Panel.Visible
    if Panel.Visible then BotonFlotante.Visible = false end
end)

-- Pestañas
local ContTabs = Instance.new("Frame")
ContTabs.Size = UDim2.new(1, -20, 0, 32)
ContTabs.Position = UDim2.new(0, 10, 0, 70)
ContTabs.BackgroundTransparency = 1
ContTabs.ZIndex = 2
ContTabs.Parent = Panel

local layoutTabs = Instance.new("UIListLayout")
layoutTabs.FillDirection = Enum.FillDirection.Horizontal
layoutTabs.Padding = UDim.new(0, 5)
layoutTabs.HorizontalAlignment = Enum.HorizontalAlignment.Center
layoutTabs.Parent = ContTabs

local Contenido = Instance.new("Frame")
Contenido.Size = UDim2.new(1, -20, 1, -115)
Contenido.Position = UDim2.new(0, 10, 0, 105)
Contenido.BackgroundTransparency = 1
Contenido.ZIndex = 2
Contenido.Parent = Panel

local tabs = {}
local paginas = {}

local function crearTab(nombre)
    local boton = Instance.new("TextButton")
    boton.Size = UDim2.new(0, 72, 1, 0)
    boton.BackgroundColor3 = COLORES.FondoSecundario
    boton.Text = nombre
    boton.TextColor3 = COLORES.TextoSecundario
    boton.Font = Enum.Font.GothamMedium
    boton.TextSize = 10
    boton.BorderSizePixel = 0
    boton.ZIndex = 2
    boton.Parent = ContTabs

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 7)
    c.Parent = boton

    local pagina = Instance.new("ScrollingFrame")
    pagina.Size = UDim2.new(1, 0, 1, 0)
    pagina.BackgroundTransparency = 1
    pagina.BorderSizePixel = 0
    pagina.ScrollBarThickness = 4
    pagina.ScrollBarImageColor3 = COLORES.Acento
    pagina.Visible = false
    pagina.ZIndex = 2
    pagina.Parent = Contenido

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 7)
    layout.Parent = pagina

    table.insert(tabs, boton)
    table.insert(paginas, pagina)

    boton.MouseButton1Click:Connect(function()
        for i, t in ipairs(tabs) do
            t.BackgroundColor3 = COLORES.FondoSecundario
            t.TextColor3 = COLORES.TextoSecundario
            paginas[i].Visible = false
        end
        boton.BackgroundColor3 = COLORES.Acento
        boton.TextColor3 = COLORES.Texto
        pagina.Visible = true
    end)

    return pagina
end

local function crearToggle(padre, texto, estadoInicial, callback, icono)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 42)
    frame.BackgroundColor3 = COLORES.FondoSecundario
    frame.BorderSizePixel = 0
    frame.ZIndex = 2
    frame.Parent = padre

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 9)
    c.Parent = frame

    local iconLbl = Instance.new("TextLabel")
    iconLbl.Size = UDim2.new(0, 28, 1, 0)
    iconLbl.Position = UDim2.new(0, 6, 0, 0)
    iconLbl.BackgroundTransparency = 1
    iconLbl.Text = icono or "✦"
    iconLbl.TextColor3 = COLORES.TextoSecundario
    iconLbl.TextSize = 14
    iconLbl.Font = Enum.Font.GothamBold
    iconLbl.ZIndex = 2
    iconLbl.Parent = frame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.6, 0, 1, 0)
    label.Position = UDim2.new(0, 36, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = texto
    label.TextColor3 = COLORES.Texto
    label.Font = Enum.Font.GothamMedium
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 2
    label.Parent = frame

    local switch = Instance.new("TextButton")
    switch.Size = UDim2.new(0, 48, 0, 24)
    switch.Position = UDim2.new(1, -60, 0.5, -12)
    switch.BackgroundColor3 = estadoInicial and COLORES.Verde or Color3.fromRGB(60, 70, 100)
    switch.Text = ""
    switch.BorderSizePixel = 0
    switch.ZIndex = 2
    switch.Parent = frame

    local c2 = Instance.new("UICorner")
    c2.CornerRadius = UDim.new(1, 0)
    c2.Parent = switch

    local circulo = Instance.new("Frame")
    circulo.Size = UDim2.new(0, 18, 0, 18)
    circulo.Position = estadoInicial and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
    circulo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    circulo.BorderSizePixel = 0
    circulo.ZIndex = 3
    circulo.Parent = switch

    local c3 = Instance.new("UICorner")
    c3.CornerRadius = UDim.new(1, 0)
    c3.Parent = circulo

    local estado = estadoInicial

    switch.MouseButton1Click:Connect(function()
        estado = not estado
        switch.BackgroundColor3 = estado and COLORES.Verde or Color3.fromRGB(60, 70, 100)
        TweenService:Create(circulo, TweenInfo.new(0.2), {
            Position = estado and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
        }):Play()
        callback(estado)
    end)
end

local function crearBoton(padre, texto, callback, color, icono)
    local boton = Instance.new("TextButton")
    boton.Size = UDim2.new(1, 0, 0, 46)
    boton.BackgroundColor3 = color or COLORES.Acento
    boton.Text = ""
    boton.BorderSizePixel = 0
    boton.ZIndex = 2
    boton.Parent = padre

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 9)
    c.Parent = boton

    local iconLbl = Instance.new("TextLabel")
    iconLbl.Size = UDim2.new(0, 28, 1, 0)
    iconLbl.Position = UDim2.new(0, 6, 0, 0)
    iconLbl.BackgroundTransparency = 1
    iconLbl.Text = icono or ""
    iconLbl.TextColor3 = COLORES.Texto
    iconLbl.TextSize = 14
    iconLbl.Font = Enum.Font.GothamBold
    iconLbl.ZIndex = 3
    iconLbl.Parent = boton

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -40, 1, 0)
    label.Position = UDim2.new(0, 36, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = texto
    label.TextColor3 = COLORES.Texto
    label.Font = Enum.Font.GothamBold
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 3
    label.Parent = boton

    boton.MouseButton1Click:Connect(callback)
    return boton
end

local function crearSlider(padre, texto, min, max, inicial, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 58)
    frame.BackgroundColor3 = COLORES.FondoSecundario
    frame.BorderSizePixel = 0
    frame.ZIndex = 2
    frame.Parent = padre

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 9)
    c.Parent = frame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 0, 20)
    label.Position = UDim2.new(0, 10, 0, 6)
    label.BackgroundTransparency = 1
    label.Text = texto .. ": " .. inicial
    label.TextColor3 = COLORES.Texto
    label.Font = Enum.Font.GothamMedium
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 2
    label.Parent = frame

    local barra = Instance.new("Frame")
    barra.Size = UDim2.new(1, -20, 0, 9)
    barra.Position = UDim2.new(0, 10, 0, 37)
    barra.BackgroundColor3 = Color3.fromRGB(40, 50, 80)
    barra.BorderSizePixel = 0
    barra.ZIndex = 2
    barra.Parent = frame

    local c2 = Instance.new("UICorner")
    c2.CornerRadius = UDim.new(1, 0)
    c2.Parent = barra

    local relleno = Instance.new("Frame")
    relleno.Size = UDim2.new((inicial - min) / (max - min), 0, 1, 0)
    relleno.BackgroundColor3 = COLORES.Acento
    relleno.BorderSizePixel = 0
    relleno.ZIndex = 3
    relleno.Parent = barra

    local c3 = Instance.new("UICorner")
    c3.CornerRadius = UDim.new(1, 0)
    c3.Parent = relleno

    local valor = inicial
    local arrastrando = false

    barra.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            arrastrando = true
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if arrastrando and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local posX = math.clamp((input.Position.X - barra.AbsolutePosition.X) / barra.AbsoluteSize.X, 0, 1)
            valor = math.floor(min + (max - min) * posX)
            relleno.Size = UDim2.new(posX, 0, 1, 0)
            label.Text = texto .. ": " .. valor
            callback(valor)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            arrastrando = false
        end
    end)
end

-- ============================================
-- Parte 2/3: ESP, Auto Shoot y Movimiento
-- ============================================

local PaginaVisual = crearTab("Visual")
local PaginaShoot = crearTab("Shoot")
local PaginaPlayer = crearTab("Player")
local PaginaUtil = crearTab("Util")
local PaginaInfo = crearTab("Info")

tabs[1].BackgroundColor3 = COLORES.Acento
tabs[1].TextColor3 = COLORES.Texto
paginas[1].Visible = true

-- ESP Jugadores
local COLORES_ESP = {
    Murderer = Color3.fromRGB(255, 40, 40),
    Sheriff  = Color3.fromRGB(40, 150, 255),
    Innocent = Color3.fromRGB(40, 255, 130),
}

local function detectarRol(jugador)
    if not jugador.Character then return "Innocent" end
    for _, tool in ipairs(jugador.Character:GetChildren()) do
        if tool:IsA("Tool") then
            if tool.Name == "Knife" or tool.Name:lower():find("knife") then return "Murderer" end
            if tool.Name == "Gun" or tool.Name == "Revolver" or tool.Name:lower():find("gun") then return "Sheriff" end
        end
    end
    local backpack = jugador:FindFirstChild("Backpack")
    if backpack then
        if backpack:FindFirstChild("Knife") then return "Murderer" end
        if backpack:FindFirstChild("Gun") or backpack:FindFirstChild("Revolver") then return "Sheriff" end
    end
    return "Innocent"
end

local function aplicarESP(jugador)
    if jugador == LocalPlayer then return end
    if not jugador.Character then return end
    local rol = detectarRol(jugador)
    local color = COLORES_ESP[rol]
    local anterior = jugador.Character:FindFirstChild("ESP_Highlight")
    if anterior then anterior:Destroy() end
    local hl = Instance.new("Highlight")
    hl.Name = "ESP_Highlight"
    hl.Parent = jugador.Character
    hl.Adornee = jugador.Character
    hl.FillColor = color
    hl.FillTransparency = 0.35
    hl.OutlineColor = color
    hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
end

task.spawn(function()
    while task.wait(0.5) do
        if ESP_ACTIVO then
            for _, jugador in ipairs(Players:GetPlayers()) do
                if jugador ~= LocalPlayer and jugador.Character then
                    local hum = jugador.Character:FindFirstChildOfClass("Humanoid")
                    if hum and hum.Health > 0 then
                        aplicarESP(jugador)
                    end
                end
            end
        end
    end
end)

-- Gun ESP
local function aplicarGunESP()
    if not GUN_ESP_ACTIVO then return end
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Tool") and (obj.Name == "Gun" or obj.Name == "Revolver") then
            local tieneDueño = false
            for _, jugador in ipairs(Players:GetPlayers()) do
                if jugador.Character and obj:IsDescendantOf(jugador.Character) then
                    tieneDueño = true
                    break
                end
                local backpack = jugador:FindFirstChild("Backpack")
                if backpack and obj:IsDescendantOf(backpack) then
                    tieneDueño = true
                    break
                end
            end
            if not tieneDueño then
                if not obj:FindFirstChild("GunESP_Highlight") then
                    local handle = obj:FindFirstChild("Handle")
                    if handle then
                        local hl = Instance.new("Highlight")
                        hl.Name = "GunESP_Highlight"
                        hl.Parent = handle
                        hl.Adornee = handle
                        hl.FillColor = Color3.fromRGB(60, 140, 255)
                        hl.FillTransparency = 0.4
                        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                        hl.OutlineTransparency = 0
                        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    end
                end
            end
        end
    end
end

task.spawn(function()
    while task.wait(1) do
        if GUN_ESP_ACTIVO then
            aplicarGunESP()
        end
    end
end)

-- Detectores
local function detectarMurderer()
    for _, jugador in ipairs(Players:GetPlayers()) do
        if jugador ~= LocalPlayer and jugador.Character then
            local hum = jugador.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                for _, tool in ipairs(jugador.Character:GetChildren()) do
                    if tool:IsA("Tool") and (tool.Name == "Knife" or tool.Name:lower():find("knife")) then
                        return jugador
                    end
                end
                local backpack = jugador:FindFirstChild("Backpack")
                if backpack and backpack:FindFirstChild("Knife") then
                    return jugador
                end
            end
        end
    end
    return nil
end

local function tengoPistola()
    local char = LocalPlayer.Character
    if not char then return nil end
    local tool = char:FindFirstChildOfClass("Tool")
    if tool and (tool.Name == "Gun" or tool.Name == "Revolver" or tool.Name:lower():find("gun")) then
        return tool
    end
    return nil
end

-- Silent Aim con pcall
local hookOK = pcall(function()
    local gmt = getrawmetatable(game)
    local oldIndex = gmt.__index
    setreadonly(gmt, false)
    gmt.__index = newcclosure(function(self, key)
        if (key == "Hit" or key == "Target") then
            if SILENT_AIM_ACTIVO or AUTOSHOOT_ACTIVO then
                local m = detectarMurderer()
                if m and m.Character then
                    local hrp = m.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then return hrp end
                end
            end
        end
        return oldIndex(self, key)
    end)
    setreadonly(gmt, true)
end)

if not hookOK then
    print("⚠️ Silent Aim no disponible")
end

function dispararAlMurderer()
    if not AUTOSHOOT_ACTIVO then return end
    local pistola = tengoPistola()
    if not pistola then return end
    local m = detectarMurderer()
    if not m or not m.Character then return end
    local hrp = m.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    pistola:Activate()
end

-- Toggles Visual
crearToggle(PaginaVisual, "ESP Jugadores", true, function(e) ESP_ACTIVO = e end, "👁")
crearToggle(PaginaVisual, "Gun ESP", false, function(e)
    GUN_ESP_ACTIVO = e
    if not e then
        for _, obj in ipairs(workspace:GetDescendants()) do
            local hl = obj:FindFirstChild("GunESP_Highlight")
            if hl then hl:Destroy() end
        end
    end
end, "🔫")

-- Toggles Shoot
crearToggle(PaginaShoot, "Auto Shoot", false, function(e) AUTOSHOOT_ACTIVO = e end, "🎯")
crearToggle(PaginaShoot, "Silent Aim", false, function(e) SILENT_AIM_ACTIVO = e end, "💥")
crearBoton(PaginaShoot, "Shoot Murderer", function() dispararAlMurderer() end, COLORES.Rojo, "🔫")

-- Player
local function aplicarAntiFling()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    if not hrp:FindFirstChild("AntiFling") then
        local bv = Instance.new("BodyVelocity")
        bv.Name = "AntiFling"
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.Velocity = Vector3.new(0, 0, 0)
        bv.Parent = hrp
    end
end

crearToggle(PaginaPlayer, "Anti-Fling", false, function(e)
    ANTI_FLING_ACTIVO = e
    if e then
        aplicarAntiFling()
    else
        local char = LocalPlayer.Character
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                local af = hrp:FindFirstChild("AntiFling")
                if af then af:Destroy() end
            end
        end
    end
end, "🛡")

crearToggle(PaginaPlayer, "Noclip", false, function(e) NOCLIP_ACTIVO = e end, "👻")

crearSlider(PaginaPlayer, "Walkspeed", 16, 200, 16, function(v)
    WALKSPEED_VALOR = v
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = v end
    end
end)

-- Bucle de movimiento
task.spawn(function()
    while task.wait(0.2) do
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                if hum.WalkSpeed ~= WALKSPEED_VALOR then
                    hum.WalkSpeed = WALKSPEED_VALOR
                end
                if NOCLIP_ACTIVO then
                    for _, part in ipairs(char:GetDescendants()) do
                        if part:IsA("BasePart") and part.CanCollide then
                            part.CanCollide = false
                        end
                    end
                end
                if ANTI_FLING_ACTIVO then
                    aplicarAntiFling()
                end
            end
        end
    end
end)

LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    if ANTI_FLING_ACTIVO then aplicarAntiFling() end
    if WALKSPEED_VALOR ~= 16 then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = WALKSPEED_VALOR end
    end
end)

-- ============================================
-- Parte 3/3: Auto Pickup, Fling, Utilidades
-- ============================================

-- Auto Pickup Gun
local function buscarPistolaEnMapa()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Tool") and (obj.Name == "Gun" or obj.Name == "Revolver" or obj.Name:lower():find("gun")) then
            local tieneDueño = false
            for _, jugador in ipairs(Players:GetPlayers()) do
                if jugador.Character and obj:IsDescendantOf(jugador.Character) then
                    tieneDueño = true
                    break
                end
                local backpack = jugador:FindFirstChild("Backpack")
                if backpack and obj:IsDescendantOf(backpack) then
                    tieneDueño = true
                    break
                end
            end
            if not tieneDueño then
                return obj
            end
        end
    end
    return nil
end

task.spawn(function()
    while task.wait(0.5) do
        if GUN_AURA_ACTIVO then
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
                local pistola = buscarPistolaEnMapa()
                if pistola then
                    local handle = pistola:FindFirstChild("Handle")
                    if handle then
                        local posOriginal = hrp.CFrame
                        hrp.CFrame = handle.CFrame + Vector3.new(0, 3, 0)
                        task.wait(0.15)
                        hrp.CFrame = posOriginal
                    end
                end
            end
        end
    end
end)

crearToggle(PaginaUtil, "Auto Pickup Gun", false, function(e)
    GUN_AURA_ACTIVO = e
end, "🔫")

-- Fling mejorado (1 segundo)
function flingPlayer(target)
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    if not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then return end

    local posicionOriginal = hrp.CFrame
    local targetHrp = target.Character.HumanoidRootPart
    
    local bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bv.Velocity = Vector3.new(
        math.random(-50000, 50000),
        math.random(50000, 100000),
        math.random(-50000, 50000)
    )
    bv.Parent = targetHrp
    
    hrp.CFrame = targetHrp.CFrame * CFrame.new(0, 0, 2)
    
    task.wait(1)
    
    bv:Destroy()
    
    task.wait(0.3)
    hrp.CFrame = posicionOriginal
end

crearBoton(PaginaUtil, "Fling Murderer", function()
    local m = detectarMurderer()
    if m then flingPlayer(m) end
end, Color3.fromRGB(150, 50, 200), "🌀")

crearBoton(PaginaUtil, "Fling Sheriff", function()
    for _, jugador in ipairs(Players:GetPlayers()) do
        if jugador ~= LocalPlayer and jugador.Character then
            for _, tool in ipairs(jugador.Character:GetChildren()) do
                if tool:IsA("Tool") and (tool.Name == "Gun" or tool.Name == "Revolver") then
                    flingPlayer(jugador)
                    return
                end
            end
            local backpack = jugador:FindFirstChild("Backpack")
            if backpack and (backpack:FindFirstChild("Gun") or backpack:FindFirstChild("Revolver")) then
                flingPlayer(jugador)
                return
            end
        end
    end
end, Color3.fromRGB(50, 150, 200), "🌀")

-- Reportar Bug y Reseñas
crearBoton(PaginaInfo, "Reportar Bug", function()
    pcall(function()
        if setclipboard then
            setclipboard("https://discord.gg/tu-servidor")
        end
    end)
    print("Discord: discord.gg/tu-servidor")
end, Color3.fromRGB(200, 100, 50), "🐛")

crearBoton(PaginaInfo, "Dejar Reseña", function()
    pcall(function()
        if setclipboard then
            setclipboard("https://discord.gg/tu-servidor")
        end
    end)
    print("¡Gracias por usar Uzivert Hub!")
end, Color3.fromRGB(50, 150, 200), "⭐")

-- Info
local info1 = Instance.new("TextLabel")
info1.Size = UDim2.new(1, 0, 0, 42)
info1.BackgroundColor3 = COLORES.FondoSecundario
info1.Text = "Uzivert Hub | " .. VERSION
info1.TextColor3 = COLORES.Texto
info1.Font = Enum.Font.GothamBold
info1.TextSize = 14
info1.BorderSizePixel = 0
info1.ZIndex = 2
info1.Parent = PaginaInfo

local cI1 = Instance.new("UICorner")
cI1.CornerRadius = UDim.new(0, 9)
cI1.Parent = info1

local info2 = Instance.new("TextLabel")
info2.Size = UDim2.new(1, 0, 0, 180)
info2.BackgroundColor3 = COLORES.FondoSecundario
info2.Text = "Uzivert Hub " .. VERSION .. "\n\nAnti-Fling | Noclip | Walkspeed\nAuto Pickup Gun | Fling mejorado\nESP Jugadores | Gun ESP | Silent Aim\n\nScript inspirado en mi niña Sofi <3"
info2.TextColor3 = COLORES.TextoSecundario
info2.Font = Enum.Font.Gotham
info2.TextSize = 11
info2.TextWrapped = true
info2.BorderSizePixel = 0
info2.ZIndex = 2
info2.Parent = PaginaInfo

local cI2 = Instance.new("UICorner")
cI2.CornerRadius = UDim.new(0, 9)
cI2.Parent = info2

print("====================================")
print("Uzivert Hub " .. VERSION .. " cargado")
print("====================================")