#!/bin/bash

echo "[*] Starting Offline AI Assistant (Mistral via Ollama)"

# Start ollama daemon if not running
pgrep ollama > /dev/null || (echo "[*] Starting Ollama..." && ollama serve &)

# Run the model
echo "[*] Launching chat interface..."
ollama run mistral
