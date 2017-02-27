# Enable Remote Desktop
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server' -Name fDenyTSConnections -Value 0
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name UserAuthentication -Value 1
netsh advfirewall firewall add rule name="Remote Desktop" dir=in localport=3389 protocol=TCP action=allow

# Install VirtualBox Guest Addition
$cdroms = Get-WmiObject win32_logicaldisk -filter 'DriveType=5' | ForEach {$_.DeviceID}
ForEach ($cdrom in $cdroms) {
	if (Test-Path "$cdrom\VBoxWindowsAdditions.exe") {
		$cddrive = $cdrom
		break
	}
}
Start-Process "VBoxCertUtil.exe" "add-trusted-publisher vbox-sha1.cer --root vbox-sha1.cer" -WorkingDirectory "$cddrive\cert"
Start-Process "$cddrive\VBoxWindowsAdditions.exe" "/S /force" -NoNewWindow -Wait

# Disable auto login
$WinlogonPath = "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon"
Remove-ItemProperty -Path $WinlogonPath -Name AutoAdminLogon
Remove-ItemProperty -Path $WinlogonPath -Name DefaultUserName

# Download and install Windows updates
start-process powershell "a:\wsus.ps1 Y N" -Wait

# Windows cleanup
Remove-Item C:\Windows\SoftwareDistribution\Download\* -Force -Recurse
Remove-Item C:\Windows\Installer\* -Force -Recurse

# Enable WinRM
Get-NetConnectionProfile | Set-NetConnectionProfile -NetworkCategory Private
winrm quickconfig -q
winrm set winrm/config '@{MaxTimeoutms="1800000"}'
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="300"}'
winrm set winrm/config/client/auth '@{Basic="true"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
netsh advfirewall firewall add rule name="WinRM-HTTP" dir=in localport=5985 protocol=TCP action=allow
