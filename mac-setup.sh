# Script to Setup a New Mac
SCRIPTDIR="$(dirname "$leira")"
THEME="steeef"

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

# Check for system update and install 
softwareupdate -i -a

# Auto-hide the dock
defaults write com.apple.dock autohide -float 1
defaults write com.apple.dock autohide-time-modifier -float 1;

# Finder should show all .files
defaults write com.apple.finder AppleShowAllFiles YES

echo "${green}Setting up project folders...${reset}"
mkdir -p ~/dev

# Install Brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "${green}Installing shell profile...${reset}"
cat "$SCRIPTDIR/.zshrc" >> "$CFG_FILE"
perl -pi -e  "s/avit/$THEME/g" ~/.zshrc

# Add custom aliases
echo "${green}Adding Custom Aliases...${reset}"
touch ~/.oh-my-zsh/custom/aliases.zsh
echo -e "alias gac='git add . && git commit -m'\nalias co='checkout'" >> ~/.oh-my-zsh/custom/aliases.zsh

# Install Xcode command line tools
xcode-select --install

# Node + NPM + Yarn
brew install npm
brew install yarn
brew install n

echo "${green}Installing NVM...${reset}"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash

# Config git username and email
echo "${green}Now we'll setup your name and email for git ${reset}"
  echo "What's your name?"
  read USER_NAME
  git config --global user.name $USER_NAME
  echo "What's your email?"
  read EMAIL_ADDRESS
git config --global user.email $EMAIL_ADDRESS

# Install VS Code and extensions
echo "${green}Installing VSCode...${reset}"
brew cask install visual-studio-code

echo "${green}Installing VSCode Extensions...${reset}"
code --install-extension CoenraadS.bracket-pair-colorizer-2
code --install-extension formulahendry.auto-rename-tag
code --install-extension wayou.vscode-todo-highlight
code --install-extension Gruntfuggly.todo-tree
code --install-extension eamodio.gitlens
code --install-extension bierner.markdown-preview-github-styles
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension xabikos.javascriptsnippets

# Install all useful Apps
echo "${green}Installing Chrome...${reset}"
brew cask install google-chrome

echo "${green}Installing Alfred...${reset}"
brew cask install alfred

echo "${green}Installing appcleaner...${reset}"
brew cask install appcleaner

echo "${green}Installing slack...${reset}"
brew cask install slack

echo "${green}Installing dropbox...${reset}"
brew cask install dropbox

echo "${green}Installing spotify...${reset}"
brew cask install spotify

echo "${green}Installing postman...${reset}"
brew cask install postman

echo "${green}Installing rectangle...${reset}"
brew cask install rectangle

echo "${green}Installing postico...${reset}"
brew cask install postico

echo "${green}Installing whatsapp...${reset}"
brew cask install whatsapp

echo "${green}Installing kindle...${reset}"
brew cask install kindle

echo "${green}Installing send-to-kindle...${reset}"
brew cask install send-to-kindle

echo "${green}Installing clipy...${reset}"
brew cask install clipy

# Install App Store CLI
brew install mas

# Install XCode from the App Store using its identifier
mas install 497799835

#Done
echo "\n\Done! 🎉 You might need to log out and in for changes to take effect."