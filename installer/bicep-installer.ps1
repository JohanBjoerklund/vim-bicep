# Create the install folder
$installPath = "$env:USERPROFILE\.bicep"
$installDir = New-Item -ItemType Directory -Path $installPath -Force
$installDir.Attributes += 'Hidden'
# Fetch the latest Bicep CLI binary
(New-Object Net.WebClient).DownloadFile("https://github.com/Azure/bicep/releases/latest/download/bicep-langserver.zip", "${installPath}\bicep-langserver.zip")


# Run Expand-Archive in versions that support it
if ($PSVersionTable.PSVersion.Major -gt 4) {
    Expand-Archive  "${installPath}\bicep-langserver.zip" "$installPath\bicep-langserver" -Force
} else {
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    [System.IO.Compression.ZipFile]::ExtractToDirectory("${installPath}\bicep-langserver.zip", "$installPath\bicep-lagnserver")
}

# Add bicep to your PATH
$currentPath = (Get-Item -path "HKCU:\Environment" ).GetValue('Path', '', 'DoNotExpandEnvironmentNames')
if (-not $currentPath.Contains("%USERPROFILE%\.bicep")) { setx PATH ($currentPath + ";%USERPROFILE%\.bicep") }
if (-not $currentPath.Contains("%USERPROFILE%\.bicep\bicep-langserver")) { setx PATH ($currentPath + ";%USERPROFILE%\.bicep\bicep-langserver") }
if (-not $env:path.Contains($installPath)) { $env:path += ";$installPath" }
