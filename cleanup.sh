#!/bin/bash
echo "Cleaning up old processes..."
pkill -f singularity 2>/dev/null
pkill -f websockify 2>/dev/null
pkill -f x11vnc 2>/dev/null
pkill -f Xvfb 2>/dev/null
pkill -f fluxbox 2>/dev/null
sleep 2
echo "All clear!"
