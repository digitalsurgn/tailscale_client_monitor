# Tailscale Status Monitor & Telegram Alerter

A lightweight Bash script designed for Linux environments (Ubuntu/Alpine/LXC) to monitor the **Tailscale** backend state and send real-time alerts via **Telegram** when a node requires re-authentication or goes offline.

## 🚀 Features
- **Real-time Monitoring:** Detects if Tailscale is `Running`, `NeedsLogin`, or `Stopped`.
- **Reliable Parsing:** Uses `jq` for accurate JSON data extraction.
- **Smart Notifications:** Sends formatted Telegram alerts including Hostname and Timestamp.
- **LXC/Docker Compatible:** Works within Proxmox containers and virtual machines.

---

## 🛠️ Prerequisites

1. **Tailscale** installed and configured.
2. **jq** installed (for JSON parsing):
   - *Ubuntu/Debian:* `sudo apt update && sudo apt install jq -y`
   - *Alpine:* `apk add jq`
3. **curl** installed (for sending Telegram messages).

---

## 🤖 Telegram Bot Setup

To send notifications, you need a Telegram Bot and your personal Chat ID.

### 1. Create the Bot
1. Search for **@BotFather** on Telegram.
2. Send `/newbot` and follow the instructions to name your bot.
3. **Save the API Token** provided (e.g., `12345678:AAH...`).

### 2. Get Your Chat ID
1. Search for your new bot's username and press **Start**.
2. Visit the following URL in your browser (replace `YOUR_TOKEN` with your API Token):
   `https://api.telegram.org/botYOUR_TOKEN/getUpdates`
3. Look for `"id":` in the JSON response (e.g., `987654321`). This is your **Chat ID**.
   - *Note: If sending to a group, add the bot to the group and use a bot like @IDBot to get the group ID (it will start with a `-`).*

---

## 📥 Installation

1. **Create the script file:**
   ```bash
   sudo nano /usr/local/bin/tailscale-monitor.sh
