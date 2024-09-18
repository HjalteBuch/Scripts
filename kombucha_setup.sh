#!/bin/bash

SESSION_NAME="Kombucha"

# Check if the session already exists
if tmux has-session -t $SESSION_NAME 2>/dev/null; then
    echo "Session $SESSION_NAME already exists. Attaching to it."
    tmux attach-session -t $SESSION_NAME
else
    # Create a new session
    tmux new-session -d -s $SESSION_NAME -c ~/Projects/kombucha/Kombucha/ -n Backend

    tmux new-window -c ~/Projects/kombucha/kombuchafrontend/ -n Frontend

    tmux new-window -c ~/Documents/workstation/ -n Notes

    tmux new-window -c ~ -n Server

    tmux attach-session -t $SESSION_NAME
fi
