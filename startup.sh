#!/bin/bash
# ── startup.sh ──────────────────────────────────────────
# Runs automatically on Codespace start via postStartCommand.
# After it finishes, set ports 6081 and 8080 to Public manually.

set -e

echo "▶ Step 1: Cleanup…"
bash /workspaces/simcode/cleanup.sh

echo "▶ Step 2: Starting OpenSim in background…"
export DOTNET_ROOT=/usr/lib/dotnet
export PATH=/usr/lib/dotnet:$PATH
cd /workspaces/simcode/opensim-0.9.3.0/bin
dotnet OpenSim.dll > /tmp/opensim.log 2>&1 &

echo "   Waiting for region to load (may take ~60s)…"
until grep -q "Region (My Region) #" /tmp/opensim.log; do
  sleep 3
done
echo "   ✓ Region is up!"

echo "▶ Step 3: Launching noVNC sessions…"
bash /workspaces/simcode/launch_user.sh 1 6081 &
sleep 2
bash /workspaces/simcode/launch_user.sh 2 8080 &

echo "▶ Step 4: Copying portal…"
sudo cp /workspaces/simcode/portal.html /usr/share/novnc/portal.html

echo ""
echo "════════════════════════════════════════"
echo "✅ All done! Now do these two manual steps:"
echo "   Ports tab → right-click 6081 → Set Public"
echo "   Ports tab → right-click 8080 → Set Public"
echo ""
echo "   Your portal URL:"
echo "   https://${CODESPACE_NAME}-6081.app.github.dev/portal.html"
echo "════════════════════════════════════════"
