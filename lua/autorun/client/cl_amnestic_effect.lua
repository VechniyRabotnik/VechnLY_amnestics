include("amnestic_config.lua")

local AmnesticTypes = {
    ["D"] = "amenstic_d",
    ["A"] = "amenstic_a",
    ["B"] = "amenstic_b",
    ["H"] = "amenstic_h",
    ["d"] = "amenstic_d",
    ["a"] = "amenstic_a",
    ["b"] = "amenstic_b",
    ["h"] = "amenstic_h",
}

local function MainEffect(time, text)
    hook.Add("RenderScreenspaceEffects", "AmnesticEffect1", function()
        DrawColorModify(AmnesticConfig.Effects.ColorModify)
        DrawMotionBlur(unpack(AmnesticConfig.Effects.MotionBlur))
        DrawBloom(unpack(AmnesticConfig.Effects.Bloom))
        DrawMaterialOverlay(AmnesticConfig.Effects.Overlay, 0)
        local text = "????"
         surface.SetFont("font.50")
local textWidth, textHeight = surface.GetTextSize(text)

        local positions = {}
        for i = 1, #text do
            local posX = math.random(0, ScrW() - textWidth)
            local posY = math.random(0, ScrH() - textHeight)
            positions[i] = { x = posX, y = posY }
        end

        
        surface.SetTextColor(255, 255, 255, 255)

        for i = 1, #text do
            local char = text:sub(i, i)
            local charWidth, charHeight = surface.GetTextSize(char)

            local charOffsetX = math.sin(CurTime() * 0.2 + i * 2) * 3
            local charOffsetY = math.cos(CurTime() * 0.2 + i * 2) * 3

            surface.SetTextPos(positions[i].x + charOffsetX, positions[i].y + charOffsetY)
            surface.DrawText(char)
        end
    end)
            
local targetFOV = 90 
local startingFOV = 20 
local transitionTime = 10 
local heartbeatInterval = 1 
local heartbeatStrength = 7 
local startTime = CurTime() 
local lastHeartbeat = startTime 

hook.Add("CalcView", "fovamnestic", function()
    local view = {}

    local currentTime = CurTime()
    local deltaTime = currentTime - startTime

    
    local newFOV = Lerp(math.min(1, deltaTime / transitionTime), targetFOV, startingFOV)

    
    if currentTime - lastHeartbeat >= heartbeatInterval then
        
        newFOV = newFOV + heartbeatStrength
        lastHeartbeat = currentTime
    end

    view.fov = newFOV

    return view
end)
    
    surface.PlaySound(AmnesticConfig.Effects.HeartbeatSound)
    local soundTimerName = "HeartbeatSoundTimer"
    timer.Create(soundTimerName, 1, 0, function()
        surface.PlaySound(AmnesticConfig.Effects.HeartbeatSound)
    end)
    
    timer.Simple(time, function()
        hook.Remove("RenderScreenspaceEffects", "AmnesticEffect1")
         hook.Remove("CalcView", "fovamnestic")
         timer.Remove(soundTimerName)
    end)
end

local function AmnesticClassD()
        
        
        local soundType = "D"

        timer.Simple(3, function()
            
            surface.PlaySound(AmnesticConfig.Effects.BackgroundSound[soundType])
            MainEffect(3, "??????????")
        end)

        timer.Simple(9, function()
            
            MainEffect(5, "??????????")
        end)
        timer.Simple(17, function()
            
            MainEffect(8, "??????????")
        end)
        timer.Simple(27, function()
            
            MainEffect(8, "??????????")
        end)
        timer.Simple(35, function()
            hook.Add("HUDPaint", "BlackScreen", function()
                surface.SetDrawColor(0, 0, 0, 255)
                surface.DrawRect(0, 0, ScrW(), ScrH())
            end)
           net.Start("SetJobForAmnesticPlayer")
           net.WriteEntity(LocalPlayer())
           net.SendToServer()
           net.Start("SetAmnesticValueToAvoid")
           net.WriteBool(false)
           net.WriteEntity(LocalPlayer())
           net.SendToServer()
          surface.PlaySound(AmnesticConfig.Effects.EndSound)
        
            timer.Simple(5, function()
                hook.Remove("HUDPaint", "BlackScreen")
                 LocalPlayer():ConCommand("stopsound") 
            end)
        end)
end

local function AmnesticClassA(textToShow)

    local soundType = "A"
        timer.Simple(3, function()
            surface.PlaySound(AmnesticConfig.Effects.BackgroundSound[soundType])
            MainEffect(3, "??????????")
        end)
    
        timer.Simple(9, function()
            
            MainEffect(5, "??????????")
        end)
        timer.Simple(17, function()
            
            MainEffect(8, "??????????")
        end)
        timer.Simple(25, function()
        local alpha = 0 
        local fadeSpeed = 1 

        hook.Add("HUDPaint", "BlackScreen", function()
            
            surface.SetDrawColor(0, 0, 0, 255)
            surface.DrawRect(0, 0, ScrW(), ScrH())

            
            alpha = math.Clamp(alpha + fadeSpeed, 0, 255)
            draw.SimpleText(textToShow, "font.40", ScrW() / 2, ScrH() / 2, Color(255, 255, 255, alpha), TEXT_ALIGN_CENTER)
        end)
           net.Start("SetAmnesticValueToAvoid")
           net.WriteBool(false)
           net.WriteEntity(LocalPlayer())
           net.SendToServer()
           surface.PlaySound(AmnesticConfig.Effects.EndSound)
        
            timer.Simple(5, function()
                hook.Remove("HUDPaint", "BlackScreen")
                 LocalPlayer():ConCommand("stopsound") 
            end)
        end)
end

local function AmnesticClassB()
     

        local soundType = "B"
        
        timer.Simple(3, function()
           
            surface.PlaySound(AmnesticConfig.Effects.BackgroundSound[soundType])
            MainEffect(3, "??????????")
        end)

        timer.Simple(9, function()
            
            MainEffect(5, "??????????")
        end)
        timer.Simple(17, function()
           
            MainEffect(8, "??????????")
        end)
        timer.Simple(27, function()
           
            MainEffect(8, "??????????")
        end)
        timer.Simple(35, function()
            hook.Add("HUDPaint", "BlackScreen", function()
                surface.SetDrawColor(0, 0, 0, 255)
                surface.DrawRect(0, 0, ScrW(), ScrH())
            end)
           net.Start("KillPlayerAmnestic")
           net.WriteEntity(LocalPlayer())
           net.SendToServer()
           net.Start("SetAmnesticValueToAvoid")
           net.WriteBool(false)
           net.WriteEntity(LocalPlayer())
           net.SendToServer()
           surface.PlaySound(AmnesticConfig.Effects.EndSound)
        
            timer.Simple(5, function()
                hook.Remove("HUDPaint", "BlackScreen")
                 LocalPlayer():ConCommand("stopsound") 
            end)
        end)
end

local function ContusionEffectNew()
    
    if LocalPlayer():GetNWBool("amnestic_activated", false) then
    local screenWidth, screenHeight = ScrW(), ScrH()

    DrawColorModify(AmnesticConfig.Effects.ColorModify)
    DrawMotionBlur(unpack(AmnesticConfig.Effects.MotionBlur))
    DrawBloom(unpack(AmnesticConfig.Effects.Bloom))
    DrawMaterialOverlay(AmnesticConfig.Effects.Overlay, 0)
  else
        LocalPlayer():ConCommand("stopsound") 
        hook.Remove("RenderScreenspaceEffects", "ContusionEffect")
  end
end

local function HEffect()

    local soundType = "H"

   timer.Simple(3, function()
    
    hook.Add("RenderScreenspaceEffects", "ContusionEffect", ContusionEffectNew)
        surface.PlaySound(AmnesticConfig.Effects.BackgroundSound[soundType])
   end)
    timer.Simple(343, function()
            hook.Remove("RenderScreenspaceEffects", "ContusionEffect")
            net.Start("SetAmnesticValueToAvoid")
           net.WriteBool(false)
           net.WriteEntity(LocalPlayer())
   end)
end

local function AmnesticClassH()
    HEffect()
end

net.Receive("activated_effect_amnestic", function()
     local amnestic_type = net.ReadString()
     local typefrom = AmnesticTypes[amnestic_type]
     if typefrom == "amenstic_d" then
            AmnesticClassD()
     elseif typefrom == "amenstic_a" then
            AmnesticClassA(AmnesticConfig.GetText("ForgetHours"))
     elseif typefrom == "amenstic_b" then
          AmnesticClassB()
     elseif typefrom == "amenstic_h" then
            AmnesticClassH()
     end
end)

