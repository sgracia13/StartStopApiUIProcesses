##First Form
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'Select an API'
$form.Size = New-Object System.Drawing.Size(300, 200)
$form.StartPosition = 'CenterScreen'

$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(75, 120)
$okButton.Size = New-Object System.Drawing.Size(75, 23)
$okButton.Text = 'OK'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(150, 120)
$cancelButton.Size = New-Object System.Drawing.Size(75, 23)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10, 20)
$label.Size = New-Object System.Drawing.Size(280, 20)
$label.Text = 'Please select the APIs you wish spin up:'
$form.Controls.Add($label)



$listBox = New-Object System.Windows.Forms.ListBox
$listBox.Location = New-Object System.Drawing.Point(10, 40)
$listBox.Size = New-Object System.Drawing.Size(260, 20)
$listBox.Height = 80

$listBox.SelectionMode = 'MultiExtended'

[void] $listBox.Items.Add('Gateway.API')
[void] $listBox.Items.Add('Employee.API')
[void] $listBox.Items.Add('Company.API')
[void] $listBox.Items.Add('Identity.API')
[void] $listBox.Items.Add('Tax.API')

$form.Controls.Add($listBox)
$form.Topmost = $true

$result = $form.ShowDialog()


###Functions to start services

$url = Get-Content 'C:\Users\rgracia\Documents\ProjectPath.json' -raw | ConvertFrom-Json

function Start-GatewayApiService
{
  $gatewayUrl = $url.GatewayApi.Path
  Start-Process 'C:\Program Files (x86)\IIS Express\iisexpress.exe' -ArgumentList "/path:$gatewayUrl"
}


function Start-EmployeeApiService
{
    Start-Process -FilePath 'dotnet' -WorkingDirectory $url.EmployeeApi.Path -ArgumentList 'watch run'
}
function Start-CompanyApiService
{
  Start-Process -FilePath 'dotnet' -WorkingDirectory $url.CompanyApi.Path -ArgumentList 'watch run'
}
function Start-IdentityApiService
{
  Start-Process -FilePath 'dotnet' -WorkingDirectory $url.IdentityApi.Path -ArgumentList 'watch run'
}

function Start-TaxApiService
{
  Start-Process -FilePath 'dotnet' -WorkingDirectory $url.TaxApi.Path -ArgumentList 'watch run'
}


function Open-ApiService
{

  foreach ($item in $listBox.SelectedItems)
  {
    switch ($item)
    {
      'Employee.API'  { Start-EmployeeApiService }
      'Identity.API'  { Start-IdentityApiService }
      'Gateway.API'   { Start-GatewayApiService }
      'Company.API'   { Start-CompanyApiService }
      'Tax.API'       { Start-TaxApiService }
    }
  }


}


#Second Form
# $secondForm = New-Object System.Windows.Forms.Form
# $secondForm.Text = 'Stop API Process'
# $secondForm.Size = New-Object System.Drawing.Size(300,200)
# $secondForm.StartPosition = 'CenterScreen'

# $secondOkButton = New-Object System.Windows.Forms.Button
# $secondOkButton.Location = New-Object System.Drawing.Point(75,120)
# $secondOkButton.Size = New-Object System.Drawing.Size(75,23)
# $secondOkButton.Text = 'Stop Services'
# $secondOkButton.DialogResult = [System.Windows.Forms.DialogResult]::Abort
# $secondForm.AcceptButton = $secondOkButton
# $secondForm.Controls.Add($secondOkButton)

# $secondcancelButton = New-Object System.Windows.Forms.Button
# $secondCancelButton.Location = New-Object System.Drawing.Point(150,120)
# $secondCancelButton.Size = New-Object System.Drawing.Size(75,23)
# $secondCancelButton.Text = 'Cancel'
# $secondCancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
# $secondForm.CancelButton = $secondCancelButton
# $secondForm.Controls.Add($secondCancelButton)

# $secondLabel = New-Object System.Windows.Forms.Label
# $secondLabel.Location = New-Object System.Drawing.Point(10,20)
# $secondLabel.Size = New-Object System.Drawing.Size(280,20)
# $secondLabel.Text = 'Please select the APIs you wish stop:'
# $secondForm.Controls.Add($secondLabel)



# $secondListBox = New-Object System.Windows.Forms.ListBox
# $secondListBox.Location = New-Object System.Drawing.Point(10,40)
# $secondListBox.Size = New-Object System.Drawing.Size(260,20)
# $secondListBox.Height = 80

# $secondListBox.SelectionMode = 'MultiExtended'

# [void] $secondListBox.Items.Add('Gateway.API')
# [void] $secondListBox.Items.Add('Employee.API')
# [void] $secondListBox.Items.Add('Company.API')
# [void] $secondListBox.Items.Add('Identity.API')
# [void] $secondListBox.Items.Add('Tax.API')

# $secondForm.Controls.Add($secondListBox)
# $secondForm.Topmost = $true
# $secondResult = $secondForm.ShowDialog()







#Logic


if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{ Open-ApiService }

