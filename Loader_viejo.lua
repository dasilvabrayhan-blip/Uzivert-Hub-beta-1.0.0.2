-- 🚨 CARTEL DE LOADER DESACTUALIZADO (SIN ESCAPATORIA)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CartelLoaderViejo"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 999999
ScreenGui.Parent = game:GetService("CoreGui")

-- Fondo oscuro que tapa todo el juego
local Fondo = Instance.new("Frame")
Fondo.Size = UDim2.new(1, 0, 1, 0)
Fondo.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Fondo.BackgroundTransparency = 0.4 -- Un poquito transparente para que se vea el juego atrás
Fondo.BorderSizePixel = 0
Fondo.Parent = ScreenGui

-- Ventana del cartel
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 350, 0, 180)
Frame.Position = UDim2.new(0.5, -175, 0.5, -90)
Frame.BackgroundColor3 = Color3.fromRGB(20, 5, 5)
Frame.BorderSizePixel = 0
Frame.Active = true -- Evita que los clics pasen al juego de atrás
Frame.Parent = Fondo

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = Frame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(255, 50, 50)
UIStroke.Thickness = 2
UIStroke.Parent = Frame

local Titulo = Instance.new("TextLabel")
Titulo.Size = UDim2.new(1, 0, 0, 40)
Titulo.Position = UDim2.new(0, 0, 0, 10)
Titulo.BackgroundTransparency = 1
Titulo.Text = "⚠️ LOADER DESACTUALIZADO ⚠️"
Titulo.TextColor3 = Color3.fromRGB(255, 50, 50)
Titulo.Font = Enum.Font.GothamBlack
Titulo.TextSize = 16
Titulo.Parent = Frame

local Texto = Instance.new("TextLabel")
Texto.Size = UDim2.new(1, -20, 0, 80)
Texto.Position = UDim2.new(0, 10, 0, 55)
Texto.BackgroundTransparency = 1
Texto.Text = "Este Loader ya no es el oficial.\nUnite al Discord para copiar el nuevo Loader actualizado."
Texto.TextColor3 = Color3.fromRGB(255, 255, 255)
Texto.Font = Enum.Font.GothamMedium
Texto.TextSize = 13
Texto.TextWrapped = true
Texto.Parent = Frame

local Boton = Instance.new("TextButton")
Boton.Size = UDim2.new(1, -40, 0, 30)
Boton.Position = UDim2.new(0, 20, 1, -40)
Boton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
Boton.Text = "COPIAR LINK DEL DISCORD"
Boton.TextColor3 = Color3.fromRGB(255, 255, 255)
Boton.Font = Enum.Font.GothamBold
Boton.TextSize = 12
Boton.Parent = Frame

local BC = Instance.new("UICorner")
BC.CornerRadius = UDim.new(0, 6)
BC.Parent = Boton

Boton.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard("https://discord.gg/vhHERWcbXe")
        Boton.Text = "¡LINK COPIADO! Andá a Discord"
        Boton.BackgroundColor3 = Color3.fromRGB(0, 200, 0) -- Se pone verde al copiar
        task.wait(3)
        Boton.Text = "COPIAR LINK DEL DISCORD"
        Boton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    end
end)
