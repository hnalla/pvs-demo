#!/bin/bash

# If the .venv directory exists, delete it
if [ -d ".venv" ]; then
    echo "Deleting existing virtual environment..."
    rm -rf .venv
fi

echo "Checking if python3.10 is installed..."

# Check if python3.10 is installed
if ! command -v python3.10 &> /dev/null
then
    echo "python3.10 could not be found"
    exit
fi

echo "Creating a virtual environment..."

# Create a virtual environment
python3.10 -m venv .venv

echo "Activating the virtual environment..."

# Activate the virtual environment
source .venv/bin/activate

echo "Upgrading pip..."

# Upgrade pip
pip install --upgrade pip

echo "Installing packages from requirements.txt..."
pip install -r requirements.txt
