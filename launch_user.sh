#!/bin/bash
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: ./launch_user.sh <User_Number> <Web_Port>"
  echo "Example: ./launch_user.sh 1 6081"
  exit 1
fi

NUM=$1
WEB_PORT=$2
VNC_PORT=$((5900 + NUM))
DISPLAY_ID=":$NUM"

echo "Launching Session $NUM on Web Port $WEB_PORT..."

# Create isolated virtual screen
Xvfb $DISPLAY_ID -screen 0 1280x720x24 &
sleep 1

# Launch window manager for this screen
DISPLAY=$DISPLAY_ID fluxbox &
sleep 1

# Stream screen to its own VNC port
x11vnc -display $DISPLAY_ID -nopw -listen localhost -rfbport $VNC_PORT -forever -shared &
sleep 1

# Bind web browser endpoint to web port
websockify --web=/usr/share/novnc/ $WEB_PORT localhost:$VNC_PORT &
sleep 1

# Launch Singularity into this display
cd /workspaces/simcode/Singularity_1_8_9_8338_x86_64
DISPLAY=$DISPLAY_ID ./singularity &


echo "Session $NUM ready! Open port $WEB_PORT in Codespaces Ports tab and set to Public."
