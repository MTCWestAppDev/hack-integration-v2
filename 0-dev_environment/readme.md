# Overview

## Development Environment Configuration

The following configuration options should work for this hack

## GitHub Account

If you plan to implement CI/CD as part of the integration solutions built during the hack (optional), you should have a GitHub account.  Create a [free account](https://github.com/signup) here

## Azure Subscription

If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free) before you begin.  The following subscription types should work:

* Azure Visual Studio Subscription
* Azure Enterprise Dev/Test Subscription
* Azure Enterprise Subscription
* Ability to create the following resources:
  * Logic Apps
  * Azure Functions
  * Log Analytics Workspace
  * Application Insights
  * API Management
  * Service Bus
  * Event Grid

## Windows 10/11

### Visual Studio Option

* Visual Studio 2019/2022 (C#)
  * Azure Development Workload
  * .NET cross platform development
  * Azure LogicApps Tools for VS2019 [Download](https://marketplace.visualstudio.com/items?itemName=VinaySinghMSFT.AzureLogicAppsToolsForVS2019)

### VS Code Option

* Visual Studio Code [Download](https://code.visualstudio.com/Download)
  * Azure Account extension
  * Azure logic app (standard) extension
  * Azure logic app (consumption) extension
  * Azure Functions extension
  * Azure API Management extension
* Azure CLI [Download](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-windows?tabs=azure-cli)
* Azure Functions Core Tools 3/4 for Windows [Download](https://docs.microsoft.com/en-us/azure/azure-functions/functions-run-local)
* .NET 3.1 for Windows [Download](https://dotnet.microsoft.com/download/dotnet/3.1)
* .NET 6.0 for Windows [Download](https://dotnet.microsoft.com/download/dotnet/6.0)

### Windows 10/11 with Ubuntu WSL

* Visual Studio Code [Download](https://code.visualstudio.com/Download)
  * Azure Account extension
  * Azure logic app (standard) extension
  * Azure logic app (consumption) extension
  * Azure Functions extension
  * Azure API Management extension
  * Windows Subsystem for Linux (WSL) extension
* Windows Subsystem for Linux OS feature
* Ubuntu for WSL (From the Microsoft Store)
  * Azure CLI for Linux
  * Azure Functions Core Tools 4 for Linux
  * .NET Core SDK 6 for Linux
  * Nodejs Latest LTS

### Windows REST Clients/Tools (optional)

* [Nightingale](https://www.microsoft.com/en-us/p/nightingale-rest-client/9n2t6f9f5zdn?activetab=pivot:overviewtab)
* [Postman](https://www.postman.com)
* [Test web APIs with the HttpRepl](https://docs.microsoft.com/en-us/aspnet/core/web-api/http-repl/?view=aspnetcore-5.0&tabs=windows)
* [PowerShell Invoke-RestMethod](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-restmethod)

## macOS

* Azure CLI
* Azure Functions Core Tools 4
* .NET Core SDK
* VS Code (JavaScript, Python)
  * Azure Account extension
  * Azure logic app (standard) extension
  * Azure logic app (consumption) extension
  * Azure Functions extension
  * Azure API Management extension

## Ubuntu 20.04 Install Reference

### Ubuntu Updates

    sudo apt-get update -y && sudo apt-get upgrade -y

### Azure CLI

[Install Azure CLI on Linux](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux)

```bash
sudo apt-get install ca-certificates curl apt-transport-https lsb-release gnupg
curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null
AZ_REPO=$(lsb_release -cs)
echo $AZ_REPO
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | sudo tee /etc/apt/sources.list.d/azure-cli.list
cat /etc/apt/sources.list.d/azure-cli.list
sudo apt-get update -y
sudo apt-get install azure-cli -y
```

### Azure Functions Core Tools 4

[Work with Azure Functions Core Tools on Ubuntu](https://docs.microsoft.com/en-us/azure/azure-functions/functions-run-local?tabs=linux)

```bash
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-$(lsb_release -cs)-prod $(lsb_release -cs) main" > /etc/apt/sources.list.d/dotnetdev.list'
cat /etc/apt/sources.list.d/dotnetdev.list
sudo apt-get update -y
sudo apt-get install azure-functions-core-tools-4 -y
echo 'export FUNCTIONS_CORE_TOOLS_TELEMETRY_OPTOUT=1' >> ~/.bashrc
cat ~/.bashrc
. ~/.profile
```

### dotnet SDK 6 on Ubuntu 20.04 LTS

[Install the .NET SDK or the .NET Runtime on Ubuntu](https://docs.microsoft.com/en-us/dotnet/core/install/linux-ubuntu)

```bash
wget https://packages.microsoft.com/config/ubuntu/21.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
sudo apt-get install apt-transport-https -y
sudo apt-get install -y dotnet-sdk-6.0 -y
echo 'export DOTNET_CLI_TELEMETRY_OPTOUT=1' >> ~/.bashrc
cat ~/.bashrc
. ~/.profile
```

### Nodejs v16.x

[How to install Node.js via Package Manager](https://nodejs.org/en/download/package-manager/)
[How to install Node.js via binary archive on Linux](https://github.com/nodejs/help/wiki/Installation)
[Index of /download/release/latest-v16.x/](https://nodejs.org/download/release/latest-v16.x/)

Shell commands for manual installation on Ubuntu 20.04.4 LTS

```bash
# remove all existing installs (destructive!)
ls /usr/local/lib/
sudo rm -rf /usr/local/lib/nodejs

# install the latest LTS version (verify latest version and update variables as needed)
VERSION=v16.15.1
DISTRO=linux-x64
echo $VERSION
echo $DISTRO
echo "Install Nodejs $VERSION for $DISTRO"
wget https://nodejs.org/dist/$VERSION/node-$VERSION-$DISTRO.tar.xz
sudo mkdir -p /usr/local/lib/nodejs
sudo tar -xJvf node-$VERSION-$DISTRO.tar.xz -C /usr/local/lib/nodejs

# verify the files were extracted
ll /usr/local/lib/nodejs

# update the bash profile
cat ~/.bashrc
echo "VERSION=$VERSION" >> ~/.bashrc
echo "DISTRO=$DISTRO" >> ~/.bashrc
echo 'export PATH=/usr/local/lib/nodejs/node-$VERSION-$DISTRO/bin:$PATH' >> ~/.bashrc

# verify the bash profile was updated and reload
cat ~/.bashrc
. ~/.profile

# verify nodejs and npm is working
node -v
npm version
npx -v

# delete the nodejs download
rm node-$VERSION-$DISTRO.tar.xz
```

## macOS Install Reference

### Homebrew

Homebrew macOS Requirements

* A 64-bit Intel CPU or Apple Silicon CPU
* macOS Mojave (10.14) (or higher)
* Command Line Tools (CLT) for Xcode: xcode-select --install, developer.apple.com/downloads or Xcode 3
  * NOTE: Some homebrew formulae require full the Xcode installation which may require an Apple Developer account. You can get an Apple Developer account [here](https://developer.apple.com/register/index.action)
* A Bourne-compatible shell for installation (e.g. bash or zsh)

[Install homebrew package manager](https://docs.brew.sh/Installation)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Azure CLI

[Install Azure CLI on macOS](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-macOS)

For the macOS platform, you can install the Azure CLI with the homebrew package manager

```bash
brew update && brew install azure-cli
```

### Azure Functions Core Tools 4

[Work with Azure Functions Core Tools on macOS](https://docs.microsoft.com/en-us/azure/azure-functions/functions-run-local?tabs=macOS)

```bash
brew tap azure/functions
brew install azure-functions-core-tools@3

# if upgrading on a machine that has 2.x installed
brew link --overwrite azure-functions-core-tools@4
```

### Dotnet SDK 6

[Install .NET on macOS Overview](https://docs.microsoft.com/en-us/dotnet/core/install/macos)

[Standalone installer for .NET on macOS](https://dotnet.microsoft.com/en-us/download/dotnet/thank-you/sdk-6.0.301-macos-x64-installer)

### Nodejs latest v16.x

[Node.js distribuution page](https://nodejs.org/dist/latest-v16.x/)

[Node.js macOS Installer (.pkg)](https://nodejs.org/dist/v16.15.1/node-v16.15.1.pkg)