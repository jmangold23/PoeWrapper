<#
.SYNOPSIS
This script compiles a Python script into a standalone executable.

.DESCRIPTION
This script uses PyInstaller to package a Python script into a single executable file for distribution. 
It automatically finds the Python script in the same directory as the PowerShell script and uses PyInstaller 
to build the executable with a console window.

.PARAMETER $pythonFile
The path to the Python file to be compiled.

.EXAMPLE
.\build.ps1
This example runs the PowerShell script, which compiles the 'PoeWrapper.py' Python script into an executable.

.NOTES
You need to have PyInstaller installed and accessible in your environment to use this script.
Ensure that 'PoeWrapper.py' is in the same directory as this PowerShell script.

#>

# Resolve the full path of the Python script, replacing backslashes with forward slashes.
$pythonFile = (Get-ChildItem -Path $PSCommandPath -Filter 'PoeWrapper.py').FullName.Replace('\','/')

# Invoke the command prompt to run PyInstaller with the specified options.
&cmd /c "pyinstaller --clean --noconfirm --onefile --console $pythonFile"
