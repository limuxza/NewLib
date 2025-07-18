local Linux = {}

function Linux.Create(config)
    local ui = {}
    local player = game.Players.LocalPlayer
    local playerGui = player.PlayerGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = config.Name
    screenGui.ResetOnSpawn = true
    screenGui.Parent = playerGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = config.Size or UDim2.new(0, 200, 0, 250)
    mainFrame.Position = UDim2.new(0.5, -(config.Size and config.Size.X.Offset or 200)/2, 0.5, -(config.Size and config.Size.Y.Offset or 250)/2)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    mainFrame.BackgroundTransparency = 0
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui

    local scrollingFrame = Instance.new("ScrollingFrame")
    scrollingFrame.Size = UDim2.new(1, -10, 1, -40)
    scrollingFrame.Position = UDim2.new(0, 5, 0, 35)
    scrollingFrame.BackgroundTransparency = 0
    scrollingFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    scrollingFrame.ScrollBarThickness = 4
    scrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
    scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    scrollingFrame.Parent = mainFrame

    local uiLayout = Instance.new("UIListLayout")
    uiLayout.Padding = UDim.new(0, 5)
    uiLayout.Parent = scrollingFrame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 25)
    titleLabel.Position = UDim2.new(0, 0, 0, 5)
    titleLabel.Text = config.Name
    titleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    titleLabel.BackgroundTransparency = 0
    titleLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextSize = 18
    titleLabel.BorderSizePixel = 0
    titleLabel.Parent = mainFrame

    local function updateCanvasSize()
        scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, uiLayout.AbsoluteContentSize.Y + 10)
    end
    uiLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvasSize)

    function ui:AddButton(text, callback)
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, -10, 0, 30)
        button.Text = text
        button.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Font = Enum.Font.SourceSans
        button.TextSize = 16
        button.BorderSizePixel = 0
        button.Parent = scrollingFrame
        button.Activated:Connect(function()
            if callback then
                callback()
            end
        end)
        updateCanvasSize()
        return button
    end

    function ui:AddToggle(text, defaultState, callback)
        local toggleFrame = Instance.new("Frame")
        toggleFrame.Size = UDim2.new(1, -10, 0, 30)
        toggleFrame.BackgroundTransparency = 0
        toggleFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        toggleFrame.Parent = scrollingFrame

        local toggleLabel = Instance.new("TextLabel")
        toggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
        toggleLabel.Text = text
        toggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        toggleLabel.BackgroundTransparency = 1
        toggleLabel.Font = Enum.Font.SourceSans
        toggleLabel.TextSize = 16
        toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
        toggleLabel.Parent = toggleFrame

        local toggleButton = Instance.new("TextButton")
        toggleButton.Size = UDim2.new(0, 40, 0, 20)
        toggleButton.Position = UDim2.new(1, -45, 0.5, -10)
        toggleButton.Text = defaultState and "ON" or "OFF"
        toggleButton.BackgroundColor3 = defaultState and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
        toggleButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        toggleButton.Font = Enum.Font.SourceSans
        toggleButton.TextSize = 14
        toggleButton.BorderSizePixel = 0
        toggleButton.Parent = toggleFrame

        local state = defaultState
        toggleButton.Activated:Connect(function()
            state = not state
            toggleButton.Text = state and "ON" or "OFF"
            toggleButton.BackgroundColor3 = state and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
            if callback then
                callback(state)
            end
        end)
        updateCanvasSize()
        return toggleFrame
    end

    function ui:AddLabel(text)
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -10, 0, 25)
        label.Text = text
        label.TextColor3 = Color3.fromRGB(200, 200, 200)
        label.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        label.BackgroundTransparency = 0
        label.Font = Enum.Font.SourceSans
        label.TextSize = 14
        label.BorderSizePixel = 0
        label.Parent = scrollingFrame
        updateCanvasSize()
        return label
    end

    return ui
end

return Linux
