# REBUILD Guide — Papa Jerry's World from Scratch

Use this guide if the Codespace gets deleted and you need to rebuild everything from zero.
All scripts and config files are saved in the GitHub repo at `https://github.com/satorizak/simcode`.

---

## Step 1 — Create a New Codespace

1. Go to `https://github.com/satorizak/simcode`
2. Click the green **Code** button
3. Click **Codespaces** tab
4. Click **Create codespace on main**
5. Wait for it to start up

---

## Step 2 — Install Required Packages

In the terminal run:

```bash
sudo apt-get update
sudo apt-get install -y dotnet-runtime-8.0 x11vnc xvfb fluxbox websockify novnc tmux netcat-openbsd libvorbis-dev libvorbisenc2 libglu1-mesa libopenal-dev libsdl1.2-dev libgtk2.0-0 libgdk-pixbuf2.0-0
```

---

## Step 3 — Fix dotnet Path

```bash
export DOTNET_ROOT=/usr/lib/dotnet
export PATH=/usr/lib/dotnet:$PATH
dotnet --list-runtimes
```

You should see `Microsoft.NETCore.App 8.0.x` in the list.

---

## Step 4 — Download OpenSimulator

```bash
cd /workspaces/simcode
wget http://opensimulator.org/dist/opensim-0.9.3.0.tar.gz
tar -xvf opensim-0.9.3.0.tar.gz
```

---

## Step 5 — Restore OpenSim Config Files

The config files are saved in the repo. Copy them into place:

```bash
cp /workspaces/simcode/opensim-0.9.3.0/bin/OpenSim.ini /workspaces/simcode/opensim-0.9.3.0/bin/OpenSim.ini
```

The config files are already in the right place since they're part of the repo — no action needed!

Just verify they exist:

```bash
ls /workspaces/simcode/opensim-0.9.3.0/bin/OpenSim.ini
ls /workspaces/simcode/opensim-0.9.3.0/bin/Regions/Regions.ini
ls /workspaces/simcode/opensim-0.9.3.0/bin/config-include/StandaloneCommon.ini
```

---

## Step 6 — Download Singularity Viewer

```bash
cd /workspaces/simcode
curl -L https://github.com/singularity-viewer/SingularityViewer/releases/download/sv-1.8.9.8338-release/Singularity_1_8_9_8338_x86_64.tar.xz -o Singularity_1_8_9_8338_x86_64.tar.xz
tar -xf Singularity_1_8_9_8338_x86_64.tar.xz
```

---

## Step 7 — Install Missing Singularity Libraries

```bash
sudo apt-get install -y libvorbis-dev libvorbisenc2 libglu1-mesa libopenal-dev libsdl1.2-dev libgtk2.0-0t64 libgdk-pixbuf2.0-0
```

---

## Step 8 — Test OpenSim Starts

```bash
export DOTNET_ROOT=/usr/lib/dotnet
export PATH=/usr/lib/dotnet:$PATH
cd /workspaces/simcode/opensim-0.9.3.0/bin
dotnet OpenSim.dll
```

Wait for `Region (My Region) #` — then type `shutdown` to stop it.

---

## Step 9 — Fix Unix Server PHP Files

If needed, re-upload these two files to `https://fs3.just.edu.tw/~satori/1oworld/`:

**index.php** — replace `__DIR__` with full path:
```php
$url_file = '/home2/satori/public_html/1oworld/world_url.txt';
```

**update.php** — replace `__DIR__` with full path:
```php
file_put_contents('/home2/satori/public_html/1oworld/world_url.txt', $url);
```

Make sure `world_url.txt` exists and has permissions **666**.

---

## Step 10 — You're Ready!

Follow the normal startup instructions in `README.md`:

```bash
bash /workspaces/simcode/cleanup.sh
```

Then start OpenSim and the two user sessions as described in README.md.

---

## Avatar Accounts

Avatar accounts are stored in the OpenSim database files:
- `opensim-0.9.3.0/bin/OpenSim.db`
- `opensim-0.9.3.0/bin/avatars.db`
- `opensim-0.9.3.0/bin/auth.db`

These are NOT saved in the GitHub repo (too large). If the Codespace is deleted, avatar accounts will be lost and need to be recreated with `create user` at the OpenSim console.

To avoid losing avatars, periodically back them up:

```bash
cp /workspaces/simcode/opensim-0.9.3.0/bin/OpenSim.db ~/OpenSim.db.backup
cp /workspaces/simcode/opensim-0.9.3.0/bin/avatars.db ~/avatars.db.backup
cp /workspaces/simcode/opensim-0.9.3.0/bin/auth.db ~/auth.db.backup
```

---

## Summary of What Gets Downloaded Fresh Each Rebuild

| Item | Source |
|------|---------|
| OpenSimulator 0.9.3.0 | opensimulator.org |
| Singularity viewer | GitHub releases |
| apt packages | Ubuntu repos |
| Avatar accounts | Must recreate with `create user` |

## Summary of What's Already in the Repo

| Item | Location |
|------|----------|
| All scripts | `/workspaces/simcode/` |
| OpenSim config | `/workspaces/simcode/opensim-0.9.3.0/bin/` |
| Portal page | `/workspaces/simcode/portal.html` |
| This guide | `/workspaces/simcode/REBUILD.md` |
