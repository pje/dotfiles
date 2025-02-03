#!/usr/bin/env bash

# adapted from:
# - https://github.com/mathiasbynens/dotfiles/blob/master/.osx
# - http://www.defaults-write.com

###############################################################################
# Meta: Setup
###############################################################################

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until this script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# System-wide UI / Behavior
###############################################################################

# default shell to homebrew bash, not zsh
brew_bash="$(brew --prefix)/bin/bash"
if [[ $(echo "$SHELL") != /opt/homebrew/bin/bash ]]; then
  which "$brew_bash" || exit 1
  grep "$brew_bash" /etc/shells || sudo sh -c "$brew_bash" >> /etc/shells
  chsh -s "$brew_bash"
fi

# add login items
osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Flycut.app", hidden:false}'
osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Hammerspoon.app", hidden:false}'
osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Karabiner-Elements.app", hidden:false}'
osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Nightfall.app", hidden:false}'

# disable siri
defaults write com.apple.assistant.support "Assistant Enabled" -bool false

# Remove siri icon from status menu
defaults write com.apple.Siri StatusMenuVisible -bool false

# disable stage manager (dock recent items)
defaults write com.apple.WindowManager GloballyEnabled -bool false

# Enable auto dark mode
osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to auto'

# use blue icon set (instead of graphite (blue is the default))
defaults write NSGlobalDomain AppleAquaColorVariant -int 1

# Set sidebar icon size to medium
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

# Disable opening and closing window animations
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Disabling automatic termination of inactive apps
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

# Set Help Viewer windows to non-floating mode
defaults write com.apple.helpviewer DevMode -bool true

# Reveal IP address, hostname, OS version, etc. via clock in login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Set language and text formats
defaults write NSGlobalDomain AppleLanguages -array "en"
defaults write NSGlobalDomain AppleLocale -string "en_US@currency=USD"

# Disable Resume system-wide
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

###############################################################################
# Menu Bar
###############################################################################

# auto-hide the menu bar
defaults write NSGlobalDomain _HIHideMenuBar -bool true

# enable transparency
defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool true

# why would I want a spotlight icon in the menu bar? i know about cmd+space
defaults write com.apple.Spotlight "NSStatusItem Visible Item-0" 0

# Hide Siri
defaults write com.apple.siri "StatusMenuVisible" 0
defaults write com.apple.systemuiserver "NSStatusItem Visible Siri" 0

# Enable favorite menu extras
defaults write com.apple.systemuiserver "menuExtras" -array \
  "/System/Library/CoreServices/Menu Extras/Clock.menu" \
  "/System/Library/CoreServices/Menu Extras/Battery.menu" \
  "/System/Library/CoreServices/Menu Extras/Volume.menu" \
  "/System/Library/CoreServices/Menu Extras/Bluetooth.menu"

# show remaining battery time (on pre-10.8); hide percentage
defaults write com.apple.menuextra.battery ShowPercent -string "NO"
defaults write com.apple.menuextra.battery ShowTime -string "YES"

# show ᛒ, time machine, wifi, battery in menubar
defaults write com.apple.systemuiserver menuExtras -array "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" "/System/Library/CoreServices/Menu Extras/TimeMachine.menu" "/System/Library/CoreServices/Menu Extras/AirPort.menu" "/System/Library/CoreServices/Menu Extras/Battery.menu"

# Disable Notification Center and remove the menu bar icon
launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2> /dev/null

###############################################################################
# Annoying Warnings
###############################################################################

# Disable the "Are you sure you want to open this application?" dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

###############################################################################
# Trackpad, Mouse
###############################################################################

# disable force click everywhere
defaults write NSGlobalDomain com.apple.trackpad.forceClick -bool false

# enable tap-to-click everywhere
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# disable annoying backswipe navigation
defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false

# enable three-finger swipe gesture ("navigate back" and "navigate forward")
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerHorizSwipeGesture -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 1

# Disable the Launchpad gesture (pinch with thumb and three fingers)
defaults write com.apple.dock showLaunchpadGestureEnabled -int 0

# Set a faster doubleclick threshold
defaults write NSGlobalDomain com.apple.mouse.doubleClickThreshold -float 0.8

# global mouse tracking speed (1...5)
defaults write NSGlobalDomain com.apple.mouse.scaling -float 2

# global trackpad tracking speed (1...5)
defaults write NSGlobalDomain com.apple.trackpad.scaling -int 2

# global scrolling speed (1...5)
defaults write NSGlobalDomain com.apple.scrollwheel.scaling -float 0.5

# stop all those damn noises
defaults write NSGlobalDomain com.apple.sound.beep.feedback -bool false

# use "natural" lion-style scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true

# enable secondary click on the trackpad
defaults write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

# allow two-finger, 2D scrolling
defaults write NSGlobalDomain com.apple.trackpad.scrollBehavior -int 2
defaults write NSGlobalDomain com.apple.trackpad.scrolling -int 3

###############################################################################
# Keyboard
###############################################################################

# Enable full keyboard access for all controls (eg enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a faster keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write -g InitialKeyRepeat -int 20

# Automatically illuminate built-in MacBook keyboard in low light
defaults write com.apple.BezelServices kDim -bool true

# Turn off keyboard illumination when computer is not used for 5 minutes
defaults write com.apple.BezelServices kDimTime -int 300

###############################################################################
# Screens
###############################################################################

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Save screenshots to the desktop
defaults write com.apple.screencapture location -string "$HOME/Desktop"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# Enable subpixel font rendering on non-Apple LCDs
defaults write NSGlobalDomain AppleFontSmoothing -int 2

# Enable HiDPI display modes (requires restart)
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

###############################################################################
# Finder
###############################################################################

# Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

# Don’t show Dashboard as a Space
defaults write com.apple.dock dashboard-in-overlay -bool true

# disable window animations and Get Info animations
defaults write com.apple.finder DisableAllAnimations -bool true

# Set Desktop as the default location for new Finder windows
# For other paths, use `PfLo` and `file:///full/path/here/`
defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"

# Desktop: show external drive icons
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true

# Desktop: show hard drive icons
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true

# Desktop: show mounted server icons
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true

# Desktop: show removable media icons
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# hide status bar
defaults write com.apple.finder ShowStatusBar -bool false

# hide path bar
defaults write com.apple.finder ShowPathbar -bool false

# allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Enable spring loading for directories
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# Remove the spring loading delay for directories
defaults write NSGlobalDomain com.apple.springing.delay -float 0

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Enable snap-to-grid for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Increase grid spacing for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist

# Increase the size of icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist

# Default to list view in Finder windows (others: `icnv`, `clmv`, `Flwv`)
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Show the ~/Library folder
chflags nohidden ~/Library

###############################################################################
# Dock
###############################################################################

# Put the dock on the bottom and autohide it like a civilized person
defaults write com.apple.dock orientation -string "bottom"

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Set the icon size of Dock items to 32 pixels
defaults write com.apple.dock tilesize -int 32

# Shorten the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0.05

# Shorten the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0.25

# Enable the 2D Dock
defaults write com.apple.dock no-glass -bool true

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Don’t animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Make Dock more transparent
defaults write com.apple.dock hide-mirror -bool true

# Don't show recent items in the dock
defaults write com.apple.dock show-recents -bool false

# Delete all the default bloat from the dock
if dockutil --find "App Store" >/dev/null 2>/dev/null; then dockutil --remove "App Store"; fi
if dockutil --find Calendar    >/dev/null 2>/dev/null; then dockutil --remove Calendar; fi
if dockutil --find Contacts    >/dev/null 2>/dev/null; then dockutil --remove Contacts; fi
if dockutil --find Downloads   >/dev/null 2>/dev/null; then dockutil --remove Downloads; fi
if dockutil --find FaceTime    >/dev/null 2>/dev/null; then dockutil --remove FaceTime; fi
if dockutil --find Freeform    >/dev/null 2>/dev/null; then dockutil --remove Freeform; fi
if dockutil --find Keynote     >/dev/null 2>/dev/null; then dockutil --remove Keynote; fi
if dockutil --find Launchpad   >/dev/null 2>/dev/null; then dockutil --remove Launchpad; fi
if dockutil --find Mail        >/dev/null 2>/dev/null; then dockutil --remove Mail; fi
if dockutil --find Maps        >/dev/null 2>/dev/null; then dockutil --remove Maps; fi
if dockutil --find News        >/dev/null 2>/dev/null; then dockutil --remove News; fi
if dockutil --find Notes       >/dev/null 2>/dev/null; then dockutil --remove Notes; fi
if dockutil --find Numbers     >/dev/null 2>/dev/null; then dockutil --remove Numbers; fi
if dockutil --find Pages       >/dev/null 2>/dev/null; then dockutil --remove Pages; fi
if dockutil --find Photos      >/dev/null 2>/dev/null; then dockutil --remove Photos; fi
if dockutil --find Reminders   >/dev/null 2>/dev/null; then dockutil --remove Reminders; fi
if dockutil --find Safari      >/dev/null 2>/dev/null; then dockutil --remove Safari; fi
if dockutil --find TV          >/dev/null 2>/dev/null; then dockutil --remove TV; fi

# Add apps to the dock — `dockutil --add` will fail if the app is already in the dock, and we just silence those error messages and move on
dockutil --add "/System/Applications/System Settings.app" >/dev/null 2>/dev/null
dockutil --add "/Applications/Google Chrome.app"          >/dev/null 2>/dev/null
dockutil --add "/Applications/Chromium.app"               >/dev/null 2>/dev/null
dockutil --add "/Applications/Music.app"                  >/dev/null 2>/dev/null
dockutil --add "/Applications/Spotify.app"                >/dev/null 2>/dev/null
dockutil --add "/Applications/Slack.app"                  >/dev/null 2>/dev/null
dockutil --add "/Applications/Signal.app"                 >/dev/null 2>/dev/null
dockutil --add "/System/Applications/Messages.app"        >/dev/null 2>/dev/null
dockutil --add "/Applications/Visual Studio Code.app"     >/dev/null 2>/dev/null
dockutil --add "/Applications/Ghostty.app"                >/dev/null 2>/dev/null
dockutil --add "/Users/pje/gifs-etc"                      >/dev/null 2>/dev/null

###############################################################################
# TextEdit
###############################################################################

# Use plain text mode for new documents
defaults write com.apple.TextEdit RichText -int 0

# Open files as UTF-8
defaults write com.apple.TextEdit PlainTextEncoding -int 4

# Save files as UTF-8
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

###############################################################################
# Activity Monitor
###############################################################################

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

###############################################################################
# Messages
###############################################################################

# Disable continuous spell checking
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false

###############################################################################
# iTunes
###############################################################################

# Don't launch iTunes when connecting an iPhone
defaults write com.apple.iTunesHelper ignore-devices 1

###############################################################################
# Mac App Store
###############################################################################

# Enable Debug Menu in the Mac App Store
defaults write com.apple.appstore ShowDebugMenu -bool true

###############################################################################
# Transmission
###############################################################################

# Don’t prompt for confirmation before downloading
defaults write org.m0k.transmission DownloadAsk -bool false

# Trash original torrent files
defaults write org.m0k.transmission DeleteOriginalTorrent -bool true

# Hide the donate message
defaults write org.m0k.transmission WarningDonate -bool false

# Hide the legal disclaimer
defaults write org.m0k.transmission WarningLegal -bool false

###############################################################################
# Disk Utility
###############################################################################

# Enable the debug menu in Disk Utility
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true

###############################################################################
# Dictionary
###############################################################################

echo changeset >> ~/Library/Spelling/LocalDictionary

sort -o ~/Library/Spelling/LocalDictionary ~/Library/Spelling/LocalDictionary

###############################################################################
# Flycut
###############################################################################

# launch on startup
defaults write com.generalarcade.flycut loadOnStartup -int 1

# Use the "Black Scissors" Icon
defaults write com.generalarcade.flycut menuIcon -int 3

# Set hotkey to ⌘⇧J
defaults write com.generalarcade.flycut "ShortcutRecorder mainHotkey" -dict-add "keyCode" -int 38
defaults write com.generalarcade.flycut "ShortcutRecorder mainHotkey" -dict-add "modifierFlags" -int 1179648

# Store 100 clippings
defaults write com.generalarcade.flycut "store" -dict-add "rememberNum" -int 100

###############################################################################
# set default editor app for common extensions
###############################################################################

extensions="\
ackrc
bash_login
bashrc
Brewfile
c
cc
clj
coffee
cpp
cson
css
ctags
Dockerfile
erb
ghci
git
gitconfig
gitignore
graphql
h
haml
hpp
html
idx
inputrc
irbrc
js
json
jsx
lein
lock
make
Makefile
profile
py
rake
rb
ru
ruby
scss
sh
slate
sql
tags
ts
tsx
txt
vimrc
yaml
yml"

for e in $extensions; do duti -s com.microsoft.VSCode "$e" editor ; done

###############################################################################
# Kill affected applications
###############################################################################
apps=("Activity Monitor" AppleSpell cfprefsd "Disk Utility" Dock Finder SystemUIServer TextEdit Transmission)

for app in "${apps[@]}"; do (pgrep "$app" && killall "$app") || true; done

echo "Done. Note that some of these changes require a logout/restart to take effect."
