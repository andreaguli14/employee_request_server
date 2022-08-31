$url = "http://localhost:3000/EmployeeRequests/" + $args[0]
$data = Invoke-RestMethod -Uri $url 
$username = $data.username
$name = $data.name
$surname = $data.surname
$email = $data.email
$jobtitle = $data.jobTitle
$password = $data.tempPassword
$domain = $data.domain
$usernamecomplete = $username + $domain


New-ADUser `
    -UserPrincipalName $username+$domain `
    -SamAccountName $username `
    -Name ($name + " " + $surname) `
    -GivenName $name `
    -Surname $surname `
    -EmailAddress $email  `
    # -HomePhone (Read-Host "Input User Phone number") `
    -Title $jobtitle `
    -AccountPassword $password `
    -ChangePasswordAtLogon $True `
    -Enabled $True


foreach ($group in  $data.selectedGroup ) {

    Add-ADPrincipalGroupMembership -Identity $usernamecomplete -MemberOf $group

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
        

