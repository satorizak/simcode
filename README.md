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
5. Then enter Papa Jerry's world webpage on https://satorizak.github.io/simcode/  

---

## How Family Members Connect

1. Open the https://satorizak.github.io/simcode/ URL in any browser - this will open the portal
2. Click **Join — Session 1** or **Join — Session 2**
3. A new tab opens with the Singularity login screen
4. Enter avatar first name, last name, and password
5. Wait about 5 minutes for the world and avatars to fully load

---
To summarize the working startup procedure each session:
Terminal 1:
bashbash /workspaces/simcode/startup.sh
Wait for Region (My Region) #
Terminal 2:
bashbash /workspaces/simcode/launch_user.sh 1 6081
Terminal 3:
bashbash /workspaces/simcode/launch_user.sh 2 8080
Terminal 4:
bashsudo cp /workspaces/simcode/portal.html /usr/share/novnc/portal.html
Then set ports 6081 and 8080 to Public, and log in with Local Host grid in Singularity.
