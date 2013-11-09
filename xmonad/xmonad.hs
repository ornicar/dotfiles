import XMonad
import XMonad.Layout.NoBorders
import XMonad.Util.EZConfig
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.ManageHelpers

import qualified XMonad.StackSet as W

main = xmonad $ withUrgencyHook dzenArgs myConfig
  where dzenArgs = dzenUrgencyHook { args = ["-bg", "darkgreen", "-xs", "1"] }

------------------------------------------------------------------------
-- Workspaces
-- The default number of workspaces (virtual screens) and their names.
--
myWorkspaces = ["1:system","2:main","3:network"] ++ map show [4..9]

noborderLayout = noBorders Full ||| noBorders tiled
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

smartLayout = smartBorders $ layoutHook defaultConfig

myLayout = noborderLayout

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
    [ resource  =? "Skype"          --> doFloat
    , isFullscreen --> (doF W.focusDown <+> doFullFloat)]

myConfig = defaultConfig {
      terminal   = "urxvtc -e ~/.tmux/menu"
    , modMask    = mod1Mask -- Alt
    , layoutHook = myLayout
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
    , ("M-S-l",   sendMessage NextLayout) -- next layout
    , ("M-o",   spawn "~/.scripts/path-dmenu")
    , ("M-r",   spawn "urxvtc -e ranger")
    , ("M-a",   spawn "urxvtc -e pacmixer")
    , ("M-S-t", spawn "urxvtc -e ~/.tmux/menu")
    , ("M-S-b", spawn "firefox")
    , ("M-s",   spawn "urxvtc -e ~/.scripts/music ui")
    , ("M-t",   spawn "urxvtc -e ~/.scripts/music toggle")
    , ("M-w",   spawn "urxvtc -e wicd-curses")
    , ("C-m",   spawn "~/.scripts/touchpad_toggle")
    , ("M-S-p", spawn "~/.scripts/screenshot")           -- Take a screenshot
  ]
