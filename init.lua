-- Hammerspoon config

-- "local" = variables
local tink_sound  = hs.sound.getByName("Tink") -- Sounds in /System/Library/Sounds

-- Set up hotkey combinations
local mashsshh      = {"cmd", "alt", "ctrl"}
local mashshift = {"cmd", "alt", "shift"}
local mash = {"cmd", "ctrl", "shift"}

-- application help
local function open_help()
  help_str = "cmd + alt + ctrl\n" ..
  "t: Terminal\n" ..
  "n: Firefox\n" ..
  "k: KeepassX"
  hs.alert.show(
   help_str, 2)
end

-- Set grid size.
hs.grid.GRIDWIDTH  = 7
hs.grid.GRIDHEIGHT = 3
hs.grid.MARGINX    = 0
hs.grid.MARGINY    = 0
-- No animation
hs.window.animationDuration = 0
-- Set volume increments
local volumeIncrement = 5

hs.hotkey.bind(mash, 'h', open_help)

-- apps
hs.hotkey.bind(mash, 't', function () hs.application.launchOrFocus("terminal") end)
hs.hotkey.bind(mash, 'n', function () hs.application.launchOrFocus("Firefox") end)
hs.hotkey.bind(mash, 'k', function () hs.application.launchOrFocus("KeepassX") end)

--
hs.hotkey.bind(mash, ';', function() hs.grid.snap(hs.window.focusedWindow()) end)
hs.hotkey.bind(mash, "'", function() hs.fnutils.map(hs.window.visibleWindows(), hs.grid.snap) end)

-- larger width
hs.hotkey.bind(mash,      '=', function() hs.grid.adjustWidth(1)   end)

-- reduce width
hs.hotkey.bind(mash,      '-', function() hs.grid.adjustWidth(-1)  end)

-- larger height
hs.hotkey.bind(mashshift, '=', function() hs.grid.adjustHeight(1)  end)

-- lower height
hs.hotkey.bind(mashshift, '-', function() hs.grid.adjustHeight(-1) end)

-- focus on window
-- hs.hotkey.bind(mash, 'left',  function() hs.window.focusedWindow():focusWindowWest()  end)
-- hs.hotkey.bind(mash, 'right', function() hs.window.focusedWindow():focusWindowEast()  end)
-- hs.hotkey.bind(mash, 'up',    function() hs.window.focusedWindow():focusWindowNorth() end)
-- hs.hotkey.bind(mash, 'down',  function() hs.window.focusedWindow():focusWindowSouth() end)

-- maximize window
hs.hotkey.bind(mash, 'M', hs.grid.maximizeWindow)

-- fullscreen enabled/disabled
hs.hotkey.bind(mash, 'F', function() hs.window.focusedWindow():toggleFullScreen() end)

-- not using this right now
-- hs.hotkey.bind(mash, 'N', hs.grid.pushWindowNextScreen)
-- hs.hotkey.bind(mash, 'P', hs.grid.pushWindowPrevScreen)
-- hs.hotkey.bind(mash, 'D', hs.grid.pushWindowDown)
-- hs.hotkey.bind(mash, 'U', hs.grid.pushWindowUp)
-- hs.hotkey.bind(mash, 'L', hs.grid.pushWindowLeft)
-- hs.hotkey.bind(mash, 'R', hs.grid.pushWindowRight)

-- windows resizing
hs.hotkey.bind(mash, 'down', hs.grid.resizeWindowTaller)
hs.hotkey.bind(mash, 'right', hs.grid.resizeWindowWider)
hs.hotkey.bind(mash, 'left', hs.grid.resizeWindowThinner)
hs.hotkey.bind(mash, 'up', hs.grid.resizeWindowShorter)

-- caffeine replacement
local caffeine = hs.menubar.new()
function setCaffeineDisplay(state)
    if state then
        -- awake
        caffeine:setTitle("✔")
    else
        -- sleepy
        caffeine:setTitle("✖")
    end
end

function caffeineClicked()
    setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end

if caffeine then
    caffeine:setClickCallback(caffeineClicked)
    setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
end
-- caffeine end

-- clearing clipboard
hs.hotkey.bind(mash, 'C', function()
  hs.applescript('do shell script "echo | pbcopy"')
  hs.alert.show("Clipboard cleared!", 4)
end)

-- battery status
hs.hotkey.bind(mash, 'B', function ()
  hs.alert.show("Battery: " .. hs.battery.percentage() .. "%", 4)
  end)

-- what is my ip, copying the IP in clipboard
hs.hotkey.bind(mash, "i", function ()
  status, data, headers = hs.http.get("http://ip.wains.be")
  hs.applescript('do shell script "echo " .. data .. " | pbcopy"')
  hs.alert.show("Your IP is " .. data, 4)
  end)

-- weather
hs.hotkey.bind(mash, "o", function ()
  hs.alert.show("Retrieving weather info...", 1)
  status, data, headers = hs.http.get("http://monit.wains.be/cgi-bin/weather.sh")
  hs.alert.show("Current weather in Brussels:\n" .. data, 4)
  end)

-- connected Wi-Fi
hs.hotkey.bind(mash, 'w', function ()
  hs.alert.show("Wi-Fi connected to " .. hs.wifi.currentNetwork(), 4)
  end)

-- displaying date
hs.hotkey.bind(mash, 'D', function() hs.alert.show(os.date("%A %b %d, %Y - %I:%M%p"), 4) end)

-- do this at the end of parsing the conf
tink_sound:play()
hs.alert.show("Hammerspoon is ready, press cmd + ctrl + alt + h for help", 4)
