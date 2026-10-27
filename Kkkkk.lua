-- 🛡️ CENTINELA ANTI-LOADER V5 (A prueba de fallos para Delta)
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

-- 🟢 TUS DOMINIOS PERMITIDOS (Todo lo que sea tuyo pasa)
local DOMINIOS_PERMITIDOS = {
    "dasilvabrayhan-blip",       -- Tu GitHub
    "uzivert-api.onrender.com",  -- Tu API
    "tinyurl.com",               -- Por si usás TinyURL para los hubs
    "rbxassetid",                -- Para las imágenes o sonidos del juego
    "roblox.com"                 -- Para las APIs oficiales
}

local function banearJugador(motivo)
    warn("🚨 [UZIVERT SHIELD] Bloqueado: " .. motivo)
    local gui = Instance.new("ScreenGui")
    gui.Name = "UzivertSecurityKick"
    gui.IgnoreGuiInset = true
    gui.DisplayOrder = 999999
    if gethui then gui.Parent = gethui() else gui.Parent = localPlayer:WaitForChild("PlayerGui") end
    local frame = Instance.new("Frame")
    frame.Size = UDim2.fromScale(1, 1)
    frame.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
    frame.BorderSizePixel = 0
    frame.Parent = gui
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 80)
    title.Position = UDim2.new(0, 0, 0.3, 0)
    title.BackgroundTransparency = 1
    title.Text = "⚠️ LOADER MALICIOSO DETECTADO ⚠️"
    title.TextColor3 = Color3.fromRGB(255, 50, 50)
    title.Font = Enum.Font.GothamBlack
    title.TextSize = 40
    title.Parent = frame
    local desc = Instance.new("TextLabel")
    desc.Size = UDim2.new(0.8, 0, 0, 100)
    desc.Position = UDim2.new(0.1, 0, 0.4, 0)
    desc.BackgroundTransparency = 1
    desc.Text = "El script intentó descargar código no autorizado.\n\nMotivo: " .. motivo
    desc.TextColor3 = Color3.fromRGB(255, 255, 255)
    desc.Font = Enum.Font.GothamMedium
    desc.TextSize = 20
    desc.TextWrapped = true
    desc.Parent = frame
    task.delay(3, function() localPlayer:Kick("🚨 ANTI-CHEAT: Intento de inyección externa bloqueado.") end)
end

-- 🛑 HOOK USANDO HOOKFUNCTION (Método seguro de Delta)
local oldHttpGet
oldHttpGet = hookfunction(game.HttpGet, function(self, url, ...)
    if type(url) == "string" then
        local permitido = false
        for _, dominio in ipairs(DOMINIOS_PERMITIDOS) do
            if string.find(url, dominio) then permitido = true break end
        end
        
        if not permitido then
            banearJugador("Intento de descarga desde: " .. url)
            return "" -- Devuelve vacío para no colgar el script
        end
    end
    return oldHttpGet(self, url, ...)
end)

print("🛡️ [UZIVERT SHIELD V5] Escudo activo. (Usando hookfunction)")

-- ============================================
-- 🎃 UZIVERT HUB — LOADER OFICIAL
-- ============================================
print("🎃 Cargando Uzivert Hub...")

local BASE_URL = "https://raw.githubusercontent.com/dasilvabrayhan-blip/Uzivert-Hub-v4/main/"
local SCRIPT_URL = BASE_URL .. "Uzivert-Hub.lua"
local MANTENIMIENTO_URL = BASE_URL .. "mantenimiento.txt"
local DISCORD_URL = "https://discord.gg/vHhERWcbXe"

-- 🧟 Chequeo de mantenimiento
local mantActivo = false
pcall(function()
    local resp = game:HttpGet(MANTENIMIENTO_URL)
    if resp and resp:gsub("%s", "") == "1" then
        mantActivo = true
    end
end)

if mantActivo then
    print("🧟 UZIVERT HUB EN MANTENIMIENTO")

    -- ========================================================================
    -- UI DE MANTENIMIENTO (todo dibujado con Frames, sin emojis)
    -- ========================================================================
    local TweenService = game:GetService("TweenService")
    local RunService = game:GetService("RunService")
    local Debris = game:GetService("Debris")
    local UserInputService = game:GetService("UserInputService")

    local function mk(class, props, parent)
        local o = Instance.new(class)
        for k, v in pairs(props) do
            o[k] = v
        end
        o.Parent = parent
        return o
    end
    local function tw(obj, info, goal)
        local t = TweenService:Create(obj, info, goal)
        t:Play()
        return t
    end
    local function ti(t, style, dir)
        return TweenInfo.new(t, style or Enum.EasingStyle.Quint, dir or Enum.EasingDirection.Out)
    end
    local function loop(t, style)
        return TweenInfo.new(t, style or Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
    end
    local function corner(p, r)
        return mk("UICorner", { CornerRadius = UDim.new(0, r) }, p)
    end
    local function setLine(f, x1, y1, x2, y2, th)
        local dx, dy = x2 - x1, y2 - y1
        f.Size = UDim2.fromOffset(math.sqrt(dx * dx + dy * dy), th)
        f.Position = UDim2.fromOffset((x1 + x2) / 2, (y1 + y2) / 2)
        f.Rotation = math.deg(math.atan2(dy, dx))
    end
    local function line(parent, color, z)
        return mk("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = color, BorderSizePixel = 0, ZIndex = z or 1,
        }, parent)
    end
    local function dot(parent, size, color, z)
        local f = mk("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(size, size),
            BackgroundColor3 = color, BorderSizePixel = 0, ZIndex = z or 1,
        }, parent)
        corner(f, 999)
        return f
    end

    local ORANGE = Color3.fromRGB(255, 140, 0)
    local AMBER = Color3.fromRGB(255, 205, 90)
    local PURPLE = Color3.fromRGB(150, 70, 220)
    local LILAC = Color3.fromRGB(215, 190, 235)
    local BLURPLE = Color3.fromRGB(88, 101, 242)
    local BONE = Color3.fromRGB(235, 228, 205)
    local INK = Color3.fromRGB(60, 45, 30)
    local WEB = Color3.fromRGB(210, 200, 225)

    local W, H = 440, 270
    local ups = {} -- animaciones por frame

    -- ========== Ventana ==========
    local ScreenGui = mk("ScreenGui", {
        Name = "UzivertMantenimiento",
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        DisplayOrder = 9999,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    }, game:GetService("CoreGui"))

    local Panel = mk("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(W, H),
        BackgroundTransparency = 1,
    }, ScreenGui)

    local cam = workspace.CurrentCamera
    local vp = cam and cam.ViewportSize or Vector2.new(1280, 720)
    local base = math.clamp(math.min(vp.X / (W + 30), vp.Y / (H + 30)), 0.55, 1.3)
    local popScale = mk("UIScale", { Scale = 0 }, Panel)
    tw(popScale, TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Scale = base })

    -- resplandor pulsante alrededor
    local glowA = mk("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, 56, 1, 56),
        BackgroundColor3 = Color3.fromRGB(150, 60, 230), BackgroundTransparency = 0.86, BorderSizePixel = 0, ZIndex = 1,
    }, Panel)
    corner(glowA, 40)
    local glowB = mk("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, 22, 1, 22),
        BackgroundColor3 = ORANGE, BackgroundTransparency = 0.8, BorderSizePixel = 0, ZIndex = 2,
    }, Panel)
    corner(glowB, 24)

    local Surface = mk("CanvasGroup", {
        Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.fromRGB(10, 5, 15), BorderSizePixel = 0,
        ZIndex = 5, GroupTransparency = 1,
    }, Panel)
    corner(Surface, 16)
    tw(Surface, ti(0.5), { GroupTransparency = 0 })

    -- borde con degradado que gira
    local border = mk("Frame", { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ZIndex = 50 }, Panel)
    corner(border, 16)
    local bStroke = mk("UIStroke", {
        Thickness = 2, Color = Color3.new(1, 1, 1), ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    }, border)
    local bGrad = mk("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, ORANGE), ColorSequenceKeypoint.new(0.33, PURPLE),
            ColorSequenceKeypoint.new(0.66, ORANGE), ColorSequenceKeypoint.new(1, PURPLE),
        }),
    }, bStroke)

    -- ========== Fondo animado ==========
    local bg = mk("Frame", {
        Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1),
        BackgroundTransparency = 0.55, BorderSizePixel = 0, ZIndex = 1,
    }, Surface)
    local gradient = mk("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(18, 6, 32)),
            ColorSequenceKeypoint.new(0.6, Color3.fromRGB(70, 22, 90)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 60, 10)),
        }),
    }, bg)

    -- estrellas parpadeando
    local stars = {}
    for i = 1, 22 do
        local s = mk("Frame", {
            Position = UDim2.fromScale(math.random(), math.random() * 0.55),
            Size = UDim2.fromOffset(math.random(1, 2), math.random(1, 2)),
            BackgroundColor3 = Color3.fromRGB(255, 240, 200), BorderSizePixel = 0, ZIndex = 2,
        }, Surface)
        stars[i] = { s, math.random() * 6, 0.6 + math.random() * 1.6 }
    end

    -- luna con crateres, halo y nube que pasa
    local moonG = mk("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(112, 56), Size = UDim2.fromOffset(40, 40),
        BackgroundTransparency = 1, ZIndex = 3,
    }, Surface)
    local halo1 = dot(moonG, 96, Color3.fromRGB(255, 220, 150), 1)
    halo1.Position = UDim2.fromScale(0.5, 0.5)
    local halo2 = dot(moonG, 64, Color3.fromRGB(255, 230, 170), 2)
    halo2.Position = UDim2.fromScale(0.5, 0.5)
    local disc = mk("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(38, 38),
        BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0, ZIndex = 3,
    }, moonG)
    corner(disc, 19)
    mk("UIGradient", {
        Rotation = 45, Color = ColorSequence.new(Color3.fromRGB(255, 247, 210), Color3.fromRGB(240, 215, 150)),
    }, disc)
    for _, c in ipairs({ { 0.2, 0.22, 0.22 }, { 0.58, 0.12, 0.14 }, { 0.48, 0.54, 0.28 }, { 0.14, 0.62, 0.12 } }) do
        local cr = mk("Frame", {
            Position = UDim2.fromScale(c[1], c[2]), Size = UDim2.fromScale(c[3], c[3]),
            BackgroundColor3 = Color3.fromRGB(222, 200, 138), BackgroundTransparency = 0.35, BorderSizePixel = 0,
        }, disc)
        corner(cr, 20)
    end
    local cloudA = mk("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(72, 12), BackgroundColor3 = Color3.fromRGB(28, 14, 44),
        BackgroundTransparency = 0.1, BorderSizePixel = 0, ZIndex = 5,
    }, moonG)
    corner(cloudA, 6)
    local cloudB = mk("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(40, 10), BackgroundColor3 = Color3.fromRGB(28, 14, 44),
        BackgroundTransparency = 0.1, BorderSizePixel = 0, ZIndex = 5,
    }, moonG)
    corner(cloudB, 5)

    -- telaranas dibujadas en las esquinas (se mecen)
    local function createWeb(esq, size)
        local sx = (esq == "TL" or esq == "BL") and 1 or -1
        local sy = (esq == "TL" or esq == "TR") and 1 or -1
        local holder = mk("Frame", {
            AnchorPoint = Vector2.new(sx == 1 and 0 or 1, sy == 1 and 0 or 1),
            Position = UDim2.fromScale(sx == 1 and 0 or 1, sy == 1 and 0 or 1),
            Size = UDim2.fromOffset(size, size), BackgroundTransparency = 1, ClipsDescendants = true, ZIndex = 3,
        }, Surface)
        local ox = sx == 1 and 0 or size
        local oy = sy == 1 and 0 or size
        local function pt(a, r) return ox + sx * r * math.cos(a), oy + sy * r * math.sin(a) end
        local NS, RINGS = 5, 5
        local strands, segs = {}, {}
        for i = 0, NS - 1 do
            local a = (math.pi / 2) * i / (NS - 1)
            local l = line(holder, WEB, 2)
            local x2, y2 = pt(a, size * 1.5)
            setLine(l, ox, oy, x2, y2, 1)
            strands[#strands + 1] = l
        end
        for r = 1, RINGS do
            for i = 0, NS - 2 do
                segs[#segs + 1] = {
                    r = r, i = i, R = size * 1.1 * (r / RINGS),
                    a1 = (math.pi / 2) * i / (NS - 1), a2 = (math.pi / 2) * (i + 1) / (NS - 1),
                    am = (math.pi / 2) * (i + 0.5) / (NS - 1),
                    l1 = line(holder, WEB, 1), l2 = line(holder, WEB, 1),
                }
            end
        end
        local n = 0
        local function render(t)
            for _, s in ipairs(segs) do
                local sag = 0.84 + 0.035 * math.sin(t * 1.3 + s.r * 0.8 + s.i * 0.5)
                local x1, y1 = pt(s.a1, s.R)
                local x2, y2 = pt(s.a2, s.R)
                local xm, ym = pt(s.am, s.R * sag)
                setLine(s.l1, x1, y1, xm, ym, 1)
                setLine(s.l2, xm, ym, x2, y2, 1)
                local tr = 0.72 + 0.08 * math.sin(t * 1.8 - s.r * 0.9)
                s.l1.BackgroundTransparency = tr
                s.l2.BackgroundTransparency = tr
            end
            for i, l in ipairs(strands) do
                l.BackgroundTransparency = 0.6 + 0.08 * math.sin(t * 1.1 + i)
            end
        end
        render(0)
        ups[#ups + 1] = function(t)
            n += 1
            if n % 3 == 0 then render(t) end
        end
    end
    createWeb("TL", 78)
    createWeb("TR", 60)
    createWeb("BL", 54)
    createWeb("BR", 74)

    -- lapidas del cementerio + niebla del suelo
    local tombColor = Color3.fromRGB(44, 30, 56)
    for _, d in ipairs({
        { 12, 14, 18 }, { 36, 3, 22, true }, { 150, 16, 20 }, { 172, 3, 18, true }, { 404, 14, 16 }, { 426, 3, 20, true },
    }) do
        local x, w, h, cross = d[1], d[2], d[3], d[4]
        if cross then
            mk("Frame", {
                AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.fromOffset(x, 208), Size = UDim2.fromOffset(3, h),
                BackgroundColor3 = tombColor, BorderSizePixel = 0, ZIndex = 4,
            }, Surface)
            mk("Frame", {
                AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(x, 208 - h * 0.7), Size = UDim2.fromOffset(12, 3),
                BackgroundColor3 = tombColor, BorderSizePixel = 0, ZIndex = 4,
            }, Surface)
        else
            local g = mk("Frame", {
                AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.fromOffset(x, 220), Size = UDim2.fromOffset(w, h + 12),
                BackgroundColor3 = tombColor, BorderSizePixel = 0, ZIndex = 4,
            }, Surface)
            corner(g, w)
        end
    end
    local wispKeys = {
        NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.2, 0.88), NumberSequenceKeypoint.new(0.4, 1),
        NumberSequenceKeypoint.new(0.65, 0.86), NumberSequenceKeypoint.new(0.85, 1), NumberSequenceKeypoint.new(1, 1),
    }
    local function wisp(y, h, col)
        local f = mk("Frame", {
            Position = UDim2.fromOffset(0, y), Size = UDim2.new(1, 0, 0, h), BackgroundColor3 = col, BorderSizePixel = 0, ZIndex = 5,
        }, Surface)
        return mk("UIGradient", { Transparency = NumberSequence.new(wispKeys) }, f)
    end
    local wispA = wisp(178, 40, Color3.fromRGB(190, 150, 255))
    local wispB = wisp(194, 26, Color3.fromRGB(255, 170, 110))
    local pA, pB = 0, 0
    ups[#ups + 1] = function(t, dt)
        pA = (pA + dt * 0.08) % 2
        pB = (pB + dt * 0.05) % 2
        wispA.Offset = Vector2.new(pA - 1, 0)
        wispB.Offset = Vector2.new(1 - pB, 0)
    end

    -- brasas que suben (pool)
    local embers = {}
    for i = 1, 16 do
        local s = math.random(2, 4)
        local f = mk("Frame", {
            Size = UDim2.fromOffset(s, s), BorderSizePixel = 0, ZIndex = 4,
            BackgroundColor3 = (i % 3 == 0) and PURPLE or ((i % 2 == 0) and ORANGE or AMBER),
        }, Surface)
        corner(f, 4)
        embers[i] = {
            f = f, x = math.random() * W, y = math.random() * H, speed = 8 + math.random() * 18,
            amp = 6 + math.random() * 10, ph = math.random() * 6.28, fr = 0.6 + math.random() * 0.8,
        }
    end
    ups[#ups + 1] = function(t, dt)
        for _, e in ipairs(embers) do
            e.y -= e.speed * dt
            if e.y < -6 then e.y = H + 6; e.x = math.random() * W end
            e.f.Position = UDim2.fromOffset(e.x + math.sin(t * e.fr + e.ph) * e.amp, e.y)
            e.f.BackgroundTransparency = 1 - 0.8 * math.sin(math.pi * math.clamp(e.y / H, 0, 1))
        end
    end

    -- murcielagos dibujados con lineas
    local batColor = Color3.fromRGB(125, 85, 175)
    local bats = {}
    for i = 1, 3 do
        local b = { active = false, timer = 1 + i * 2.5, x = 0, baseY = 0, dir = 1, flap = 0, seed = i * 2.1, s = (i == 1) and 1.1 or ((i == 2) and 0.85 or 0.7), lines = {} }
        b.root = mk("Frame", { Size = UDim2.fromOffset(0, 0), BackgroundTransparency = 1, Visible = false, ZIndex = 3 }, Surface)
        for k = 1, 10 do
            b.lines[k] = line(b.root, batColor, 1)
            b.lines[k].BackgroundTransparency = 0.2
        end
        dot(b.root, 5 * b.s, batColor, 2)
        bats[i] = b
    end
    ups[#ups + 1] = function(t, dt)
        for _, b in ipairs(bats) do
            if not b.active then
                b.timer -= dt
                if b.timer <= 0 then
                    b.active = true
                    b.dir = (math.random() > 0.5) and 1 or -1
                    b.x = (b.dir == 1) and -24 or (W + 24)
                    b.baseY = math.random(14, 120)
                    b.root.Visible = true
                end
            else
                b.x += b.dir * (52 + b.s * 12) * dt
                b.flap += dt * 13
                b.root.Position = UDim2.fromOffset(b.x, b.baseY + math.sin(t * 1.8 + b.seed) * 16)
                local f, s, li = math.sin(b.flap), b.s, 1
                for side = -1, 1, 2 do
                    local tx, ty = side * 14 * s, -f * 9 * s - 2 * s
                    local p1x, p1y = side * 9 * s, 5 * s - f * 3 * s
                    local p2x, p2y = side * 4 * s, 4 * s
                    setLine(b.lines[li], 0, -1 * s, tx, ty, 1.5)
                    setLine(b.lines[li + 1], tx, ty, p1x, p1y, 1.5)
                    setLine(b.lines[li + 2], p1x, p1y, p2x, p2y, 1.5)
                    setLine(b.lines[li + 3], p2x, p2y, 0, 2 * s, 1.5)
                    li += 4
                end
                if b.x < -30 or b.x > W + 30 then
                    b.active = false
                    b.root.Visible = false
                    b.timer = 3 + math.random() * 5
                end
            end
        end
    end

    -- fantasma dibujado que flota de lado a lado
    local ghost = mk("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(34, 42), Position = UDim2.fromOffset(-40, 70),
        BackgroundTransparency = 1, ZIndex = 3,
    }, Surface)
    local ghostCol = Color3.fromRGB(225, 220, 255)
    local gBody = mk("Frame", {
        Position = UDim2.fromOffset(3, 0), Size = UDim2.fromOffset(28, 32), BackgroundColor3 = ghostCol,
        BackgroundTransparency = 0.78, BorderSizePixel = 0,
    }, ghost)
    corner(gBody, 14)
    for i = 0, 2 do
        local sc = dot(ghost, 10, ghostCol, 1)
        sc.Position = UDim2.fromOffset(8 + i * 9, 30 + ((i % 2 == 0) and 4 or 0))
        sc.BackgroundTransparency = 0.78
    end
    for i = 0, 1 do
        local e = dot(ghost, 5, Color3.fromRGB(30, 20, 50), 2)
        e.Position = UDim2.fromOffset(11 + i * 12, 13)
        e.BackgroundTransparency = 0.35
    end
    local gMouth = dot(ghost, 7, Color3.fromRGB(30, 20, 50), 2)
    gMouth.Position = UDim2.fromOffset(17, 23)
    gMouth.BackgroundTransparency = 0.45
    ups[#ups + 1] = function(t)
        local x = ((t * 16) % (W + 100)) - 50
        ghost.Position = UDim2.fromOffset(x, 74 + math.sin(t * 1.4) * 14)
        ghost.Rotation = math.sin(t * 1.4) * 6
        gMouth.Size = UDim2.fromOffset(6 + math.sin(t * 3) * 2, 7 + math.sin(t * 3) * 3)
    end

    -- relampago ocasional
    local flashF = mk("Frame", {
        Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.fromRGB(235, 225, 255), BackgroundTransparency = 1,
        BorderSizePixel = 0, ZIndex = 40,
    }, Surface)
    task.spawn(function()
        task.wait(4 + math.random() * 4)
        while Panel.Parent do
            tw(flashF, ti(0.05), { BackgroundTransparency = 0.8 })
            task.wait(0.07)
            tw(flashF, ti(0.1), { BackgroundTransparency = 1 })
            task.wait(0.12)
            tw(flashF, ti(0.05), { BackgroundTransparency = 0.88 })
            task.wait(0.06)
            tw(flashF, ti(0.35), { BackgroundTransparency = 1 })
            task.wait(7 + math.random() * 7)
        end
    end)

    -- ========== ESCENA: esqueleto jugando con la mariposa ==========
    local Scene = mk("Frame", {
        Position = UDim2.fromOffset(0, 45),
        Size = UDim2.fromOffset(170, 170),
        BackgroundTransparency = 1,
        ZIndex = 6,
    }, Surface)

    -- aura calida detras del esqueleto
    local aura = dot(Scene, 130, ORANGE, 1)
    aura.Position = UDim2.fromOffset(55, 80)
    aura.BackgroundTransparency = 0.9
    ups[#ups + 1] = function(t)
        aura.BackgroundTransparency = 0.9 + 0.04 * math.sin(t * 3.1)
        local sz = 130 + 6 * math.sin(t * 2.2)
        aura.Size = UDim2.fromOffset(sz, sz)
    end

    local function bone(props, parent)
        props.BackgroundColor3 = props.BackgroundColor3 or BONE
        props.BorderSizePixel = 0
        props.ZIndex = props.ZIndex or 6
        local f = mk("Frame", props, parent)
        mk("UIStroke", { Thickness = 1, Color = INK }, f)
        return f
    end

    local skel = mk("Frame", {
        AnchorPoint = Vector2.new(0.5, 1),
        Position = UDim2.fromOffset(55, 142),
        Size = UDim2.fromOffset(90, 150),
        BackgroundTransparency = 1,
        ZIndex = 6,
    }, Scene)
    -- baile suave
    tw(skel, loop(0.45), { Position = UDim2.fromOffset(55, 138) })
    tw(skel, loop(0.9), { Rotation = 3 })

    -- columna y costillas
    bone({ AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromOffset(45, 36), Size = UDim2.fromOffset(6, 78) }, skel)
    bone({ AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromOffset(45, 43), Size = UDim2.fromOffset(42, 5) }, skel)
    for i = 1, 4 do
        local r = bone({
            AnchorPoint = Vector2.new(0.5, 0),
            Position = UDim2.fromOffset(45, 52 + (i - 1) * 10),
            Size = UDim2.fromOffset(38 - i * 3, 5),
        }, skel)
        corner(r, 99)
    end
    -- pelvis y piernas
    local pelvis = bone({ AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromOffset(45, 112), Size = UDim2.fromOffset(32, 10) }, skel)
    corner(pelvis, 5)
    for _, x in ipairs({ 35, 55 }) do
        bone({ AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromOffset(x, 120), Size = UDim2.fromOffset(7, 24) }, skel)
        local foot = bone({ AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromOffset(x + 2, 144), Size = UDim2.fromOffset(13, 5) }, skel)
        corner(foot, 99)
    end

    -- brazos (el pivote es el centro del contenedor = hombro)
    local function makeArm(x, y, rot)
        local pivot = mk("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromOffset(x, y),
            Size = UDim2.fromOffset(8, 92),
            BackgroundTransparency = 1,
            Rotation = rot,
            ZIndex = 6,
        }, skel)
        local b = bone({ AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.fromOffset(6, 44) }, pivot)
        corner(b, 99)
        local hand = bone({ AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 47), Size = UDim2.fromOffset(10, 10) }, pivot)
        corner(hand, 99)
        return pivot
    end
    local lArm = makeArm(27, 47, 12)
    local rArm = makeArm(63, 47, -30)
    tw(lArm, loop(0.7), { Rotation = 22 })

    -- cabeza
    local head = bone({
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.fromOffset(45, 2),
        Size = UDim2.fromOffset(42, 36),
        ZIndex = 7,
    }, skel)
    corner(head, 18)
    for i = 1, 2 do
        local eye = mk("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(i == 1 and 0.3 or 0.7, 0.42),
            Size = UDim2.fromOffset(10, 12),
            BackgroundColor3 = Color3.fromRGB(8, 4, 8),
            Rotation = i == 1 and 10 or -10,
            ZIndex = 9,
        }, head)
        corner(eye, 6)
        local pupil = dot(eye, 4, ORANGE, 10)
        pupil.Position = UDim2.fromScale(0.5, 0.5)
        tw(pupil, loop(0.5), { BackgroundColor3 = Color3.fromRGB(255, 50, 30), Size = UDim2.fromOffset(6, 6) })
    end
    -- nariz dibujada (rombo)
    mk("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.66), Size = UDim2.fromOffset(5, 5),
        BackgroundColor3 = Color3.fromRGB(10, 5, 10), BorderSizePixel = 0, Rotation = 45, ZIndex = 9,
    }, head)
    -- boca y mandibula
    mk("Frame", {
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.fromScale(0.5, 0.78),
        Size = UDim2.fromOffset(24, 9),
        BackgroundColor3 = Color3.fromRGB(10, 5, 10),
        BorderSizePixel = 0,
        ZIndex = 8,
    }, head)
    local JAW_CLOSED = UDim2.new(0.5, 0, 0.82, 0)
    local JAW_OPEN = UDim2.new(0.5, 0, 0.82, 8)
    local jaw = bone({
        AnchorPoint = Vector2.new(0.5, 0),
        Position = JAW_CLOSED,
        Size = UDim2.fromOffset(26, 11),
        ZIndex = 11,
    }, head)
    corner(jaw, 5)
    for i = 1, 3 do
        mk("Frame", {
            Position = UDim2.new(i / 4, 0, 0, 0),
            Size = UDim2.fromOffset(1, 6),
            BackgroundColor3 = INK,
            BorderSizePixel = 0,
            ZIndex = 12,
        }, jaw)
    end

    -- risa "JA JA JA" con ondas
    local laughLabel = mk("TextLabel", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromOffset(55, -6),
        Size = UDim2.fromOffset(110, 18),
        BackgroundTransparency = 1,
        Text = "JA JA JA!",
        Font = Enum.Font.Creepster,
        TextScaled = true,
        TextColor3 = Color3.fromRGB(255, 200, 60),
        TextTransparency = 1,
        ZIndex = 15,
    }, Scene)
    local laughStroke = mk("UIStroke", { Thickness = 1.5, Color = Color3.fromRGB(80, 0, 0), Transparency = 1 }, laughLabel)

    local function ondaRisa()
        local ring = mk("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(55, 38), Size = UDim2.fromOffset(30, 30),
            BackgroundTransparency = 1, ZIndex = 5,
        }, Scene)
        corner(ring, 99)
        local rs = mk("UIStroke", { Thickness = 2, Color = AMBER }, ring)
        tw(ring, ti(0.7, Enum.EasingStyle.Quad), { Size = UDim2.fromOffset(150, 150) })
        tw(rs, ti(0.7), { Transparency = 1 })
        Debris:AddItem(ring, 0.8)
    end

    task.spawn(function()
        task.wait(1)
        while Panel.Parent do
            laughLabel.Position = UDim2.fromOffset(55, 4)
            laughLabel.Rotation = -6
            tw(laughLabel, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                TextTransparency = 0,
                Position = UDim2.fromOffset(55, -6),
                Rotation = 6,
            })
            tw(laughStroke, ti(0.25), { Transparency = 0 })
            for i = 1, 6 do
                if i % 3 == 1 then ondaRisa() end
                tw(jaw, TweenInfo.new(0.1, Enum.EasingStyle.Quad), { Position = JAW_OPEN })
                task.wait(0.11)
                tw(jaw, TweenInfo.new(0.09, Enum.EasingStyle.Quad), { Position = JAW_CLOSED })
                task.wait(0.09)
            end
            tw(laughLabel, ti(0.4), { TextTransparency = 1 })
            tw(laughStroke, ti(0.4), { Transparency = 1 })
            task.wait(1.2 + math.random() * 1.5)
        end
    end)

    -- mariposa dibujada (alas que aletean, estela de chispas)
    local butterfly = mk("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromOffset(110, 60),
        Size = UDim2.fromOffset(26, 26),
        BackgroundTransparency = 1,
        ZIndex = 14,
    }, Scene)
    local bfGlow = dot(butterfly, 30, AMBER, 12)
    bfGlow.Position = UDim2.fromScale(0.5, 0.5)
    bfGlow.BackgroundTransparency = 0.85
    local wings = {}
    local function wing(side, y, w, h, color)
        local f = mk("Frame", {
            AnchorPoint = Vector2.new(side == -1 and 1 or 0, 0.5), Position = UDim2.new(0.5, 0, 0.5, y),
            Size = UDim2.fromOffset(w, h), BackgroundColor3 = color, BorderSizePixel = 0, ZIndex = 14,
        }, butterfly)
        corner(f, h / 2)
        mk("UIStroke", { Thickness = 1, Color = Color3.fromRGB(40, 10, 50) }, f)
        wings[#wings + 1] = { f = f, w = w, h = h }
    end
    wing(-1, -4, 11, 12, ORANGE)
    wing(1, -4, 11, 12, ORANGE)
    wing(-1, 5, 8, 9, PURPLE)
    wing(1, 5, 8, 9, PURPLE)
    local bfBody = mk("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(3, 14),
        BackgroundColor3 = Color3.fromRGB(35, 15, 45), BorderSizePixel = 0, ZIndex = 15,
    }, butterfly)
    corner(bfBody, 2)
    setLine(line(butterfly, Color3.fromRGB(35, 15, 45), 15), 13, 6, 9, 0, 1)
    setLine(line(butterfly, Color3.fromRGB(35, 15, 45), 15), 13, 6, 17, 0, 1)

    task.spawn(function()
        while Panel.Parent do
            local pos
            if math.random() < 0.3 then
                pos = UDim2.fromOffset(math.random(88, 100), math.random(60, 85)) -- se acerca a la mano
            else
                pos = UDim2.fromOffset(math.random(88, 150), math.random(12, 115))
            end
            local t = 0.9 + math.random() * 0.8
            local info = TweenInfo.new(t, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            tw(butterfly, info, { Position = pos, Rotation = math.random(-25, 25) })
            task.wait(t)
        end
    end)

    local trailT = 0
    ups[#ups + 1] = function(t, dt)
        local k = 0.2 + 0.8 * math.abs(math.sin(t * 16))
        for _, w in ipairs(wings) do
            w.f.Size = UDim2.fromOffset(w.w * k, w.h)
        end
        bfGlow.BackgroundTransparency = 0.82 + 0.06 * math.sin(t * 5)
        trailT += dt
        if trailT > 0.07 then
            trailT = 0
            local sp = dot(Scene, math.random(2, 3), (math.random() > 0.5) and AMBER or PURPLE, 12)
            sp.Position = butterfly.Position
            tw(sp, ti(0.7, Enum.EasingStyle.Quad), {
                Position = UDim2.fromOffset(butterfly.Position.X.Offset + math.random(-6, 6), butterfly.Position.Y.Offset + math.random(6, 16)),
                BackgroundTransparency = 1,
            })
            Debris:AddItem(sp, 0.8)
        end
    end

    -- el brazo sigue a la mariposa y la cabeza la mira
    local armAngle, headAngle = -30, 0
    ups[#ups + 1] = function(t, dt)
        local shoulder = rArm.AbsolutePosition + rArm.AbsoluteSize / 2
        local bf = butterfly.AbsolutePosition + butterfly.AbsoluteSize / 2
        local d = bf - shoulder
        local target = math.deg(math.atan2(-d.X, d.Y))
        local diff = (target - armAngle + 180) % 360 - 180
        armAngle = armAngle + diff * math.min(1, dt * 8)
        rArm.Rotation = armAngle

        local headC = head.AbsolutePosition + head.AbsoluteSize / 2
        local goal = math.clamp((bf.X - headC.X) * 0.2, -18, 18)
        headAngle = headAngle + (goal - headAngle) * math.min(1, dt * 6)
        head.Rotation = headAngle
    end

    -- ========== Textos ==========
    local TX, TW_ = 182, W - 198

    -- sombra morada + titulo con brillo
    local TituloSombra = mk("TextLabel", {
        Size = UDim2.new(0, TW_, 0, 44), Position = UDim2.fromOffset(TX + 2, 18),
        BackgroundTransparency = 1, Text = "UZIVERT HUB", Font = Enum.Font.Creepster, TextSize = 38,
        TextColor3 = PURPLE, TextTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 9,
    }, Surface)
    local Titulo = mk("TextLabel", {
        Size = UDim2.new(0, TW_, 0, 44), Position = UDim2.fromOffset(TX, 28),
        BackgroundTransparency = 1, Text = "UZIVERT HUB", Font = Enum.Font.Creepster, TextSize = 38,
        TextColor3 = Color3.new(1, 1, 1), TextTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 10,
    }, Surface)
    local titleGrad = mk("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 120, 0)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 225, 110)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 120, 0)),
        }),
        Offset = Vector2.new(-1, 0),
    }, Titulo)
    tw(titleGrad, TweenInfo.new(2.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1), { Offset = Vector2.new(1, 0) })

    -- etiqueta "EN MANTENIMIENTO" con engranaje giratorio
    local pill = mk("Frame", {
        Position = UDim2.fromOffset(TX, 76), Size = UDim2.fromOffset(176, 22), BackgroundColor3 = Color3.fromRGB(40, 18, 8),
        BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 10,
    }, Surface)
    corner(pill, 11)
    local pillStroke = mk("UIStroke", { Color = ORANGE, Thickness = 1.2, Transparency = 1 }, pill)
    local gear = mk("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(15, 11), Size = UDim2.fromOffset(14, 14),
        BackgroundTransparency = 1, ZIndex = 11,
    }, pill)
    local gearRing = mk("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(8, 8),
        BackgroundTransparency = 1, ZIndex = 11,
    }, gear)
    corner(gearRing, 4)
    mk("UIStroke", { Thickness = 1.8, Color = ORANGE }, gearRing)
    for i = 0, 3 do
        local tooth = mk("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(2.4, 14),
            BackgroundColor3 = ORANGE, BorderSizePixel = 0, Rotation = i * 45, ZIndex = 11,
        }, gear)
        corner(tooth, 1)
    end
    local pillLbl = mk("TextLabel", {
        Position = UDim2.fromOffset(30, 0), Size = UDim2.new(1, -38, 1, 0), BackgroundTransparency = 1,
        Text = "EN MANTENIMIENTO", Font = Enum.Font.GothamBold, TextSize = 10, TextColor3 = AMBER,
        TextTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 11,
    }, pill)

    local Mensaje = mk("TextLabel", {
        Size = UDim2.new(0, TW_, 0, 56),
        Position = UDim2.fromOffset(TX, 106),
        BackgroundTransparency = 1,
        Text = "Estamos reparando bugs y puliendo cada detalle del hub.\nVolvé en unos minutos, la noche recién empieza.",
        TextColor3 = LILAC,
        Font = Enum.Font.GothamMedium,
        TextSize = 12,
        TextWrapped = true,
        TextTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        ZIndex = 10,
    }, Surface)

    -- linea de estado con efecto maquina de escribir
    local statusLbl = mk("TextLabel", {
        Size = UDim2.new(0, TW_, 0, 16), Position = UDim2.fromOffset(TX, 160), BackgroundTransparency = 1, Text = "",
        Font = Enum.Font.GothamMedium, TextSize = 11, TextColor3 = AMBER, TextXAlignment = Enum.TextXAlignment.Left,
        TextTransparency = 1, ZIndex = 10,
    }, Surface)
    task.spawn(function()
        task.wait(1.4)
        local msgs = {
            "Afilando los cuchillos...", "Encendiendo las velas...", "Limpiando las telarañas...",
            "Despertando a los fantasmas...", "Preparando el truco o trato...",
        }
        local i = 1
        tw(statusLbl, ti(0.3), { TextTransparency = 0 })
        while Panel.Parent do
            statusLbl.Text = msgs[i]
            local n = utf8.len(msgs[i]) or #msgs[i]
            for g = 0, n do
                statusLbl.MaxVisibleGraphemes = g
                task.wait(0.04)
            end
            task.wait(1.6)
            for g = n, 0, -1 do
                statusLbl.MaxVisibleGraphemes = g
                task.wait(0.02)
            end
            i = i % #msgs + 1
        end
    end)

    -- barra de "reparando" con brillo
    local barBack = mk("Frame", {
        Position = UDim2.fromOffset(TX, 184),
        Size = UDim2.new(0, TW_, 0, 6),
        BackgroundColor3 = Color3.fromRGB(45, 25, 55),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        ZIndex = 10,
    }, Surface)
    corner(barBack, 3)
    local barFill = mk("Frame", {
        Position = UDim2.fromScale(-0.4, 0),
        Size = UDim2.fromScale(0.4, 1),
        BackgroundColor3 = Color3.new(1, 1, 1),
        BorderSizePixel = 0,
        ZIndex = 11,
    }, barBack)
    corner(barFill, 3)
    mk("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, PURPLE), ColorSequenceKeypoint.new(0.5, ORANGE), ColorSequenceKeypoint.new(1, AMBER),
        }),
    }, barFill)
    tw(barFill, TweenInfo.new(1.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1), {
        Position = UDim2.fromScale(1, 0),
    })

    -- ========== Boton Discord (con su logo dibujado) ==========
    local DiscordBtn = mk("TextButton", {
        Size = UDim2.new(1, -32, 0, 42),
        Position = UDim2.new(0, 16, 1, -12),
        AnchorPoint = Vector2.new(0, 1),
        BackgroundColor3 = Color3.new(1, 1, 1),
        BackgroundTransparency = 1,
        Text = "",
        BorderSizePixel = 0,
        AutoButtonColor = false,
        ClipsDescendants = true,
        ZIndex = 20,
    }, Surface)
    corner(DiscordBtn, 10)
    mk("UIGradient", {
        Rotation = 0, Color = ColorSequence.new(Color3.fromRGB(104, 116, 255), Color3.fromRGB(72, 84, 222)),
    }, DiscordBtn)
    local btnStroke = mk("UIStroke", { Thickness = 1.5, Color = Color3.fromRGB(170, 178, 255), Transparency = 0.5 }, DiscordBtn)
    local btnScale = mk("UIScale", { Scale = 1 }, DiscordBtn)

    local eyeCol = Color3.fromRGB(84, 96, 232)
    local logo = mk("Frame", {
        AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 16, 0.5, 0), Size = UDim2.fromOffset(28, 28),
        BackgroundTransparency = 1, ZIndex = 22,
    }, DiscordBtn)
    local function white(x, y, w, h, r, rot)
        local f = mk("Frame", {
            Position = UDim2.fromOffset(x, y), Size = UDim2.fromOffset(w, h), BackgroundColor3 = Color3.new(1, 1, 1),
            BorderSizePixel = 0, Rotation = rot or 0, ZIndex = 22,
        }, logo)
        corner(f, r)
        return f
    end
    local function cut(x, y, w, h, r)
        local f = mk("Frame", {
            Position = UDim2.fromOffset(x, y), Size = UDim2.fromOffset(w, h), BackgroundColor3 = eyeCol,
            BorderSizePixel = 0, ZIndex = 23,
        }, logo)
        corner(f, r)
        return f
    end
    white(2, 6, 24, 17, 8)          -- cuerpo
    white(3, 3, 9, 8, 3, -18)       -- oreja izquierda
    white(16, 3, 9, 8, 3, 18)       -- oreja derecha
    white(5, 19, 6, 7, 3, 22)       -- pata izquierda
    white(17, 19, 6, 7, 3, -22)     -- pata derecha
    local eyeL, eyeR = cut(7, 11, 5, 7, 3), cut(16, 11, 5, 7, 3)
    cut(9, 20, 10, 2, 1)            -- boca

    -- icono de "copiado" (check dibujado)
    local check = mk("Frame", {
        AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 16, 0.5, 0), Size = UDim2.fromOffset(28, 28),
        BackgroundTransparency = 1, Visible = false, ZIndex = 22,
    }, DiscordBtn)
    setLine(line(check, Color3.new(1, 1, 1), 22), 6, 15, 12, 21, 3)
    setLine(line(check, Color3.new(1, 1, 1), 22), 12, 21, 23, 8, 3)

    local btnLabel = mk("TextLabel", {
        Position = UDim2.fromOffset(54, 0), Size = UDim2.new(1, -100, 1, 0), BackgroundTransparency = 1,
        Text = "Unirse al Discord", TextColor3 = Color3.new(1, 1, 1), Font = Enum.Font.GothamBold, TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 22,
    }, DiscordBtn)

    -- flecha dibujada a la derecha
    local arrow = mk("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(1, -24, 0.5, 0), Size = UDim2.fromOffset(12, 12),
        BackgroundTransparency = 1, ZIndex = 22,
    }, DiscordBtn)
    setLine(line(arrow, Color3.new(1, 1, 1), 22), 3, 1, 9, 6, 2)
    setLine(line(arrow, Color3.new(1, 1, 1), 22), 9, 6, 3, 11, 2)

    local shine = mk("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0, -40, 0.5, 0), Size = UDim2.fromOffset(30, 120),
        BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.82, BorderSizePixel = 0, Rotation = 20, ZIndex = 21,
    }, DiscordBtn)
    local function pasarBrillo()
        shine.Position = UDim2.new(0, -40, 0.5, 0)
        tw(shine, TweenInfo.new(0.7, Enum.EasingStyle.Quad), { Position = UDim2.new(1, 40, 0.5, 0) })
    end
    task.spawn(function()
        task.wait(2)
        while Panel.Parent do
            pasarBrillo()
            task.wait(3.5)
        end
    end)

    -- parpadeo del logo y pulso del boton
    ups[#ups + 1] = function(t)
        local blink = (t % 3.4) < 0.12
        local h = blink and 1 or 7
        eyeL.Size = UDim2.fromOffset(5, h)
        eyeR.Size = UDim2.fromOffset(5, h)
        eyeL.Position = UDim2.fromOffset(7, blink and 14 or 11)
        eyeR.Position = UDim2.fromOffset(16, blink and 14 or 11)
        arrow.Position = UDim2.new(1, -24 + math.sin(t * 4) * 2, 0.5, 0)
    end

    DiscordBtn.MouseEnter:Connect(function()
        tw(btnStroke, ti(0.15), { Transparency = 0 })
        tw(btnScale, TweenInfo.new(0.15, Enum.EasingStyle.Back), { Scale = 1.03 })
        pasarBrillo()
    end)
    DiscordBtn.MouseLeave:Connect(function()
        tw(btnStroke, ti(0.15), { Transparency = 0.5 })
        tw(btnScale, ti(0.15), { Scale = 1 })
    end)

    DiscordBtn.MouseButton1Click:Connect(function()
        tw(btnScale, ti(0.07), { Scale = 0.96 })
        local r = dot(DiscordBtn, 10, Color3.new(1, 1, 1), 21)
        r.Position = UDim2.fromScale(0.5, 0.5)
        r.BackgroundTransparency = 0.6
        tw(r, ti(0.5), { Size = UDim2.fromOffset(420, 420), BackgroundTransparency = 1 })
        Debris:AddItem(r, 0.6)
        tw(btnScale, TweenInfo.new(0.2, Enum.EasingStyle.Back), { Scale = 1 })
        if setclipboard then
            setclipboard(DISCORD_URL)
            btnLabel.Text = "¡Link copiado!"
            logo.Visible = false
            check.Visible = true
            task.wait(2)
            check.Visible = false
            logo.Visible = true
            btnLabel.Text = "Unirse al Discord"
        else
            btnLabel.Text = DISCORD_URL
            task.wait(3)
            btnLabel.Text = "Unirse al Discord"
        end
    end)

    -- ========== Entrada escalonada de los textos ==========
    task.delay(0.35, function()
        tw(TituloSombra, ti(0.5), { TextTransparency = 0.45, Position = UDim2.fromOffset(TX + 2, 20) })
        tw(Titulo, ti(0.5), { TextTransparency = 0, Position = UDim2.fromOffset(TX, 18) })
    end)
    task.delay(0.6, function()
        tw(pill, ti(0.4), { BackgroundTransparency = 0.3 })
        tw(pillStroke, ti(0.4), { Transparency = 0.2 })
        tw(pillLbl, ti(0.4), { TextTransparency = 0 })
    end)
    task.delay(0.85, function()
        tw(Mensaje, ti(0.5), { TextTransparency = 0 })
        tw(barBack, ti(0.5), { BackgroundTransparency = 0 })
    end)

    -- ========== Animaciones por frame ==========
    local T0 = os.clock()
    local conn
    conn = RunService.Heartbeat:Connect(function(dt)
        if not Panel.Parent then
            conn:Disconnect()
            return
        end
        local t = os.clock() - T0
        gradient.Rotation = (t * 10) % 360
        bGrad.Rotation = (t * 50) % 360
        glowA.BackgroundTransparency = 0.86 + 0.04 * math.sin(t * 1.4)
        glowB.BackgroundTransparency = 0.8 + 0.05 * math.sin(t * 2.1 + 1)
        for _, s in ipairs(stars) do
            s[1].BackgroundTransparency = 0.15 + 0.8 * (0.5 + 0.5 * math.sin(t * s[3] + s[2]))
        end
        halo1.BackgroundTransparency = 0.93 + 0.02 * math.sin(t * 1.2)
        halo2.BackgroundTransparency = 0.88 + 0.03 * math.sin(t * 1.7)
        local cx = ((t * 10) % 170) - 85
        local fade = math.clamp((math.abs(cx) - 28) / 20, 0, 1)
        cloudA.Position = UDim2.fromOffset(20 + cx, 24)
        cloudB.Position = UDim2.fromOffset(20 + cx - 14, 14)
        cloudA.BackgroundTransparency = 0.1 + 0.9 * fade
        cloudB.BackgroundTransparency = 0.1 + 0.9 * fade
        gear.Rotation = (t * 90) % 360
        titleGrad.Offset = titleGrad.Offset -- (el desplazamiento lo mueve el tween)
        Titulo.TextTransparency = ((t % 5.5) < 0.25 and math.sin(t * 90) > 0 and Titulo.TextTransparency < 0.5 and Titulo.Position.Y.Offset <= 20) and 0.55 or Titulo.TextTransparency
        for _, fn in ipairs(ups) do pcall(fn, t, dt) end
    end)

    -- ========== Arrastrar la ventana ==========
    do
        local dragging, dragStart, startPos
        Surface.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging, dragStart, startPos = true, input.Position, Panel.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then dragging = false end
                end)
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local d = (input.Position - dragStart) / math.max(popScale.Scale, 0.1)
                Panel.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
            end
        end)
    end

    return
end

-- ============================================
-- 🎮 SELECTOR DE JUEGO (agregado)
-- Elige el hub segun el juego; al elegir se ejecuta el loadstring de esa opcion.
-- Los IDs (PlaceId / GameId) solo sirven para marcar "DETECTADO" el juego en el que estas.
-- Si el selector no puede mostrarse, el loader sigue con el comportamiento de siempre (mas abajo).
-- ============================================
local ESPECIAL_HASTA = 1794884399 -- 16/11/2026 23:59:59 (hora de Paraguay, UTC-3)

local JUEGOS = {
    {
        game = "Murder Mystery 2",
        title = "Murder Mystery 2",
        sub = "Uzivert Hub v4",
        icon = "knife",
        placeIds = { 142823291 },   -- ID del juego (PlaceId) de MM2
        universeIds = { 66654135 }, -- GameId de MM2
        url = "https://tinyurl.com/UzivertAPI",
    },
    {
        game = "Distrito de Violencia",
        title = "Distrito de Violencia",
        sub = "Violence District  ·  Uzivert Hub",
        icon = "hook",
        placeIds = { 93978595733734 },  -- ID del juego (PlaceId) de Violence District (corrígelo aqui si cambia)
        universeIds = { 6739698191 },   -- GameId de Violence District
        url = "https://tinyurl.com/Uzivertt",
    },
    {
        game = "Prison Life",
        title = "Prison Life",
        sub = "Uzivert Hub  ·  v1.0",
        icon = "cuffs",
        placeIds = { 155615604 },   -- ID del juego (PlaceId) de Prison Life
        universeIds = { 73885730 }, -- GameId de Prison Life
        url = "https://tinyurl.com/UzivertAPl",
    },
    {
        game = "Duelos Latam",
        title = "Duelos Latam",
        aviso = "En mantenimiento / Parchado",
        sub = "Murder vs Sheriff  ·  Uzivert Hub",
        icon = "knife",
        placeIds = { 129714054840627 },  -- ID del juego (PlaceId) de Duelos Latam
        universeIds = { 10769225758 },   -- GameId de Duelos Latam
        url = "https://tinyurl.com/UzivertLatam",
    },
    {
        game = "Murder Mystery 2",
        title = "MM2 Auto Farm",
        sub = "Especial Edition",
        icon = "star",
        limited = true,             -- version limitada
        hasta = ESPECIAL_HASTA,
        placeIds = { 142823291 },
        universeIds = { 66654135 },
        url = "https://tinyurl.com/EspecialEdition",
    },
}

local selectorGui
local selOk, selErr = pcall(function()
    local TweenService = game:GetService("TweenService")
    local RunService = game:GetService("RunService")
    local Debris = game:GetService("Debris")
    local Workspace = game:GetService("Workspace")

    -- ========== Helpers ==========
    local function mk(class, props, parent)
        local o = Instance.new(class)
        for k, v in pairs(props) do
            o[k] = v
        end
        if parent then o.Parent = parent end
        return o
    end
    local function tw(obj, info, goal)
        local t = TweenService:Create(obj, info, goal)
        t:Play()
        return t
    end
    local function loop(t, style)
        return TweenInfo.new(t, style or Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
    end
    local function ti(t, style, dir)
        return TweenInfo.new(t, style or Enum.EasingStyle.Quint, dir or Enum.EasingDirection.Out)
    end

    local ORANGE = Color3.fromRGB(255, 140, 0)
    local PURPLE = Color3.fromRGB(150, 70, 220)
    local GOLD = Color3.fromRGB(255, 205, 90)
    local LAV = Color3.fromRGB(215, 190, 235)
    local GREEN = Color3.fromRGB(74, 222, 128)

    local function nowT()
        local ok, t = pcall(function() return Workspace:GetServerTimeNow() end)
        if ok and type(t) == "number" and t > 1000000000 then return t end
        return os.time()
    end
    local function fmtLeft(sec)
        sec = math.max(0, math.floor(sec))
        return string.format("%dd %02dh %02dm %02ds", math.floor(sec / 86400), math.floor(sec % 86400 / 3600), math.floor(sec % 3600 / 60), sec % 60)
    end
    local nameCache
    local function placeName()
        if nameCache == nil then
            nameCache = ""
            pcall(function()
                nameCache = string.lower(game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name or "")
            end)
        end
        return nameCache
    end
    local function isHere(entry)
        if entry.nameMatch then
            local n, all = placeName(), true
            for _, w in ipairs(entry.nameMatch) do
                if not string.find(n, w, 1, true) then all = false break end
            end
            if all and n ~= "" then return true end
        end
        for _, id in ipairs(entry.placeIds or {}) do
            if game.PlaceId == id then return true end
        end
        for _, id in ipairs(entry.universeIds or {}) do
            if game.GameId == id then return true end
        end
        return false
    end

    -- ========== Ventana ==========
    selectorGui = mk("ScreenGui", {
        Name = "UzivertSelector",
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        DisplayOrder = 9999,
    })
    do
        local okH, hui = pcall(function() return gethui and gethui() end)
        if not pcall(function() selectorGui.Parent = (okH and hui) or game:GetService("CoreGui") end) then
            selectorGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
        end
    end

    local Panel = mk("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(440, 262),
        BackgroundColor3 = Color3.fromRGB(10, 5, 15),
        BorderSizePixel = 0,
        Active = true,
        Draggable = true,
        ClipsDescendants = true,
    }, selectorGui)
    mk("UICorner", { CornerRadius = UDim.new(0, 6) }, Panel)
    local sPanel = mk("UIStroke", { Color = ORANGE, Thickness = 2 }, Panel)
    tw(sPanel, loop(3), { Color = PURPLE })

    -- animación de entrada (se ajusta al tamaño de la pantalla)
    local function fit()
        local cam = workspace.CurrentCamera
        local vp = cam and cam.ViewportSize or Vector2.new(1280, 720)
        return math.clamp(math.min(vp.X / 480, vp.Y / 290), 0.5, 1.15)
    end
    local popScale = mk("UIScale", { Scale = fit() * 0.92 }, Panel)
    tw(popScale, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Scale = fit() })

    -- ========== Fondo animado (mismo estilo del loader) ==========
    local gradient
    pcall(function()
        local bg = mk("Frame", {
            Size = UDim2.fromScale(1, 1),
            BackgroundColor3 = Color3.new(1, 1, 1),
            BackgroundTransparency = 0.7,
            BorderSizePixel = 0,
            ZIndex = 1,
        }, Panel)
        gradient = mk("UIGradient", {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(18, 6, 32)),
                ColorSequenceKeypoint.new(0.6, Color3.fromRGB(70, 22, 90)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 60, 10)),
            }),
        }, bg)

        -- estrellas parpadeando
        for _ = 1, 18 do
            local s = mk("Frame", {
                Position = UDim2.fromScale(math.random(), math.random() * 0.5),
                Size = UDim2.fromOffset(2, 2),
                BackgroundColor3 = Color3.fromRGB(255, 240, 200),
                BorderSizePixel = 0,
                ZIndex = 2,
            }, Panel)
            tw(s, TweenInfo.new(0.6 + math.random() * 1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
                BackgroundTransparency = 0.9,
            })
        end

        -- luna
        local moon = mk("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromOffset(398, 36),
            Size = UDim2.fromOffset(30, 30),
            BackgroundColor3 = Color3.fromRGB(255, 240, 190),
            ZIndex = 2,
        }, Panel)
        mk("UICorner", { CornerRadius = UDim.new(1, 0) }, moon)
        mk("UIStroke", { Thickness = 5, Color = Color3.fromRGB(255, 200, 100), Transparency = 0.65 }, moon)
        tw(moon, loop(4), { Size = UDim2.fromOffset(34, 34) })

        -- telarañas dibujadas en las esquinas (animadas, se mecen como en mantenimiento)
        local WEB = Color3.fromRGB(210, 200, 225)
        local function setLine(f, x1, y1, x2, y2, th)
            local dx, dy = x2 - x1, y2 - y1
            f.Size = UDim2.fromOffset(math.sqrt(dx * dx + dy * dy), th)
            f.Position = UDim2.fromOffset((x1 + x2) / 2, (y1 + y2) / 2)
            f.Rotation = math.deg(math.atan2(dy, dx))
        end
        local function wline(parent, color, z)
            return mk("Frame", {
                AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = color, BorderSizePixel = 0, ZIndex = z or 1,
            }, parent)
        end
        local webUps = {}
        local function createWeb(esq, size)
            local sx = (esq == "TL" or esq == "BL") and 1 or -1
            local sy = (esq == "TL" or esq == "TR") and 1 or -1
            local holder = mk("Frame", {
                AnchorPoint = Vector2.new(sx == 1 and 0 or 1, sy == 1 and 0 or 1),
                Position = UDim2.fromScale(sx == 1 and 0 or 1, sy == 1 and 0 or 1),
                Size = UDim2.fromOffset(size, size), BackgroundTransparency = 1, ClipsDescendants = true, ZIndex = 3,
            }, Panel)
            local ox = sx == 1 and 0 or size
            local oy = sy == 1 and 0 or size
            local function pt(a, r) return ox + sx * r * math.cos(a), oy + sy * r * math.sin(a) end
            local NS, RINGS = 5, 5
            local strands, segs = {}, {}
            for i = 0, NS - 1 do
                local a = (math.pi / 2) * i / (NS - 1)
                local l = wline(holder, WEB, 2)
                local x2, y2 = pt(a, size * 1.5)
                setLine(l, ox, oy, x2, y2, 1)
                strands[#strands + 1] = l
            end
            for r = 1, RINGS do
                for i = 0, NS - 2 do
                    segs[#segs + 1] = {
                        r = r, i = i, R = size * 1.1 * (r / RINGS),
                        a1 = (math.pi / 2) * i / (NS - 1), a2 = (math.pi / 2) * (i + 1) / (NS - 1),
                        am = (math.pi / 2) * (i + 0.5) / (NS - 1),
                        l1 = wline(holder, WEB, 1), l2 = wline(holder, WEB, 1),
                    }
                end
            end
            local n = 0
            local function render(t)
                for _, sg in ipairs(segs) do
                    local sag = 0.84 + 0.035 * math.sin(t * 1.3 + sg.r * 0.8 + sg.i * 0.5)
                    local x1, y1 = pt(sg.a1, sg.R)
                    local x2, y2 = pt(sg.a2, sg.R)
                    local xm, ym = pt(sg.am, sg.R * sag)
                    setLine(sg.l1, x1, y1, xm, ym, 1)
                    setLine(sg.l2, xm, ym, x2, y2, 1)
                    local tr = 0.72 + 0.08 * math.sin(t * 1.8 - sg.r * 0.9)
                    sg.l1.BackgroundTransparency = tr
                    sg.l2.BackgroundTransparency = tr
                end
                for i, l in ipairs(strands) do
                    l.BackgroundTransparency = 0.6 + 0.08 * math.sin(t * 1.1 + i)
                end
            end
            render(0)
            webUps[#webUps + 1] = function(t)
                n += 1
                if n % 3 == 0 then render(t) end
            end
        end
        createWeb("TL", 70)
        createWeb("TR", 52)
        createWeb("BL", 50)
        createWeb("BR", 66)
        do
            local wconn
            wconn = RunService.Heartbeat:Connect(function()
                if not Panel.Parent then
                    wconn:Disconnect()
                    return
                end
                local t = os.clock()
                for _, fn in ipairs(webUps) do pcall(fn, t) end
            end)
        end

        -- brasas que suben
        task.spawn(function()
            while Panel.Parent do
                local e = mk("Frame", {
                    Size = UDim2.fromOffset(math.random(2, 5), math.random(2, 5)),
                    Position = UDim2.fromScale(math.random(), 1.02),
                    BackgroundColor3 = (math.random() > 0.5) and ORANGE or Color3.fromRGB(255, 210, 80),
                    BorderSizePixel = 0,
                    ZIndex = 3,
                }, Panel)
                mk("UICorner", { CornerRadius = UDim.new(1, 0) }, e)
                local dur = 6 + math.random() * 3
                tw(e, TweenInfo.new(dur, Enum.EasingStyle.Sine), {
                    Position = UDim2.fromScale(e.Position.X.Scale + (math.random() - 0.5) * 0.15, -0.05),
                    BackgroundTransparency = 1,
                })
                Debris:AddItem(e, dur + 0.1)
                task.wait(0.9)
            end
        end)

        -- el degradado gira despacio
        local conn
        conn = RunService.Heartbeat:Connect(function()
            if not Panel.Parent then
                conn:Disconnect()
                return
            end
            gradient.Rotation = (os.clock() * 4) % 360
        end)
    end)

    -- ========== Titulo (mismo estilo del de mantenimiento) ==========
    mk("TextLabel", {
        Position = UDim2.fromOffset(24, 6),
        Size = UDim2.fromOffset(280, 38),
        BackgroundTransparency = 1,
        Text = "UZIVERT HUB",
        TextColor3 = PURPLE,
        TextTransparency = 0.45,
        Font = Enum.Font.Creepster,
        TextSize = 34,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 9,
    }, Panel)
    local Titulo = mk("TextLabel", {
        Position = UDim2.fromOffset(22, 4),
        Size = UDim2.fromOffset(280, 38),
        BackgroundTransparency = 1,
        Text = "UZIVERT HUB",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.Creepster,
        TextSize = 34,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 10,
    }, Panel)
    local titleGrad = mk("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 120, 0)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 225, 110)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 120, 0)),
        }),
        Offset = Vector2.new(-1, 0),
    }, Titulo)
    tw(titleGrad, TweenInfo.new(2.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1), { Offset = Vector2.new(1, 0) })

    local Subtitulo = mk("TextLabel", {
        Position = UDim2.fromOffset(22, 41),
        Size = UDim2.fromOffset(270, 16),
        BackgroundTransparency = 1,
        Text = "Elige el juego que vas a jugar",
        TextColor3 = LAV,
        Font = Enum.Font.GothamMedium,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 10,
    }, Panel)

    -- linea separadora
    local sep = mk("Frame", {
        Position = UDim2.fromOffset(22, 58), Size = UDim2.new(1, -44, 0, 1), BackgroundColor3 = ORANGE, BorderSizePixel = 0, ZIndex = 10,
    }, Panel)
    mk("UIGradient", {
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.3, 0.2), NumberSequenceKeypoint.new(0.7, 0.2), NumberSequenceKeypoint.new(1, 1),
        }),
    }, sep)

    -- boton cerrar
    do
        local x = mk("TextButton", {
            AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -12, 0, 12), Size = UDim2.fromOffset(24, 24),
            BackgroundColor3 = Color3.fromRGB(40, 16, 60), BackgroundTransparency = 0.2, Text = "", AutoButtonColor = false,
            BorderSizePixel = 0, ZIndex = 20,
        }, Panel)
        mk("UICorner", { CornerRadius = UDim.new(0, 4) }, x)
        local xs = mk("UIStroke", { Thickness = 1, Color = PURPLE, Transparency = 0.3 }, x)
        local bars = {}
        for _, rot in ipairs({ 45, -45 }) do
            bars[#bars + 1] = mk("Frame", {
                AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(12, 2),
                BackgroundColor3 = LAV, BorderSizePixel = 0, Rotation = rot, ZIndex = 21,
            }, x)
        end
        x.MouseEnter:Connect(function()
            tw(xs, ti(0.15), { Color = Color3.fromRGB(220, 60, 60), Transparency = 0 })
            for _, b in ipairs(bars) do tw(b, ti(0.15), { BackgroundColor3 = Color3.fromRGB(255, 120, 120) }) end
        end)
        x.MouseLeave:Connect(function()
            tw(xs, ti(0.15), { Color = PURPLE, Transparency = 0.3 })
            for _, b in ipairs(bars) do tw(b, ti(0.15), { BackgroundColor3 = LAV }) end
        end)
        x.Activated:Connect(function()
            tw(popScale, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Scale = 0 })
            task.delay(0.35, function() selectorGui:Destroy() end)
        end)
    end

    -- ========== Tarjetas de juegos ==========
    local list = mk("ScrollingFrame", {
        Position = UDim2.fromOffset(16, 66), Size = UDim2.new(1, -32, 0, 168), BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 10,
        ScrollingDirection = Enum.ScrollingDirection.Y, ScrollingEnabled = true, ScrollBarThickness = 3,
        ScrollBarImageColor3 = ORANGE, ScrollBarImageTransparency = 0.2,
        CanvasSize = UDim2.new(0, 0, 0, 0), AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ElasticBehavior = Enum.ElasticBehavior.Always, ClipsDescendants = true,
    }, Panel)
    mk("UIPadding", {
        PaddingTop = UDim.new(0, 2), PaddingBottom = UDim.new(0, 2), PaddingLeft = UDim.new(0, 2), PaddingRight = UDim.new(0, 8),
    }, list)
    mk("UIListLayout", { Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder }, list)

    -- el juego en el que estas va primero
    local ordered = {}
    for _, e in ipairs(JUEGOS) do if isHere(e) then ordered[#ordered + 1] = e end end
    for _, e in ipairs(JUEGOS) do if not isHere(e) then ordered[#ordered + 1] = e end end

    -- iconos dibujados con Frames
    local function drawIcon(kind, tile, col)
        local function part(w, h, x, y, rot, color, round, stroke)
            local f = mk("Frame", {
                AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, x, 0.5, y), Size = UDim2.fromOffset(w, h),
                BackgroundColor3 = color or col, BackgroundTransparency = stroke and 1 or 0, BorderSizePixel = 0, Rotation = rot or 0, ZIndex = 12,
            }, tile)
            if round then mk("UICorner", { CornerRadius = UDim.new(round, 0) }, f) end
            if stroke then mk("UIStroke", { Thickness = stroke, Color = color or col }, f) end
            return f
        end
        if kind == "knife" then
            part(6, 26, 5, -5, 45, Color3.fromRGB(240, 235, 245), 0.4)
            part(14, 3, -3, 3, 45, col, 0.3)
            part(6, 12, -8, 9, 45, col, 0.4)
        elseif kind == "hook" then
            part(4, 20, 4, -5, 0, Color3.fromRGB(240, 235, 245), 0.4)
            part(16, 16, -2, 7, 0, col, 1, 4)
            part(6, 6, 4, -17, 0, col, 1, 2)
        elseif kind == "cuffs" then
            part(15, 15, -8, 2, 0, col, 1, 3)
            part(15, 15, 8, 2, 0, col, 1, 3)
            part(8, 3, 0, 2, 0, Color3.fromRGB(240, 235, 245), 0.4)
            part(4, 6, -8, -7, 0, Color3.fromRGB(240, 235, 245), 0.4)
        else
            part(14, 14, 0, 0, 45, col, 0.15)
            part(14, 14, 0, 0, 0, col, 0.15)
            part(5, 5, 0, 0, 45, Color3.fromRGB(40, 20, 4), 0.2)
        end
    end

    -- icono real del juego (thumbnail oficial); si falla se queda el icono dibujado
    local iconCache = {}
    local function getGameIcon(universeId)
        if iconCache[universeId] ~= nil then return iconCache[universeId] or nil end
        local asset
        pcall(function()
            if not (writefile and getcustomasset) then return end
            local api = "https://thumbnails.roblox.com/v1/games/icons?universeIds=" .. universeId
                .. "&returnPolicy=PlaceHolder&size=150x150&format=Png&isCircular=false"
            local data = game:GetService("HttpService"):JSONDecode(game:HttpGet(api))
            local imgUrl = data and data.data and data.data[1] and data.data[1].imageUrl
            if not imgUrl then return end
            local fname = "uzivert_icon_" .. universeId .. ".png"
            writefile(fname, game:HttpGet(imgUrl))
            asset = getcustomasset(fname)
        end)
        iconCache[universeId] = asset or false
        return asset
    end

    local cards = {}
    local chosen = false

    local function sheen(card)
        local s = mk("Frame", {
            Position = UDim2.fromOffset(-50, -20), Size = UDim2.fromOffset(34, 120), Rotation = 20, BackgroundColor3 = Color3.new(1, 1, 1),
            BackgroundTransparency = 0.88, BorderSizePixel = 0, ZIndex = 14,
        }, card)
        tw(s, TweenInfo.new(0.7, Enum.EasingStyle.Quad), { Position = UDim2.fromOffset(420, -20) })
        Debris:AddItem(s, 0.8)
    end

    local function burst(card)
        local c = card.AbsolutePosition + card.AbsoluteSize / 2 - Panel.AbsolutePosition
        c = c / math.max(popScale.Scale, 0.1)
        for _ = 1, 10 do
            local e = mk("Frame", {
                AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(c.X, c.Y), Size = UDim2.fromOffset(3, 3),
                BackgroundColor3 = (math.random() > 0.5) and ORANGE or GOLD, BorderSizePixel = 0, ZIndex = 30,
            }, Panel)
            mk("UICorner", { CornerRadius = UDim.new(1, 0) }, e)
            local a, d = math.random() * math.pi * 2, 30 + math.random() * 60
            tw(e, ti(0.7), { Position = UDim2.fromOffset(c.X + math.cos(a) * d, c.Y + math.sin(a) * d), BackgroundTransparency = 1 })
            Debris:AddItem(e, 0.8)
        end
    end

    local function resetCards()
        chosen = false
        Subtitulo.Text = "Elige el juego que vas a jugar"
        Subtitulo.TextColor3 = LAV
        for _, c in ipairs(cards) do
            tw(c.scale, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Scale = 1 })
            if c.bar then c.bar.Visible = false end
        end
    end

    local function choose(entry, c)
        if chosen then return end
        -- si eligen un juego que NO esta siendo detectado, los kickea
        if not isHere(entry) then
            chosen = true
            pcall(function() game:GetService("Players").LocalPlayer:Kick("NO MODEL WTF") end)
            return
        end
        chosen = true
        Subtitulo.Text = "Cargando " .. entry.title .. "..."
        Subtitulo.TextColor3 = (entry.limited and GOLD) or ORANGE
        for _, o in ipairs(cards) do
            if o ~= c then tw(o.scale, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Scale = 0 }) end
        end
        c.bar.Visible = true

        task.spawn(function()
            local t0 = os.clock()
            local okH, src = pcall(function() return game:HttpGet(entry.url) end)
            local fn, err
            if okH and src then fn, err = loadstring(src) end
            -- minimo un momento de "cargando" para que se vea la animacion
            local rest = 0.9 - (os.clock() - t0)
            if rest > 0 then task.wait(rest) end
            if not selectorGui.Parent then return end -- cerraste el selector mientras cargaba

            if not fn then
                print("❌ No se pudo cargar " .. entry.title .. (err and (": " .. tostring(err)) or ""))
                Subtitulo.Text = "No se pudo cargar. Intenta de nuevo."
                Subtitulo.TextColor3 = Color3.fromRGB(255, 110, 110)
                task.wait(2)
                if selectorGui.Parent then resetCards() end
                return
            end

            -- cierra el selector y ejecuta el hub elegido
            tw(popScale, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Scale = 0 })
            task.wait(0.4)
            selectorGui:Destroy()
            local okRun, errRun = pcall(fn)
            if not okRun then print("❌ Error: " .. tostring(errRun)) end
        end)
    end

    for i, entry in ipairs(ordered) do
        local here = isHere(entry)
        local locked = entry.hasta ~= nil and nowT() >= entry.hasta
        local accent = entry.limited and GOLD or ORANGE
        local c = {}

        local card = mk("TextButton", {
            LayoutOrder = i,
            Size = UDim2.new(1, 0, 0, entry.limited and 64 or (entry.aviso and 64 or 50)),
            BackgroundColor3 = entry.limited and Color3.fromRGB(34, 18, 12) or Color3.fromRGB(24, 10, 38),
            BackgroundTransparency = locked and 0.5 or 0.12,
            AutoButtonColor = false,
            Text = "",
            BorderSizePixel = 0,
            ClipsDescendants = true,
            ZIndex = 10,
        }, list)
        mk("UICorner", { CornerRadius = UDim.new(0, 5) }, card)
        local stroke = mk("UIStroke", { Thickness = 1.5, Color = entry.limited and GOLD or PURPLE, Transparency = locked and 0.7 or 0.35 }, card)
        local scale = mk("UIScale", { Scale = 0.96 }, card)
        c.card, c.scale = card, scale

        -- aparicion escalonada
        task.delay(0.35 + i * 0.12, function()
            if scale.Parent then tw(scale, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Scale = 1 }) end
        end)

        -- la version limitada tiene un borde dorado que brilla
        if entry.limited and not locked then
            tw(stroke, loop(2), { Transparency = 0.05 })
        end

        -- icono
        local tile = mk("Frame", {
            Position = UDim2.fromOffset(10, entry.limited and 14 or (entry.aviso and 14 or 7)), Size = UDim2.fromOffset(36, 36),
            BackgroundColor3 = entry.limited and Color3.fromRGB(70, 46, 8) or Color3.fromRGB(46, 20, 70), BorderSizePixel = 0, ClipsDescendants = true, ZIndex = 11,
        }, card)
        mk("UICorner", { CornerRadius = UDim.new(0, 5) }, tile)
        mk("UIStroke", { Thickness = 1, Color = accent, Transparency = 0.4 }, tile)
        -- icono dibujado (respaldo) + imagen real del juego si se puede descargar
        local holder = mk("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(44, 44),
            BackgroundTransparency = 1, ZIndex = 12,
        }, tile)
        mk("UIScale", { Scale = 0.75 }, holder)
        drawIcon(entry.icon, holder, accent)
        local img = mk("ImageLabel", {
            Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ScaleType = Enum.ScaleType.Crop,
            ImageTransparency = locked and 0.5 or 0, Visible = false, ZIndex = 13,
        }, tile)
        local uid = (entry.universeIds and entry.universeIds[1]) or (here and game.GameId ~= 0 and game.GameId or nil)
        if uid then
            task.spawn(function()
                local asset = getGameIcon(uid)
                if asset and img.Parent then
                    img.Image = asset
                    img.Visible = true
                    holder.Visible = false
                end
            end)
        end

        -- textos
        mk("TextLabel", {
            Position = UDim2.fromOffset(56, 8), Size = UDim2.new(1, -190, 0, 20), BackgroundTransparency = 1, Text = entry.title,
            Font = Enum.Font.GothamBold, TextSize = 14, TextColor3 = locked and Color3.fromRGB(150, 140, 160) or Color3.new(1, 1, 1),
            TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 11,
        }, card)
        local subL = mk("TextLabel", {
            Position = UDim2.fromOffset(56, entry.aviso and 44 or 28), Size = UDim2.new(1, -190, 0, 16), BackgroundTransparency = 1, Text = entry.sub,
            Font = Enum.Font.Gotham, TextSize = 10, TextColor3 = LAV, TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 11,
        }, card)

        if entry.aviso then
            mk("TextLabel", {
                Position = UDim2.fromOffset(56, 27), Size = UDim2.new(1, -70, 0, 16), BackgroundTransparency = 1, Text = entry.aviso,
                Font = Enum.Font.GothamBold, TextSize = 11, TextColor3 = Color3.fromRGB(255, 190, 70),
                TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 11,
            }, card)
        end

        -- insignias
        local function chip(text, color, textColor, y, w)
            local f = mk("Frame", {
                AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -32, 0, y), Size = UDim2.fromOffset(w, 17),
                BackgroundColor3 = color, BorderSizePixel = 0, ZIndex = 12,
            }, card)
            mk("UICorner", { CornerRadius = UDim.new(1, 0) }, f)
            mk("TextLabel", {
                Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Text = text, Font = Enum.Font.GothamBold, TextSize = 8,
                TextColor3 = textColor, ZIndex = 13,
            }, f)
            return f
        end
        local chipY = 7
        if entry.limited then
            local lim = chip(locked and "FINALIZADA" or "VERSION LIMITADA", locked and Color3.fromRGB(90, 80, 100) or GOLD, Color3.fromRGB(40, 20, 0), chipY, locked and 78 or 104)
            if not locked then
                local sh = mk("UIGradient", {
                    Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 180, 60)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 240, 170)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 180, 60)),
                    }),
                    Offset = Vector2.new(-1, 0),
                }, lim)
                tw(sh, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1), { Offset = Vector2.new(1, 0) })
            end
            chipY = chipY + 21
        end
        if here and not locked then
            local d = chip("DETECTADO", Color3.fromRGB(22, 90, 56), GREEN, chipY, 74)
            tw(d, loop(1.4), { BackgroundTransparency = 0.45 })
        end

        -- version limitada: cuenta regresiva en su propia linea (abajo), baja cada segundo
        if entry.hasta then
            local cdL = mk("TextLabel", {
                Position = UDim2.fromOffset(56, 45), Size = UDim2.new(1, -70, 0, 14), BackgroundTransparency = 1, Text = "",
                Font = Enum.Font.GothamBold, TextSize = 10, TextColor3 = locked and Color3.fromRGB(150, 140, 160) or GOLD,
                TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 11,
            }, card)
            local baseLeft, baseClock = entry.hasta - nowT(), os.clock()
            local function refresh()
                local left = baseLeft - (os.clock() - baseClock)
                if left <= 0 then
                    cdL.Text = "Edicion finalizada"
                    cdL.TextColor3 = Color3.fromRGB(150, 140, 160)
                else
                    cdL.Text = "Quedan " .. fmtLeft(left)
                end
            end
            refresh()
            task.spawn(function()
                while card.Parent do
                    task.wait(0.25)
                    if card.Parent then refresh() end
                end
            end)
        end

        -- flecha (chevron) que se mueve al pasar el cursor
        local chev = mk("Frame", {
            AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -14, 0.5, 0), Size = UDim2.fromOffset(10, 10), BackgroundTransparency = 1, ZIndex = 12,
        }, card)
        for _, rot in ipairs({ 45, -45 }) do
            mk("Frame", {
                AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, rot == 45 and 0.25 or 0.75, 0), Size = UDim2.fromOffset(8, 2),
                BackgroundColor3 = accent, BorderSizePixel = 0, Rotation = rot, ZIndex = 12,
            }, chev)
        end
        chev.Visible = not locked

        -- barra de carga (se ve al elegir)
        local bar = mk("Frame", {
            Position = UDim2.new(0, 0, 1, -3), Size = UDim2.new(1, 0, 0, 3), BackgroundColor3 = Color3.fromRGB(45, 25, 55), BorderSizePixel = 0,
            ClipsDescendants = true, Visible = false, ZIndex = 15,
        }, card)
        local fill = mk("Frame", {
            Position = UDim2.fromScale(-0.4, 0), Size = UDim2.fromScale(0.4, 1), BackgroundColor3 = accent, BorderSizePixel = 0, ZIndex = 16,
        }, bar)
        tw(fill, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1), { Position = UDim2.fromScale(1, 0) })
        c.bar = bar

        -- interaccion
        card.MouseEnter:Connect(function()
            if chosen or locked then return end
            tw(card, ti(0.15), { BackgroundColor3 = entry.limited and Color3.fromRGB(56, 30, 14) or Color3.fromRGB(44, 20, 66) })
            tw(stroke, ti(0.15), { Color = accent, Transparency = 0 })
            tw(chev, ti(0.2), { Position = UDim2.new(1, -9, 0.5, 0) })
        end)
        card.MouseLeave:Connect(function()
            if chosen or locked then return end
            tw(card, ti(0.2), { BackgroundColor3 = entry.limited and Color3.fromRGB(34, 18, 12) or Color3.fromRGB(24, 10, 38) })
            tw(stroke, ti(0.2), { Color = entry.limited and GOLD or PURPLE, Transparency = 0.35 })
            tw(scale, ti(0.2), { Scale = 1 })
            tw(chev, ti(0.2), { Position = UDim2.new(1, -14, 0.5, 0) })
        end)
        card.Activated:Connect(function()
            if chosen or locked then return end
            tw(scale, TweenInfo.new(0.07), { Scale = 0.97 })
            choose(entry, c)
        end)

        cards[#cards + 1] = c
    end

    -- ========== Pie ==========
    local detected
    for _, e in ipairs(JUEGOS) do
        if isHere(e) then detected = e.game break end
    end
    mk("TextLabel", {
        Position = UDim2.fromOffset(22, 238), Size = UDim2.new(1, -150, 0, 14), BackgroundTransparency = 1,
        Text = detected and ("Juego detectado: " .. detected) or "Juego no reconocido: elige el hub a mano",
        Font = Enum.Font.GothamMedium, TextSize = 10, TextColor3 = detected and GREEN or LAV, TextXAlignment = Enum.TextXAlignment.Left,
        TextTransparency = 0.1, ZIndex = 10,
    }, Panel)
    mk("TextLabel", {
        AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -22, 0, 238), Size = UDim2.fromOffset(120, 14), BackgroundTransparency = 1,
        Text = "By Uzivert 🇵🇾", Font = Enum.Font.GothamMedium, TextSize = 10, TextColor3 = LAV, TextXAlignment = Enum.TextXAlignment.Right,
        TextTransparency = 0.1, ZIndex = 10,
    }, Panel)
end)

if selOk then
    return -- el selector esta activo: el hub se ejecuta cuando elijas una opcion
end
-- si el selector fallo, se limpia y se sigue con el comportamiento original (abajo)
warn("Selector no disponible: " .. tostring(selErr))
if selectorGui then pcall(function() selectorGui:Destroy() end) end


-- 🎯 Cargar el hub
print("✅ Cargando hub...")
local ok, scriptContent = pcall(function()
    return game:HttpGet(SCRIPT_URL)
end)

if ok and scriptContent then
    local fn, err = loadstring(scriptContent)
    if fn then
        fn()
    else
        print("❌ Error: " .. tostring(err))
    end
else
    print("❌ No se pudo cargar el hub")
end
