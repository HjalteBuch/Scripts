#!/bin/bash

# Extract the base name of the selected directory for the session name
SESSION_NAME="Notes"

if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    if [[ -n "$TMUX" ]]; then
       tmux switch-client -t "$SESSION_NAME"
    else
        tmux attach-session -t "$SESSION_NAME"
    fi
else
    # Create a new session
    tmux new-session -d -s "$SESSION_NAME" -c "$HOME/Documents/workstation/" -n Obsidian

    if [[ -n "$TMUX" ]]; then
       tmux switch-client -t "$SESSION_NAME"
    else
        tmux attach-session -t "$SESSION_NAME"
    fi
fi
