<#
.SYNOPSIS
Invokes the PoeAI query and retrieves the response.

.DESCRIPTION
This function is used to invoke a query with the PoeAI using PoeWrapper.exe. It takes in an API key for authentication, 
the name of the bot, a user message, and a system message, runs the executable, and returns the response. It writes the response
to a temporary file and, if an output path is provided, moves the file to that location.

.PARAMETER ApiKey
The API key used for authenticating with the PoeAI service.

.PARAMETER BotName
The name of the bot to which the messages will be sent.

.PARAMETER UserMessage
The message from the user that will be sent to the bot.

.PARAMETER SystemMessage
The system message that will be sent along with the user message.

.PARAMETER OutputPath
The path where the output file will be moved if this parameter is provided. If not provided, the output will be written
to a temporary file and not moved.

.EXAMPLE
Invoke-PoeAIQuery -ApiKey 'your-developer-api-key' -BotName 'chatgpt' -UserMessage 'a=5,b=3' -SystemMessage 'You only respond with valid json and nothing else.' -OutputPath 'C:\path\to\output.json'

This example invokes a PoeAI query with the provided API key, bot name, user message, system message, and moves the output to the specified file.

.NOTES
Author: Joshua Mangold 

To get your API key: https://poe.com/developers

This function is a wrapper for PoeWrapper.exe, which is a compiled wrapper for fastapi_poe.

https://github.com/poe-platform/fastapi_poe
https://developer.poe.com/server-bots/accessing-other-bots-on-poe
#>
function Invoke-PoeAIQuery {
    # Define the parameters that the function accepts.
    param (
        [string]$ApiKey,          # The API key for authenticating with the PoeAI service.
        [string]$BotName,         # The name of the bot to send messages to.
        [string]$UserMessage,     # The message from the user.
        [string]$SystemMessage,   # The system-related message.
        [string]$OutputPath       # The path where the output file will be moved if provided.
    )
    
    # Get the current script's root directory. This is where the script is located.
    $PSScriptRoot | Get-Item
    
    # Search recursively in the script's directory for the 'PoeWrapper.exe' executable.
    $poewrapperexe = Get-ChildItem -Path ($PSScriptRoot | Get-Item).Directory.FullName -Recurse -Filter 'PoeWrapper.exe'
    
    # Create a new temporary file with a random name to store the output.
    $tempOutput = New-Item -Path $PSScriptRoot -Name ((New-Guid).Guid + ".txt") -ItemType File -Force
    
    # Start the 'PoeWrapper.exe' process with the necessary arguments.
    $processParams = @{
        FilePath = $poewrapperexe.FullName
        WorkingDirectory = $poewrapperexe.Directory.FullName
        ArgumentList = "-ApiKey `"$ApiKey`" -BotName `"$BotName`" -UserMessage `"$UserMessage`" -SystemMessage `"$SystemMessage`""
        NoNewWindow = $true
        Wait = $true
        RedirectStandardOutput = $tempOutput.FullName
    }
    Start-Process @processParams
        
    # Check if the OutputPath parameter has been provided.
    if ($OutputPath) {
        $out = ($OutputPath | Get-Item).FullName
        # Move the temporary file to the specified output path.
        Move-Item -Path $tempOutput.FullName -Destination $OutputPath -Force -InformationAction SilentlyContinue

    } else {
        # Read the output from the temporary file.
        $out = Get-Content $tempOutput.FullName -Raw
        # Output the path to the temporary file if no OutputPath was provided.
        $tempOutput | Remove-Item -Force
    }
    
    # Return the output from the file.
    return $out
}
