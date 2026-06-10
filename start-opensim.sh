#!/bin/bash
export DOTNET_ROOT=/usr/lib/dotnet
export PATH=/usr/lib/dotnet:$PATH

echo "Starting playit tunnel..."
/workspaces/simcode/playit-old &

echo "Starting OpenSim..."
cd /workspaces/simcode/opensim-0.9.3.0/bin
dotnet OpenSim.dll
