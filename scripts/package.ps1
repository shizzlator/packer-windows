Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowFileExtensions -EnableShowFullPathInTitleBar
Enable-RemoteDesktop
Set-NetFirewallRule -Name RemoteDesktop-UserMode-In-TCP -Enabled True

Write-BoxstarterMessage "Removing page file"
$pageFileMemoryKey = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management"
Set-ItemProperty -Path $pageFileMemoryKey -Name PagingFiles -Value ""

Update-ExecutionPolicy -Policy Unrestricted

Install-WindowsUpdate -AcceptEula
if(Test-PendingReboot){ Invoke-Reboot }

Write-BoxstarterMessage "Installing Choco packages..."
choco install git -y
choco install git.install -y
choco install poshgit -y
choco install notepadplusplus -y
choco install nuget.commandline -y
choco install notepadplusplus -y
choco install diffmerge -y
choco install webpi -y
choco install google-chrome-x64 -y
choco install firefox -y
choco install nodejs -y

Write-BoxstarterMessage "Install all IIS features (except FTP), these things take time...."
# Need to clean up and only install what isnt already by using /All
dism /online /Enable-Feature /FeatureName:IIS-WebServerRole /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-WebServer /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-CommonHttpFeatures /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-HttpErrors /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-HttpRedirect /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-ApplicationDevelopment /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-Security /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-URLAuthorization /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-RequestFiltering /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-NetFxExtensibility /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-HealthAndDiagnostics /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-HttpLogging /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-LoggingLibraries /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-RequestMonitor /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-HttpTracing /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-IPSecurity /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-Performance /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-HttpCompressionDynamic /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-WebServerManagementTools /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-ManagementScriptingTools /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-IIS6ManagementCompatibility /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-Metabase /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-HostableWebCore /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-ISAPIExtensions /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-ISAPIFilter /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-StaticContent /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-DefaultDocument /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-DirectoryBrowsing /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-WebDAV /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-ASPNET /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-ASP /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-CGI /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-ServerSideIncludes /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-CustomLogging /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-BasicAuthentication /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-HttpCompressionStatic /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-ManagementConsole /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-ManagementService /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-WMICompatibility /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-LegacyScripts /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-LegacySnapIn /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-WindowsAuthentication /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-DigestAuthentication /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-ClientCertificateMappingAuthentication /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-IISCertificateMappingAuthentication /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-ODBCLogging /All /NoRestart

Write-BoxstarterMessage "WCF features"
dism /online /Enable-Feature /FeatureName:WAS-WindowsActivationService /All /NoRestart
dism /online /Enable-Feature /FeatureName:WAS-ProcessModel /All /NoRestart
dism /online /Enable-Feature /FeatureName:WAS-NetFxEnvironment /All /NoRestart
dism /online /Enable-Feature /FeatureName:WAS-ConfigurationAPI /All /NoRestart
dism /online /Enable-Feature /FeatureName:WCF-HTTP-Activation /All /NoRestart
dism /online /Enable-Feature /FeatureName:WCF-NonHTTP-Activation /All /NoRestart

Write-BoxstarterMessage "MSMQ"
dism /online /Enable-Feature /FeatureName:MSMQ-Container /All /NoRestart
dism /online /Enable-Feature /FeatureName:MSMQ-Server /All /NoRestart
dism /online /Enable-Feature /FeatureName:MSMQ-Triggers /All /NoRestart
dism /online /Enable-Feature /FeatureName:MSMQ-ADIntegration /All /NoRestart
dism /online /Enable-Feature /FeatureName:MSMQ-HTTP /All /NoRestart
dism /online /Enable-Feature /FeatureName:MSMQ-Multicast /All /NoRestart
dism /online /Enable-Feature /FeatureName:MSMQ-DCOMProxy /All /NoRestart

if(Test-PendingReboot){ Invoke-Reboot }

Write-BoxstarterMessage "Installing ARRv3 and UrlRewrite2"
$webpi = "C:\Program Files\Microsoft\Web Platform Installer\WebpiCmd.exe"
$args = '/Install /Products:"ARRv3_0,UrlRewrite2" /AcceptEULA'
Start-Process $webpi $args -NoNewWindow -Wait

$vspathExists = Test-Path "C:\Program Files (x86)\Microsoft Visual Studio 14.0"
if(!$vspathExists){
	$vspath = "\\uk-w2k8fp-trl01\TJShared$\Development\installers\VisualStudio\VS2015_unattended\vs_professional.exe"
	$args = "/Passive /InstallSelectableItems TypeScriptV3;WebToolsV1;MDDJSDependencyHiddenV1;BlissHidden;HelpHidden;JavaScript;NetFX4Hidden;NetFX45Hidden;NetFX451MTPackHidden;NetFX451MTPackCoreHidden;NetFX452MTPackHidden;NetFX46MTPackHidden;PortableDTPHidden;PreEmptiveDotfuscatorHidden;PreEmptiveAnalyticsHidden;ProfilerHidden;RoslynLanguageServicesHidden;SDKTools3Hidden;SDKTools4Hidden;StoryboardingHidden;WCFDataServicesHidden;Win81SDK_HiddenV1;PowerShellToolsV1;Node.jsV1;ToolsForWin81_WP80_WP81V1;GitForWindowsV1;GitHubVSV1;JavaScript_HiddenV1"
	Start-Process $vspath $args -NoNewWindow -Wait
}

if(Test-PendingReboot){ Invoke-Reboot }

Write-BoxstarterMessage "Adding New 4.5 Features"
dism /online /Enable-Feature /FeatureName:NetFx4Extended-ASPNET45 /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-NetFxExtensibility45 /All /NoRestart
dism /online /Enable-Feature /FeatureName:IIS-ASPNET45 /All /NoRestart
dism /online /Enable-Feature /FeatureName:WCF-Services45 /All /NoRestart
dism /online /Enable-Feature /FeatureName:WCF-HTTP-Activation45 /All /NoRestart
dism /online /Enable-Feature /FeatureName:WCF-TCP-Activation45 /All /NoRestart
dism /online /Enable-Feature /FeatureName:WCF-Pipe-Activation45 /All /NoRestart
dism /online /Enable-Feature /FeatureName:WCF-MSMQ-Activation45 /All /NoRestart
dism /online /Enable-Feature /FeatureName:WCF-TCP-PortSharing45 /All /NoRestart

if(Test-PendingReboot){ Invoke-Reboot }

Write-BoxstarterMessage "Installing ReSharper 9.2"
$client = New-Object System.Net.WebClient
$client.DownloadFile("http://download.jetbrains.com/resharper/JetBrains.ReSharperUltimate.2015.2-checked.exe","c:\ReSharper-9.2.exe")
$resharper = "c:\ReSharper-9.2.exe"
$args = "/VsVersion=14 /SpecificProductNames=teamCityAddin;ReSharper /IgnoreExtensions=True /Silent=True"
Start-Process $resharper $args -NoNewWindow -Wait

Write-BoxstarterMessage "SQL Management Studio"
$Sqlinstaller = "\\uk-w2k8fp-trl01\TJShared$\DBA\SQLInstallMedia\SQL2014\ManagementStudio\SETUP.EXE"
$args = '/ACTION="Install" /IACCEPTSQLSERVERLICENSETERMS /Q /INDICATEPROGRESS /FEATURES="Tools"'
Start-Process $Sqlinstaller $args -NoNewWindow -Wait

Write-BoxstarterMessage "Removing unused features..."
Get-WindowsFeature | 
? { $_.InstallState -eq 'Available' } | 
Uninstall-WindowsFeature -Remove

Write-BoxstarterMessage "Cleaning SxS..."
Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase

@(
    "$env:localappdata\Nuget",
    "$env:localappdata\temp\*",
    "$env:windir\logs",
    "$env:windir\panther",
    "$env:windir\temp\*",
    "$env:windir\winsxs\manifestcache"
) | % {
        if(Test-Path $_) {
            Write-BoxstarterMessage "Removing $_"
            Takeown /d Y /R /f $_
            Icacls $_ /GRANT:r administrators:F /T /c /q  2>&1 | Out-Null
            Remove-Item $_ -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
        }
    }

Write-BoxstarterMessage "defragging..."
Optimize-Volume -DriveLetter C

Write-BoxstarterMessage "0ing out empty space..."
wget http://download.sysinternals.com/files/SDelete.zip -OutFile sdelete.zip
[System.Reflection.Assembly]::LoadWithPartialName("System.IO.Compression.FileSystem")
[System.IO.Compression.ZipFile]::ExtractToDirectory("sdelete.zip", ".") 
./sdelete.exe /accepteula -z c:

Write-BoxstarterMessage "Recreate pagefile after sysprep"
$System = GWMI Win32_ComputerSystem -EnableAllPrivileges
$System.AutomaticManagedPagefile = $true
$System.Put()

Write-BoxstarterMessage "Setting up winrm"
Set-NetFirewallRule -Name WINRM-HTTP-In-TCP-PUBLIC -RemoteAddress Any
Enable-WSManCredSSP -Force -Role Server

Enable-PSRemoting -Force -SkipNetworkProfileCheck
winrm set winrm/config/client/auth '@{Basic="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'

Write-BoxstarterMessage "Setting SSH Service startuptype to automatic"
Set-Service "opensshd" -startuptype "automatic"
Start-Service "opensshd"