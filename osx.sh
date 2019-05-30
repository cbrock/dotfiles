#!/usr/bin/env bash

###########################
# This script based on
# https://github.com/atomantic/dotfiles/blob/master/install.sh
###########################

echo "closing any system preferences to prevent issues with automated changes"
osascript -e 'tell application "System Preferences" to quit'

##############################################################################
# Security                                                                   #
##############################################################################
# Based on:
# https://github.com/drduh/macOS-Security-and-Privacy-Guide
# https://benchmarks.cisecurity.org/tools2/osx/CIS_Apple_OSX_10.12_Benchmark_v1.0.0.pdf

# Enable firewall. Possible values:
#   0 = off
#   1 = on for specific sevices
#   2 = on for essential services
sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 1

# Enable firewall stealth mode (no response to ICMP / ping requests)
# Source: https://support.apple.com/kb/PH18642
#sudo defaults write /Library/Preferences/com.apple.alf stealthenabled -int 1
sudo defaults write /Library/Preferences/com.apple.alf stealthenabled -int 1

# Disable remote apple events
sudo systemsetup -setremoteappleevents off

# Disable remote login
sudo systemsetup -setremotelogin off

# Disable wake-on modem
sudo systemsetup -setwakeonmodem off

# Disable wake-on LAN
sudo systemsetup -setwakeonnetworkaccess off

# Disable guest account login
sudo defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool false

###############################################################################
# SSD-specific tweaks                                                         #
###############################################################################

echo "Disable local Time Machine snapshots"
sudo tmutil disablelocal;


echo "Wipe all (default) app icons from the Dock"
# # This is only really useful when setting up a new Mac, or if you don’t use
# # the Dock to launch apps.
defaults write com.apple.dock persistent-apps -array "";

#running "Enable the 2D Dock"
defaults write com.apple.dock no-glass -bool true;

################################################
# "Standard System Changes"
################################################

echo "Check for software updates daily, not just once per week"
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1;

# echo "Disable Notification Center and remove the menu bar icon"
# launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist > /dev/null 2>&1;

echo "Disable smart quotes as they’re annoying when typing code"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false;

echo "Disable smart dashes as they’re annoying when typing code"
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false;

echo "Disable shake to magnify cursor"
defaults write NSGlobalDomain CGDisableCursorLocationMagnification -bool true

# Disable automatic period insertion on double-space
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false

# Required for iterm2 session restoration
# See https://www.iterm2.com/documentation-restoration.html
echo "Don't close windows when quitting an app"
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool true

###############################################################################
# "Trackpad, mouse, keyboard, Bluetooth accessories, and input"
###############################################################################

echo "Trackpad: enable tap to click for this user and for the login screen"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1;

echo "Force Click and haptic feedback"
defaults write com.apple.AppleMultitouchTrackpad ActuateDetents -bool false

echo "Disable press-and-hold for keys in favor of key repeat"
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false;

echo "Set a blazingly fast keyboard repeat rate"
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 10;

echo "Disable auto-correct"
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false;

###############################################################################
# "Configuring the Screen"
###############################################################################

echo "Require password immediately after sleep or screen saver begins"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0;

###############################################################################
# "Finder Configs"
###############################################################################
echo "Disable window animations and Get Info animations"
defaults write com.apple.finder DisableAllAnimations -bool true;

echo "Show hidden files by default"
defaults write com.apple.finder AppleShowAllFiles -bool true;

echo "Show all filename extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true;

echo "Show status bar"
defaults write com.apple.finder ShowStatusBar -bool true;

echo "Show path bar"
defaults write com.apple.finder ShowPathbar -bool true;

echo "Allow text selection in Quick Look"
defaults write com.apple.finder QLEnableTextSelection -bool true;

echo "Display full POSIX path as Finder window title"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true;

echo "When performing a search, search the current folder by default"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf";

echo "Disable the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false;

echo "Avoid creating .DS_Store files on network volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true;

echo "Use list view in all Finder windows by default"
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv";

echo "Disable the warning before emptying the Trash"
defaults write com.apple.finder WarnOnEmptyTrash -bool false;

echo "Empty Trash securely by default"
defaults write com.apple.finder EmptyTrashSecurely -bool true;

echo "Show the ~/Library folder"
chflags nohidden ~/Library;

###############################################################################
# "Dock & Dashboard"
###############################################################################

echo "Set the icon size of Dock items to 36 pixels"
defaults write com.apple.dock tilesize -int 36;

echo "Change minimize/maximize window effect to scale"
defaults write com.apple.dock mineffect -string "scale";

echo "Minimize windows into their application’s icon"
defaults write com.apple.dock minimize-to-application -bool true;

echo "Show indicator lights for open applications in the Dock"
defaults write com.apple.dock show-process-indicators -bool true;

echo "Don’t animate opening applications from the Dock"
defaults write com.apple.dock launchanim -bool false;

echo "Speed up Mission Control animations"
defaults write com.apple.dock expose-animation-duration -float 0.1;

echo "Disable Dashboard"
defaults write com.apple.dashboard mcx-disabled -bool true;

echo "Don’t show Dashboard as a Space"
defaults write com.apple.dock dashboard-in-overlay -bool true;

echo "Don’t automatically rearrange Spaces based on most recent use"
defaults write com.apple.dock mru-spaces -bool false;

echo "Remove the auto-hiding Dock delay"
defaults write com.apple.dock autohide-delay -float 0;
echo "Remove the animation when hiding/showing the Dock"
defaults write com.apple.dock autohide-time-modifier -float 0;

echo "Automatically hide and show the Dock"
defaults write com.apple.dock autohide -bool true;

echo "Make Dock icons of hidden applications translucent"
defaults write com.apple.dock showhidden -bool true;

echo "Make Dock more transparent"
defaults write com.apple.dock hide-mirror -bool true;

echo "Reset Launchpad, but keep the desktop wallpaper intact"
find "${HOME}/Library/Application Support/Dock" -name "*-*.db" -maxdepth 1 -delete;

###############################################################################
# "Configuring Safari & WebKit"
###############################################################################

echo "Set Safari’s home page to ‘about:blank’ for faster loading"
defaults write com.apple.Safari HomePage -string "about:blank";

echo "Prevent Safari from opening ‘safe’ files automatically after downloading"
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false;

echo "Allow hitting the Backspace key to go to the previous page in history"
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true;

echo "Hide Safari’s bookmarks bar by default"
defaults write com.apple.Safari ShowFavoritesBar -bool false;

echo "Hide Safari’s sidebar in Top Sites"
defaults write com.apple.Safari ShowSidebarInTopSites -bool false;

echo "Disable Safari’s thumbnail cache for History and Top Sites"
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2;

echo "Enable Safari’s debug menu"
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true;

echo "Make Safari’s search banners default to Contains instead of Starts With"
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false;

echo "Remove useless icons from Safari’s bookmarks bar"
defaults write com.apple.Safari ProxiesInBookmarksBar "()";

echo "Enable the Develop menu and the Web Inspector in Safari"
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true;

echo "Add a context menu item for showing the Web Inspector in web views"
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true;

###############################################################################
# "Time Machine"
###############################################################################

echo "Prevent Time Machine from prompting to use new hard drives as backup volume"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true;

echo "Disable local Time Machine backups"
hash tmutil &> /dev/null && sudo tmutil disablelocal;

###############################################################################
# "Activity Monitor"
###############################################################################

echo "Show the main window when launching Activity Monitor"
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true;

echo "Visualize CPU usage in the Activity Monitor Dock icon"
defaults write com.apple.ActivityMonitor IconType -int 5;

echo "Show all processes in Activity Monitor"
defaults write com.apple.ActivityMonitor ShowCategory -int 0;

echo "Sort Activity Monitor results by CPU usage"
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0;

###############################################################################
# "Address Book, Dashboard, iCal, TextEdit, and Disk Utility"
###############################################################################

echo "Use plain text mode for new TextEdit documents"
defaults write com.apple.TextEdit RichText -int 0;

###############################################################################
# Kill affected applications                                                  #
###############################################################################
echo "OK. Note that some of these changes require a logout/restart to take effect. Killing affected applications (so they can reboot)...."
for app in "Activity Monitor" "Address Book" "Calendar" "Contacts" "cfprefsd" \
  "Dock" "Finder" "Mail" "Messages" "Safari" "SystemUIServer" \
  "iCal" "Terminal"; do
  killall "${app}" > /dev/null 2>&1
done


echo "Woot! All done."
