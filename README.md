# SimCode — Papa Jerry's Family Virtual World

A free, browser-based virtual world that runs entirely inside a GitHub Codespace. Family members connect using just a URL — no installs, no downloads required.

---

## How It Works

OpenSimulator runs as the world server inside the Codespace. Each user gets their own Singularity viewer running in a virtual desktop, streamed to their browser via noVNC. All communication stays on localhost inside the Codespace.

```
Family member's browser → Portal page → noVNC → Singularity viewer → OpenSimulator
```

---

## Every Time You Start Up

### Step 1 — Start OpenSim

Open a terminal and run:

```bash
export DOTNET_ROOT=/usr/lib/dotnet
export PATH=/usr/lib/dotnet:$PATH
cd /workspaces/simcode/opensim-0.9.3.0/bin
dotnet OpenSim.dll
```

Wait until you see:

```
Region (My Region) #
```

---

### Step 2 — Launch user sessions

Open a **new terminal** for each session:

**Session 1:**
```bash
bash /workspaces/simcode/launch_user.sh 1 6081
```

**Session 2:**
```bash
bash /workspaces/simcode/launch_user.sh 2 6082
```

**Session 3 (optional):**
```bash
bash /workspaces/simcode/launch_user.sh 3 6083
```

---

### Step 3 — Make ports public

1. Click the **Ports tab** at the bottom of Codespaces
2. Right-click port **6081** → Port Visibility → **Public**
3. Right-click port **6082** → Port Visibility → **Public**
4. Copy the URL for port **6081** — this is your portal address

---

### Step 4 — Copy portal to web folder

```bash
sudo cp /workspaces/simcode/portal.html /usr/share/novnc/portal.html
```

---

### Step 5 — Share the portal URL

The portal address looks like:
```
https://your-codespace-name-6081.app.github.dev/portal.html
```

Send this link to family members. They open it in any browser and click a session button to enter the world.

---

## How Family Members Connect

1. Open the portal URL in any browser
2. Click **Join — Session 1** or **Join — Session 2**
3. A new tab opens with the Singularity login screen
4. Enter avatar first name, last name, and password
5. Wait about 5 minutes for the world and avatars to fully load

---

## Adding a New Avatar Account

At the OpenSim console prompt `Region (My Region) #` type:

```
create user
```

Follow the prompts to set first name, last name, and password. Accounts are saved permanently.

---

## Practical Limits

| Sessions | Terminals needed | Notes |
|----------|-----------------|-------|
| 1 | 2 | OpenSim + 1 session |
| 2 | 3 | Recommended for family use |
| 3 | 4 | Maximum recommended |

Codespaces free tier: 8GB RAM, 60 hours/month, auto-stops after 30 minutes idle.

---

## Files in This Repo

| File | Purpose |
|------|---------|
| `launch_user.sh` | Launches a complete user session |
| `portal.html` | Family portal webpage with session buttons |
| `status.py` | Optional session status server |
| `playit-old` | playit.gg v0.15.26 binary (kept for future use) |
| `opensim-0.9.3.0/bin/OpenSim.ini` | Main OpenSim configuration |
| `opensim-0.9.3.0/bin/Regions/Regions.ini` | Region configuration |
| `opensim-0.9.3.0/bin/config-include/StandaloneCommon.ini` | Standalone grid config |

---

## Important Notes

- Avatar accounts and world data persist between Codespace sessions
- The portal URL changes every time the Codespace restarts
- GitHub auto-stops a Codespace after 30 minutes of inactivity
- GitHub deletes a Codespace after 30 days of inactivity — use it regularly!
- Avatars take about 5 minutes to fully load due to software rendering
