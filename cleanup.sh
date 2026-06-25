#!/bin/bash
echo "Cleaning up old processes..."
pkill -f "dotnet OpenSim" 2>/dev/null || true
pkill -f singularity 2>/dev/null || true
pkill -f websockify 2>/dev/null || true
pkill -f x11vnc 2>/dev/null || true
pkill -f Xvfb 2>/dev/null || true
pkill -f fluxbox 2>/dev/null || true
sleep 3
echo "All clear!"
