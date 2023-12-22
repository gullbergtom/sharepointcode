Install-Module -Name Microsoft.Online.SharePoint.PowerShell
Import-module -Name Microsoft.Online.SharePoint.PowerShell
Install-Module PnP.PowerShell -Force
Import-Module PnP.PowerShell

$Title = "Site Template Tom Gullberg"
$Description = "Custom site template named Tom Gullberg"
$WebTemplate = "68" # 64 Team site template # 1 Team site (with group creation disabled) # 68 Communication site template # 69 Channel site template
$ThumbnailUrl = "https://raw.githubusercontent.com/gullbergtom/sharepointcode/main/assets/ContosoPreview1.png"
$PreviewImageUrl = "https://raw.githubusercontent.com/gullbergtom/sharepointcode/main/assets/ContosoPreview1.png"
$TenantName = "0my60"
$SiteScriptJson = ".\SiteScriptContoso.json"
$SiteScriptJsonContent = Get-Content $SiteScriptJson -Raw

Connect-SPOService -Url https://$TenantName-admin.sharepoint.com

Connect-PnPOnline -Url https://$TenantName-admin.sharepoint.com -Interactive

#Creating a new Site Script & Site Design
$SiteScript = Add-SPOSiteScript -Title $Title -Description $Description -Content $SiteScriptJsonContent
Add-SPOSiteDesign `
  -Title $Title `
  -Description $Description `
  -SiteScripts $SiteScript.Id `
  -WebTemplate $WebTemplate `
  -ThumbnailUrl $ThumbnailUrl `
  -PreviewImageUrl $PreviewImageUrl

#Updating existing Site Template
Get-SPOSiteDesign edcb8b63-e208-4fad-b9e4-b64ec09e144d
Set-SPOSiteDesign -Identity 7c61ffaa-72e0-46a2-94ef-c3fc2bee2ca8 `
    -ThumbnailUrl $ThumbnailUrl `
    -PreviewImageUrl $PreviewImageUrl

Get-SPOSiteScript $SiteScript.Id
Set-SPOSiteScript -Identity $SiteScript.Id -Content $SiteScriptJsonContent

#Get current Site Templates in tenant
Get-SPOSiteDesign
#Remove Site Template from tenant
Remove-SPOSiteDesign -Identity edcb8b63-e208-4fad-b9e4-b64ec09e144d

#Get current Site Scripts in tenant
Get-SPOSiteScript
#Remove Site Script from tenant
Remove-SPOSiteScript -Identity a3eefaac-3e64-4a21-bde1-0eaa8b14ed10