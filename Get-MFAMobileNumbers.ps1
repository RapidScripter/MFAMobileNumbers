# Ensure Microsoft Graph SDK is installed
# Install-Module Microsoft.Graph -Force

# Connect to Microsoft Graph
Connect-MgGraph -Scopes "User.Read.All", "UserAuthenticationMethod.Read.All"

# Initialize a list to store results
$Results = @()

# Get all users
$Users = Get-MgUser -All

# Loop through each user
foreach ($User in $Users) {
    $UserPrincipalName = $User.UserPrincipalName
    Write-Host "Processing user: $UserPrincipalName"

    try {
        # Get phone authentication methods
        $PhoneMethods = Get-MgUserAuthenticationPhoneMethod -UserId $User.Id

        # Initialize phone number placeholders
        $Phones = @($null, $null, $null, $null, $null)  # Supports up to 5 numbers

        # Store phone numbers sequentially
        $PhoneIndex = 0
        foreach ($PhoneMethod in $PhoneMethods) {
            if ($PhoneIndex -lt 5) {  # Limit to 5 numbers
                $Phones[$PhoneIndex] = $PhoneMethod.PhoneNumber
            }
            $PhoneIndex++
        }

        # Create an ordered object
        $UserResult = [PSCustomObject]@{
            Email   = $UserPrincipalName
            Mobile1 = $Phones[0]
            Mobile2 = $Phones[1]
            Mobile3 = $Phones[2]
            Mobile4 = $Phones[3]
            Mobile5 = $Phones[4]
        }

        # Add to the results list
        $Results += $UserResult

    } catch {
        Write-Host "Error processing user: $UserPrincipalName - $_" -ForegroundColor Red
    }
}

# Export results to CSV with fixed column order
$Results | Select-Object Email, Mobile1, Mobile2, Mobile3, Mobile4, Mobile5 | `
    Export-Csv -Path "C:\PhoneMethodsReport.csv" -NoTypeInformation

# Disconnect from Microsoft Graph
Disconnect-MgGraph
