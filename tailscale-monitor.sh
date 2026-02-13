#!/bin/bash

# --- CONFIG ---
TOKEN="your_token_here"
CHAT_ID="your_chat_id_here"

# Set paths to ensure cron can find binaries
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# --- STATUS CHECK ---
# Grab the BackendState directly using jq
STATUS=$(tailscale status --json | jq -r .BackendState)

# Fallback if jq fails or status is empty
if [ -z "$STATUS" ] || [ "$STATUS" == "null" ]; then
    STATUS="Offline/Unknown"
fi

# --- NOTIFICATION LOGIC ---
if [ "$STATUS" != "Running" ]; then
    MESSAGE="⚠️ Tailscale Alert!
Host: $(hostname)
Status: $STATUS
Time: $(date '+%Y-%m-%d %H:%M:%S')
Action: Manual re-authentication may be required."

    curl -s -X POST "[https://api.telegram.org/bot$TOKEN/sendMessage](https://api.telegram.org/bot$TOKEN/sendMessage)" \
        -d "chat_id=$CHAT_ID" \
        -d "text=$MESSAGE"
fi
