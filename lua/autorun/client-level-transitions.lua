-- Addon Name: HL2 Campaign Loading Screen
-- Author: iceman_twitch
-- Email: iceman.twitch.contact@gmail.com
-- Website: linktr.ee/iceman_twitch
-- Version: 0.13v 2025/02/11-13:28

-- Description:
-- This addon enhances the loading screen experience for the HL2 Campaign gamemode in Garry’s Mod. It features a custom HTML-based loading screen that dynamically saves a screenshot every time the player reaches the end of a map. The saved screenshot is then displayed during the next loading screen, providing a seamless and immersive transition between maps.

-- Key Features:

    -- Custom HTML loading screen for a personalized look.

    -- Automatically captures and displays in-game screenshots at the end of each map.

    -- Deletes the screenshot file upon loading to save space.

-- Known Issues:

    -- Does not check which map the player is transitioning to.

    -- Lacks specific map file naming for screenshots.

    -- Currently tied to the HL2 Campaign gamemode (compatibility with other gamemodes is planned).

-- Future Plans:

    -- Make the addon compatible with gamemodes other than HL2 Campaign.

    -- Improve map detection and screenshot file naming for better organization.

if CLIENT then
local tag = "[HL2-LoadingScreen]: "
local author = "iceman_twitch"
local email = "iceman.twitch.contact@gmail.com"
local website = "linktr.ee/iceman_twitch"
local version = "0.13v 2025/02/11-13:28"
local aaaaaaaaaa = print
local function print(...)
    local a = ...
    local b = tag .. a
    aaaaaaaaaa(b)
end
local lEP, lEA
hook.Add("PostDrawTranslucentRenderables", "LevelTransitions_EyePos", function()
    lEP, lEA = EyePos(), EyeAngles() 
end)
hook.Add("InitPostEntity", "LevelTransition_ImageDelete", function()
    file.Delete("map_transition.png")
end)
print("author: "..author)
print("email: "..email)
print("website: "..website)
print("version: "..version)
print"Init"
function LevelTransitions_Capture()
    print"Capture Called"
    gui.HideGameUI()
    file.Delete("hl2-campaign-loading/map_transition.png")
    print"Deleted Previous Image"
    timer.Simple( 0, function()
        
        if not file.Exists("hl2-campaign-loading", "DATA") then
            file.Write"hl2-campaign-loading"
        end
        render.RenderView({
              origin = lEP, angles = lEA,
              x = 0, y = 0,
              w = ScrW(), h = ScrH(),
              zfar = 16000;
              -- do you need FOV? nah lol
            })  
        local data = render.Capture( {
            format = "png",
            x = 0,
            y = 0,
            w = ScrW(),
            h = ScrH(),
            quality = 70, -- 
            alpha = false, -- only needed for the png format to prevent the depth buffer leaking in, see BUG
        } )
        print"Captured Screenshot"
        file.Write("hl2-campaign-loading/map_transition.png", data )
        print"Saved Screenshot"
    end)
end
-- hook.Add("ShutDown", "LevelTransitions_DoCapture", LevelTransitions_Capture)
net.Receive( "trigger_changelevel_touch", function( len, ply )
    LevelTransitions_Capture()
end)

end