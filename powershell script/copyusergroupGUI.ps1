Clear-Host
Write-Output  "
_______   ____  _  ______  __  _____________    __  _________  ______  _______  ______ _________  ____
/ ___/ /  / __ \/ |/ / __/ / / / / __/ __/ _ \  /  |/  / __/  |/  / _ )/ __/ _ \/ __/ // /  _/ _ \/ __/
/ /__/ /__/ /_/ /    / _/  / /_/ /\ \/ _// , _/ / /|_/ / _// /|_/ / _  / _// , _/\ \/ _  // // ___/\ \  
\___/____/\____/_/|_/___/  \____/___/___/_/|_| /_/  /_/___/_/  /_/____/___/_/|_/___/_//_/___/_/  /___/
                                                                                                       
"
$mcopy = (Read-Host "Please input the username of the User to copy")
$usernamecomplete = (Read-Host "Please input the username of the destination User")


Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = "Membership list of $mcopy"
$form.Size = New-Object System.Drawing.Size(450,700)
$form.AutoSize = $false
$form.FormBorderStyle = 'Fixed3D'
$form.MaximizeBox = $false
$form.StartPosition = 'CenterScreen'


$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Point(75, 630)
$OKButton.Size = New-Object System.Drawing.Size(75, 23)
$OKButton.Text = 'OK'
$OKButton.AutoSize = "True"
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $OKButton
$form.Controls.Add($OKButton)

$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Point(275, 630)
$CancelButton.Size = New-Object System.Drawing.Size(75, 23)
$CancelButton.Text = 'Cancel'
$CancelButton.AutoSize = "True"
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $CancelButton
$form.Controls.Add($CancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10, 20)
$label.Size = New-Object System.Drawing.Size(280, 20)
$label.AutoSize = "True"
$label.Text = 'Please make a selection from the list below:'
$form.Controls.Add($label)

$listBox = New-Object System.Windows.Forms.Listbox
$listBox.Location = New-Object System.Drawing.Point(10, 40)
$form.AutoSize = $false
$listBox.Size = New-Object System.Drawing.Size(420, 580)

$listBox.SelectionMode = 'MultiExtended'

Get-ADPrincipalGroupMembership -Identity $mcopy | ForEach-Object { [void] $listBox.Items.Add($_.Name ) }
#Get-ADGroup -Server inspectra.local -Filter "GroupScope -eq 'DomainLocal'"| ForEach-Object { [void] $listBox.Items.Add($_.Name )}

$listBox.Height = 580
$form.Controls.Add($listBox)
$form.Topmost = $true

$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    $x = $listBox.SelectedItems
    foreach ($Name in $x) {
        Add-ADPrincipalGroupMembership -Identity $usernamecomplete -MemberOf $Name
    }
}

