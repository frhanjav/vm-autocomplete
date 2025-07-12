#!/bin/bash

# Simple zsh setup with autosuggestions for VMs
echo "Setting up zsh with autosuggestions..."

# Check if git exists (only dependency we might need)
GIT_INSTALLED_BY_SCRIPT=false
if ! command -v git &> /dev/null; then
    echo "Installing git..."
    if command -v apt &> /dev/null; then
        sudo apt update && sudo apt install -y git
    elif command -v yum &> /dev/null; then
        sudo yum install -y git
    elif command -v dnf &> /dev/null; then
        sudo dnf install -y git
    fi
    GIT_INSTALLED_BY_SCRIPT=true
fi

# Install zsh if needed
if ! command -v zsh &> /dev/null; then
    echo "Installing zsh..."
    if command -v apt &> /dev/null; then
        sudo apt install -y zsh
    elif command -v yum &> /dev/null; then
        sudo yum install -y zsh
    elif command -v dnf &> /dev/null; then
        sudo dnf install -y zsh
    fi
fi

# Install zsh-autosuggestions
echo "Installing zsh-autosuggestions..."
mkdir -p ~/.zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

# Create simple zsh config
cat > ~/.zshrc << 'EOF'
# Terminal compatibility for Ghostty
export TERM=xterm

# Colors and prompt
autoload -Uz colors && colors
export PROMPT='%F{green}%n@%m%f:%F{blue}%~%f$ '

# Enable completion
autoload -Uz compinit && compinit

# History
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Load autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Basic aliases
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
EOF

# Set as default shell
sudo chsh -s $(which zsh) $(whoami)

echo "✅ Done! Zsh with autosuggestions installed."
echo "💡 Use → arrow key to accept gray suggestions"
echo "🔄 Run 'exec zsh' to start using it now"

# Simple cleanup option
echo ""
read -p "Want cleanup option? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "To remove later, run these commands:"
    echo "rm -rf ~/.zsh ~/.zshrc ~/.zsh_history"
    echo "sudo chsh -s /bin/bash $(whoami)"
    if [ "$GIT_INSTALLED_BY_SCRIPT" = true ]; then
        echo "sudo apt remove git  # (if you want to remove git too)"
    fi
fi