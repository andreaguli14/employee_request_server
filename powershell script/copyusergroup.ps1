$user = get-aduser $args[0] -Properties memberof
$user.MemberOf | % { ($_ -split ",*..=")[1]}