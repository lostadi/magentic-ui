#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# 1. Ollama Installation
if command -v ollama &> /dev/null
then
    echo "Ollama is already installed. Skipping installation."
else
    echo "Installing Ollama..."
    curl -fsSL https://ollama.com/install.sh | sh
fi

# 2. Pull Ollama Model
MODEL_NAME="huihui_ai/qwen2.5-abliterate:0.5b"
if ollama list | grep -q "$MODEL_NAME"
then
    echo "Ollama model $MODEL_NAME is already pulled. Skipping."
else
    echo "Pulling Ollama model $MODEL_NAME..."
    ollama pull "$MODEL_NAME"
fi

# 3. Project Dependencies
# Install uv if not present
if command -v uv &> /dev/null
then
    echo "uv is already installed. Skipping installation."
else
    echo "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    # Source environment variables to make uv available in the current session
    source "$HOME/.cargo/env" 
fi

echo "Installing project dependencies using uv..."
# Assuming pyproject.toml is set up for local installation
# If requirements.txt exists, you might prefer:
# if [ -f "requirements.txt" ]; then
# uv pip install -r requirements.txt
# else
# uv pip install .
# fi
# For now, directly using `uv pip install .` as pyproject.toml is present
# Alternatively, to sync with uv.lock if pyproject.toml is suitable:
# uv pip sync --locked pyproject.toml
uv pip install .


# 4. Running the Application
echo "--------------------------------------------------"
echo "Setup complete."
echo "To run the application, add the appropriate command below and uncomment it."
echo "For example:"
echo "# python -m src.magentic_ui.main"
echo "# or, if your project uses a different entry point, modify accordingly."
echo "--------------------------------------------------"

# Make the script executable (this line makes the script itself executable)
# chmod +x setup_popos.sh
# However, this is usually done from outside the script.
# The task asks for `chmod +x setup_popos.sh` to be run after creation.

echo "Script setup_popos.sh created successfully."
echo "Run 'source ~/.cargo/env' if uv command is not found in your current terminal session after first install."
echo "Then make it executable by running: chmod +x setup_popos.sh"
