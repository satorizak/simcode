#!/bin/bash
export DOTNET_ROOT=/usr/lib/dotnet
export PATH=/usr/lib/dotnet:$PATH

# Start virtual desktop
Xvfb :1 -screen 0 1280x720x24 &
sleep 1
DISPLAY=:1 fluxbox &
sleep 1
x11vnc -display :1 -nopw -listen localhost -xkb -forever -shared &
sleep 1
websockify --web=/usr/share/novnc/ 6080 localhost:5900 &
sleep 1

echo "Virtual desktop running - open port 6080 in browser"
echo "Now start OpenSim in a new terminal with: cd /workspaces/simcode/opensim-0.9.3.0/bin && dotnet OpenSim.dll"
echo "Then start Singularity with: cd /workspaces/simcode/Singularity_1_8_9_8338_x86_64 && DISPLAY=:1 ./singularity &"
