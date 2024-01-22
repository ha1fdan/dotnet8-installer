#!/bin/bash

DOTNET_VERSION=8.0

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Get Ubuntu version
apt update && apt upgrade -y
apt-get install -y gpg
declare repo_version=$(if command -v lsb_release &> /dev/null; then lsb_release -r -s; else grep -oP '(?<=^VERSION_ID=).+' /etc/os-release | tr -d '"'; fi)
wget https://packages.microsoft.com/config/ubuntu/$repo_version/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
apt update

apt-get install -y aspnetcore-runtime-$DOTNET_VERSION

#As an alternative to the ASP.NET Core Runtime, you can install the .NET Runtime, which doesn't include ASP.NET Core support
#apt-get install -y dotnet-runtime-8.0