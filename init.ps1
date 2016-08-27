# make sure we are an admin
If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{   
$arguments = "& '" + $myinvocation.mycommand.definition + "'"
Start-Process powershell -Verb runAs -ArgumentList $arguments
Break
}

# check if cygwin is already installed
# HACK ALERT
$installCygwin = $true
If ((Test-Path "C:\cygwin64\") -or (Test-Path "C:\cygwin\")) {
    Write-Output "Cygwin already installed.  Skipping install." 
    $installCygwin = $false
}

# powershell reminds me why I need cygwin in the first place.  Jeez.
If ($installCygwin){

    # determine if 64 or 32 bit
    $url = ""

    if ([System.IntPtr]::Size -eq 4) 
    { 
        # 32 bit
        $url = "https://www.cygwin.com/setup-x86.exe"
    } 
    else 
    { 
        # 64 bit
        $url = "https://www.cygwin.com/setup-x86_64.exe"
    }

    # download the cygwin file, ONLY if not already downloaded

    if(![System.IO.File]::Exists("$PSScriptRoot\cygwin-setup.exe")){
        # file with path $path doesn't exist
        Write-Output "Downloading cygwin installer.  Please wait, this might take several seconds."
        $output = "$PSScriptRoot\cygwin-setup.exe"
        $start_time = Get-Date
        $wc = New-Object System.Net.WebClient
        $wc.DownloadFile($url, $output)
        #OR
        (New-Object System.Net.WebClient).DownloadFile($url, $output)
        Write-Output "Finished downloading cygwin.  Installing now."
    }
    else
    {
        Write-Output "Cygwin file already detected. Installing now."
    }

    Read-Host -Prompt "You will now install cygwin.  You MUST install Lynx for install to work.  Press Enter to continue."

    # run setup
    [System.Diagnostics.Process]::Start("$PSScriptRoot\cygwin-setup.exe")

    Read-Host -Prompt "Please enter any key after you have finished installing via the GUI."

    
    }

# HACK ALERT!!!!
# get the cygwin exe so we can run our scripts
$cygwinBin = ""
$path = ""
If ((Test-Path C:\cygwin64) -or (Test-Path C:\cygwin)) {
  If (Test-Path C:\cygwin64\bin\bash.exe){
    $cygwinBin = "C:\cygwin64\bin\"
  }
  else
  {
    $cygwinBin = "C:\cygwin\bin\"
  }
}
else
{
    Read-Host -Prompt "Couldn't find Cygwin in the C drive.  Quitting."
    Exit
}

# install menlo for powerline
$url = "https://github.com/abertsch/Menlo-for-Powerline/blob/master/Menlo%20for%20Powerline.ttf?raw=true"
$output = "$PSScriptRoot\Menlo for Powerline.ttf"
Write-Output "Downloading font.  Please wait, this might take several seconds."
(New-Object System.Net.WebClient).DownloadFile($url, $output)

$FONTS = 0x14
$objShell = New-Object -ComObject Shell.Application
$objFolder = $objShell.Namespace($FONTS)
$objFolder.CopyHere($output)

# open up our bootstrap.sh file
$env:Path = $cygwinBin;
[Diagnostics.Process]::Start("bash.exe","$PSScriptRoot\bootstrap.sh $($cygwinBin) $PSScriptRoot")
#cmd /c  "$PSScriptRoot\bootstrap.sh" /run

function Is-Installed( $program ) {
    
    $x86 = ((Get-ChildItem "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall") |
        Where-Object { $_.GetValue( "DisplayName" ) -like "*$program*" } ).Length -gt 0;

    $x64 = ((Get-ChildItem "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall") |
        Where-Object { $_.GetValue( "DisplayName" ) -like "*$program*" } ).Length -gt 0;

    return $x86 -or $x64;
}
