-- Hammerspoon config

-- "local" = variables
local tink_sound  = hs.sound.getByName("Tink") -- Sounds in /System/Library/Sounds

-- Set up hotkey combinations
local mash      = {"cmd", "alt", "ctrl"}
local mashshift = {"cmd", "alt", "shift"}
local funkymash = {"cmd", "ctrl", "shift"}

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
-- Set window animation off. It's much smoother.
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

-- agrandir largeur
hs.hotkey.bind(mash,      '=', function() hs.grid.adjustWidth(1)   end)

-- reduire largeur
hs.hotkey.bind(mash,      '-', function() hs.grid.adjustWidth(-1)  end)

-- agrandir hauteur
hs.hotkey.bind(mashshift, '=', function() hs.grid.adjustHeight(1)  end)

-- reduire hauteur
hs.hotkey.bind(mashshift, '-', function() hs.grid.adjustHeight(-1) end)

-- focus sur fenetre
-- hs.hotkey.bind(mash, 'left',  function() hs.window.focusedWindow():focusWindowWest()  end)
-- hs.hotkey.bind(mash, 'right', function() hs.window.focusedWindow():focusWindowEast()  end)
-- hs.hotkey.bind(mash, 'up',    function() hs.window.focusedWindow():focusWindowNorth() end)
-- hs.hotkey.bind(mash, 'down',  function() hs.window.focusedWindow():focusWindowSouth() end)

-- maximiser la fenetre
hs.hotkey.bind(mash, 'M', hs.grid.maximizeWindow)

-- fullscreen active/desactive
hs.hotkey.bind(mash, 'F', function() hs.window.focusedWindow():toggleFullScreen() end)

-- hs.hotkey.bind(mash, 'N', hs.grid.pushWindowNextScreen)
-- hs.hotkey.bind(mash, 'P', hs.grid.pushWindowPrevScreen)

-- hs.hotkey.bind(mash, 'D', hs.grid.pushWindowDown)
-- hs.hotkey.bind(mash, 'U', hs.grid.pushWindowUp)
-- hs.hotkey.bind(mash, 'L', hs.grid.pushWindowLeft)
-- hs.hotkey.bind(mash, 'R', hs.grid.pushWindowRight)

hs.hotkey.bind(mash, 'down', hs.grid.resizeWindowTaller)
hs.hotkey.bind(mash, 'right', hs.grid.resizeWindowWider)
hs.hotkey.bind(mash, 'left', hs.grid.resizeWindowThinner)
hs.hotkey.bind(mash, 'up', hs.grid.resizeWindowShorter)

-- battery status
hs.hotkey.bind(mash, 'B', function ()
  hs.alert.show("Battery: " .. hs.battery.percentage() .. "%", 4)
  end)

-- what is my ip
hs.hotkey.bind(mash, "i", function ()
  status, data, headers = hs.http.get("http://ip.wains.be")
  hs.alert.show("Your IP is " .. data, 4)
  end)

-- what is my ip
hs.hotkey.bind(mash, "o", function ()
  status, data, headers = hs.http.get("http://monit.wains.be/cgi-bin/weather.sh")
  hs.alert.show(data, 4)
  end)

-- connected Wi-Fi
hs.hotkey.bind(mash, 'w', function ()
  hs.alert.show("Wi-Fi connected to " .. hs.wifi.currentNetwork(), 4)
  end)

-- afficher la date
hs.hotkey.bind(mash, 'D', function() hs.alert.show(os.date("%A %b %d, %Y - %I:%M%p"), 4) end)



-- do this at the end of parsing the conf
tink_sound:play()
hs.alert.show("Hammerspoon is ready, press cmd + ctrl + alt + h for help", 4)
