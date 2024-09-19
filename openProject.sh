#!/bin/bash

# Define the directories to search
PROJECT_DIRS=("$HOME/Projects" "$HOME/Dotfiles" "$HOME/.config")

# Find directories within the specified project directories
SELECTED_DIR=$(find "${PROJECT_DIRS[@]}" -maxdepth 1 -type d | fzf --tmux)

# Exit if no directory was selected
if [[ -z "$SELECTED_DIR" ]]; then
  echo "No directory selected."
  exit 1
fi

# Extract the base name of the selected directory for the session name
SESSION_NAME=$(basename "$SELECTED_DIR")

if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    if [[ -n "$TMUX" ]]; then
       tmux switch-client -t "$SESSION_NAME"
    else
        tmux attach-session -t "$SESSION_NAME"
    fi
else
    # Create a new session
    tmux new-session -d -s "$SESSION_NAME" -c "$SELECTED_DIR" -n Nvim

    if [[ -n "$TMUX" ]]; then
       tmux switch-client -t "$SESSION_NAME"
    else
        tmux attach-session -t "$SESSION_NAME"
    fi

    tmux new-window -d -t "$SESSION_NAME" -c "$SELECTED_DIR" -n Terminal

    # Dropping this window, I can just a shortuct that will always go here
    #tmux new-window -c ~/Documents/workstation/ -n Notes
fi
