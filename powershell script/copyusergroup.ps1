$mcopy = $args[0]
Get-ADGroup -Server $mcopy -Filter "GroupScope -eq 'DomainLocal'"| ForEach-Object {$_.Name}