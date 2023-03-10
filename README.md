# Rectangle

![](https://github.com/rxhanson/Rectangle/workflows/Build/badge.svg)

Rectangle is a window management app based on Spectacle, written in Swift.

![image](https://user-images.githubusercontent.com/13651296/71896594-7cdb9280-3154-11ea-83a7-70b71c6df9d4.png)

## System Requirements
Rectangle supports macOS v10.11+. If you're willing to test on earlier versions of macOS, this can be updated.

## Installation
You can download the latest dmg from https://rectangleapp.com or the [Releases page](https://github.com/rxhanson/Rectangle/releases).

Or install with brew cask:

```bash
brew cask install rectangle
```
## How to use it
The keyboard shortcuts are self explanatory, but the snap areas can use some explanation if you've never used them on Windows or other window management apps.

Drag a window to the edge of the screen. When the mouse cursor reaches the edge of the screen, you'll see a footprint that Rectangle will attempt to resize and move the window to when the click is released.

| Snap Area                                              | Resulting Action                       |
|--------------------------------------------------------|----------------------------------------|
| Left or right edge                                     | Left or right half                     |
| Top                                                    | Maximize                               |
| Corners                                                | Quarter in respective corner           |
| Left or right edge, just above or below a corner       | Top or bottom half                     |
| Bottom left, center, or right third                    | Respective third                       |
| Bottom left or right third, then drag to bottom center | First or last two thirds, respectively |

### Ignore an app

   1. Focus the app that you want to ignore (make a window from that app frontmost).
   2. Open the Rectangle menu and select "Ignore app"

## Differences with Spectacle
* Rectangle uses [MASShortcut](https://github.com/shpakovski/MASShortcut) for keyboard shortcut recording. Spectacle used it's own shortcut recorder.
* Rectangle has additional window actions: move windows to each edge without resizing, maximize only the height of a window, almost maximizing a window. 
* Next/prev screen thirds is replaced with explicitly first third, first two thirds, center third, last two thirds, and last third. Screen orientation is taken into account, as in first third will be left third on landscape and top third on portrait.
* There's an option to have windows traverse across displays on subsequent left or right executions.
* Windows will snap when dragged to edges/corners of the screen. This can be disabled.

## Terminal commands
The preferences window is purposefully slim, but there's a lot that can be modified via Terminal. After executing a terminal command, restart the app as these values are loaded on application startup.

### Keyboard Shortcuts
If you wish to change the default shortcuts after first launch, use the following command. True is for the recommended shortcuts, false is for Spectacle's.

```bash
defaults write com.knollsoft.Rectangle alternateDefaultShortcuts -bool true
```

### Halves to thirds (repeated execution of half and quarter actions)
Halves to thirds is controlled by the "Cycle displays" setting in the preferences. 
If the cycle displays setting is not checked, then each time you execute a half or quarter action, the width of the window will cycle through the following sizes: 1/2 -> 2/3 -> 1/3.

The cycling behavior can be disabled entirely with:

```bash
defaults write com.knollsoft.Rectangle subsequentExecutionMode -int 2
```

`subsequentExecutionMode` accepts the following values:
0: halves to thirds Spectacle behavior (box unchecked)
1: cycle displays (box checked)
2: disabled
3: cycle displays for left/right actions, halves to thirds for the rest (old Rectangle behavior)

### Almost Maximize
By default, "Almost Maximize" will resize the window to 90% of the screen (width & height).

```bash
defaults write com.knollsoft.Rectangle almostMaximizeHeight -float <VALUE_BETWEEN_0_&_1>
```

```bash
defaults write com.knollsoft.Rectangle almostMaximizeWidth -float <VALUE_BETWEEN_0_&_1>
```
### Adding Gaps Between Windows

```bash
defaults write com.knollsoft.Rectangle gapSize -float <NUM_PIXELS>
```
### Move Up/Down/Left/Right: Don't center on edge

By default, the directional move will center the window along the edge that the window is being moved to. 

```bash
defaults write com.knollsoft.Rectangle centeredDirectionalMove -int 2
```
### Make Smaller limits

By default, "Make Smaller" will decrease the window until it reaches 25% of the screen (width & height).

```bash
defaults write com.knollsoft.Rectangle minimumWindowWidth -float <VALUE_BETWEEN_0_&_1>
```

```bash
defaults write com.knollsoft.Rectangle minimumWindowHeight -float <VALUE_BETWEEN_0_&_1>
```

### Make Smaller/Make Larger size increments

By default, "Make Smaller" and "Make Larger" change the window height/width by 30 pixels.

```bash
defaults write com.knollsoft.Rectangle sizeOffset -float <NUM_PIXELS>
```

### Make Smaller/Make Larger "curtain resize" with gaps

By default, windows touching the edge of the screen will keep those shared edges the same while only resizing the non-shared edge. With window gaps, this is a little ambiguous since the edges don't actually touch the screen, so you can disable it for traditional, floating resizing:

```bash
defaults write com.knollsoft.Rectangle curtainChangeSize -int 2
```

### Disabling window restore when moving windows

```bash
defaults write com.knollsoft.Rectangle unsnapRestore -int 2
```

### Changing the margin for the snap areas

Each margin is configured separately, and has a default value of 5

```bash
defaults write com.knollsoft.Rectangle snapEdgeMarginTop -int 10
defaults write com.knollsoft.Rectangle snapEdgeMarginBottom -int 10
defaults write com.knollsoft.Rectangle snapEdgeMarginLeft -int 10
defaults write com.knollsoft.Rectangle snapEdgeMarginRight -int 10
```

### Ignore specific drag to snap areas

Each drag to snap area on the edge of a screen can be ignored with a single Terminal command, but it's a bit field setting so you'll have to determine the bit field for which ones you want to disable.


| Bit | Snap Area                 | Window Action       |
|-----|---------------------------|---------------------|
| 1   | Top                       | Maximize            |
| 2   | Bottom                    | Thirds              |
| 3   | Left                      | Left Half           |
| 4   | Right                     | Right Half          |
| 5   | Top Left                  | Top Left Corner     |
| 6   | Top Right                 | Top Right Corner    |
| 7   | Bottom Left               | Bottom Left Corner  |
| 8   | Bottom Right              | Bottom Right Corner |
| 9   | Top Left Below Corner     | Top Half            |
| 10  | Top Right Below Corner    | Top Half            |
| 11  | Bottom Left Above Corner  | Bottom Half         |
| 12  | Bottom Right Above Corner | Bottom Half         |

To disable the top (maximize) snap area, execute:
```bash
defaults write com.knollsoft.Rectangle ignoredSnapAreas -int 1
```

To disable the Top Half and Bottom Half snap areas, the bit field would be 1111 0000 0000, or 3840
```bash
defaults write com.knollsoft.Rectangle ignoredSnapAreas -int 3840
```

## Common Known Issues

### Rectangle doesn't have the ability to move to other desktops/spaces.

Apple never released a public API for Spaces, so any direct interaction with Spaces uses private APIs that are actually a bit shaky. Using the private API adds enough complexity to the app to where I feel it's better off without it. If Apple decides to release a public API for it, I'll add it in.

### Window moving/resizing appears animated/smooth instead of quick, and windows don't end up where you expect

This is a macOS bug. Here's some things that trigger it:

* Using the on-screen keyboard
* Unnecessary accessibility privileges for certain apps, like Alfred. Remove accessiblity privileges from apps that don't need them.
* Running certain apps, like Dragon and Punto Switcher (a Russian app).
* Certain external monitors trigger this behavior.

You can try enabling "Reduce motion" in the "Display" section of the "Accessibility" System Preferences. This doesn't appear to work with the on-screen keyboard, but might work for other triggers of the issue. Note that this setting will replace the Spaces/Mission Control/Expos?? animations with fades.

As a last resort, you can use this workaround release of Rectangle: [v0.25.1](https://github.com/rxhanson/Rectangle/releases/tag/v0.25.1), but it's just a better experience to avoid the items that trigger it and use the latest version of Rectangle. The ideal scenario is that Apple gets around to fixing it. This scenario will only happen if _a lot_ of people file the issue.

If you are a developer, file an issue here:
https://feedbackassistant.apple.com/

If you are not a developer, use:
https://www.apple.com/feedback/macos.html

### Window resizing is off slightly for iTerm2

By default iTerm2 will only resize in increments of character widths. There might be a setting inside iTerm2 to disable this, but you can change it with the following command.

```bash
defaults write com.googlecode.iterm2 DisableWindowSizeSnap -integer 1
```

### Troubleshooting
If windows aren't resizing or moving as you expect, here's some initial steps to get to the bottom of it. Most issues of this type have been caused by other apps.
1. Make sure macOS is up to date, if possible.
1. Restart your machine.
1. Make sure there are no other window manager applications running.
1. Make sure that the app whose windows are not behaving properly does not have any conflicting keyboard shortcuts.
1. Try using the menu items to execute a window action or changing the keyboard shortcut to something different so we can tell if it's a keyboard shortcut issue or not.
1. Enable debug logging, as per the instructions in the following section.
1. The logs are pretty straightforward. If your calculated rect and your resulting rect are identical, chances are that there is another application causing issues. Save your logs if needed to attach to an issue if you create one.
1. If you suspect there may be another application causing issues, try creating and logging in as a new macOS user.

## View Debug Logging
1. Hold down the alt (option) key with the Rectangle menu open. 
1. Select the "View Logging..." menu item, which is in place of the "About" menu item.
1. Logging will appear in the window as you perform Rectangle commands.

## Preferences Storage
The configuration for Rectangle is stored using NSUserDefaults, meaning it is stored in the following location:
`~/Library/Preferences/com.knollsoft.Rectangle.plist`

That file can be backed up or transferred to other machines.

---

## Contributing
Logic from Rectangle is used in the [Multitouch](https://multitouch.app) app. The [Hookshot](https://hookshot.app) app is entirely built on top of Rectangle. If you contribute significant code or localizations that get merged into Rectangle, you get free licenses of Multitouch and Hookshot. Contributors to Sparkle, MASShortcut, or Spectacle can also receive free Multitouch or Hookshot licenses (just send me a direct message on [Gitter](https://gitter.im)). 

### Localization
Initial localizations were done using [DeepL](https://www.deepl.com/translator) and Google Translate, but many of them have been updated by contributors. Translations that weren't done by humans can definitely be improved. If you would like to contribute to localization, all of the translations are held in the Main.strings per language. If you would like to add a localization but one doesn't currently exist and you don't know how to create one, create an issue and a translation file can be initialized.

Pull requests for new localizations or improvements on existing localizations are welcome.

### Running the app in Xcode (for developers)
Rectangle uses [CocoaPods](https://cocoapods.org/) to install Sparkle and MASShortcut. 

1. Make sure CocoaPods is installed and up to date on your machine (`sudo gem install cocoapods`).
1. Execute `pod install` the root directory of the project. 
1. Open the generated xcworkspace file (`open Rectangle.xcworkspace`).

#### Signing
- When running in Xcode (debug), Rectangle is signed to run locally with no developer ID configured.
- You can run the app out of the box this way, but you might have to authorize the app in System Prefs every time you run it. 
- If you don't want to authorize in System Prefs every time you run it and you have a developer ID set up, you'll want to use that to sign it and additionally add the Hardened Runtime capability to the Rectangle and RectangleLauncher targets. 
