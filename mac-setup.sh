# Script to Setup a New Mac
# run without downloading: 
# curl https://raw.githubusercontent.com/leira-sanchez/mac-setup/master/mac-setup.sh | bash

THEME="steeef"

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

# Check for system update and install 
softwareupdate -i -a

###############################################################################
# General                                                                        #
###############################################################################

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable the crash reporter
defaults write com.apple.CrashReporter DialogType -string "none"

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

###############################################################################
# Dock                                                                        #
###############################################################################
# Auto-hide the dock
defaults write com.apple.dock autohide -float 1
defaults write com.apple.dock autohide-time-modifier -float 1;

# Wipe all (default) app icons from the Dock
# This is only really useful when setting up a new Mac, or if you don’t use
# the Dock to launch apps
defaults write com.apple.dock persistent-apps -array

# Show only open applications in the Dock
defaults write com.apple.dock static-only -bool true

###############################################################################
# Mail                                                                        #
###############################################################################

# Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false


###############################################################################
# Finder Stuff                                                                #
###############################################################################

# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true

# Finder should show all .files
defaults write com.apple.finder AppleShowAllFiles YES

# Finder should show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Trackpad: map bottom right corner to right-click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
# defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false


# enable three finger drag on trackpad
defaults write http://com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -int 1
defaults write http://com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -int 1

echo "${green}Setting up code folder...${reset}"
mkdir -p ~/code

# Install Brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Add custom aliases
echo "${green}Adding Custom Aliases...${reset}"
touch ~/.oh-my-zsh/custom/aliases.zsh
echo -e "alias gac='git add . && git commit -m'\n alias co='checkout'\n alias ys='yarn start'" >> ~/.oh-my-zsh/custom/aliases.zsh

# Install Xcode command line tools
xcode-select --install

# Node + NPM + Yarn
brew install npm
brew install yarn
brew install n

echo "${green}Installing NVM...${reset}"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash

echo "${green}Installing mysql...${reset}"
brew install mysql

echo "${green}Installing sequel-pro-nightly...${reset}"
brew cask install homebrew/cask-versions/sequel-pro-nightly

# Config git username and email
echo "${green}Now we'll setup your name and email for git ${reset}"
  echo "What's your name?"
  read USER_NAME
  git config --global user.name "$USER_NAME"
  echo "What's your email?"
  read EMAIL_ADDRESS
  git config --global user.email $EMAIL_ADDRESS

###############################################################################
# VSCode                                                                      #
###############################################################################

# Install VS Code and extensions
echo "${green}Installing VSCode...${reset}"
brew cask install visual-studio-code

echo "${green}Installing VSCode Extensions...${reset}"
code --install-extension CoenraadS.bracket-pair-colorizer-2
code --install-extension formulahendry.auto-rename-tag
code --install-extension Gruntfuggly.todo-tree
code --install-extension eamodio.gitlens
code --install-extension bierner.markdown-preview-github-styles
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension xabikos.javascriptsnippets
code --install-extension ue.alphabetical-sorter
code --install-extension jpoissonnier.vscode-styled-components

###############################################################################
# Apps                                                                        #
###############################################################################
echo "${green}Installing Chrome...${reset}"
brew cask install google-chrome

echo "${green}Installing Alfred...${reset}"
brew cask install alfred

echo "${green}Installing appcleaner...${reset}"
brew cask install appcleaner

echo "${green}Installing slack...${reset}"
brew cask install slack

echo "${green}Installing spotify...${reset}"
brew cask install spotify

echo "${green}Installing postman...${reset}"
brew cask install postman

echo "${green}Installing zoom...${reset}"
brew cask install zoomus

echo "${green}Installing rectangle...${reset}"
brew cask install rectangle

# echo "${green}Installing postico...${reset}"
# brew cask install postico

echo "${green}Installing whatsapp...${reset}"
brew cask install whatsapp

echo "${green}Installing kindle...${reset}"
brew cask install kindle

echo "${green}Installing send-to-kindle...${reset}"
brew cask install send-to-kindle

echo "${green}Installing clipy...${reset}"
brew cask install clipy

echo "${green}Installing notion...${reset}"
brew cask install notion

echo "${green}Installing Firefox Developer Edition...${reset}"
brew cask install firefox-developer-edition

echo "${green}Installing App Store CLI...${reset}"
brew install mas

echo "${green}Installing Xcode...${reset}"
# Install XCode from the App Store using its identifier
mas install 497799835

# echo "${green}Installing OneNote...${reset}"
# # Install Microsoft OneNote from the App Store
#  mas install 784801555

#Done
echo "${green}\n\Done! 🎉 You might need to log out and in or even restart for changes to take effect."
