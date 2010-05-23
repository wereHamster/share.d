
import XMonad

import qualified XMonad.StackSet as S
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ManageDocks
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Util.CustomKeys

import XMonad.Util.Run
import XMonad.Util.Scratchpad

import XMonad.Actions.CycleWS
import XMonad.Actions.GridSelect

import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.FadeInactive

import XMonad.Operations

import System.IO
import System.Exit

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

myWorkspaces = ["main","web","mail","chat"]

keyBindings conf@(XConfig { XMonad.modMask = modMask }) = M.fromList $

    -- launch a terminal
    [ ((modMask .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- close focused window
    , ((modMask .|. shiftMask, xK_k     ), kill)

     -- Rotate through the available layout algorithms
    , ((modMask,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modMask,               xK_slash ), refresh)

    -- Move focus to the next window
    , ((modMask,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modMask,               xK_n     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modMask,               xK_e     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modMask,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modMask,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modMask .|. shiftMask, xK_n     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modMask .|. shiftMask, xK_e     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modMask .|. shiftMask, xK_z     ), sendMessage Shrink)

    -- Expand the master area
    , ((modMask,               xK_z     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modMask,               xK_period), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modMask              , xK_a     ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modMask .|. shiftMask, xK_a     ), sendMessage (IncMasterN (-1)))

    -- Quit xmonad
    , ((modMask .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modMask              , xK_q     ), restart "xmonad" True)

    -- Programs
    , ((modMask              , xK_w     ), spawn "chromium --ignore-gpu-blacklist")
    , ((modMask              , xK_f     ), scratchpadSpawnAction conf)
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

myMouseBindings (XConfig { XMonad.modMask = modMask }) = M.fromList $
  [
    ((modMask, button1), (\w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster))
  , ((modMask, button2), (\w -> focus w >> windows W.shiftMaster))
  , ((modMask, button3), (\w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster))
  ]

-- find class name with xprop | grep CLASS
myManageHook = composeAll
    [ floatC "MPlayer"
    , floatC "Gimp"
    , moveToC "Chromium" "web"
    ]
  where moveToC c w = className =? c --> doF (S.shift w)
        moveToT t w = title     =? t --> doF (S.shift w)
        floatC  c   = className =? c --> doFloat

manageScratchPad :: ManageHook
manageScratchPad = scratchpadManageHook (W.RationalRect l t w h)

  where
    h = 0.5     -- terminal height, 10%
    w = 1       -- terminal width, 100%
    t = 1 - h   -- distance from top edge, 90%
    l = 1 - w   -- distance from left edge, 0%

myLayoutHook =
    smartBorders $ avoidStruts $ tiled ||| Mirror tiled ||| full
  where
    tiled   = spacing 1 $ Tall nmaster delta ratio
    full    = spacing 1 $ Full
    nmaster = 1
    ratio   = 1/2
    delta   = 4/100

main = do

    xmonad $ defaultConfig {
          modMask            = mod1Mask
        , workspaces         = myWorkspaces

        , terminal           = "urxvtc"
        , borderWidth        = 1
        , normalBorderColor  = "#586e75"
        , focusedBorderColor = "#687e85"

        , keys               = keyBindings
        , mouseBindings      = myMouseBindings

        , manageHook         = myManageHook <+> manageScratchPad
        , layoutHook         = myLayoutHook

        , focusFollowsMouse  = False
    }
