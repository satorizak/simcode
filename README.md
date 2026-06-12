# SimCode — Papa Jerry's Family Virtual World

A free, browser-based virtual world that runs entirely inside a GitHub Codespace. Family members connect using just a URL — no installs, no downloads required.

---

## Every Time You Start Up

### Terminal 1 — Cleanup first:
```bash
bash /workspaces/simcode/cleanup.sh
```

### Terminal 2 — Start OpenSim:
```bash
export DOTNET_ROOT=/usr/lib/dotnet
export PATH=/usr/lib/dotnet:$PATH
cd /workspaces/simcode/opensim-0.9.3.0/bin
dotnet OpenSim.dll
```
Wait for `Region (My Region) #` to appear.

### Terminal 3 — Session 1:
```bash
bash /workspaces/simcode/launch_user.sh 1 6081
```

### Terminal 4 — Session 2:
```bash
bash /workspaces/simcode/launch_user.sh 2 8080
```

### Then:
1. Ports tab → right-click **6081** → set **Public**
2. Ports tab → right-click **8080** → set **Public**
3. Copy portal to web folder:
```bash
sudo cp /workspaces/simcode/portal.html /usr/share/novnc/portal.html
```
4. Get your portal URL from the Ports tab — copy the 6081 URL and add `/portal.html`:
```
https://your-codespace-name-6081.app.github.dev/portal.html
```
5. Share that URL with family!

---

## How Family Members Connect

1. Open the portal URL in any browser
2. Click **Join — Session 1** or **Join — Session 2**
3. A new tab opens with the Singularity login screen
4. Enter avatar first name, last name, and password
5. Wait about 5 minutes for the world and avatars to fully load

---

## OpenSim Console Commands

To access the OpenSim console (running in Terminal 2):
```bash
tmux attach -t opensim
```
Press **Ctrl+B then D** to detach without stopping OpenSim.

Useful console commands:
- `create user` — add a new avatar account
- `show users` — list logged in users
- `alert general "message"` — send message to all users
- `shutdown` — stop OpenSim cleanly

---

## Adding a New Avatar Account

At the OpenSim console prompt `Region (My Region) #` type:
```
create user
```
Follow the prompts. Accounts are saved permanently between sessions.

---

## Practical Limits

| Sessions | Terminals | Notes |
|----------|-----------|-------|
| 1 | 3 | OpenSim + cleanup + 1 session |
| 2 | 4 | Recommended for family use |
| 3 | 5 | Maximum recommended |

- Codespaces free tier: 8GB RAM, 60 hours/month
- Auto-stops after 30 minutes of inactivity
- Deleted after 30 days of inactivity — use it regularly!
- Avatars take about 5 minutes to fully load

---

## Session Ports

| Session | Port |
|---------|------|
| Session 1 | 6081 |
| Session 2 | 8080 |

---

## Files in This Repo

| File | Purpose |
|------|---------|
| `cleanup.sh` | Kills all leftover processes before startup |
| `launch_user.sh` | Launches a complete user session |
| `portal.html` | Family portal webpage with session buttons |
| `playit-old` | playit.gg v0.15.26 binary (kept for future use) |
| `opensim-0.9.3.0/bin/OpenSim.ini` | Main OpenSim configuration |
| `opensim-0.9.3.0/bin/Regions/Regions.ini` | Region configuration |
| `opensim-0.9.3.0/bin/config-include/StandaloneCommon.ini` | Standalone grid config |

---

## Important Notes

- The portal URL changes every Codespace restart — share the new URL each time
- Avatar accounts and world objects persist between restarts
- Always run cleanup.sh first to avoid leftover process conflicts
