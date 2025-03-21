# MFAMobileNumbers - Microsoft Graph Phone Authentication Methods Exporter

## Description

This PowerShell script retrieves phone authentication methods for all users in a Microsoft 365 tenant using Microsoft Graph SDK. It exports the extracted data to a CSV file for further analysis.

## Prerequisites

- **PowerShell**: Ensure you are using PowerShell 5.1 or later.
- **Microsoft Graph PowerShell Module**: Install the module using:
   ```powershell
   Install-Module Microsoft.Graph -Force
- **Permissions**: Ensure you have the necessary permissions to read user authentication methods in Microsoft Graph.

## Installation and Usage

1. Download or Clone the Script
   ```bash
   git clone https://github.com/RapidScripter/MFAMobileNumbers.git

2. Update Configuration
- Open the script in a text editor.
- Ensure you have the required Graph permissions (`User.Read.All`, `UserAuthenticationMethod.Read.All`).

3. Run the Script
- Open PowerShell with Administrator privileges.
- Navigate to the script directory and execute:
   ```powershell
   .\Get-MFAMobileNumbers.ps1

4. Output
- The script generates a CSV file at `C:\PhoneMethodsReport.csv` containing user principal names and up to five phone authentication methods.
- Example columns in the CSV: Email, Mobile1, Mobile2, Mobile3, Mobile4, Mobile5

## Script Details

1. Retrieve User Data
- Connects to Microsoft Graph.
- Fetches all users and their authentication phone methods.
- Stores up to five phone numbers per user.

2. Error Handling
- Handles missing or inaccessible data gracefully.
- Displays errors in the console for troubleshooting.

3. Logging
- Outputs progress and errors to the console for easy tracking.

## Disconnect from Microsoft Graph

After execution, the script disconnects from Microsoft Graph: `Disconnect-MgGraph`
