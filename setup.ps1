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
        winget install -e --id $app --disable-interactivity --accept-package-agreements   
    }

}

function Install-VMs () {
    
    $VMs = @(
        "Mware.WorkstationPro",
        "VMware.WorkstationPlayer"
    )

    foreach($app in $VMs){
        winget install -e --id $app --disable-interactivity --accept-package-agreements   
    }
}

function Install-LabEnv {
    winget install -e --id Python.Python.3.11 --disable-interactivity --accept-package-agreements   
}

function Install-WSL (){
    wsl --install;

    winget install -e --id Canonical.Ubuntu.2204 --disable-interactivity
    winget install -e --id kalilinux.kalilinux
}