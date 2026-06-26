# SimCode — Papa Jerry's Family Virtual World
A free, browser-based virtual world that runs entirely inside a GitHub Codespace. Family members connect using just a URL — no installs, no downloads required.

---

## Every Time You Start Up

### Terminal 1 — Fix IP, then Cleanup:
```bash
MYIP=$(hostname -I | awk '{print $1}') && sed -i "s/ExternalHostName = .*/ExternalHostName = $MYIP/" /workspaces/simcode/opensim-0.9.3.0/bin/Regions/Regions.ini && bash /workspaces/simcode/cleanup.sh
```

### Terminal 2 — Start OpenSim:
```bash
export DOTNET_ROOT=$HOME/.dotnet && export PATH=$HOME/.dotnet:$PATH && cd /workspaces/simcode/opensim-0.9.3.0/bin && dotnet OpenSim.dll
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

### Terminal 5 (or maybe Terminal 1) — Copy portal:
```bash
sudo cp /workspaces/simcode/portal.html /usr/share/novnc/portal.html
```

### Then:
1. Ports tab → right-click **6081** → set **Public**
2. Ports tab → right-click **8080** → set **Public**
3. Get your portal URL from the Ports tab — copy the 6081 URL and add `/portal.html`:
```
https://your-codespace-name-6081.app.github.dev/portal.html
```
4. Then enter Papa Jerry's world webpage on https://satorizak.github.io/simcode/

---

## How Family Members Connect
1. Open https://satorizak.github.io/simcode/ in any browser — this will open the portal
2. Click **Join — Session 1** or **Join — Session 2**
3. A new tab opens with the Singularity login screen
4. Select **Local Host** from the grid dropdown
5. Enter avatar first name, last name, and password
6. Wait about 5 minutes for the world and avatars to fully load

---

## OpenSim Console Commands
The OpenSim console is running live in Terminal 2. Just click on it and type commands at the `Region (My Region) #` prompt:

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
| `opensim-0.9.3.0/bin/OpenSim.ini` | Main OpenSim configuration |
| `opensim-0.9.3.0/bin/Regions/Regions.ini` | Region configuration |
| `opensim-0.9.3.0/bin/config-include/StandaloneCommon.ini` | Standalone grid config |

---

## Important Notes
- The portal URL changes every Codespace restart — share the new URL each time
- The IP fix in Terminal 1 is required every restart — the Codespace gets a new internal IP each time
- Avatar accounts and world objects persist between restarts
- Always run Terminal 1 first to avoid leftover process conflicts
- In the Singularity login screen, always select **Local Host** as the grid

---

## Troubleshooting

**Portal URL returns 404:**
In the Ports tab, right-click port 6081 → Delete, then click Add Port → type 6081 → Enter, then right-click → Set Public. Try the URL again.

**noVNC error on screen:**
Press F5 to refresh the page — the session will reconnect normally.
