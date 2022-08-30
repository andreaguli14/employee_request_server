$username = (Read-Host "Input Username")
$seldomain = (Read-Host "Select the domain: `n 1)inspectra.local `n 2)inspectra.eu `n 3)prettyneat.io `n")
$name = (Read-Host "Input User Name")
$surname = (Read-Host "Input User Surname")
$usernamecomplete=$username+"@"+$domain
switch ($seldomain)
{
    1 { $domain = 'inspectra.local'}
    2 { $domain = 'inspectra.eu'}
    3 { $domain = 'prettyneat.io'}
}

New-ADUser `
    -UserPrincipalName $username@$domain `
    -SamAccountName $username `
    -Name ($name+" "+$surname) `
    -GivenName $name `
    -Surname $surname `
    -EmailAddress (Read-Host "Input User Email") `
    -HomePhone (Read-Host "Input User Phone number") `
    -Title (Read-Host "Input User Job Title") `
    -AccountPassword (Read-Host -AsSecureString "Input User Password") `
    -ChangePasswordAtLogon $True `
    -Enabled $True

$mcopy=(Read-Host "Input User to copy ")


foreach ($objectGUID in Get-ADPrincipalGroupMembership -Identity $mcopy | Select-Object -Property objectGUID )
{

    Add-ADPrincipalGroupMembership -Identity $usernamecomplete -MemberOf $objectGUID 

}
  
  
  
  
  
  

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
    <#  Connect-MsolService
    $exchangechose = Read-Host "Do you want add Exchange License write Y to confirm"
    if($exchangechose -eq "y" -or $exchangechose -eq "Y"  ){
            
        Set-MsolUserLicense -UserPrincipalName $usernamecomplete  -AddLicenses "inspectraeu:EXCHANGESTANDARD"
                
        }
    
    $businesschose = Read-Host "Do you want add Business License write Y to confirm"
    if($businessgechose -eq "y" -or $businesschose -eq "Y"  ){
            
        Set-MsolUserLicense -UserPrincipalName $usernamecomplete  -AddLicenses "inspectraeu:O365_BUSINESS"
            
        }
#>
        

