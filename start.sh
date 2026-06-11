#!/bin/bash

echo "🌍 Starting Papa Jerry's World..."
echo ""

# Fix dotnet path
export DOTNET_ROOT=/usr/lib/dotnet
export PATH=/usr/lib/dotnet:$PATH

# Start OpenSim in tmux
tmux new-session -d -s opensim -x 220 -y 50
tmux send-keys -t opensim "export DOTNET_ROOT=/usr/lib/dotnet && export PATH=/usr/lib/dotnet:\$PATH && cd /workspaces/simcode/opensim-0.9.3.0/bin && dotnet OpenSim.dll" Enter
echo "✅ OpenSim starting in tmux session 'opensim'"
echo "   (type 'tmux attach -t opensim' to see the console)"

# Wait for OpenSim to be ready
echo "⏳ Waiting for OpenSim to be ready..."
sleep 30

# Launch Session 1
echo "✅ Starting Session 1 on port 6081..."
Xvfb :1 -screen 0 1024x768x16 &
sleep 1
DISPLAY=:1 fluxbox &
sleep 1
x11vnc -display :1 -nopw -listen localhost -rfbport 5901 -forever -shared &
sleep 2
websockify --web=/usr/share/novnc/ 6081 localhost:5901 &
sleep 1
cd /workspaces/simcode/Singularity_1_8_9_8338_x86_64
DISPLAY=:1 ./singularity &
cd /workspaces/simcode

# Launch Session 2
echo "✅ Starting Session 2 on port 6082..."
Xvfb :2 -screen 0 1024x768x16 &
sleep 1
DISPLAY=:2 fluxbox &
sleep 1
x11vnc -display :2 -nopw -listen localhost -rfbport 5902 -forever -shared &
sleep 2
websockify --web=/usr/share/novnc/ 6082 localhost:5902 &
sleep 1
cd /workspaces/simcode/Singularity_1_8_9_8338_x86_64
DISPLAY=:2 ./singularity &
cd /workspaces/simcode

# Copy portal
sudo cp /workspaces/simcode/portal.html /usr/share/novnc/portal.html
echo "✅ Portal page ready"

# Get the Codespace URL
CODESPACE_URL=$(echo $CODESPACE_NAME)
if [ -n "$CODESPACE_URL" ]; then
  PORTAL_URL="https://${CODESPACE_NAME}-6081.app.github.dev/portal.html"
else
  PORTAL_URL="Check the Ports tab for your 6081 URL, then add /portal.html"
fi

echo ""
echo "========================================="
echo "🌍 Papa Jerry's World is starting up!"
echo "========================================="
echo ""
echo "📋 Your portal URL is:"
echo "   $PORTAL_URL"
echo ""
echo "👉 Now do these 2 things in the Ports tab:"
echo "   1. Right-click port 6081 → set Public"
echo "   2. Right-click port 6082 → set Public"
echo ""
echo "⏳ World will be fully ready in about 5 minutes"
echo "========================================="
