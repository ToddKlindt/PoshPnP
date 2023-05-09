function Add-CarandcolorBefore {
    param(
        [Parameter(Mandatory=$true)]
        [string]$CarName,

        [Parameter(Mandatory=$true)]
        [string]$Color
    )

    $listName = "CarsandColors"

    $itemProperties = @{
        "Title" = $CarName
        "Color" = $Color
    }
    Add-PnPListItem -List $listName -Values $itemProperties

    Write-Host "Item added successfully"
}

function Add-CarandcolorBefore2 {
    param(
        [Parameter(Mandatory=$true)]
        [string]$CarName,

        [Parameter(Mandatory=$true)]
        [ValidateSet("Blue","Black","Red")]
        [string]$Color
    )

    $listName = "CarsandColors"

    $itemProperties = @{
        "Title" = $CarName
        "Color" = $Color
    }
    Add-PnPListItem -List $listName -Values $itemProperties

    Write-Host "Item added successfully"
}

function Add-CarandcolorAfter {
    [CmdletBinding()]
    param (
        # Title of the entry
        $CarName,

        # Car color
        [ValidateScript({ $_ -in $(Connect-PnPOnline -Url https://1kgvf.sharepoint.com/teams/dcptest12; ((Get-PnPList -Identity "CarsandColors" -Includes Fields).Fields | Where-Object -Property Title -EQ -Value Color).Choices)},ErrorMessage = 'Color not found')]
        [String]$Color

    )
    
    process {
        $listName = "CarsandColors"

        $itemProperties = @{
            "Title" = $CarName
            "Color" = $Color
        }
        Add-PnPListItem -List $listName -Values $itemProperties
    
        Write-Host "Item added successfully"
   
    }
}

function Add-CarandcolorAfter2 {
    [CmdletBinding()]
    param (
        # Title of the entry
        $CarName,

        # Car color
        [ValidateScript({ $_ -in $(Connect-PnPOnline -Url https://1kgvf.sharepoint.com/teams/dcptest12; ((Get-PnPList -Identity "CarsandColors" -Includes Fields).Fields | Where-Object -Property Title -EQ -Value Color).Choices)},ErrorMessage = 'Color not found')]
        [ArgumentCompleter(
            {
            param($cmd, $param, $wordToComplete)
            # This is the duplicated part of the code in the [ValidateScipt] attribute.
            [string[]] $validValues = $(Connect-PnPOnline -Url https://1kgvf.sharepoint.com/teams/dcptest12; ((Get-PnPList -Identity "CarsandColors" -Includes Fields).Fields | Where-Object -Property Title -EQ -Value Color).Choices) | ForEach-Object { "'$_'"}
            $validValues -like "$wordToComplete*"
            }
        )]
        [String]$Color

    )
    
    process {
        $listName = "CarsandColors"

        $itemProperties = @{
            "Title" = $CarName
            "Color" = $Color
        }
        Add-PnPListItem -List $listName -Values $itemProperties
    
        Write-Host "Item added successfully"
   
    }
}



function Add-Carandcolor {
    param(
        [Parameter(Mandatory=$true)]
        [string]$CarName,

        [Parameter(Mandatory=$true)]
        [ValidateScript({ $_ -in $(Get-ValidColorChoices)},ErrorMessage = 'Color not found')]
        [ArgumentCompleter({Get-ValidColorChoices})]
        [string]$Color
    )

    $listName = "CarsandColors"

    $itemProperties = @{
        "Title" = $CarName
        "Color" = $Color
    }
    Add-PnPListItem -List $listName -Values $itemProperties

    Write-Host "Item added successfully"
}

function Get-ValidColorChoices {
    $listName = "CarsandColors"

    $choiceField = Get-PnPField -List $listName -Identity "Color"
    $validChoices = $choiceField.Choices
    return $validChoices
}



function Get-TKPnPList {
    param(
        [Parameter(Mandatory=$true)]
        [ValidateScript({ $_ -in $(Get-ValidListNames)},ErrorMessage = 'List not found')]
        [ArgumentCompleter({Get-ValidListNames})]
        [string]$ListName
    )

    $list = Get-PnPList -Identity $ListName

    return $list
}

function Get-ValidListNames {
    $lists = Get-PnPList -Includes IsSystemList | Where-Object { $_.Hidden -eq $false -and $_.IsSystemList -eq $false }
    $validListNames = $lists.Title
    return $validListNames
}

function Get-TKPnPTenantSite {
    param(
        [Parameter(Mandatory=$true)]
        [ValidateScript({ $_ -in $(Get-ValidSiteNames)},ErrorMessage = 'Site not found')]
        [ArgumentCompleter({Get-ValidSiteNames})]
        [string]$SiteName
    )

    $site = Get-PnPTenantSite -Identity $SiteName

    return $site
}

function Get-ValidSiteNames {
    $sites = Get-PnPTenantSite
    $validSiteNames = $sites.Url
    return $validSiteNames
}

# For next time





# No really, you have to wait until next month











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
                if ($user.DisplayName -like "$wordToComplete*") {
                    $completionText = "'{0}'" -f $user.DisplayName
                    $tooltip = $user.UserPrincipalName
                    $result = New-Object System.Management.Automation.CompletionResult $completionText, $tooltip, 'ParameterValue', $tooltip
                    $result
                }
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

