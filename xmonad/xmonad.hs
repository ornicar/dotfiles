import XMonad
import XMonad.Layout.NoBorders
import XMonad.Layout.Accordion
import XMonad.Util.EZConfig
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.ManageHelpers
import Graphics.X11.ExtraTypes.XF86

import qualified XMonad.StackSet as W

main = xmonad $ withUrgencyHook dzenUrgencyHook { args = ["-bg", "darkgreen", "-xs", "1"] }
              $ myConfig

------------------------------------------------------------------------
-- Workspaces
-- The default number of workspaces (virtual screens) and their names.
--
myWorkspaces = ["1:system","2:main","3:network"] ++ map show [4..6]

------------------------------------------------------------------------
-- Window rules
-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "Firefox"        --> doShift "2:main"
    , resource  =? "Skype"          --> doFloat
    , isFullscreen --> (doF W.focusDown <+> doFullFloat)]

myConfig = defaultConfig {
      terminal   = "urxvtc -e ~/.tmux/menu"
    , modMask    = mod1Mask -- Alt
    , layoutHook = noBorders Full
    , manageHook = myManageHook
    , workspaces = myWorkspaces
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
    , "M-S-<Enter>" -- Launch terminal
    , "M-<Space>" -- Rotate layout algorithm
    , "M-<Tab>"   -- Toggle windows
    , "M-S-p"     -- gmrun
  ]
  `additionalKeysP` [
      ("C-<Space>", windows W.focusDown)
    , ("M-o",   spawn "~/.scripts/path-dmenu")
    , ("M-r",   spawn "urxvtc -e ranger")
    , ("M-a",   spawn "urxvtc -e alsamixer")
    , ("M-m",   spawn "urxvtc -e mutt")
    , ("M-S-t", spawn "urxvtc -e ~/.tmux/menu")
    , ("M-S-b", spawn "firefox-beta-bin")
    , ("M-s",   spawn "urxvtc -e ~/.scripts/music ui")
    , ("M-t",   spawn "urxvtc -e ~/.scripts/music toggle")
    , ("M-w",   spawn "urxvtc -e wicd-curses")
    , ("C-m",   spawn "~/.scripts/touchpad_toggle")
    , ("M-S-p", spawn "~/.scripts/screenshot")           -- Take a screenshot
  ]
  `additionalKeys` [
    ((0, xF86XK_AudioMute),          spawn "amixer -q set PCM toggle")
    , ((0, xF86XK_AudioRaiseVolume), spawn "amixer -q set PCM 15+")
    , ((0, xF86XK_AudioLowerVolume), spawn "amixer -q set PCM 15-")
  ]
