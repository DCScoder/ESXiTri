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
- Ash History

Logs:

- vmsyslog Configuration
- /var/log/*
- /var/run/*

File System:

- bin Binary Hashes
- tmp File Hashes
- bin Directory Listing
- tmp Directory Listing
- etc Directory Listing
- tmp File Collection

#### Usage:

Step 1: Copy ESXiTri.sh to the root of the target host file system.

Step 2: Set script permissions to execute:

```
chmod +x ./ESXiTri.sh
```

Step 3: Execute script:

```
./ESXiTri.sh
```

Step 4: Download resultant (*.tar.gz) archive file via your preferred method.

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

#### Limitations:
- If a persistent scratch location is configured, you may need to manually collect some logs from the scatch location, due to the use of symlinks. Further information on this topic can be found [here](https://download3.vmware.com/vcat/vmw-vcloud-architecture-toolkit-spv1-webworks/index.html#page/Cloud%20Operations%20and%20Management/Architecting%20a%20vRealize%20Log%20Insight%20Solution/Architecting%20a%20vRealize%20Log%20Insight%20Solution.2.05.html). Review the vmsyslog.conf log configuration to determine file path or run a search using the below command:
```
find / -name "auth.log"
```
