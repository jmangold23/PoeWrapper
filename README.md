# Poe AI .exe & PowerShell Wrapper

## Rationale

Poe provides limited information about their web APIs and encourages the use of their bot-to-bot Python FastAPI modules.

That is fine for Python. 

The main reason for creating an executable from a FastAPI application is to simplify the deployment process. Compiling the FastAPI code into an `.exe` file allows for easy distribution and execution on any Windows platform without the need for a Python runtime environment. This is particularly useful for end-users who may not be familiar with Python or do not want to deal with setting up a development environment.

Furthermore, wrapping the executable with a PowerShell function provides an additional layer of convenience. PowerShell is a powerful scripting language that is built into Windows, and it allows for automation and easy manipulation of the executable. By providing a PowerShell wrapper, we make it straightforward for users to interact with the provided Poe FastAPI server code, but with simple local commands and nothing to host.

# Invoke-PoeAIQuery

## Overview
The PowerShell module provides an interface to interact with PoeAI bots, facilitating the sending of queries and retrieval of responses with an option to save the output.

## Prerequisites
- PowerShell 5.0 or higher
- PoeWrapper.exe available in the script's ./dist directory

## Installation
1. Clone the repository to your local machine using Git commands or download the ZIP and extract it.
2. Ensure PoeWrapper.exe is placed in the ./dist directory.

## Usage
To use the `Invoke-PoeAIQuery` function, import the module into your PowerShell session and provide the following params:

```powershell
Import-Module .\Invoke-PoeAIQuery\Invoke-PoeAIQuery.psm1

Invoke-PoeAIQuery -ApiKey 'your-api-key' -BotName 'your-bot-name' -UserMessage 'your-message' -SystemMessage 'your-system-message' -OutputPath 'optional-output-path'

```
## Parameters
- ApiKey: Your API key for PoeAI authentication.
- BotName: The name of the bot you wish to send messages to.
- UserMessage: The user message to send to the bot.
- SystemMessage: Any system message to accompany the user message.
- OutputPath: (Optional) The file path where you want to save the output.

## Output

The function will output the response from the bot. If OutputPath is provided, it will also save the response to the specified location.


# PoeWrapper.py 

This is the base python script that gets compiled into PoeWrapper.exe. You do not need to interact with this file to use the pre-compiled PoeWrapper.exe file included with this repo.

## Quickstart

```bash
python PoeWrapper.py -ApiKey "your_api_key" -BotName "your_bot_name" -UserMessage "Tell a story." -SystemMessage "You're a pirate."
```

## Description
The ChatConductor class in PoeWrapper.py provides a CLI to interact with a chat bot using FastAPI Poe. It supports queing the bot's asynchronous communication and command-line arguments for easy use and integration.

## Usage
-ApiKey: API key for bot authentication.
-BotName: Name of the bot, default 'chatgpt'.
-UserMessage: Message to send to the bot.
-SystemMessage: System context message (optional).

Run the script directly to get the bot's response in the console.

# Environment Setup (Optional)

## Setup Script 

The `setup.ps1` script is designed to prepare your Python project environment. Here's what it does:

1. **Activate the Python Virtual Environment**: It activates the Python virtual environment which should already be created in the `.venv` directory. Activating the environment aligns the shell's environment to use the Python interpreter and the libraries located within the `.venv` directory.

    ```powershell
    .\.venv\Scripts\Activate.ps1
    ```

2. **Install Dependencies**: It installs all the Python dependencies listed in the `requirements.txt` file into the activated virtual environment. This is a crucial step to ensure that all necessary Python packages are available for the project.

    ```bash
    pip install -r requirements.txt
    ```

By running this script, you ensure that your project's virtual environment is set up consistently with all the required dependencies installed.

## Build Script

Note: The ./dist folder should already contain a compiled copy of the PoeWrapper.exe file. To update or test the build process see the information below.

`build.ps1` is a PowerShell script to compile a Python script  into a standalone executable. This process helps reduce dependencies when deploying many instances of the PowerShell module.

The script utilizes PyInstaller to transform the Python script, by default named 'PoeWrapper.py', located in the same directory as the PowerShell script into a distributable `.exe` file. Below are the steps taken by the script:

1. **Python Script Identification**: It searches for the 'PoeWrapper.py' Python script within the same directory as the PowerShell script.

2. **Compilation**: Executes PyInstaller with the following flags:
   - `--clean`: Clears the PyInstaller cache and removes temporary files before building.
   - `--noconfirm`: Overwrites the output directory without prompting for confirmation.
   - `--onefile`: Packages all necessary files into a single executable for easy distribution.
   - `--console`: Creates a console window for the executable, ideal for CLI-based utilities.

3. **Path Formatting**: Converts backslashes in the Python script path to forward slashes to prevent any command line issues.

### Prerequisites
- PyInstaller must be installed and available in the env PATH. This is handled when the setup.ps1 script is run. (See "Setup Script" section above.)

### Running the Script
To compile your Python script into an executable, simply run the PowerShell script with the following command:
```powershell
.\build.ps1
```


# Support
For support, please open an issue in the GitHub repository issue tracker.

# License
This project is licensed under the MIT License - see the LICENSE file for details.

# Contributions
Contributions are welcome. Please fork the repository and submit a pull request.

