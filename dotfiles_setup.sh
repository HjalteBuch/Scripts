#!/bin/bash

SESSION_NAME="Dotfiles"

# Check if the session already exists
if tmux has-session -t $SESSION_NAME 2>/dev/null; then
    echo "Session $SESSION_NAME already exists. Attaching to it."
    tmux attach-session -t $SESSION_NAME
else
    # Create a new session
    tmux new-session -d -s $SESSION_NAME -c ~/.config/nvim -n Neovim

    tmux new-window -c ~/.config/tmux -n Tmux

    tmux new-window -c ~/Documents/workstation/ -n Notes

    tmux attach-session -t $SESSION_NAME
fi
