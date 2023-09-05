# Install Python packages
pip install -r .\my_text_aggregator\requirements.txt

Write-Host "Dependencies installed successfully."
Write-Host "Installing Tools..."

# Powershell Script to Install Poppler and Set Path

# Define download URL and destination folder
$url = "https://github.com/oschwartz10612/poppler-windows/releases/download/v23.08.0-0/Release-23.08.0-0.zip"
$dest = "C:\temp\poppler.7z"

# Download Poppler
Invoke-WebRequest -Uri $url -OutFile $dest

# Extract the Poppler 7z file to P:\tools
7z x $dest -o"C:\tools"

Write-Host "Tools installed hopefully successfully. ADD PATH VARIABLE to C:\tools\poppler\bin (check out exactly where bin is)!"