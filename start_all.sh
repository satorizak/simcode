#!/bin/bash
set -uo pipefail

LOGDIR=/workspaces/simcode/logs
mkdir -p "$LOGDIR"

echo "[start_all] Cleaning up old processes..."
pkill -f "dotnet OpenSim" 2>/dev/null || true
pkill -f singularity 2>/dev/null || true
pkill -f websockify 2>/dev/null || true
pkill -f x11vnc 2>/dev/null || true
pkill -f Xvfb 2>/dev/null || true
pkill -f fluxbox 2>/dev/null || true
sleep 3

echo "[start_all] Setting ExternalHostName..."
MYIP=$(hostname -I | awk '{print $1}')
sed -i "s/ExternalHostName = .*/ExternalHostName = $MYIP/" \
  /workspaces/simcode/opensim-0.9.3.0/bin/Regions/Regions.ini

echo "[start_all] Starting OpenSim..."
cd /workspaces/simcode/opensim-0.9.3.0/bin
setsid nohup dotnet OpenSim.dll > "$LOGDIR/opensim.log" 2>&1 < /dev/null &
disown
echo "[start_all] OpenSim launched — logging to $LOGDIR/opensim.log"

echo "[start_all] Waiting for OpenSim's HTTP server (port 9000)..."
for i in $(seq 1 60); do
  if (echo > /dev/tcp/127.0.0.1/9000) >/dev/null 2>&1; then
    echo "[start_all] OpenSim is up."
    break
  fi
  if grep -qi "Fatal error" "$LOGDIR/opensim.log" 2>/dev/null; then
    echo "[start_all] OpenSim hit a fatal error — check $LOGDIR/opensim.log"
    break
  fi
  sleep 2
done

echo "[start_all] Restoring portal.html into novnc web root..."
sudo cp /workspaces/simcode/portal.html /usr/share/novnc/portal.html

echo "[start_all] Launching viewer sessions..."
setsid nohup bash /workspaces/simcode/launch_user.sh 1 6081 > "$LOGDIR/session1.log" 2>&1 < /dev/null &
disown
setsid nohup bash /workspaces/simcode/launch_user.sh 2 8080 > "$LOGDIR/session2.log" 2>&1 < /dev/null &
disown

sleep 5

echo "[start_all] Done. Logs in $LOGDIR — ports 6081 and 8080 should be reachable shortly."

if [ -n "${CODESPACE_NAME:-}" ]; then
  echo "[start_all] Current Codespace name: $CODESPACE_NAME"
  echo "[start_all] Portal URL: https://${CODESPACE_NAME}-6081.app.github.dev/portal.html"
  echo "[start_all] If this differs from the GitHub Pages portal (satorizak.github.io/simcode),"
  echo "[start_all] update CODESPACE_NAME in index.html to match."
else
  echo "[start_all] CODESPACE_NAME not set — could not print portal URL."
fi
