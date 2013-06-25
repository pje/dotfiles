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

# default to graphite icon set instead of blue
defaults write NSGlobalDomain AppleAquaColorVariant -int 6

# Set sidebar icon size to medium
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

# Disable opening and closing window animations
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Set Help Viewer windows to non-floating mode
defaults write com.apple.helpviewer DevMode -bool true

# Reveal IP address, hostname, OS version, etc. via clock in login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Set language and text formats
defaults write NSGlobalDomain AppleLanguages -array "en"
defaults write NSGlobalDomain AppleLocale -string "en_US@currency=USD"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

# Disable Resume system-wide
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

###############################################################################
# Menu Bar
###############################################################################

# enable transparency
defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool true

# show remaining battery time (on pre-10.8); hide percentage
defaults write com.apple.menuextra.battery ShowPercent -string "NO"
defaults write com.apple.menuextra.battery ShowTime -string "YES"

# hide the useless Time Machine and Volume icons
defaults write com.apple.systemuiserver menuExtras -array "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" "/System/Library/CoreServices/Menu Extras/AirPort.menu" "/System/Library/CoreServices/Menu Extras/Battery.menu"

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

# enable tap-to-click everywhere
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# swipe between pages with three fingers
defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerHorizSwipeGesture -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 1

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

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a faster keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2

# Automatically illuminate built-in MacBook keyboard in low light
defaults write com.apple.BezelServices kDim -bool true

# Turn off keyboard illumination when computer is not used for 5 minutes
defaults write com.apple.BezelServices kDimTime -int 300

###############################################################################
# Accesibility & Other Input
###############################################################################

# Enable access for assistive devices
echo -n 'a' | sudo tee /private/var/db/.AccessibilityAPIEnabled > /dev/null 2>&1
sudo chmod 444 /private/var/db/.AccessibilityAPIEnabled

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

###############################################################################
# Finder
###############################################################################

# disable window animations and Get Info animations
defaults write com.apple.finder DisableAllAnimations -bool true

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

# Empty Trash securely
defaults write com.apple.finder EmptyTrashSecurely -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

###############################################################################
# Dock
###############################################################################

# Set the icon size of Dock items to 32 pixels
defaults write com.apple.dock tilesize -int 32

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

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
# Disk Utility
###############################################################################

# Enable the debug menu in Disk Utility
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true

###############################################################################
# Meta: Restart/Peace
###############################################################################

for app in "Disk Utility" "Dock" "Finder" "SystemUIServer" "TextEdit" ; do
  killall "$app" > /dev/null 2>&1
done

echo "Done. Note that some of these changes require a logout/restart to take effect."
