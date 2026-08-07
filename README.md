# SimCode — Papa Jerry's Family Virtual World
A free, browser-based virtual world that runs entirely inside a GitHub Codespace. Family members connect using just a URL — no installs, no downloads required.

---

## Every Time You Start Up

everything should just start automatically

### Next:
1. Ports tab → right-click **6081** → set **Public**
2. Ports tab → right-click **8080** → set **Public**

## How Family Members Connect
1. Open https://satorizak.github.io/simcode/ in any browser — this will open the portal
2. Click **Join — Session 1** or **Join — Session 2**
3. A new tab opens with the Singularity login screen
4. Select **Local Host** from the grid dropdown
5. Enter avatar first name, last name, and password
6. Wait about 5 minutes for the world and avatars to fully load

---

## OpenSim Console Commands
1. pkill -f "dotnet OpenSim" — stops the backgrounded instance from start_all.sh so there's no conflict
2. cd /workspaces/simcode/opensim-0.9.3.0/bin && dotnet OpenSim.dll — runs it in the foreground, giving you the interactive console
Do your create user / save oar / load oar work at the console prompt
shutdown — clean graceful shutdown, flushes everything to OpenSim.db
3. bash /workspaces/simcode/start_all.sh — brings the full automated stack back up (fresh OpenSim instance, both viewer sessions, portal.html restored, everything)

One small note on step 5: start_all.sh already does its own cleanup (pkill on all the relevant processes) as its first step, so it's safe to run even though you already killed OpenSim manually — no conflict there.

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
- Avatar accounts and world objects persist between restarts
- In the Singularity login screen, always select **Local Host** as the grid

