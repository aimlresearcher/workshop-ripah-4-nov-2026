#!/usr/bin/env bash
# Start the workshop: makes sure Ollama is running, then opens JupyterLab.
set -euo pipefail
cd "$(dirname "$0")"

if [ ! -x .venv/bin/python ]; then
    echo "Please run ./setup_arch.sh first."
    exit 1
fi
if ! systemctl is-active --quiet ollama; then
    echo "Starting Ollama..."
    sudo systemctl start ollama
fi
exec .venv/bin/python -m jupyterlab
