# This PowerShell script is intended to set up a Python virtual environment for a project.
# It assumes that a virtual environment has already been created in the .venv directory
# and that there is a requirements.txt file listing the necessary Python packages.

# Activate the Python virtual environment.
# This changes the shell’s environment to use the Python interpreter and libraries from the .venv directory.
.\.venv\Scripts\Activate.ps1

# Install the Python dependencies listed in the requirements.txt file.
# This ensures that all the necessary libraries are installed in the virtual environment for the project.
pip install -r requirements.txt
