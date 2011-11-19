import XMonad
import XMonad.Layout.NoBorders
import XMonad.Layout.Accordion
import XMonad.Util.EZConfig
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.UrgencyHook

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
    , "M-j"       -- Next window
    , "M-k"       -- Prev window
    , "M-m"       -- Master window
    , "M-p"       -- Bin menu
    , "M-<Enter>" -- Swap focused/master windows
    , "M-<Space>" -- Rotate layout algorithm
    , "M-<Tab>"
    , "M-S-p"     -- gmrun
  ]
  `removeKeysP` ["M-" ++ [n] | n <- ['1'..'9']] -- Workspace switch
  `additionalKeysP` [
      ("C-<Space>", windows W.focusDown)
    , ("M-u", focusUrgent)
    , ("M-r", spawn "urxvtc -e ranger")
    , ("M-a", spawn "urxvtc -e alsamixer")
    , ("M-m", spawn "urxvtc -e mutt")
    , ("M-s", spawn "urxvtc -e ~/.scripts/music ui")
    , ("M-t", spawn "urxvtc -e ~/.scripts/music toggle")
    , ("M-S-b", spawn "firefox")
    , ("C-m", spawn "/home/thib/.scripts/touchpad_toggle")
  ]
  `additionalKeys` [
      ((0, 0x1008FF13), spawn "amixer -q set PCM 5+ unmute")     -- Audio raise volume
    , ((0, 0x1008FF11), spawn "amixer -q set PCM 5- unmute")     -- Audio lower volume
  ]
