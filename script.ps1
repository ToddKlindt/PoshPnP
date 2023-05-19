<#
Be the Tool Maker

Tell story about Audit Log list
The API will let you add non-choices!!!
Stored in a SharePoint list
Runs in Azure Function
So popular kept adding actions
Added ValidateSet
Kept having to update code
And push it to Azure Function, Scary!

#>

## Demo 1: No checking
# Zoooooooooom
# Start Transcript
Start-TKTranscript "PnP Dynamic Parameter Values"

# Show List
# Zoooooooooom
https://1kgvf.sharepoint.com/teams/dcptest12/Lists/CarsandColors/AllItems.aspx

# Connect to my site
Connect-PnPOnline -Url https://1kgvf.sharepoint.com/teams/dcptest12

# Import my module
Import-Module 'D:\Code\PoshPnP\PnP Validation.psm1'

# Show that You can add good values
Add-CarandcolorBefore -CarName "Trans Am" -Color Black

# Show that You can add bad values
Add-CarandcolorBefore -CarName Tesla -Color Yellow

## Demo 2: ValidateSet
# Can't add bad value, yay!
Add-CarandcolorBefore2 -CarName Tesla2 -Color Yellow

# Can add good value, even better
Add-CarandcolorBefore2 -CarName Tesla2 -Color Blue

# When I add a new color, like Fancy Blue
$field = Get-PnPField -List "CarsandColors" -Identity "Color"
[string[]]$values = $field.Choices + "Fancy Blue"
Set-PnPField -List "CarsandColors" -Identity "Color" -Values @{Choices=$values}

# Show Field colors

# Don't work :(
Add-CarandcolorBefore2 -CarName Tesla3 -Color "Fancy Blue"


## Demo 3: ValidateScript
# Works with new color
Add-CarandcolorAfter -CarName Tesla3 -Color "Fancy Blue"

# Let's add green
$field = Get-PnPField -List "CarsandColors" -Identity "Color"
[string[]]$values = $field.Choices + "Green"
Set-PnPField -List "CarsandColors" -Identity "Color" -Values @{Choices=$values}

# Show Field colors

# It works!!
Add-CarandcolorAfter -CarName Honda -Color "Green"

# Now try tab complete :(
Add-CarandcolorAfter -CarName Ford -Color

## Demo 4: ValidateScript with Tab Complete
Add-CarandcolorAfter2 -CarName Ford -Color

## Demo 5: List example
Get-TKPnPList -ListName    # <tab>
Get-ValidListNames

## Demo 6: Site example
Get-TKPnPTenantSite -SiteName https://1kgvf.sharepoint.com/sites/dcptest12

# It's the real deal
Get-TKPnPTenantSite -SiteName https://1kgvf.sharepoint.com/sites/dcptest12 | Get-Member

# Anything else. Contents of a file, results of another PowerShell cmdlet, results from a REST call

# Show AI bit