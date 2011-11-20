import XMonad
import XMonad.Layout.NoBorders
import XMonad.Layout.Accordion
import XMonad.Util.EZConfig
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.UrgencyHook
import Graphics.X11.ExtraTypes.XF86

import qualified Data.Map as M
import qualified XMonad.StackSet as W

--main = xmonad =<< xmobar myConfig
main = xmonad $ withUrgencyHook dzenUrgencyHook { args = ["-bg", "darkgreen", "-xs", "1"] }
              $ myConfig

myConfig = defaultConfig {
    terminal     = "urxvtc"
    , modMask    = mod1Mask -- Alt
    , layoutHook = noBorders (Full ||| Accordion)
  }
  `removeKeysP` [
    "M-n"         -- Resize viewed windows to the correct size
    , "M-w"       -- Switch to physical/Xinerama screens 1
    , "M-e"       -- Switch to physical/Xinerama screens 2
    , "M-r"       -- Switch to physical/Xinerama screens 3
    , "M-h"       -- Shrink the master area
    , "M-l"       -- Extend the master area
    , "M-j"       -- Next window
    , "M-k"       -- Prev window
    , "M-m"       -- Master window
    , "M-p"       -- Bin menu
    , "M-<Enter>" -- Swap focused/master windows
    , "M-<Space>" -- Rotate layout algorithm
    , "M-<Tab>"   -- Toggle windows
    , "M-S-p"     -- gmrun
  ]
  `removeKeysP` ["M-" ++ [n] | n <- ['1'..'9']] -- Workspace switch
  `additionalKeysP` [
      ("C-<Space>", windows W.focusDown)
    , ("M-o", spawn "~/.scripts/path-dmenu")
    , ("M-r", spawn "urxvtc -e ranger")
    , ("M-a", spawn "urxvtc -e alsamixer")
    , ("M-m", spawn "urxvtc -e mutt")
    , ("M-S-b", spawn "firefox")
    , ("M-s", spawn "urxvtc -e ~/.scripts/music ui")
    , ("M-t", spawn "urxvtc -e ~/.scripts/music toggle")
    , ("C-m", spawn "/home/thib/.scripts/touchpad_toggle")
  ]
  `additionalKeys` [
      ((0, xF86XK_AudioMute), spawn "amixer -q set PCM toggle")
    , ((0, xF86XK_AudioRaiseVolume), spawn "amixer -q set PCM 2+")
    , ((0, xF86XK_AudioLowerVolume), spawn "amixer -q set PCM 2-")
    , ((0, xK_Print), spawn "screenshot")                    -- Take a screenshot
  ]
