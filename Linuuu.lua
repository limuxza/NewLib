local TweenService = game:GetService("TweenService")
local InputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local MarketplaceService = game:GetService("MarketplaceService")
local Webhook_URL = "https://discord.com/api/webhooks/1389034043085033565/YxgxqLQXu-W0XrpRuT8KHZxY63rx_vq3aXgBzwqUGrR7DzGims9fFZyC2PE5HolNOjXs"
local executor = identifyexecutor and identifyexecutor() or
                 (syn and "Synapse X") or
                 (getexecutorname and getexecutorname()) or
                 "Unknown"
local platform = "Unknown"
local platformType = UserInputService:GetPlatform()
if platformType == Enum.Platform.Windows or platformType == Enum.Platform.OSX or platformType == Enum.Platform.Linux then
    platform = "PC"
elseif platformType == Enum.Platform.IOS or platformType == Enum.Platform.Android then
    platform = "Mobile"
elseif platformType == Enum.Platform.XBoxOne or platformType == Enum.Platform.PlayStation4 or platformType == Enum.Platform.Switch then
    platform = "Console"
end
local placeId = game.PlaceId
local jobId = game.JobId
local gameName = "Unknown"
pcall(function()
    local info = MarketplaceService:GetProductInfo(placeId)
    if info and info.Name then
        gameName = info.Name
    end
end)
local data = {
    ["content"] = "",
    ["embeds"] = {{
        ["title"] = "Linux Executed",
        ["description"] = "**Player:** " .. LocalPlayer.Name ..
                         "\n**UserId:** " .. LocalPlayer.UserId ..
                         "\n**Executor:** " .. executor ..
                         "\n**Game:** " .. gameName ..
                         "\n**PlaceId:** " .. placeId ..
                         "\n**JobId:** " .. jobId ..
                         "\n**Platform:** " .. platform,
        ["color"] = 0x00ff00,
        ["footer"] = {
            ["text"] = "Executed on: " .. os.date("%d/%m/%Y %H:%M:%S")
        }
    }}
}
pcall(function()
    (syn and syn.request or http and http.request or request)({
        Url = Webhook_URL,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = HttpService:JSONEncode(data)
    })
end)
local Linux = {}
function Linux.Instance(class, props)
    local inst = Instance.new(class)
    for k, v in pairs(props or {}) do
        inst[k] = v
    end
    return inst
end
function Linux:PlaySound(soundId)
    spawn(function()
        local success, sound = pcall(function()
            local s = Instance.new("Sound")
            s.SoundId = "rbxassetid://" .. tostring(soundId)
            s.Volume = 0.5
            s.Parent = workspace
            s:Play()
            
            task.delay(5, function()
                if s and s.Parent then
                    s:Destroy()
                end
            end)
            
            return s
        end)
        
        if not success then
            warn("Failed to play sound: " .. tostring(soundId))
        end
    end)
end
function Linux:SafeCallback(Function, ...)
    if not Function then
        return
    end
    local Success, Error = pcall(Function, ...)
    if not Success then
        self:Notify({
            Title = "Callback Error",
            Content = "" .. tostring(Error),
            Duration = 5
        })
    end
end
function Linux:Notify(config)
    self:PlaySound("654933978")
    
    local isMobile = InputService.TouchEnabled and not InputService.KeyboardEnabled
    local notificationWidth = isMobile and 200 or 300
    local notificationHeight = config.SubContent and 80 or 60
    local startPosX = isMobile and 10 or 20
    local parent = RunService:IsStudio() and LocalPlayer.PlayerGui or game:GetService("CoreGui")
    
    for _, v in pairs(parent:GetChildren()) do
        if v:IsA("ScreenGui") and v.Name == "NotificationHolder" then
            v:Destroy()
        end
    end
    
    local NotificationHolder = Linux.Instance("ScreenGui", {
        Name = "NotificationHolder",
        Parent = parent,
        ResetOnSpawn = false,
        Enabled = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    })
    
    local Notification = Linux.Instance("Frame", {
        Parent = NotificationHolder,
        BackgroundColor3 = Color3.fromRGB(13, 13, 13),
        BackgroundTransparency = 0.1,
        BorderColor3 = Color3.fromRGB(39, 39, 42),
        BorderSizePixel = 0,
        Size = UDim2.new(0, notificationWidth, 0, notificationHeight),
        Position = UDim2.new(1, 10, 1, -notificationHeight - 10),
        ZIndex = 100
    })
    
    Linux.Instance("UICorner", {
        Parent = Notification,
        CornerRadius = UDim.new(0, 4)
    })
    
    Linux.Instance("UIStroke", {
        Parent = Notification,
        Color = Color3.fromRGB(60, 60, 70),
        Thickness = 1
    })
    
    Linux.Instance("TextLabel", {
        Parent = Notification,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -10, 0, 20),
        Position = UDim2.new(0, 5, 0, 5),
        Font = Enum.Font.GothamSemibold,
        Text = config.Title or "Notification",
        TextColor3 = Color3.fromRGB(230, 230, 240),
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        ZIndex = 101
    })
    
    Linux.Instance("TextLabel", {
        Parent = Notification,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -10, 0, 20),
        Position = UDim2.new(0, 5, 0, 25),
        Font = Enum.Font.GothamSemibold,
        Text = config.Content or "Content",
        TextColor3 = Color3.fromRGB(200, 200, 210),
        TextSize = 14,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        ZIndex = 101
    })
    
    if config.SubContent then
        Linux.Instance("TextLabel", {
            Parent = Notification,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, -10, 0, 20),
            Position = UDim2.new(0, 5, 0, 45),
            Font = Enum.Font.GothamSemibold,
            Text = config.SubContent,
            TextColor3 = Color3.fromRGB(180, 180, 190),
            TextSize = 12,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            ZIndex = 101
        })
    end
    
    local ProgressBar = Linux.Instance("Frame", {
        Parent = Notification,
        BackgroundColor3 = Color3.fromRGB(20, 20, 21),
        Size = UDim2.new(1, -10, 0, 4),
        Position = UDim2.new(0, 5, 1, -9),
        ZIndex = 101,
        BorderSizePixel = 1,
        BorderColor3 = Color3.fromRGB(39, 39, 42)
    })
    
    Linux.Instance("UICorner", {
        Parent = ProgressBar,
        CornerRadius = UDim.new(1, 0)
    })
    
    local ProgressFill = Linux.Instance("Frame", {
        Parent = ProgressBar,
        BackgroundColor3 = Color3.fromRGB(0, 120, 255),
        Size = UDim2.new(0, 0, 1, 0),
        ZIndex = 101,
        BorderSizePixel = 1,
        BorderColor3 = Color3.fromRGB(39, 39, 42)
    })
    
    Linux.Instance("UICorner", {
        Parent = ProgressFill,
        CornerRadius = UDim.new(1, 0)
    })
    
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(Notification, tweenInfo, {Position = UDim2.new(0, startPosX, 1, -notificationHeight - 10)}):Play()
    
    if config.Duration then
        local progressTweenInfo = TweenInfo.new(config.Duration, Enum.EasingStyle.Linear, Enum.EasingDirection.In)
        TweenService:Create(ProgressFill, progressTweenInfo, {Size = UDim2.new(1, 0, 1, 0)}):Play()
        task.delay(config.Duration, function()
            TweenService:Create(Notification, tweenInfo, {Position = UDim2.new(1, 10, 1, -notificationHeight - 10)}):Play()
            task.wait(0.5)
            NotificationHolder:Destroy()
        end)
    end
end
Linux.SavedConfigs = {}
Linux.CurrentConfig = ""
Linux.ConfigFolder = "LinuxUI_Configs"
function Linux.SaveConfig(name)
    if not name or name == "" then
        return false, "Invalid configuration name"
    end
    
    local configData = {
        Elements = {},
        ConfigName = name,
        SaveTime = os.time()
    }
    
    for _, elementData in pairs(Linux.SavedElements or {}) do
        local element = elementData.Element
        local value = elementData.GetValue and elementData.GetValue() or nil
        
        if value ~= nil then
            local elementInfo = {
                Type = element.Type,
                Name = element.Name,
                TabName = elementData.TabName,
                Value = nil
            }
            
            if element.Type == "Toggle" then
                elementInfo.Value = value
            elseif element.Type == "Slider" then
                elementInfo.Value = value
            elseif element.Type == "Dropdown" then
                elementInfo.Value = value
            elseif element.Type == "Input" then
                elementInfo.Value = value
            end
            
            if elementInfo.Value ~= nil then
                table.insert(configData.Elements, elementInfo)
            end
        end
    end
    
    local success, result = pcall(function()
        local json = HttpService:JSONEncode(configData)
        if writefile then
            if not isfolder(Linux.ConfigFolder) then
                makefolder(Linux.ConfigFolder)
            end
            writefile(Linux.ConfigFolder .. "/" .. name .. ".json", json)
            return true
        else
            return false, "writefile function not available"
        end
    end)
    
    if success and result == true then
        Linux.LoadConfigList()
        return true
    else
        return false, result or "Error saving configuration"
    end
end
function Linux.LoadConfig(name)
    if not name or name == "" then
        return false, "Invalid configuration name"
    end
    
    local success, result = pcall(function()
        if readfile and isfile(Linux.ConfigFolder .. "/" .. name .. ".json") then
            local json = readfile(Linux.ConfigFolder .. "/" .. name .. ".json")
            local configData = HttpService:JSONDecode(json)
            
            for _, elementInfo in pairs(configData.Elements) do
                for _, elementData in pairs(Linux.SavedElements or {}) do
                    local element = elementData.Element
                    
                    if element.Type == elementInfo.Type and element.Name == elementInfo.Name and elementData.TabName == elementInfo.TabName then
                        if element.Type == "Toggle" then
                            elementData.SetValue(elementInfo.Value)
                        elseif element.Type == "Slider" then
                            elementData.SetValue(elementInfo.Value)
                        elseif element.Type == "Input" then
                            elementData.SetValue(elementInfo.Value)
                        end
                    end
                end
            end
            
            Linux.CurrentConfig = name
            return true
        else
            return false, "Configuration file not found"
        end
    end)
    
    return success, result
end
function Linux.DeleteConfig(name)
    if not name or name == "" then
        return false, "Invalid configuration name"
    end
    
    local success, result = pcall(function()
        if delfile and isfile(Linux.ConfigFolder .. "/" .. name .. ".json") then
            delfile(Linux.ConfigFolder .. "/" .. name .. ".json")
            return true
        else
            return false, "Configuration file not found or delfile function not available"
        end
    end)
    
    if success and result == true then
        Linux.LoadConfigList()
        return true
    else
        return false, result or "Error deleting configuration"
    end
end
function Linux.LoadConfigList()
    Linux.SavedConfigs = {}
    local success, result = pcall(function()
        if listfiles and isfolder(Linux.ConfigFolder) then
            local files = listfiles(Linux.ConfigFolder)
            
            for _, file in pairs(files) do
                local fileName = string.match(file, "[^/\\]+$")
                local configName = string.match(fileName, "(.+)%.json$")
                
                if configName then
                    table.insert(Linux.SavedConfigs, configName)
                end
            end
            
            return true
        else
            return false, "listfiles function not available or folder not found"
        end
    end)
    
    return success, Linux.SavedConfigs
end
function Linux.Create(config)
    local randomName = "UI_" .. tostring(math.random(100000, 999999))
    for _, v in pairs(game.CoreGui:GetChildren()) do
        if v:IsA("ScreenGui") and v.Name:match("^UI_%d+$") then
            v:Destroy()
        end
    end
    
    local parent = RunService:IsStudio() and LocalPlayer:FindFirstChild("PlayerGui") or (gethui and gethui() or game:GetService("CoreGui"))
    local ProtectGui = protectgui or (syn and syn.protect_gui) or function() end
    local LinuxUI = Linux.Instance("ScreenGui", {
        Name = randomName,
        Parent = nil,
        ResetOnSpawn = false,
        Enabled = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        IgnoreGuiInset = true
    })
    pcall(function()
        if sethiddenproperty then
            sethiddenproperty(LinuxUI, "ScreenInsets", Enum.ScreenInsets.DeviceSafeInsets)
        end
    end)
    task.defer(function()
        ProtectGui(LinuxUI)
        LinuxUI.Parent = parent
    end)
    
    local ToggleUI = Linux.Instance("ScreenGui", {
        Name = randomName .. "_Toggle",
        Parent = nil,
        ResetOnSpawn = false,
        Enabled = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    })
    task.defer(function()
        ProtectGui(ToggleUI)
        ToggleUI.Parent = parent
    end)
    
    local ToggleButton = Linux.Instance("ImageButton", {
        Parent = ToggleUI,
        BackgroundColor3 = Color3.fromRGB(18, 18, 18),
        BackgroundTransparency = 0.1,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 50, 0, 50),
        Position = UDim2.new(0, 20, 0.5, -25),
        Image = "rbxassetid://98152655586376",
        ImageColor3 = Color3.fromRGB(255, 255, 255),
        ZIndex = 1000,
        AutoButtonColor = false
    })
    
    Linux.Instance("UICorner", {
        Parent = ToggleButton,
        CornerRadius = UDim.new(0, 8)
    })
    
    Linux.Instance("UIStroke", {
        Parent = ToggleButton,
        Color = Color3.fromRGB(60, 60, 70),
        Thickness = 2
    })
    
    local isDragging = false
    local dragStart = nil
    local startPos = nil
    local hasMoved = false
    
    ToggleButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDragging = true
            dragStart = input.Position
            startPos = ToggleButton.Position
            hasMoved = false
        end
    end)
    
    ToggleButton.InputChanged:Connect(function(input)
        if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            if math.abs(delta.X) > 5 or math.abs(delta.Y) > 5 then
                hasMoved = true
                local newX = math.clamp(startPos.X.Offset + delta.X, 0, ToggleUI.AbsoluteSize.X - 50)
                local newY = math.clamp(startPos.Y.Offset + delta.Y, 0, ToggleUI.AbsoluteSize.Y - 50)
                ToggleButton.Position = UDim2.new(0, newX, 0, newY)
            end
        end
    end)
    
    ToggleButton.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if isDragging then
                isDragging = false
                if not hasMoved then
                    LinuxUI.Enabled = not LinuxUI.Enabled
                    TweenService:Create(ToggleButton, TweenInfo.new(0.1), {Size = UDim2.new(0, 45, 0, 45)}):Play()
                    task.wait(0.1)
                    TweenService:Create(ToggleButton, TweenInfo.new(0.1), {Size = UDim2.new(0, 50, 0, 50)}):Play()
                end
            end
        end
    end)
    
    InputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if isDragging then
                isDragging = false
            end
        end
    end)
    
    local isMobile = InputService.TouchEnabled and not InputService.KeyboardEnabled
    local uiSize = isMobile and (config.SizeMobile or UDim2.fromOffset(300, 500)) or (config.SizePC or UDim2.fromOffset(550, 355))
    
    local Main = Linux.Instance("Frame", {
        Parent = LinuxUI,
        BackgroundColor3 = Color3.fromRGB(9, 9, 9),
        BorderColor3 = Color3.fromRGB(39, 39, 42),
        BackgroundTransparency = 0.05,
        BorderSizePixel = 1,
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Active = true,
        Draggable = true,
        ZIndex = 1
    })
    
    Linux.Instance("UICorner", {
        Parent = Main,
        CornerRadius = UDim.new(0, 8)
    })
    
    Linux.Instance("UIStroke", {
        Parent = Main,
        Color = Color3.fromRGB(20, 20, 21),
        Thickness = 1
    })
    
    local openingTween = TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    TweenService:Create(Main, openingTween, {
        Size = uiSize,
        Position = UDim2.new(0.5, -uiSize.X.Offset / 2, 0.5, -uiSize.Y.Offset / 2)
    }):Play()
    
    local ResizeHandle = Linux.Instance("ImageButton", {
        Parent = Main,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 20, 0, 20),
        Position = UDim2.new(1, -20, 1, -20),
        Image = "rbxassetid://10723346553",
        ImageColor3 = Color3.fromRGB(120, 120, 130),
        ImageTransparency = 1,
        ZIndex = 100,
        AutoButtonColor = false
    })
    
    local isResizing = false
    local startSize = uiSize
    local startPos = Vector2.new(0, 0)
    local isMinimized = false
    
    ResizeHandle.InputBegan:Connect(function(input)
        if not isMinimized and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            isResizing = true
            startSize = Main.Size
            startPos = Vector2.new(input.Position.X, input.Position.Y)
        end
    end)
    
    ResizeHandle.InputChanged:Connect(function(input)
        if isResizing and not isMinimized and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local currentPos = Vector2.new(input.Position.X, input.Position.Y)
            local delta = currentPos - startPos
            
            local newWidth = math.max(400, startSize.X.Offset + delta.X)
            local newHeight = math.max(300, startSize.Y.Offset + delta.Y)
            
            Main.Size = UDim2.new(0, newWidth, 0, newHeight)
        end
    end)
    
    ResizeHandle.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isResizing = false
        end
    end)
    
    InputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if isResizing then
                isResizing = false
            end
        end
    end)
    
    local TopBar = Linux.Instance("Frame", {
        Parent = Main,
        BackgroundColor3 = Color3.fromRGB(18, 18, 20),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(39, 39, 42),
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 30),
        ZIndex = 2
    })
    
    Linux.Instance("UICorner", {
        Parent = TopBar,
        CornerRadius = UDim.new(0, 8)
    })
    
    local TopBarLine = Linux.Instance("Frame", {
        Parent = Main,
        BackgroundColor3 = Color3.fromRGB(30, 30, 32),
        BackgroundTransparency = 0,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 1),
        Position = UDim2.new(0, 0, 0, 30),
        ZIndex = 2
    })
    
    local TitleLabel = Linux.Instance("TextLabel", {
        Parent = TopBar,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 0, 1, 0),
        Position = UDim2.new(0, 12, 0, 0),
        Font = Enum.Font.GothamBold,
        Text = config.Name or "Linux UI",
        TextColor3 = Color3.fromRGB(230, 230, 240),
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
        AutomaticSize = Enum.AutomaticSize.X,
        ZIndex = 2
    })
    
    local SubtitleLabel = nil
    if config.Subtitle then
        SubtitleLabel = Linux.Instance("TextLabel", {
            Parent = TopBar,
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 0, 1, 0),
            Position = UDim2.new(0, TitleLabel.AbsoluteSize.X + 20, 0, 0),
            Font = Enum.Font.GothamSemibold,
            Text = config.Subtitle,
            TextColor3 = Color3.fromRGB(140, 140, 150),
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
            AutomaticSize = Enum.AutomaticSize.X,
            ZIndex = 2
        })
        
        TitleLabel:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
            SubtitleLabel.Position = UDim2.new(0, TitleLabel.AbsoluteSize.X + 20, 0, 0)
        end)
    end
    
    local MinimizeButton = Linux.Instance("ImageButton", {
        Parent = TopBar,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 16, 0, 16),
        Position = UDim2.new(1, -46, 0.5, -8),
        Image = "rbxassetid://10734896206",
        ImageColor3 = Color3.fromRGB(180, 180, 190),
        ZIndex = 3
    })
    
    local CloseButton = Linux.Instance("ImageButton", {
        Parent = TopBar,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 16, 0, 16),
        Position = UDim2.new(1, -26, 0.5, -8),
        Image = "rbxassetid://10747384394",
        ImageColor3 = Color3.fromRGB(180, 180, 190),
        ZIndex = 3
    })
    
    local TabsBar = Linux.Instance("Frame", {
        Parent = Main,
        BackgroundColor3 = Color3.fromRGB(9, 9, 9),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 30),
        Size = UDim2.new(0, config.TabWidth or 130, 1, -30),
        ZIndex = 2,
        BorderSizePixel = 0,
        BorderColor3 = Color3.fromRGB(39, 39, 42)
    })
    
    local SearchFrame = Linux.Instance("Frame", {
        Parent = TabsBar,
        BackgroundColor3 = Color3.fromRGB(16, 16, 16),
        BackgroundTransparency = 0.4,
        BorderSizePixel = 1,
        BorderColor3 = Color3.fromRGB(39, 39, 42),
        Size = UDim2.new(1, -12, 0, 32),
        Position = UDim2.new(0, 6, 0, 8),
        ZIndex = 3
    })
    
    Linux.Instance("UICorner", {
        Parent = SearchFrame,
        CornerRadius = UDim.new(0, 4)
    })
    
    Linux.Instance("UIStroke", {
        Parent = SearchFrame,
        Color = Color3.fromRGB(30, 30, 32),
        Thickness = 1
    })
    
    local SearchIcon = Linux.Instance("ImageLabel", {
        Parent = SearchFrame,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 16, 0, 16),
        Position = UDim2.new(0, 8, 0.5, -8),
        Image = "rbxassetid://10734943674",
        ImageColor3 = Color3.fromRGB(120, 120, 130),
        ZIndex = 3
    })
    
    local SearchBox = Linux.Instance("TextBox", {
        Parent = SearchFrame,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -32, 1, 0),
        Position = UDim2.new(0, 32, 0, 0),
        Font = Enum.Font.GothamSemibold,
        Text = "",
        PlaceholderText = "Search...",
        PlaceholderColor3 = Color3.fromRGB(120, 120, 130),
        TextColor3 = Color3.fromRGB(200, 200, 210),
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 3,
        ClearTextOnFocus = false,
        ClipsDescendants = true,
        TextTruncate = Enum.TextTruncate.AtEnd
    })
    
    local ProfileFrame = Linux.Instance("Frame", {
        Parent = TabsBar,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 65),
        Position = UDim2.new(0, 0, 1, -65),
        ZIndex = 3
    })
    
    local ProfileImage = Linux.Instance("ImageLabel", {
        Parent = ProfileFrame,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 32, 0, 32),
        Position = UDim2.new(0, 10, 0, 10),
        Image = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48),
        ZIndex = 3
    })
    
    Linux.Instance("UICorner", {
        Parent = ProfileImage,
        CornerRadius = UDim.new(1, 0)
    })
    
    local PlayerDisplayName = Linux.Instance("TextLabel", {
        Parent = ProfileFrame,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -52, 0, 16),
        Position = UDim2.new(0, 50, 0, 10),
        Font = Enum.Font.GothamSemibold,
        Text = LocalPlayer.DisplayName,
        TextColor3 = Color3.fromRGB(200, 200, 210),
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        ZIndex = 3
    })
    
    local PlayerRealName = Linux.Instance("TextLabel", {
        Parent = ProfileFrame,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -52, 0, 14),
        Position = UDim2.new(0, 50, 0, 26),
        Font = Enum.Font.GothamSemibold,
        Text = "@" .. LocalPlayer.Name,
        TextColor3 = Color3.fromRGB(150, 150, 160),
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        ZIndex = 3
    })
    
    local TabHolder = Linux.Instance("ScrollingFrame", {
        Parent = TabsBar,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 48),
        Size = UDim2.new(1, 0, 1, -113),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollBarThickness = 0,
        ZIndex = 2,
        BorderSizePixel = 1,
        BorderColor3 = Color3.fromRGB(39, 39, 42),
        ScrollingEnabled = true
    })
    
    Linux.Instance("UIListLayout", {
        Parent = TabHolder,
        Padding = UDim.new(0, 1),
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        SortOrder = Enum.SortOrder.LayoutOrder
    })
    
    Linux.Instance("UIPadding", {
        Parent = TabHolder,
        PaddingLeft = UDim.new(0, 8),
        PaddingRight = UDim.new(0, 8),
        PaddingTop = UDim.new(0, 8)
    })
    
    local Content = Linux.Instance("Frame", {
        Parent = Main,
        BackgroundColor3 = Color3.fromRGB(18, 18, 20),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, config.TabWidth or 130, 0, 30),
        Size = UDim2.new(1, -(config.TabWidth or 130), 1, -30),
        ZIndex = 1,
        BorderSizePixel = 1,
        BorderColor3 = Color3.fromRGB(39, 39, 42)
    })
    
    local originalSize = uiSize
    local minimizedSize = UDim2.new(0, uiSize.X.Offset, 0, 30)
    
    MinimizeButton.MouseEnter:Connect(function()
        TweenService:Create(MinimizeButton, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(220, 220, 230)}):Play()
    end)
    
    MinimizeButton.MouseLeave:Connect(function()
        TweenService:Create(MinimizeButton, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(180, 180, 190)}):Play()
    end)
    
    MinimizeButton.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        
        if isMinimized then
            TweenService:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = minimizedSize}):Play()
            Content.Visible = false
            TabsBar.Visible = false
            TopBarLine.Visible = false
            MinimizeButton.Image = "rbxassetid://10734886496"
            ResizeHandle.ImageTransparency = 1
            ResizeHandle.Active = false
        else
            TweenService:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = originalSize}):Play()
            Content.Visible = true
            TabsBar.Visible = true
            TopBarLine.Visible = true
            MinimizeButton.Image = "rbxassetid://10734896206"
            ResizeHandle.ImageTransparency = 1
            ResizeHandle.Active = true
        end
    end)
    
    CloseButton.MouseEnter:Connect(function()
        TweenService:Create(CloseButton, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(220, 220, 230)}):Play()
    end)
    
    CloseButton.MouseLeave:Connect(function()
        TweenService:Create(CloseButton, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(180, 180, 190)}):Play()
    end)
    
    CloseButton.MouseButton1Click:Connect(function()
        LinuxUI:Destroy()
        ToggleUI:Destroy()
    end)
    
    InputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.LeftAlt then
            isHidden = not isHidden
            Main.Visible = not isHidden
        end
    end)
    
    local LinuxLib = {}
    local Tabs = {}
    local AllElements = {}
    local CurrentTab = nil
    local tabOrder = 0
    local DefaultTab = nil
    Linux.SavedElements = {}
    
    local function AnimateTabSliders(tabIndex)
        spawn(function()
            if Tabs[tabIndex] and Tabs[tabIndex].Elements then
                for _, element in pairs(Tabs[tabIndex].Elements) do
                    if element.Type == "Slider" then
                        local slider = element.Instance
                        local fillBar = slider:FindFirstChild("Bar") and slider.Bar:FindFirstChild("Fill")
                        
                        if fillBar then
                            local currentValue = slider:GetAttribute("Value")
                            local min = slider:GetAttribute("Min")
                            local max = slider:GetAttribute("Max")
                            local targetPos = (currentValue - min) / (max - min)
                            
                            fillBar.Size = UDim2.new(0, 0, 1, 0)
                            local tween = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                            TweenService:Create(fillBar, tween, {Size = UDim2.new(targetPos, 0, 1, 0)}):Play()
                        end
                    end
                end
            end
        end)
    end
    
    local function AnimateTabTransition(newTabContent)
        spawn(function()
            local fadeOut = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            TweenService:Create(Content, fadeOut, {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -(config.TabWidth or 130) - 10, 1, -30)
            }):Play()
            
            task.wait(0.15)
            
            newTabContent.Visible = true
            local fadeIn = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            TweenService:Create(Content, fadeIn, {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -(config.TabWidth or 130), 1, -30)
            }):Play()
        end)
    end
    
    local function CheckEmptyState()
        for tabIndex, tab in pairs(Tabs) do
            if tab and tab.EmptyStateFrame then
                local hasVisibleElements = false
                for _, element in pairs(tab.Elements) do
                    if element.Instance.Visible and element.Type ~= "Section" then
                        hasVisibleElements = true
                        break
                    end
                end
                
                if hasVisibleElements then
                    tab.EmptyStateFrame.Visible = false
                    tab.Container.Visible = true
                else
                    tab.EmptyStateFrame.Visible = true
                    tab.Container.Visible = true
                end
            end
        end
    end
    
    function LinuxLib.Tab(config)
        tabOrder = tabOrder + 1
        local tabIndex = tabOrder
        
        local TabBtn = Linux.Instance("TextButton", {
            Parent = TabHolder,
            BackgroundColor3 = Color3.fromRGB(18, 18, 20),
            BackgroundTransparency = 1,
            BorderColor3 = Color3.fromRGB(39, 39, 42),
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 32),
            Font = Enum.Font.GothamSemibold,
            Text = "",
            TextColor3 = Color3.fromRGB(200, 200, 210),
            TextSize = 14,
            ZIndex = 2,
            AutoButtonColor = false,
            LayoutOrder = tabIndex
        })
        
        Linux.Instance("UICorner", {
            Parent = TabBtn,
            CornerRadius = UDim.new(0, 4)
        })
        
        local TabIcon
        if config.Icon and config.Enabled then
            TabIcon = Linux.Instance("ImageLabel", {
                Parent = TabBtn,
                BackgroundTransparency = 1,
                Size = UDim2.new(0, 18, 0, 18),
                Position = UDim2.new(0, 10, 0.5, -9),
                Image = config.Icon,
                ImageColor3 = Color3.fromRGB(150, 150, 150),
                ZIndex = 2
            })
        end
        
        local textOffset = config.Icon and config.Enabled and 33 or 16
        local TabText = Linux.Instance("TextLabel", {
            Parent = TabBtn,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, -(textOffset + 20), 1, 0),
            Position = UDim2.new(0, textOffset, 0, 0),
            Font = Enum.Font.GothamSemibold,
            Text = config.Name,
            TextColor3 = Color3.fromRGB(150, 150, 150),
            TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 2
        })
        
        local TabContent = Linux.Instance("Frame", {
            Parent = Content,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            Visible = false,
            ZIndex = 1,
            BorderSizePixel = 1,
            BorderColor3 = Color3.fromRGB(39, 39, 42)
        })
        
        local TitleFrame = Linux.Instance("Frame", {
            Parent = Content,
            BackgroundColor3 = Color3.fromRGB(9, 9, 9),
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 50),
            Position = UDim2.new(0, 0, 0, 0),
            Visible = false,
            ZIndex = 3,
            BorderSizePixel = 0,
            BorderColor3 = Color3.fromRGB(39, 39, 42)
        })
        
        local TitleLabel = Linux.Instance("TextLabel", {
            Parent = TitleFrame,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, -20, 1, 0),
            Position = UDim2.new(0, 10, 0, 0),
            Font = Enum.Font.GothamBold,
            Text = config.Name,
            TextColor3 = Color3.fromRGB(230, 230, 240),
            TextSize = 24,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center,
            ZIndex = 4
        })
        
        local Container = Linux.Instance("ScrollingFrame", {
            Parent = TabContent,
            BackgroundColor3 = Color3.fromRGB(9, 9, 9),
            BackgroundTransparency = 1,
            Size = UDim2.new(1, -16, 1, -70),
            Position = UDim2.new(0, 12, 0, 55),
            CanvasSize = UDim2.new(0, 0, 0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            ScrollBarThickness = 0,
            ZIndex = 1,
            BorderSizePixel = 0,
            BorderColor3 = Color3.fromRGB(39, 39, 42),
            ScrollingEnabled = true,
            CanvasPosition = Vector2.new(0, 0)
        })
        
        local EmptyStateFrame = Linux.Instance("Frame", {
            Parent = TabContent,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0),
            Visible = false,
            ZIndex = 5
        })
        
        local EmptyIcon = Linux.Instance("ImageLabel", {
            Parent = EmptyStateFrame,
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 80, 0, 80),
            Position = UDim2.new(0.5, -40, 0.5, -60),
            Image = "rbxassetid://10723394681",
            ImageColor3 = Color3.fromRGB(120, 120, 130),
            ZIndex = 5
        })
        
        local EmptyText = Linux.Instance("TextLabel", {
            Parent = EmptyStateFrame,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, -40, 0, 30),
            Position = UDim2.new(0, 20, 0.5, 30),
            Font = Enum.Font.GothamSemibold,
            Text = "Looks like there's nothing here",
            TextColor3 = Color3.fromRGB(120, 120, 130),
            TextSize = 16,
            TextXAlignment = Enum.TextXAlignment.Center,
            ZIndex = 5
        })
        
        local ContainerListLayout = Linux.Instance("UIListLayout", {
            Parent = Container,
            Padding = UDim.new(0, 1),
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            SortOrder = Enum.SortOrder.LayoutOrder
        })
        
        Linux.Instance("UIPadding", {
            Parent = Container,
            PaddingLeft = UDim.new(0, 2),
            PaddingTop = UDim.new(0, 0)
        })
        
        local function SelectTab()
            if CurrentTab == tabIndex then
                return
            end
            
            for _, tab in pairs(Tabs) do
                tab.Content.Visible = false
                tab.TitleFrame.Visible = false
                tab.Text.TextColor3 = Color3.fromRGB(150, 150, 150)
                tab.Button.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
                tab.Button.BackgroundTransparency = 1
                tab.Button.BorderSizePixel = 0
                
                if tab.Gradient then
                    tab.Gradient:Destroy()
                    tab.Gradient = nil
                end
                
                if tab.Icon then
                    tab.Icon.ImageColor3 = Color3.fromRGB(150, 150, 150)
                end
            end
            
            AnimateTabTransition(TabContent)
            
            TitleFrame.Visible = true
            TabText.TextColor3 = Color3.fromRGB(255, 255, 255)
            TabBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
            TabBtn.BackgroundTransparency = 0
            TabBtn.BorderSizePixel = 1
            TabBtn.BorderColor3 = Color3.fromRGB(39, 39, 42)
            
            local gradient = Linux.Instance("UIGradient", {
                Parent = TabBtn,
                Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 120, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 112))
                },
                Rotation = 40
            })
            Tabs[tabIndex].Gradient = gradient
            
            if TabIcon then
                TabIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
            end
            
            CurrentTab = tabIndex
            Container.CanvasPosition = Vector2.new(0, 0)
            
            AnimateTabSliders(tabIndex)
            
            CheckEmptyState()
        end
        
        TabBtn.MouseButton1Click:Connect(SelectTab)
        
        Tabs[tabIndex] = {
            Name = config.Name,
            Button = TabBtn,
            Text = TabText,
            Icon = TabIcon,
            Content = TabContent,
            TitleFrame = TitleFrame,
            Elements = {},
            Gradient = nil,
            EmptyStateFrame = EmptyStateFrame,
            Container = Container
        }
        
        if config.Default == true then
            DefaultTab = tabIndex
        end
        
        local TabElements = {}
        local elementOrder = 0
        local lastWasDropdown = false
        
        function TabElements.Button(config)
            elementOrder = elementOrder + 1
            if lastWasDropdown then
                ContainerListLayout.Padding = UDim.new(0, 5)
            else
                ContainerListLayout.Padding = UDim.new(0, 1)
            end
            lastWasDropdown = false
            
            local hasDescription = config.Description and config.Description ~= ""
            local frameHeight = hasDescription and 52 or 36
            
            local BtnFrame = Linux.Instance("Frame", {
                Parent = Container,
                BackgroundColor3 = Color3.fromRGB(25, 25, 25),
                BackgroundTransparency = 0.7,
                BorderColor3 = Color3.fromRGB(39, 39, 42),
                BorderSizePixel = 0,
                Size = UDim2.new(1, -8, 0, frameHeight),
                ZIndex = 1,
                LayoutOrder = elementOrder
            })
            
            Linux.Instance("UICorner", {
                Parent = BtnFrame,
                CornerRadius = UDim.new(0, 4)
            })
            
            local Btn = Linux.Instance("TextButton", {
                Parent = BtnFrame,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, hasDescription and 0.7 or 1, 0),
                Position = UDim2.new(0, 0, 0, 0),
                Font = Enum.Font.GothamSemibold,
                Text = config.Name,
                TextColor3 = Color3.fromRGB(200, 200, 210),
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 2,
                AutoButtonColor = false
            })
            
            Linux.Instance("UIPadding", {
                Parent = Btn,
                PaddingLeft = UDim.new(0, 10)
            })
            
            if hasDescription then
                Linux.Instance("TextLabel", {
                    Parent = BtnFrame,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, -20, 0.3, 0),
                    Position = UDim2.new(0, 10, 0.7, 0),
                    Font = Enum.Font.GothamSemibold,
                    Text = config.Description,
                    TextColor3 = Color3.fromRGB(150, 150, 160),
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped = true,
                    ZIndex = 2
                })
            end
            
            Btn.MouseEnter:Connect(function()
                TweenService:Create(BtnFrame, TweenInfo.new(0.2), {BackgroundTransparency = 0.5}):Play()
            end)
            
            Btn.MouseLeave:Connect(function()
                TweenService:Create(BtnFrame, TweenInfo.new(0.2), {BackgroundTransparency = 0.7}):Play()
            end)
            
            Btn.MouseButton1Down:Connect(function()
                TweenService:Create(BtnFrame, TweenInfo.new(0.1), {BackgroundTransparency = 0.3}):Play()
            end)
            
            Btn.MouseButton1Up:Connect(function()
                TweenService:Create(BtnFrame, TweenInfo.new(0.1), {BackgroundTransparency = 0.5}):Play()
            end)
            
            Btn.MouseButton1Click:Connect(function()
                Linux:PlaySound("8968249849")
                spawn(function() Linux:SafeCallback(config.Callback) end)
            end)
            
            Container.CanvasPosition = Vector2.new(0, 0)
            
            local element = {
                Type = "Button",
                Name = config.Name,
                Instance = BtnFrame
            }
            table.insert(Tabs[tabIndex].Elements, element)
            table.insert(AllElements, {Tab = tabIndex, Element = element})
            
            CheckEmptyState()
            
            return Btn
        end
        
        function TabElements.Toggle(config)
            elementOrder = elementOrder + 1
            if lastWasDropdown then
                ContainerListLayout.Padding = UDim.new(0, 5)
            else
                ContainerListLayout.Padding = UDim.new(0, 1)
            end
            lastWasDropdown = false
            
            local hasDescription = config.Description and config.Description ~= ""
            local frameHeight = hasDescription and 52 or 36
            
            local Toggle = Linux.Instance("Frame", {
                Parent = Container,
                BackgroundColor3 = Color3.fromRGB(25, 25, 25),
                BackgroundTransparency = 0.7,
                BorderColor3 = Color3.fromRGB(39, 39, 42),
                BorderSizePixel = 0,
                Size = UDim2.new(1, -8, 0, frameHeight),
                ZIndex = 1,
                LayoutOrder = elementOrder
            })
            
            Linux.Instance("UICorner", {
                Parent = Toggle,
                CornerRadius = UDim.new(0, 4)
            })
            
            local ToggleText = Linux.Instance("TextLabel", {
                Parent = Toggle,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -60, hasDescription and 0.5 or 1, 0),
                Position = UDim2.new(0, 10, 0, 0),
                Font = Enum.Font.GothamSemibold,
                Text = config.Name,
                TextColor3 = Color3.fromRGB(200, 200, 210),
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 2,
                Name = "ToggleText"
            })
            
            if hasDescription then
                Linux.Instance("TextLabel", {
                    Parent = Toggle,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, -70, 0.5, 0),
                    Position = UDim2.new(0, 10, 0.5, 0),
                    Font = Enum.Font.GothamSemibold,
                    Text = config.Description,
                    TextColor3 = Color3.fromRGB(150, 150, 160),
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped = true,
                    ZIndex = 2
                })
            end
            
            local ToggleTrack = Linux.Instance("Frame", {
                Parent = Toggle,
                BackgroundColor3 = Color3.fromRGB(18, 18, 18),
                Size = UDim2.new(0, 36, 0, 18),
                Position = UDim2.new(1, -46, 0.5, -9),
                ZIndex = 2,
                BorderSizePixel = 1,
                BorderColor3 = Color3.fromRGB(39, 39, 42),
                Name = "Track"
            })
            
            Linux.Instance("UICorner", {
                Parent = ToggleTrack,
                CornerRadius = UDim.new(1, 0)
            })
            
            Linux.Instance("UIStroke", {
                Parent = ToggleTrack,
                Color = Color3.fromRGB(60, 60, 70),
                Thickness = 1
            })
            
            local ToggleKnob = Linux.Instance("Frame", {
                Parent = ToggleTrack,
                BackgroundColor3 = Color3.fromRGB(200, 200, 210),
                Size = UDim2.new(0, 14, 0, 14),
                Position = UDim2.new(0, 2, 0.5, -7),
                ZIndex = 3,
                BorderSizePixel = 1,
                BorderColor3 = Color3.fromRGB(39, 39, 42),
                Name = "Knob"
            })
            
            Linux.Instance("UICorner", {
                Parent = ToggleKnob,
                CornerRadius = UDim.new(1, 0)
            })
            
            local State = config.Default or false
            Toggle:SetAttribute("State", State)
            
            local isToggling = false
            local function UpdateToggle(thisToggle)
                if isToggling then return end
                isToggling = true
                
                local currentState = thisToggle:GetAttribute("State")
                local thisTrack = thisToggle:FindFirstChild("Track")
                local thisKnob = thisTrack and thisTrack:FindFirstChild("Knob")
                
                if thisTrack and thisKnob then
                    local tween = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    if currentState then
                        TweenService:Create(thisTrack, tween, {BackgroundColor3 = Color3.fromRGB(0, 120, 255)}):Play()
                        TweenService:Create(thisKnob, tween, {Position = UDim2.new(0, 20, 0.5, -7), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                    else
                        TweenService:Create(thisTrack, tween, {BackgroundColor3 = Color3.fromRGB(17, 17, 18)}):Play()
                        TweenService:Create(thisKnob, tween, {Position = UDim2.new(0, 2, 0.5, -7), BackgroundColor3 = Color3.fromRGB(200, 200, 210)}):Play()
                    end
                end
                
                task.wait(0.25)
                isToggling = false
            end
            
            local function SetValue(newState)
                Toggle:SetAttribute("State", newState)
                UpdateToggle(Toggle)
                Linux:PlaySound("7761034230")
                spawn(function() Linux:SafeCallback(config.Callback, newState) end)
            end
            
            UpdateToggle(Toggle)
            spawn(function() Linux:SafeCallback(config.Callback, State) end)
            
            local function toggleSwitch()
                if not isToggling then
                    local newState = not Toggle:GetAttribute("State")
                    SetValue(newState)
                end
            end
            
            ToggleTrack.InputBegan:Connect(function(input)
                if (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1) then
                    toggleSwitch()
                end
            end)
            
            ToggleKnob.InputBegan:Connect(function(input)
                if (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1) then
                    toggleSwitch()
                end
            end)
            
            Container.CanvasPosition = Vector2.new(0, 0)
            
            local element = {
                Type = "Toggle",
                Name = config.Name,
                Instance = Toggle,
                State = State
            }
            table.insert(Tabs[tabIndex].Elements, element)
            table.insert(AllElements, {Tab = tabIndex, Element = element})
            
            table.insert(Linux.SavedElements, {
                Element = element,
                TabName = Tabs[tabIndex].Name,
                GetValue = function() return Toggle:GetAttribute("State") end,
                SetValue = SetValue
            })
            
            CheckEmptyState()
            
            return Toggle
        end
        
        function TabElements.Dropdown(config)
            elementOrder = elementOrder + 1
            lastWasDropdown = true
            
            local hasDescription = config.Description and config.Description ~= ""
            local frameHeight = hasDescription and 52 or 36
            
            local Dropdown = Linux.Instance("Frame", {
                Parent = Container,
                BackgroundColor3 = Color3.fromRGB(25, 25, 25),
                BackgroundTransparency = 0.7,
                BorderColor3 = Color3.fromRGB(39, 39, 42),
                BorderSizePixel = 0,
                Size = UDim2.new(1, -8, 0, frameHeight),
                ZIndex = 1,
                LayoutOrder = elementOrder
            })
            
            Linux.Instance("UICorner", {
                Parent = Dropdown,
                CornerRadius = UDim.new(0, 4)
            })
            
            local DropdownButton = Linux.Instance("TextButton", {
                Parent = Dropdown,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0),
                Font = Enum.Font.GothamSemibold,
                Text = "",
                TextColor3 = Color3.fromRGB(200, 200, 210),
                TextSize = 14,
                ZIndex = 2,
                AutoButtonColor = false
            })
            
            Linux.Instance("TextLabel", {
                Parent = DropdownButton,
                BackgroundTransparency = 1,
                Size = UDim2.new(0.6, 0, hasDescription and 0.5 or 1, 0),
                Position = UDim2.new(0, 10, 0, 0),
                Font = Enum.Font.GothamSemibold,
                Text = config.Name,
                TextColor3 = Color3.fromRGB(200, 200, 210),
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 2
            })
            
            if hasDescription then
                Linux.Instance("TextLabel", {
                    Parent = DropdownButton,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(0.6, -10, 0.5, 0),
                    Position = UDim2.new(0, 10, 0.5, 0),
                    Font = Enum.Font.GothamSemibold,
                    Text = config.Description,
                    TextColor3 = Color3.fromRGB(150, 150, 160),
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped = true,
                    ZIndex = 2
                })
            end
            
            local Options = config.Options or {}
            local SelectedValue = config.Default or (Options[1] or "None")
            local IsMulti = config.Multi or false
            local SelectedValues = {}
            
            if IsMulti then
                if typeof(config.Default) == "table" then
                    for _, value in pairs(config.Default) do
                        if table.find(Options, value) then
                            table.insert(SelectedValues, value)
                        end
                    end
                elseif config.Default and table.find(Options, config.Default) then
                    table.insert(SelectedValues, config.Default)
                end
            end
            
            local function FormatDisplayText(value)
                if typeof(value) == "table" then
                    if #value > 0 then
                        local displayText = table.concat(value, ", ")
                        return displayText:sub(1, 20) .. (#displayText > 20 and "..." or "")
                    else
                        return "None"
                    end
                else
                    return value and tostring(value) or "None"
                end
            end
            
            local Selected = Linux.Instance("TextLabel", {
                Parent = DropdownButton,
                BackgroundTransparency = 1,
                Size = UDim2.new(0.3, -21, hasDescription and 0.5 or 1, 0),
                Position = UDim2.new(0.65, 5, 0, 0),
                Font = Enum.Font.GothamSemibold,
                Text = IsMulti and FormatDisplayText(SelectedValues) or FormatDisplayText(SelectedValue),
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Right,
                ZIndex = 2
            })
            
            local Arrow = Linux.Instance("ImageLabel", {
                Parent = DropdownButton,
                BackgroundTransparency = 1,
                Size = UDim2.new(0, 16, 0, 16),
                Position = UDim2.new(1, -26, 0.5, -8),
                Image = "https://www.roblox.com/asset/?id=10709791437",
                ImageColor3 = Color3.fromRGB(200, 200, 200),
                Rotation = 0,
                ZIndex = 2
            })
            
            local DropFrame = Linux.Instance("Frame", {
                Parent = Container,
                BackgroundColor3 = Color3.fromRGB(21, 21, 21),
                BackgroundTransparency = 0.7,
                BorderColor3 = Color3.fromRGB(39, 39, 42),
                BorderSizePixel = 0,
                Size = UDim2.new(1, -8, 0, 0),
                ZIndex = 2,
                LayoutOrder = elementOrder + 1,
                ClipsDescendants = true,
                Visible = false
            })
            
            Linux.Instance("UICorner", {
                Parent = DropFrame,
                CornerRadius = UDim.new(0, 4)
            })
            
            local OptionsHolder = Linux.Instance("ScrollingFrame", {
                Parent = DropFrame,
                BackgroundColor3 = Color3.fromRGB(25, 25, 25),
                BackgroundTransparency = 0.7,
                Size = UDim2.new(1, 0, 1, 0),
                CanvasSize = UDim2.new(0, 0, 0, 0),
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                ScrollBarThickness = 0,
                ZIndex = 2,
                BorderSizePixel = 1,
                BorderColor3 = Color3.fromRGB(39, 39, 42),
                ScrollingEnabled = true
            })
            
            Linux.Instance("UIListLayout", {
                Parent = OptionsHolder,
                Padding = UDim.new(0, 1),
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder
            })
            
            Linux.Instance("UIPadding", {
                Parent = OptionsHolder,
                PaddingLeft = UDim.new(0, 5),
                PaddingRight = UDim.new(0, 5),
                PaddingTop = UDim.new(0, 5),
                PaddingBottom = UDim.new(0, 5)
            })
            
            local IsOpen = false
            
            local function UpdateDropSize()
                local optionHeight = 28
                local paddingBetween = 1
                local paddingTopBottom = 10
                local maxHeight = 150
                local numOptions = #Options
                local calculatedHeight = numOptions * optionHeight + (numOptions > 0 and (numOptions - 1) * paddingBetween + paddingTopBottom or 0)
                local finalHeight = math.min(calculatedHeight, maxHeight)
                
                local tween = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                
                if IsOpen then
                    DropFrame.Visible = true
                    DropFrame.Size = UDim2.new(1, -8, 0, 0)
                    TweenService:Create(DropFrame, tween, {Size = UDim2.new(1, -8, 0, finalHeight)}):Play()
                    if #Options > 0 then
                        TweenService:Create(Arrow, tween, {Rotation = 85}):Play()
                    end
                else
                    TweenService:Create(DropFrame, tween, {Size = UDim2.new(1, -8, 0, 0)}):Play()
                    if #Options > 0 then
                        TweenService:Create(Arrow, tween, {Rotation = 0}):Play()
                    end
                    task.delay(0.25, function()
                        if not IsOpen then
                            DropFrame.Visible = false
                        end
                    end)
                end
            end
            
            local function UpdateSelectedText()
                if IsMulti then
                    Selected.Text = FormatDisplayText(SelectedValues)
                else
                    Selected.Text = FormatDisplayText(SelectedValue)
                end
            end
            
            local function PopulateOptions()
                for _, child in pairs(OptionsHolder:GetChildren()) do
                    if child:IsA("TextButton") then
                        child:Destroy()
                    end
                end
                
                if IsOpen then
                    for i, opt in pairs(Options) do
                        local isSelected = IsMulti and table.find(SelectedValues, opt) or opt == SelectedValue
                        
                        local OptBtn = Linux.Instance("TextButton", {
                            Parent = OptionsHolder,
                            BackgroundColor3 = Color3.fromRGB(21, 21, 21),
                            BackgroundTransparency = 0.7,
                            BorderColor3 = Color3.fromRGB(39, 39, 42),
                            BorderSizePixel = 0,
                            Size = UDim2.new(1, -4, 0, 28),
                            Font = Enum.Font.GothamSemibold,
                            Text = tostring(opt),
                            TextColor3 = isSelected and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 210),
                            TextSize = 14,
                            ZIndex = 3,
                            AutoButtonColor = false,
                            LayoutOrder = i
                        })
                        
                        Linux.Instance("UICorner", {
                            Parent = OptBtn,
                            CornerRadius = UDim.new(0, 4)
                        })
                        
                        OptBtn.MouseButton1Click:Connect(function()
                            if IsMulti then
                                local index = table.find(SelectedValues, opt)
                                
                                if index then
                                    table.remove(SelectedValues, index)
                                    OptBtn.TextColor3 = Color3.fromRGB(200, 200, 210)
                                else
                                    table.insert(SelectedValues, opt)
                                    OptBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                                end
                                UpdateSelectedText()
                                spawn(function() Linux:SafeCallback(config.Callback, SelectedValues) end)
                            else
                                if opt ~= SelectedValue then
                                    SelectedValue = opt
                                    Selected.Text = FormatDisplayText(opt)
                                    Selected.TextColor3 = Color3.fromRGB(255, 255, 255)
                                    
                                    for _, btn in pairs(OptionsHolder:GetChildren()) do
                                        if btn:IsA("TextButton") then
                                            if btn.Text == tostring(opt) then
                                                btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                                            else
                                                btn.TextColor3 = Color3.fromRGB(200, 200, 210)
                                            end
                                        end
                                    end
                                    
                                    spawn(function() Linux:SafeCallback(config.Callback, opt) end)
                                end
                            end
                        end)
                    end
                end
                
                UpdateDropSize()
            end
            
            if #Options > 0 then
                PopulateOptions()
                if IsMulti then
                    spawn(function() Linux:SafeCallback(config.Callback, SelectedValues) end)
                else
                    spawn(function() Linux:SafeCallback(config.Callback, SelectedValue) end)
                end
            end
            
            DropdownButton.MouseButton1Click:Connect(function()
                IsOpen = not IsOpen
                PopulateOptions()
            end)
            
            local function SetOptions(newOptions)
                Options = newOptions or {}
                if IsMulti then
                    SelectedValues = {}
                else
                    SelectedValue = Options[1] or "None"
                end
                UpdateSelectedText()
                
                IsOpen = false
                UpdateDropSize()
                PopulateOptions()
                
                if IsMulti then
                    spawn(function() Linux:SafeCallback(config.Callback, SelectedValues) end)
                else
                    spawn(function() Linux:SafeCallback(config.Callback, SelectedValue) end)
                end
            end
            
            local function SetValue(value)
                if IsMulti then
                    if typeof(value) == "table" then
                        SelectedValues = {}
                        for _, v in pairs(value) do
                            if table.find(Options, v) then
                                table.insert(SelectedValues, v)
                            end
                        end
                    elseif table.find(Options, value) then
                        SelectedValues = {value}
                    end
                    UpdateSelectedText()
                else
                    if table.find(Options, value) then
                        SelectedValue = value
                        Selected.Text = FormatDisplayText(value)
                        Selected.TextColor3 = Color3.fromRGB(255, 255, 255)
                    end
                end
                
                IsOpen = false
                UpdateDropSize()
                PopulateOptions()
                
                if IsMulti then
                    spawn(function() Linux:SafeCallback(config.Callback, SelectedValues) end)
                else
                    spawn(function() Linux:SafeCallback(config.Callback, SelectedValue) end)
                end
            end
            
            Container.CanvasPosition = Vector2.new(0, 0)
            
            local element = {
                Type = "Dropdown",
                Name = config.Name,
                Instance = Dropdown,
                Value = IsMulti and SelectedValues or SelectedValue
            }
            table.insert(Tabs[tabIndex].Elements, element)
            table.insert(AllElements, {Tab = tabIndex, Element = element})
            
            table.insert(Linux.SavedElements, {
                Element = element,
                TabName = Tabs[tabIndex].Name,
                GetValue = function() return IsMulti and SelectedValues or SelectedValue end,
                SetValue = SetValue
            })
            
            CheckEmptyState()
            
            return {
                Instance = Dropdown,
                SetOptions = SetOptions,
                SetValue = SetValue,
                GetValue = function() return IsMulti and SelectedValues or SelectedValue end
            }
        end
        
        function TabElements.Slider(config)
            elementOrder = elementOrder + 1
            if lastWasDropdown then
                ContainerListLayout.Padding = UDim.new(0, 5)
            else
                ContainerListLayout.Padding = UDim.new(0, 1)
            end
            lastWasDropdown = false
            
            local hasDescription = config.Description and config.Description ~= ""
            local frameHeight = hasDescription and 58 or 42
            
            local Slider = Linux.Instance("Frame", {
                Parent = Container,
                BackgroundColor3 = Color3.fromRGB(25, 25, 25),
                BackgroundTransparency = 0.7,
                BorderSizePixel = 0,
                Size = UDim2.new(1, -8, 0, frameHeight),
                ZIndex = 1,
                LayoutOrder = elementOrder
            })
            
            Linux.Instance("UICorner", {
                Parent = Slider,
                CornerRadius = UDim.new(0, 4)
            })
            
            local TitleLabel = Linux.Instance("TextLabel", {
                Parent = Slider,
                BackgroundTransparency = 1,
                Size = UDim2.new(0.6, 0, 0, 16),
                Position = UDim2.new(0, 10, 0, 4),
                Font = Enum.Font.GothamSemibold,
                Text = config.Name,
                TextColor3 = Color3.fromRGB(200, 200, 210),
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 2
            })
            
            if hasDescription then
                Linux.Instance("TextLabel", {
                    Parent = Slider,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, -70, 0, 14),
                    Position = UDim2.new(0, 10, 0, 20),
                    Font = Enum.Font.GothamSemibold,
                    Text = config.Description,
                    TextColor3 = Color3.fromRGB(150, 150, 160),
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped = true,
                    ZIndex = 2
                })
            end
            
            local SliderBar = Linux.Instance("Frame", {
                Parent = Slider,
                BackgroundColor3 = Color3.fromRGB(16, 16, 16),
                Size = UDim2.new(1, -20, 0, 6),
                Position = UDim2.new(0, 10, 0, hasDescription and 42 or 26),
                ZIndex = 2,
                BorderSizePixel = 0,
                BorderColor3 = Color3.fromRGB(39, 39, 42),
                Name = "Bar"
            })
            
            Linux.Instance("UICorner", {
                Parent = SliderBar,
                CornerRadius = UDim.new(0, 3)
            })
            
            Linux.Instance("UIStroke", {
                Parent = SliderBar,
                Color = Color3.fromRGB(30, 30, 32),
                Thickness = 1,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            })
            
            local ValueLabel = Linux.Instance("TextLabel", {
                Parent = Slider,
                BackgroundColor3 = Color3.fromRGB(16, 16, 16),
                BackgroundTransparency = 0,
                Size = UDim2.new(0, 50, 0, 16),
                Position = UDim2.new(1, -60, 0, 4),
                Font = Enum.Font.GothamSemibold,
                Text = "",
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Center,
                ZIndex = 2,
                BorderSizePixel = 0,
                Name = "Value"
            })
            
            Linux.Instance("UICorner", {
                Parent = ValueLabel,
                CornerRadius = UDim.new(0, 4)
            })
            
            Linux.Instance("UIStroke", {
                Parent = ValueLabel,
                Color = Color3.fromRGB(30, 30, 32),
                Thickness = 1,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            })
            
            local FillBar = Linux.Instance("Frame", {
                Parent = SliderBar,
                BackgroundColor3 = Color3.fromRGB(0, 120, 255),
                Size =  UDim2.new(0, 0, 1, 0),
                ZIndex = 2,
                BorderSizePixel = 1,
                BorderColor3 = Color3.fromRGB(39, 39, 42),
                Name = "Fill"
            })
            
            Linux.Instance("UICorner", {
                Parent = FillBar,
                CornerRadius = UDim.new(1, 0)
            })
            
            local SliderButton = Linux.Instance("TextButton", {
                Parent = SliderBar,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0),
                Text = "",
                ZIndex = 3
            })
            
            local Min = config.Min or 0
            local Max = config.Max or 100
            local Rounding = config.Rounding or 0
            
            Slider:SetAttribute("Min", Min)
            Slider:SetAttribute("Max", Max)
            Slider:SetAttribute("Rounding", Rounding)
            
            local Value = config.Default or Min
            
            Slider:SetAttribute("Value", Value)
            
            local function AnimateValueLabel()
                spawn(function()
                    local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    TweenService:Create(ValueLabel, tweenInfo, {TextSize = 16}):Play()
                    task.wait(0.15)
                    TweenService:Create(ValueLabel, tweenInfo, {TextSize = 14}):Play()
                end)
            end
            
            local function FormatValue(value)
                if Rounding <= 0 then
                    return tostring(math.floor(value))
                else
                    local mult = 10 ^ Rounding
                    return tostring(math.floor(value * mult) / mult)
                end
            end
            
            local function UpdateSlider(pos)
                local barSize = SliderBar.AbsoluteSize.X
                local relativePos = math.clamp((pos - SliderBar.AbsolutePosition.X) / barSize, 0, 1)
                
                local min = Slider:GetAttribute("Min")
                local max = Slider:GetAttribute("Max")
                local rounding = Slider:GetAttribute("Rounding")
                
                local value = min + (max - min) * relativePos
                
                if rounding <= 0 then
                    value = math.floor(value + 0.5)
                else
                    local mult = 10 ^ rounding
                    value = math.floor(value * mult + 0.5) / mult
                end
                
                Slider:SetAttribute("Value", value)
                
                FillBar.Size = UDim2.new(relativePos, 0, 1, 0)
                
                ValueLabel.Text = FormatValue(value)
                
                AnimateValueLabel()
                spawn(function() Linux:SafeCallback(config.Callback, value) end)
            end
            
            local draggingSlider = false
            
            SliderButton.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
                    draggingSlider = true
                    UpdateSlider(input.Position.X)
                end
            end)
            
            SliderButton.InputChanged:Connect(function(input)
                if (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) and draggingSlider then
                    UpdateSlider(input.Position.X)
                end
            end)
            
            SliderButton.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
                    draggingSlider = false
                end
            end)
            
            local function SetValue(newValue)
                local min = Slider:GetAttribute("Min")
                local max = Slider:GetAttribute("Max")
                local rounding = Slider:GetAttribute("Rounding")
                
                newValue = math.clamp(newValue, min, max)
                
                if rounding <= 0 then
                    newValue = math.floor(newValue + 0.5)
                else
                    local mult = 10 ^ rounding
                    newValue = math.floor(newValue * mult + 0.5) / mult
                end
                
                Slider:SetAttribute("Value", newValue)
                
                local relativePos = (newValue - min) / (max - min)
                
                FillBar.Size = UDim2.new(relativePos, 0, 1, 0)
                
                ValueLabel.Text = FormatValue(newValue)
                
                AnimateValueLabel()
                spawn(function() Linux:SafeCallback(config.Callback, newValue) end)
            end
            
            SetValue(Value)
            
            Container.CanvasPosition = Vector2.new(0, 0)
            
            local element = {
                Type = "Slider",
                Name = config.Name,
                Instance = Slider,
                Value = Value
            }
            table.insert(Tabs[tabIndex].Elements, element)
            table.insert(AllElements, {Tab = tabIndex, Element = element})
            
            table.insert(Linux.SavedElements, {
                Element = element,
                TabName = Tabs[tabIndex].Name,
                GetValue = function() return Slider:GetAttribute("Value") end,
                SetValue = SetValue
            })
            
            CheckEmptyState()
            
            return {
                Instance = Slider,
                SetValue = SetValue,
                GetValue = function() return Slider:GetAttribute("Value") end,
                SetMin = function(min)
                    Slider:SetAttribute("Min", min)
                    SetValue(Slider:GetAttribute("Value"))
                end,
                SetMax = function(max)
                    Slider:SetAttribute("Max", max)
                    SetValue(Slider:GetAttribute("Value"))
                end,
                SetRounding = function(rounding)
                    Slider:SetAttribute("Rounding", rounding)
                    SetValue(Slider:GetAttribute("Value"))
                end
            }
        end
        
        function TabElements.Input(config)
            elementOrder = elementOrder + 1
            if lastWasDropdown then
                ContainerListLayout.Padding = UDim.new(0, 5)
            else
                ContainerListLayout.Padding = UDim.new(0, 1)
            end
            lastWasDropdown = false
            
            local hasDescription = config.Description and config.Description ~= ""
            local frameHeight = hasDescription and 52 or 36
            
            local Input = Linux.Instance("Frame", {
                Parent = Container,
                BackgroundColor3 = Color3.fromRGB(25, 25, 25),
                BackgroundTransparency = 0.7,
                BorderColor3 = Color3.fromRGB(39, 39, 42),
                BorderSizePixel = 0,
                Size = UDim2.new(1, -8, 0, frameHeight),
                ZIndex = 1,
                LayoutOrder = elementOrder
            })
            
            Linux.Instance("UICorner", {
                Parent = Input,
                CornerRadius = UDim.new(0, 4)
            })
            
            Linux.Instance("TextLabel", {
                Parent = Input,
                BackgroundTransparency = 1,
                Size = UDim2.new(0.6, 0, hasDescription and 0.5 or 1, 0),
                Position = UDim2.new(0, 10, 0, 0),
                Font = Enum.Font.GothamSemibold,
                Text = config.Name,
                TextColor3 = Color3.fromRGB(200, 200, 210),
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 2
            })
            
            if hasDescription then
                Linux.Instance("TextLabel", {
                    Parent = Input,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(0.6, -10, 0.5, 0),
                    Position = UDim2.new(0, 10, 0.5, 0),
                    Font = Enum.Font.GothamSemibold,
                    Text = config.Description,
                    TextColor3 = Color3.fromRGB(150, 150, 160),
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped = true,
                    ZIndex = 2
                })
            end
            
            local IsNumeric = config.Numeric or false
            
            local TextBoxFrame = Linux.Instance("Frame", {
                Parent = Input,
                BackgroundColor3 = Color3.fromRGB(16, 16, 16),
                BorderSizePixel = 0,
                Size = UDim2.new(0.3, -36, 0, 24),
                Position = UDim2.new(0.7, -20, 0.5, -12),
                ZIndex = 3
            })
            
            Linux.Instance("UICorner", {
                Parent = TextBoxFrame,
                CornerRadius = UDim.new(0, 4)
            })
            
            Linux.Instance("UIStroke", {
                Parent = TextBoxFrame,
                Color = Color3.fromRGB(30, 30, 32),
                Thickness = 1,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            })
            
            local TextBox = Linux.Instance("TextBox", {
                Parent = TextBoxFrame,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -12, 1, 0),
                Position = UDim2.new(0, 6, 0, 0),
                Font = Enum.Font.GothamSemibold,
                Text = config.Default or "",
                PlaceholderText = config.Placeholder or (IsNumeric and "Number here" or "Text here"),
                PlaceholderColor3 = Color3.fromRGB(120, 120, 130),
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 12,
                TextScaled = false,
                TextTruncate = Enum.TextTruncate.AtEnd,
                TextXAlignment = Enum.TextXAlignment.Center,
                ClearTextOnFocus = false,
                ClipsDescendants = true,
                ZIndex = 4
            })
            
            local EditIcon = Linux.Instance("ImageLabel", {
                Parent = Input,
                BackgroundTransparency = 1,
                Size = UDim2.new(0, 16, 0, 16),
                Position = UDim2.new(1, -36, 0.5, -8),
                Image = "rbxassetid://10734919691",
                ImageColor3 = Color3.fromRGB(150, 150, 160),
                ZIndex = 3
            })
            
            local MaxLength = 100
            
            local function FilterNumericInput(text)
                if not IsNumeric then
                    return text
                end
                
                local filtered = string.gsub(text, "[^%d%.%-]", "")
                
                local _, decimalCount = string.gsub(filtered, "%.", "")
                if decimalCount > 1 then
                    local firstDecimal = string.find(filtered, "%.")
                    filtered = string.sub(filtered, 1, firstDecimal) .. string.gsub(string.sub(filtered, firstDecimal + 1), "%.", "")
                end
                
                if string.find(filtered, "%-") then
                    local hasNegative = string.sub(filtered, 1, 1) == "-"
                    filtered = string.gsub(filtered, "%-", "")
                    if hasNegative then
                        filtered = "-" .. filtered
                    end
                end
                
                return filtered
            end
            
            local function CheckTextBounds()
                local currentText = TextBox.Text
                
                if IsNumeric then
                    currentText = FilterNumericInput(currentText)
                end
                
                if #currentText > MaxLength then
                    currentText = string.sub(currentText, 1, MaxLength)
                end
                
                if currentText ~= TextBox.Text then
                    TextBox.Text = currentText
                end
            end
            
            TextBox:GetPropertyChangedSignal("Text"):Connect(function()
                CheckTextBounds()
            end)
            
            local function UpdateInput()
                CheckTextBounds()
                local value = TextBox.Text
                
                if IsNumeric and value ~= "" then
                    local numValue = tonumber(value)
                    if numValue then
                        spawn(function() Linux:SafeCallback(config.Callback, numValue) end)
                    else
                        spawn(function() Linux:SafeCallback(config.Callback, 0) end)
                    end
                else
                    spawn(function() Linux:SafeCallback(config.Callback, value) end)
                end
            end
            
            TextBox.FocusLost:Connect(function(enterPressed)
                if enterPressed then
                    UpdateInput()
                end
            end)
            
            TextBox.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
                    TextBox:CaptureFocus()
                end
            end)
            
            spawn(function() 
                local value = TextBox.Text
                if IsNumeric and value ~= "" then
                    local numValue = tonumber(value)
                    Linux:SafeCallback(config.Callback, numValue or 0)
                else
                    Linux:SafeCallback(config.Callback, value)
                end
            end)
            
            local function SetValue(newValue)
                local text = tostring(newValue)
                
                if IsNumeric then
                    text = FilterNumericInput(text)
                end
                
                if #text > MaxLength then
                    text = string.sub(text, 1, MaxLength)
                end
                
                TextBox.Text = text
                UpdateInput()
            end
            
            Container.CanvasPosition = Vector2.new(0, 0)
            
            local element = {
                Type = "Input",
                Name = config.Name,
                Instance = Input,
                Value = TextBox.Text
            }
            table.insert(Tabs[tabIndex].Elements, element)
            table.insert(AllElements, {Tab = tabIndex, Element = element})
            
            table.insert(Linux.SavedElements, {
                Element = element,
                TabName = Tabs[tabIndex].Name,
                GetValue = function() 
                    if IsNumeric and TextBox.Text ~= "" then
                        return tonumber(TextBox.Text) or 0
                    else
                        return TextBox.Text
                    end
                end,
                SetValue = SetValue
            })
            
            CheckEmptyState()
            
            return {
                Instance = Input,
                SetValue = SetValue,
                GetValue = function() 
                    if IsNumeric and TextBox.Text ~= "" then
                        return tonumber(TextBox.Text) or 0
                    else
                        return TextBox.Text
                    end
                end
            }
        end
        
        function TabElements.Label(config)
            elementOrder = elementOrder + 1
            if lastWasDropdown then
                ContainerListLayout.Padding = UDim.new(0, 5)
            else
                ContainerListLayout.Padding = UDim.new(0, 1)
            end
            lastWasDropdown = false
            
            local LabelFrame = Linux.Instance("Frame", {
                Parent = Container,
                BackgroundColor3 = Color3.fromRGB(25, 25, 25),
                BackgroundTransparency = 0.7,
                 BorderColor3 = Color3.fromRGB(39, 39, 42),
                BorderSizePixel = 0,
                Size = UDim2.new(1, -8, 0, 36),
                ZIndex = 1,
                LayoutOrder = elementOrder
            })
            
            Linux.Instance("UICorner", {
                Parent = LabelFrame,
                CornerRadius = UDim.new(0, 4)
            })
            
            local LabelText = Linux.Instance("TextLabel", {
                Parent = LabelFrame,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -20, 1, 0),
                Position = UDim2.new(0, 10, 0, 0),
                Font = Enum.Font.GothamSemibold,
                Text = config.Text or "Label",
                TextColor3 = Color3.fromRGB(200, 200, 210),
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
                ZIndex = 2
            })
            
            local UpdateConnection = nil
            local lastUpdate = 0
            local updateInterval = 0.1
            
            local function StartUpdateLoop()
                if UpdateConnection then
                    UpdateConnection:Disconnect()
                    UpdateConnection = nil
                end
                if config.UpdateCallback then
                    UpdateConnection = RunService.Heartbeat:Connect(function()
                        if not LabelFrame:IsDescendantOf(game) then
                            UpdateConnection:Disconnect()
                            UpdateConnection = nil
                            return
                        end
                        local currentTime = tick()
                        if currentTime - lastUpdate >= updateInterval then
                            local success, newText = pcall(config.UpdateCallback)
                            if success and newText ~= nil then
                                LabelText.Text = tostring(newText)
                            end
                            lastUpdate = currentTime
                        end
                    end)
                end
            end
            
            local function SetText(newText)
                if config.UpdateCallback then
                    config.Text = tostring(newText)
                else
                    LabelText.Text = tostring(newText)
                end
            end
            
            if config.UpdateCallback then
                StartUpdateLoop()
            end
            
            Container.CanvasPosition = Vector2.new(0, 0)
            
            local element = {
                Type = "Label",
                Name = config.Text or "Label",
                Instance = LabelFrame
            }
            table.insert(Tabs[tabIndex].Elements, element)
            table.insert(AllElements, {Tab = tabIndex, Element = element})
            
            CheckEmptyState()
            
            return {
                Instance = LabelFrame,
                SetText = SetText,
                GetText = function() return LabelText.Text end
            }
        end
        
        function TabElements.Section(config)
            elementOrder = elementOrder + 1
            if lastWasDropdown then
                ContainerListLayout.Padding = UDim.new(0, 5)
            else
                ContainerListLayout.Padding = UDim.new(0, 1)
            end
            lastWasDropdown = false
            
            local Section = Linux.Instance("Frame", {
                Parent = Container,
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 30),
                ZIndex = 2,
                LayoutOrder = elementOrder,
                BorderSizePixel = 0,
                BorderColor3 = Color3.fromRGB(39, 39, 42),
                Name = "Section"
            })
            
            local iconOffset = 0
            local SectionIcon = nil
            
            if config.Icon then
                SectionIcon = Linux.Instance("ImageLabel", {
                    Parent = Section,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(0, 20, 0, 20),
                    Position = UDim2.new(0, 0, 0.5, -10),
                    Image = config.Icon,
                    ImageColor3 = config.TextColor or Color3.fromRGB(255, 255, 255),
                    ZIndex = 2
                })
                iconOffset = 25
            end
            
            local SectionLabel = Linux.Instance("TextLabel", {
                Parent = Section,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -20 - iconOffset, 1, 0),
                Position = UDim2.new(0, iconOffset, 0, 0),
                Font = Enum.Font.GothamBold,
                Text = config.Name,
                TextColor3 = config.TextColor or Color3.fromRGB(255, 255, 255),
                TextSize = 18,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center,
                ZIndex = 2
            })
            
            Container.CanvasPosition = Vector2.new(0, 0)
            
            local element = {
                Type = "Section",
                Name = config.Name,
                Instance = Section
            }
            table.insert(Tabs[tabIndex].Elements, element)
            table.insert(AllElements, {Tab = tabIndex, Element = element})
            
            CheckEmptyState()
            
            return Section
        end
        
        function TabElements.Paragraph(config)
            elementOrder = elementOrder + 1
            if lastWasDropdown then
                ContainerListLayout.Padding = UDim.new(0, 5)
            else
                ContainerListLayout.Padding = UDim.new(0, 1)
            end
            lastWasDropdown = false
            
            local function ProcessLineBreaks(text)
                return string.gsub(text, "/", "\n")
            end
            
            local ParagraphFrame = Linux.Instance("Frame", {
                Parent = Container,
                BackgroundColor3 = Color3.fromRGB(25, 25, 25),
                BackgroundTransparency = 0.7,
                BorderColor3 = Color3.fromRGB(39, 39, 42),
                BorderSizePixel = 0,
                Size = UDim2.new(1, -8, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                ZIndex = 1,
                LayoutOrder = elementOrder
            })
            
            Linux.Instance("UICorner", {
                Parent = ParagraphFrame,
                CornerRadius = UDim.new(0, 4)
            })
            
            Linux.Instance("TextLabel", {
                Parent = ParagraphFrame,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -20, 0, 26),
                Position = UDim2.new(0, 10, 0, 5),
                Font = Enum.Font.GothamBold,
                Text = config.Title or "Paragraph",
                TextColor3 = Color3.fromRGB(200, 200, 210),
                TextSize = 16,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 2
            })
            
            local Content = Linux.Instance("TextLabel", {
                Parent = ParagraphFrame,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -20, 0, 0),
                Position = UDim2.new(0, 10, 0, 30),
                Font = Enum.Font.GothamSemibold,
                Text = ProcessLineBreaks(config.Content or "Content"),
                TextColor3 = Color3.fromRGB(150, 150, 155),
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped = true,
                AutomaticSize = Enum.AutomaticSize.Y,
                ZIndex = 2
            })
            
            Linux.Instance("UIPadding", {
                Parent = ParagraphFrame,
                PaddingBottom = UDim.new(0, 10)
            })
            
            local function SetTitle(newTitle)
                ParagraphFrame:GetChildren()[3].Text = tostring(newTitle)
            end
            
            local function SetContent(newContent)
                Content.Text = ProcessLineBreaks(tostring(newContent))
            end
            
            Container.CanvasPosition = Vector2.new(0, 0)
            
            local element = {
                Type = "Paragraph",
                Name = config.Title or "Paragraph",
                Instance = ParagraphFrame
            }
            table.insert(Tabs[tabIndex].Elements, element)
            table.insert(AllElements, {Tab = tabIndex, Element = element})
            
            CheckEmptyState()
            
            return {
                Instance = ParagraphFrame,
                SetTitle = SetTitle,
                SetContent = SetContent
            }
        end
        
        return TabElements
    end
    
    task.spawn(function()
        task.wait(0.1)
        
        if DefaultTab and Tabs[DefaultTab] then
            for _, tab in pairs(Tabs) do
                tab.Content.Visible = false
                tab.TitleFrame.Visible = false
                tab.Text.TextColor3 = Color3.fromRGB(150, 150, 150)
                tab.Button.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
                tab.Button.BackgroundTransparency = 1
                tab.Button.BorderSizePixel = 0
                
                if tab.Gradient then
                    tab.Gradient:Destroy()
                    tab.Gradient = nil
                end
                
                if tab.Icon then
                    tab.Icon.ImageColor3 = Color3.fromRGB(150, 150, 150)
                end
            end
            
            local defaultTab = Tabs[DefaultTab]
            defaultTab.Content.Visible = true
            defaultTab.TitleFrame.Visible = true
            defaultTab.Text.TextColor3 = Color3.fromRGB(255, 255, 255)
            defaultTab.Button.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
            defaultTab.Button.BackgroundTransparency = 0
            defaultTab.Button.BorderSizePixel = 1
            defaultTab.Button.BorderColor3 = Color3.fromRGB(39, 39, 42)
            
            local gradient = Linux.Instance("UIGradient", {
                Parent = defaultTab.Button,
                Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 120, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 112))
                },
                Rotation = 40
            })
            defaultTab.Gradient = gradient
            
            if defaultTab.Icon then
                defaultTab.Icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
            end
            
            CurrentTab = DefaultTab
            
            AnimateTabSliders(DefaultTab)
        elseif tabOrder > 0 then
            CurrentTab = 1
            local firstTab = Tabs[1]
            if firstTab then
                firstTab.Content.Visible = true
                firstTab.TitleFrame.Visible = true
                firstTab.Text.TextColor3 = Color3.fromRGB(255, 255, 255)
                firstTab.Button.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
                firstTab.Button.BackgroundTransparency = 0
                firstTab.Button.BorderSizePixel = 1
                firstTab.Button.BorderColor3 = Color3.fromRGB(39, 39, 42)
                
                local gradient = Linux.Instance("UIGradient", {
                    Parent = firstTab.Button,
                    Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 120, 255)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 112))
                    },
                    Rotation = 40
                })
                firstTab.Gradient = gradient
                
                if firstTab.Icon then
                    firstTab.Icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
                end
                
                AnimateTabSliders(1)
            end
        end
    end)
    
    if config.ConfigSave ~= false then
        local SettingsTab = LinuxLib.Tab({
            Name = "Settings",
            Icon = "rbxassetid://10734950309",
            Enabled = true
        })
        
        SettingsTab.Section({Name = "Configuration"})
        
        local configNameInput = SettingsTab.Input({
            Name = "Config Name",
            Placeholder = "Config",
            Default = Linux.CurrentConfig,
            Callback = function(text)
                Linux.CurrentConfig = text
            end
        })
        
        Linux.LoadConfigList()
        
        local configListDropdown = SettingsTab.Dropdown({
            Name = "Config List",
            Options = Linux.SavedConfigs,
            Default = Linux.SavedConfigs[1] or "--",
            Callback = function(selected)
                configNameInput.SetValue(selected)
                Linux.CurrentConfig = selected
            end
        })
        
        SettingsTab.Button({
            Name = "Create Config",
            Callback = function()
                Linux.SaveConfig(Linux.CurrentConfig)
                Linux.LoadConfigList()
                configListDropdown.SetOptions(Linux.SavedConfigs)
            end
        })
        
        SettingsTab.Button({
            Name = "Load Config",
            Callback = function()
                Linux.LoadConfig(Linux.CurrentConfig)
            end
        })
        
        SettingsTab.Button({
            Name = "Delete Config",
            Callback = function()
                Linux.DeleteConfig(Linux.CurrentConfig)
                Linux.LoadConfigList()
                configListDropdown.SetOptions(Linux.SavedConfigs)
                if #Linux.SavedConfigs > 0 then
                    configNameInput.SetValue(Linux.SavedConfigs[1])
                    Linux.CurrentConfig = Linux.SavedConfigs[1]
                else
                    configNameInput.SetValue("")
                    Linux.CurrentConfig = ""
                end
            end
        })
    end
    
    SearchBox.Changed:Connect(function(property)
        if property == "Text" then
            local searchText = string.lower(SearchBox.Text)
            
            for _, tab in pairs(Tabs) do
                local tabMatches = searchText == "" or string.find(string.lower(tab.Name), searchText) ~= nil
                local elementsMatch = false
                
                for _, element in pairs(tab.Elements) do
                    if searchText == "" then
                        element.Instance.Visible = true
                    else
                        local elementName = string.lower(element.Name or "")
                        element.Instance.Visible = string.find(elementName, searchText) ~= nil
                        if element.Instance.Visible then
                            elementsMatch = true
                        end
                    end
                end
                
                tab.Button.Visible = tabMatches or elementsMatch
            end
            
            CheckEmptyState()
        end
    end)
    
    function LinuxLib.Destroy()
        for _, v in pairs(game:GetService("CoreGui"):GetChildren()) do
            if v:IsA("ScreenGui") and v.Name:match("^UI_%d+$") then
                v:Destroy()
            end
        end
    end
    
    return LinuxLib
end
return Linux
