function Install-WinGet {
    #If winget is not installed
    if (-not (Get-Command winget -errorAction SilentlyContinue)) {
        #Install winget
        Write-Host "Installing WinGet"
        $progressPreference = 'silentlyContinue'
        Write-Information "Downloading WinGet and its dependencies..."
        Invoke-WebRequest -Uri https://aka.ms/getwinget -OutFile Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
        Invoke-WebRequest -Uri https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx -OutFile Microsoft.VCLibs.x64.14.00.Desktop.appx
        Invoke-WebRequest -Uri https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.7.3/Microsoft.UI.Xaml.2.7.x64.appx -OutFile Microsoft.UI.Xaml.2.7.x64.appx
        Add-AppxPackage Microsoft.VCLibs.x64.14.00.Desktop.appx
        Add-AppxPackage Microsoft.UI.Xaml.2.7.x64.appx
        Add-AppxPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
    }
}


function Install-DefaultApps (){
    $DefaultApps = @(
        "SublimeHQ.SublimeText.4",
        "Microsoft.VisualStudioCode",
        "Mozilla.Firefox",
        "Brave.Brave",
        "Git.Git"
    )

    foreach($app in $DefaultApps){
        Write-Host "Installing $app"
        winget install -e --id $app --disable-interactivity --accept-package-agreements --accept-source-agreements 
    }

}

function Install-VMs () {
    
    $VMs = @(
        "Mware.WorkstationPro",
        "VMware.WorkstationPlayer"
    )

    foreach($app in $VMs){
        Write-Host "Installing $app"
        winget install -e --id $app --disable-interactivity --accept-package-agreements --accept-source-agreements 
    }
}

function Install-LabEnv {
    winget install -e --id Python.Python.3.11 --disable-interactivity --accept-package-agreements --accept-source-agreements
}

function Install-WSL (){
    wsl --install;

    winget install -e --id Canonical.Ubuntu.2204 --disable-interactivity --accept-package-agreements --accept-source-agreements
    winget install -e --id kalilinux.kalilinux
}

function Remove-Bloatware (){
    $Packages = 
    '*3dbuilder*',
    '*549981C3F5F10*', # Cortana
    '*Bing*', # Money, Sports, News, Finance & Weather
    #'*Calculator*',
    '*Camera*',
    '*CommunicationsApps*', # Mail & Calendar
    '*Feedback*',
    '*Gaming*',
    '*GetHelp*',
    '*GetStarted*', # Tips app
    #'*SecHealthUI*', # Windows Defender
    '*Maps*',
    '*MSPaint*',
    '*MixedReality*',
    '*OfficeHub*',
    '*OneDrive*',
    '*MSPaint*',
    '*People*',
    '*Phone*', # Phone Companion
    '*ScreenSketch*', # Snipping Tool
    '*Skype*',
    '*Solitaire*',
    '*SoundRecorder*',
    '*StickyNotes*',
    '*Teams*',
    '*todos*',
    '*WindowsAlarms*',
    '*windowsstore*',
    '*Xbox*',
    '*Zune*'

    ForEach($Package in $Packages){

        Get-AppxProvisionedPackage -Online | Where-Object {$_.PackageName -like "$Package"} | Remove-AppxProvisionedPackage -Online -AllUsers

    }
}

function Set-VisualConf () {
    #Set dark mode
    Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0
}

function Set-LabOptimizations (){
    #Enalbe Fastboot
    REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /V HiberbootEnabled /T REG_dWORD /D 0 /F
}