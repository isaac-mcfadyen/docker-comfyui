#!/bin/bash
set -e

COMFYUI_COMMIT=${COMFYUI_COMMIT:-master}
USE_XFORMERS=${USE_XFORMERS:-false}

# Clone ComfyUI if it doesn't exist.
if [ ! -d "/comfyui/.git" ]; then
    git clone https://github.com/comfyanonymous/ComfyUI.git /comfyui
fi

# Checkout the specified commit.
cd /comfyui
git fetch
git checkout $COMFYUI_COMMIT

# Create a virtualenv if one doesn't exist.
if [ ! -d "./venv" ]; then
    python3 -m venv venv
fi

# Install PyTorch based on the value of USE_XFORMERS, because otherwise xformers overrides the PyTorch version.
if [ "$USE_XFORMERS" = true ]; then
    /comfyui/venv/bin/pip install xformers torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu121
else
    /comfyui/venv/bin/pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu121
fi

# Install other dependencies.
/comfyui/venv/bin/pip install -r requirements.txt

# Start ComfyUI.
exec /comfyui/venv/bin/python main.py --listen 0.0.0.0 --preview-method auto