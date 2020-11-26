# uConnector
## Overview
This module is used to connect to Office 365 and Azure resource used at UC Davis.

## Usage

### Setup Client
The `Set-ConnectScriptClient` command will setup the client with all the necessary eventlog, package provider and default modules used at UC Davis. The `-Fullsetup` parameter will install the Skype Online and Teams modules.

Details list:

1) Installs Nuget package provider, via command `Install-NugetPackageProvider`
2) Installs Azure AD module, via command `Install-AzureADModule`
3) Installs MSOnline Module, via command `Install-MSOnlineModule`
4) Installs RSAT tools, via command `Install-RSAT`
5) Installs LAPS UI tool, via command `Install-LAPSUI`
6) Installs EXchange Online MFA module, via command `Install-ExoMFAModule`
7) Installs EXchange Online V2 module, via command `Install-ExoV2`

### Connect to Service
The `Connect-Connector` command is used to connect to a Office 365 or Azure service.
 **Not all Services are avalable to all users do to RBAC scoping\restrictions**
# Connect to Exchange Online
```powershell
Connect-Connector -Service ExchangeOnline
```

# Connect to Azure AD
```powershell
Connect-Connector -Service AzureAD
```

# Connect to ExchangeOnlineV2  with UserCredential passthrough 
```powershell
Connect-Connector -Service ExchangeOnlineV2 -UserPrincipalName <userID>@domain.edu
```

# Connect to multiple services at once
```powershell
Connect-Connector -Service AzureAD,ExchangeOnline
```

# Connect to Exchange On-prem
`-OnpremExchangeServer` URI must contain start with `https://` or `http://` plus server FQDN and end with `/PowerShell/`

`-OnpremExchangeCred` must pass in credential
```powershell
Connect-Connector -Service ExchangeOnprem -OnpremExchangeCred (Get-Credential) -OnpremExchangeServer `https://serverURI/PowerShell/`
```

# Install Functions
To install individual module or Window features. Several of the install commands have an `-Update` parameter that can be used to update the individual module or Window feature to the latest version.

Details list:

1) Installs Azure  module, via command `Install-AzModule`
2) Installs Azure AD module, via command `Install-AzureADModule`
3) Installs Azure RM module, via command `Install-AzureRMModule` *per Microsoft recommendation this should not be install with Az module 
4) Installs EXchange Online MFA module, via command `Install-ExoMFAModule`
5) Installs EXchange Online V2 module, via command `Install-ExoV2`
6) Installs LAPS UI tool, via command `Install-LAPSUI`
7) Installs MSOnline Module, via command `Install-MSOnlineModule`
8) Installs Nuget via command `Install-Nuget`
9) Installs Nuget package provider, via command `Install-NugetPackageProvider`
10) Installs Window package managment, via command `Install-PackageManagment`
11) Installs RSAT tools, via command `Install-RSAT`
12) Installs SkypeOnline Module, via command `Install-SkypeOnlineModule`
13) Installs Teams Module, via command `Install-TeamsModule`

## Installation
Software: Windows PowerShell with .NET Framework 4.7.2

Minimum version of the PowerShell: 5.1

Supported OS: Window 10 1809+ and Windows Server 1809+

Supported ISE: [VS Code][VSCode] and PowerShell ISE

### Limited Use non supported 
Several modules are dependent on .Net Framework such as AD module and not available to non-Windows devices. Microsoft is working to migrate these modules to .Net Core 3.1 to make them cross-platform available on PowerShell Core.

For Windows using PS7 it has [backwards compatibility][PS7BackCap] with existing Windows PowerShell modules. The switch parameter `-UseWindowsPowerShell` can be added to `Import-Module` to proxy a local Windows PowerShell process to run any module still dependent on .Net Framework. 
Software: [PowerShell Core][PowerShellCore]

Recommended version of the PowerShell: 7.0.2 or 5.1

PowerShell Supported OS:

* Windows 10 1809+
* Windows Server 2012 R2, 2016 1809+, 2019 1809+
* Windows Server Semi-Annual Channel
* Ubuntu 16.04, and 18.04
* Debian 9, and 10
* CentOS 7 and 8
* Red Hat Enterprise Linux 7
* OpenSUSE 42.3
* Fedora 30
* macOS 10.13+
* Docker

PowerShell Community Supported OS:
* Arch Linux
* Kali Linus

 
### Logging
All events logged to host are written to PowerShell event queue. To view logged events run `get-event`


#Reporting Issues and Feedback
If you find any bugs when using the uConnector module or want to provide feedback, please file a ticket to [ithelp@ucdavis.edu](mailto:ithelp@ucdavis.edu)

[VSCode]: https://code.visualstudio.com/
[PowerShellCore]: https://docs.microsoft.com/en-us/powershell/?view=powershell-7
[PS7BackCap]: https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_windows_powershell_compatibility?view=powershell-7
