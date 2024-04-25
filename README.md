# ESXiTri
ESXi Cyber Security Incident Response Script

#### Description:

The purpose of this script is to preserve and collect notable ESXi artefacts. Once dropped onto the target system, the script will utilise a series of internal commands to query information from the host and retrieve data, which it stores in a temporary folder. Once all data has been collected, all files are hashed with the MD5 algorithm and the hash values are retained in a log file. Finally, the collection is archived into a TAR/GZIP file and the temporary store is deleted. The TAR/GZIP file can then be retrieved by the analyst for subsequent analysis offline. The script should be used during fast-time collection and preservation of artefacts during a cyber security incident. Frequent progress updates are provided in English and German languages via the terminal, whilst the script is active. A log of the terminal activities is also created and retained in the archive collection.

#### Artefacts Supported:

Memory:

- Active VMs
- Process List
- Open Files

Configuration:

- ESXi Version
- Hostname
- Install Time
- Welcome Message
- System Advanced Settings
- System Advanced Settings Non-Default
- vSphere Installation Bundles (VIB)
- vSphere Installation Bundles (VIB) Context
- vSphere Installation Bundles (VIB) Signature Verification
- vSphere Software Profiles
- vSphere Installation Bundles (VIB) Descriptor XML
- Timezone
- Uptime
- Date
- NTP
- DNS Resolver
- Host
- Name Service Switch
- USB Devices
- PCI Devices
- Host IP Address
- Host Domain Name
- Hosts
- Crontab Files
- init.d Files
- rc.local Files
- rc.local.d Files

Network:

- SNMP
- Network Connections
- ARP Cache
- Network Adapters
- Network Interfaces
- Network Interface IPv4 Configuration
- Network Interfaces IPv6 Configuration
- Network Configuration VMs
- Domain Search Configuration
- DNS Servers
- Virtual Switches
- Firewall Status
- Firewall Rulesets
- Firewall Ruleset Rules
- Firewall Rules Allowed IP
- VM Active Ports
- iSCSI Adapters
- SSH Files
- Service Location Protocol (SLP) Status

Storage:

- VMFS Mounted
- VMFS Mappings
- iSCSI Paths
- Device List
- Device Detached List
- Device Partition List GUID
- NFS Shares
- Disk Usage
- Disk

Accounts:

- Accounts
- Permissions
- User Accounts
- Password Hashes
- User Groups

Logs:

- vmsyslog Configuration
- /var/log/*
- /var/run/*
- /scratch/log/*
- Archived Logs VMFS
- Ash History

File System:

- root Binary Hashes
- bin Binary Hashes
- tmp File Hashes
- root Directory Listing
- bin Directory Listing
- tmp Directory Listing
- etc Directory Listing
- tmp File Collection

#### Usage:

Step 1: Copy ESXiTri.sh to the root of the target host file system via your preferred method i.e., SCP.

Step 2: Set script permissions to execute:

```
chmod +x ./ESXiTri.sh
```

Step 3: Execute script:

```
./ESXiTri.sh
```

Step 4: Download resultant (*.tar.gz) archive file via your preferred method i.e., SCP.

Step 5: Delete script and archive file from host:

```
rm ./ESXiTri.sh
```
```
rm ./ESXiTri_<hostname>_<date>_<time>.tar.gz
```

#### Requirements:
- ESXCLI and native Linux tools are leveraged. No third-party tools are required.

#### Testing:
- Tested on VMware ESXi, Version 6.5.0d (Release Name 6.5.0._ESXi 6.5.0d - Release Date 2017/04/18 - Build No 5310538)
