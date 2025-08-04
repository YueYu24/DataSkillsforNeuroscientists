#!/bin/bash
set -ex

# This script is intended to run tests that the Python scripts and notebooks in this project work correctly.

# Format and check Python files using ruff
ruff format python/*.py
ruff check python/*.py

# Install Python dependencies
pip install -r requirements.txt

# Run the data loading scripts
cd python
python LoadCSVData.py -nogui
python LoadMatData.py -nogui

# Regenerate the NWB file
python WriteMetadata.py
python CreateNWB.py

# Test running the notebook
cd ../notebooks
pytest --nbmake GurnaniData.ipynb  # requires pip install nbmake 

echo "Finished running tests"