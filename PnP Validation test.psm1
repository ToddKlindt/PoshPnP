function Add-CarandColorandOwner {
    param(
        [Parameter(Mandatory=$true)]
        [string]$CarName,

        [Parameter(Mandatory=$true)]
        [ValidateScript({ $_ -in $(Get-ValidColorChoices)},ErrorMessage = 'Color not found')]
        [ArgumentCompleter({Get-ValidColorChoices})]
        [string]$Color,
        
        [Parameter(Mandatory=$true)]
        [ValidateScript({ $_ -in $(Get-ValidUserNames -AsObjects | Select-Object DisplayName -ExpandProperty DisplayName)},ErrorMessage = 'User not found')]
        [ArgumentCompleter({
            param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

            $users = Get-ValidUserNames -AsObjects
            foreach ($user in $users) {
                $completionText = "'{0}'" -f $user.DisplayName
                $tooltip = $user.UserPrincipalName
                $result = New-Object System.Management.Automation.CompletionResult $completionText, $tooltip, 'ParameterValue', $tooltip
                $result
            }
        })]
        [string]$Owner
    )

    $listName = "CarsandColorswithPeople"

    $itemProperties = @{
        "Title" = $CarName
        "Color" = $Color
        "Owner" = $Owner
    }
    Add-PnPListItem -List $listName -Values $itemProperties

    Write-Host "Item added successfully"
}

function Get-ValidUserNames {
    param(
        [switch]$AsObjects
    )

    $Users = Get-PnPAzureADUser
    if ($AsObjects) {
        $ValidUserNames = $Users | Select-Object DisplayName, UserPrincipalName
    } else {
        $ValidUserNames = $Users.UserPrincipalName
    }
    return $ValidUserNames
}

