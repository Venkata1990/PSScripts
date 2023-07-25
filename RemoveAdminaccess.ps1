Import-Module Microsoft.Online.Sharepoint.PowerShell -DisableNameChecking
 
#Variables for processing
$AdminURL = "https://Venkat-admin.sharepoint.com/"
#Pass the email id of remove user
$AdminAccount="Venkat@Venkat.com"
 
#Connect to SharePoint Online
Connect-SPOService -url $AdminURL 
 
#Get All Site Collections
$Sites = Get-SPOSite -Limit ALL -includepersonalsite $True
 
#Loop through each site and remove site collection admin
Foreach ($Site in $Sites)
{
    Write-host "Scanning site:"$Site.Url -f Yellow
    #Get All Site Collection Administrators
    $Admins = Get-SPOUser -Site $site.Url | Where {$_.IsSiteAdmin -eq $true}
 
    #Iterate through each admin
    Foreach($Admin in $Admins)
    {
        #Check if the Admin Name matches
        If($Admin.LoginName -eq $AdminAccount)
        {
            #Remove Site collection Administrator
            Write-host "Removing Site Collection Admin from:"$Site.URL -f Green
            Set-SPOUser -site $Site -LoginName $AdminAccount -IsSiteCollectionAdmin $False
        }
    }
}
