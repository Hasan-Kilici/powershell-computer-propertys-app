$CpuModel = (Get-WmiObject -Class WIN32_VideoController | Select-Object -ExpandProperty Caption)[0]
$GpuModel = (Get-WmiObject -Class WIN32_VideoController | Select-Object -ExpandProperty Caption)[1]
$Account =  Get-WmiObject -Class WIN32_VideoController | Select-Object -ExpandProperty SystemName

$Disks = Get-WmiObject -Class Win32_LogicalDisk | Select-Object DeviceID, MediaType, Size, FreeSpace

$sizeGB = [math]::Round($Disks.Size / 1GB, 2)
$freeSpaceGB = [math]::Round($Disks.FreeSpace / 1GB, 2)

$Ram = Get-WmiObject -Class WIN32_PhysicalMemory | Measure-Object -Property Capacity -Sum | Select-Object -ExpandProperty Sum
$RamGB = [math]::Round($ram / 1GB, 2)

Add-Type -AssemblyName System.Windows.Forms
$form = New-Object System.Windows.Forms.Form
$form.Text = "$Account System Propertys"
$form.ClientSize = New-Object System.Drawing.Size(600, 140)

$Header = New-Object System.Windows.Forms.Label
$Header.Location = New-Object System.Drawing.Point(10, 10)
$Header.Size = New-Object System.Drawing.Size(600, 30)
$Header.Font = New-Object System.Drawing.Font("Arial", 16, [System.Drawing.FontStyle]::Bold)
$Header.Text = "Welcome to System Propertys"

$Cpu = New-Object System.Windows.Forms.Label
$Cpu.Size = New-Object System.Drawing.Size(200, 30)
$Cpu.Location = New-Object System.Drawing.Point(10,45)
$Cpu.Text = "CPU : $CpuModel"

$Gpu = New-Object System.Windows.Forms.Label
$Gpu.Size = New-Object System.Drawing.Size(200, 30)
$Gpu.Location = New-Object System.Drawing.Point(310,45)
$Gpu.Text = "GPU : $GpuModel"

$RamLabel = New-Object System.Windows.Forms.Label
$RamLabel.Size = New-Object System.Drawing.Size(200, 30)
$RamLabel.Location = New-Object System.Drawing.Point(10,100)
$RamLabel.Text = "Ram : $RamGB GB"

$DiskLabel = New-Object System.Windows.Forms.Label
$DiskLabel.Size = New-Object System.Drawing.Size(200,30)
$DiskLabel.Location = New-Object System.Drawing.Point(310,100)
$DiskLabel.Text = "$sizeGB GB Depolama"

$form.Controls.Add($Header)
$form.Controls.Add($Cpu)
$form.Controls.Add($Gpu)
$form.Controls.Add($RamLabel)
$form.Controls.Add($DiskLabel)

$form.ShowDialog() | Out-Null
