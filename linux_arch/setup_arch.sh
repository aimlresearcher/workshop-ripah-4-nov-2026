#!/usr/bin/env bash
# One-time setup for the Agentic AI workshop on Arch Linux.
# Run it from this folder:   ./setup_arch.sh
# Another model:             MODEL=llama3.2:1b ./setup_arch.sh
set -euo pipefail
cd "$(dirname "$0")"
MODEL="${MODEL:-llama3.2}"

echo "== 1/4  Installing Ollama and Python (pacman will ask for your password) =="
sudo pacman -S --needed ollama python python-pip
# Tip: with an NVIDIA or AMD GPU you can install ollama-cuda or ollama-rocm instead of ollama.

echo "== 2/4  Starting Ollama now and at every boot =="
sudo systemctl enable --now ollama
for _ in $(seq 1 30); do
    if ollama list >/dev/null 2>&1; then break; fi
    sleep 1
done

echo "== 3/4  Downloading the model $MODEL (about 2 GB, only the first time) =="
ollama pull "$MODEL"

echo "== 4/4  Creating .venv and installing the Python packages =="
if [ ! -x .venv/bin/python ]; then
    python -m venv .venv
fi
.venv/bin/python -m pip install --upgrade pip
.venv/bin/python -m pip install -r requirements.txt

echo
echo "Done. Start the workshop with:   ./start_workshop.sh"
