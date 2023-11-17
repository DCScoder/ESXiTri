#!/bin/sh
###################################################################################
#
#    Script:    ESXiTri.sh
#    Version:   1.3
#    Author:    Dan Saunders
#    Contact:   dcscoder@gmail.com
#    Purpose:   ESXi Cyber Security Incident Response Script (Shell)
#    Usage:     ./ESXiTri.sh
#
#    This program is free software: you can redistribute it and / or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program. If not, see <https://www.gnu.org/licenses/>.
#
###################################################################################

Version='v1.3'

########## Startup ##########

echo "

		   _______   _______ ___    ___     __________
		  |   ____| /  _____|\  \  /  / __ |___    ___| _______  __
		  |  |____ |   \___   \  \/  / |__|    |  |    |    ___||__|
		  |   ____| \__    \  |      | |  |    |  |    |   /    |  |
		  |  |____  ____\   | /  /\  \ |  |    |  |    |  |     |  |
		  |_______||_______/ /__/  \__\|__|    |__|    |__|     |__|


Script / Skript: ESXiTri.sh - $Version - Author / Autor: Dan Saunders dcscoder@gmail.com

"
echo -e "\e[93m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Please Note:

Hi, script running on $(hostname), please do not touch.

Bitte beachten Sie:

Hallo, skript laeuft auf $(hostname), bitte nicht beruehren.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\e[0m"

echo "
Running script / Ausfuehrendes Skript..."

########## Admin ##########

echo "
(Task 1 / 9) Admin tasks running / Admin-Aufgabe laeuft."

# Destination
Destination=$(pwd)
# System Date/Time
Timestamp=$(date +%Y%m%d_%H%M%S)
# Computer Name
Endpoint=$(hostname)
# Triage
Name='ESXiTri_'$Endpoint\_$Timestamp
Triage=$Name
# Directory Structure
mkdir $Triage
chmod 777 $Triage
# Start Log
exec 2> $Triage/ESXiTri.log

########## Memory ##########

echo "
(Task 2 / 9) Gather memory information / Sammeln von Speicherprozessinformationen."

# Directory Structure
mkdir $Triage/Memory
chmod 777 $Triage/Memory

# Active VMs
esxcli vm process list > $Triage/Memory/Active_VMs.txt
# Process List
esxcli system process list > $Triage/Memory/Process_List.txt
# Open Files
lsof > $Triage/Memory/Open_Files.txt

########## Configuration ##########

echo "
(Task 3 / 9) Gather system information / Sammeln von Systeminformationen."

# Directory Structure
mkdir $Triage/Configuration
chmod 777 $Triage/Configuration

# ESXi Version
esxcli system version get > $Triage/Configuration/ESXi_Version.txt
# Hostname
esxcli system hostname get > $Triage/Configuration/Hostname.txt
# Install Time
esxcli system stats installtime get > $Triage/Configuration/Install_Time.txt
# Welcome Message
esxcli system welcomemsg get > $Triage/Configuration/Welcome_Message.txt
# System Advanced Settings
esxcli system settings advanced list > $Triage/Configuration/System_Advanced_Settings.txt
# System Advanced Settings Non-Default
esxcli system settings advanced list --delta > $Triage/Configuration/System_Advanced_Settings_Non_Default.txt
# vSphere Installed Bundles (VIB)
esxcli software vib list > $Triage/Configuration/vSphere_Installed_Bundles.txt
# vSphere Installed Bundles (VIB) Context
esxcli software vib get > $Triage/Configuration/vSphere_Installed_Bundles_Context.txt
# vSphere Installed Bundles (VIB) Signature Verification
esxcli software vib signature verify > $Triage/Configuration/vSphere_Installed_Bundles_Signature_Verification.txt
# vSphere Software Profiles
esxcli software profile get > $Triage/Configuration/vSphere_Software_Profiles.txt
# vSphere Installed Bundles (VIB) Descriptor XML
cp -rfp /var/db/esximg/profiles $Triage/Configuration/profiles
# Timezone
cat /etc/localtime > $Triage/Configuration/Timezone.txt
# Uptime
uptime > $Triage/Configuration/Uptime.txt
# Date
date > $Triage/Configuration/Date.txt
# NTP
cat /etc/ntp.conf > $Triage/Configuration/ntp.conf
# DNS Resolver
cat /etc/resolv.conf > $Triage/Configuration/resolv.conf
# Host
cat /etc/host.conf > $Triage/Configuration/host.conf
# Name Service Switch
cat /etc/nsswitch.conf > $Triage/Configuration/nsswitch.conf
# USB Devices
lsusb -v > $Triage/Configuration/USB_Devices.txt
# PCI Devices
lspci > $Triage/Configuration/PCI_Devices.txt
# Host IP Address
hostname -i > $Triage/Configuration/Host_IP_Address.txt
# Host Domain Name
hostname -f > $Triage/Configuration/Host_Domain_Name.txt
# Hosts
cat /etc/hosts > $Triage/Configuration/hosts
# Crontab Files
cp -rfp /var/spool/cron/crontabs $Triage/Configuration/Crontab
# init.d Files
cp -rfp /etc/init.d $Triage/Configuration/init.d
# rc.local Files
cp -rfp /etc/rc.local $Triage/Configuration/rc.local
# rc.local.d Files
cp -rfp /etc/rc.local.d $Triage/Configuration/rc.local.d

########## Network ##########

echo "
(Task 4 / 9) Gather network information / Sammeln von Netzwerkinformationen."

# Directory Structure
mkdir $Triage/Network
chmod 777 $Triage/Network

# SNMP
esxcli system snmp get > $Triage/Network/SNMP_Configuration.txt
# Network Connections
esxcli network ip connection list > $Triage/Network/Active_Network_Connections.txt
# ARP Cache
esxcli network ip neighbor list > $Triage/Network/ARP_Cache.txt
# Network Adapters
esxcli network nic list > $Triage/Network/Network_Adapters.txt
# Network Interfaces
esxcli network ip interface list > $Triage/Network/Network_Interfaces.txt
# Network Interface IPv4 Configuration
esxcli network ip interface ipv4 address list > $Triage/Network/Network_Interface_IPv4_Configuration.txt
# Network Interface IPv6 Configuration
esxcli network ip interface ipv6 address list > $Triage/Network/Network_Interface_IPv6_Configuration.txt
# Network Configuration VMs
esxcli network vm list > $Triage/Network/Network_Configuration_VMs.txt
# Domain Search Configuration
esxcli network ip dns search list > $Triage/Network/Domain_Search_Configuration.txt
# DNS Servers
esxcli network ip dns server list > $Triage/Network/DNS_Servers.txt
# Virtual Switches
esxcli network vswitch standard list > $Triage/Network/Virtual_Switches.txt
# Firewall Status
esxcli network firewall get > $Triage/Network/Firewall_Status.txt
# Firewall Rulesets
esxcli network firewall ruleset list > $Triage/Network/Firewall_Rulesets.txt
# Firewall Ruleset Rules
esxcli network firewall ruleset rule list > $Triage/Network/Firewall_Ruleset_Rules.txt
# Firewall Rules Allowed IP
esxcli network firewall ruleset allowedip list > $Triage/Network/Firewall_Ruleset_Allowed_IP.txt
# VM Active Ports
esxcli network vm list > $Triage/Network/VM_Active_Ports.txt
# iSCSI Adapters
esxcli iscsi adapter list > $Triage/Network/iSCSI_Adapters.txt
# SSH Files
cp -rfp /etc/ssh $Triage/Network
# Service Location Protocol (SLP) Status
/etc/init.d/slpd status > $Triage/Network/OpenSLP_Status.txt

########## Storage ##########

echo "
(Task 5 / 9) Gather storage information / Sammeln von Lagerungsinformationen."

mkdir $Triage/Storage
chmod 777 $Triage/Storage

# VMFS Mounted
esxcli storage vmfs extent list > $Triage/Storage/VMFS_Mounted.txt
# VMFS Mappings
esxcli storage filesystem list > $Triage/Storage/VMFS_Mappings.txt
# iSCSI Paths
esxcli storage core path list > $Triage/Storage/iSCSI_Paths.txt
# Device List
esxcli storage core device list > $Triage/Storage/Device_List.txt
# Device Detached List
esxcli storage core device detached list > $Triage/Storage/Device_Detached_List.txt
# Device Partition List
esxcli storage core device partition list > $Triage/Storage/Device_Partition_List.txt
# Device Partition List GUID
esxcli storage core device partition showguid > $Triage/Storage/Device_Partition_List_GUID.txt
# NFS Shares
esxcli storage nfs list > $Triage/Storage/NFS_Shares.txt
# Disk Usage
df -h > $Triage/Storage/Disk_Usage.txt
# Disk
fdisk -lu > $Triage/Storage/fdisk.txt

########## Accounts ##########

echo "
(Task 6 / 9) Gather account information / Kontoinformationen sammeln."

# Directory Structure
mkdir $Triage/Accounts
chmod 777 $Triage/Accounts

# Accounts
esxcli system account list > $Triage/Accounts/Accounts.txt
# Permissions
esxcli system permission list > $Triage/Accounts/Permissions.txt
# User Accounts
cat /etc/passwd > $Triage/Accounts/passwd
# Password Hashes
cat /etc/shadow > $Triage/Accounts/shadow
# User Groups
cat /etc/group > $Triage/Accounts/group
# Ash History
cp -rfp .ash_history $Triage/Accounts

########## Logs ##########

echo "
(Task 7 / 9) Gather log information / Sammeln von Protokollinformationen."

# Directory Structure
mkdir $Triage/Logs
chmod 777 $Triage/Logs

# vmsyslog Configuration
cat /etc/vmsyslog.conf > $Triage/Logs/vmsyslog.conf
# /var/log/*
tar -zcf $Triage/Logs/var_log.tar.gz var/log
# /var/run/*
tar -zcf $Triage/Logs/var_run.tar.gz var/run
# Scratch Path
tar -zcf $Triage/Logs/scratch_log.tar.gz scratch/log

########## File System ##########

echo "
(Task 8 / 9) Gather file system information / Sammeln von Dateisysteminformationen."

# Directory Structure
mkdir $Triage/FileSystem
chmod 777 $Triage/FileSystem

# bin Binary Hashes
find /bin -type f -exec md5sum {} \; > $Triage/FileSystem/bin_MD5_Hashes.txt
# tmp File Hashes
find /tmp -type f -exec md5sum {} \; > $Triage/FileSystem/tmp_MD5_Hashes.txt
# bin Directory Listing
find /bin -print0 | xargs -0 stat > $Triage/FileSystem/bin_Dir_Listing.txt
# tmp Directory Listing
find /tmp -print0 | xargs -0 stat > $Triage/FileSystem/tmp_Dir_Listing.txt
# etc Directory Listing
find /etc -print0 | xargs -0 stat > $Triage/FileSystem/etc_Dir_Listing.txt
# tmp File Collection
tar -zcf $Triage/FileSystem/tmp.tar.gz tmp

########## Organise Collection ##########

echo "
(Task 9 / 9) Organise Collection / Sammlung organisieren."

# Hashing
find $Triage -type f -exec md5sum {} \; > $Destination/$Triage/Hashes.txt

# Compress Archive
tar -zcf $Triage.tar.gz $Destination/$Triage

# Delete Folder
rm -rf $Triage

echo -e "\e[92m
Script completed! / Skript abgeschlossen!"
