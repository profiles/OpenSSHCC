# OpenSshCC ("OpenSSH CC Toggle")
A Control Center toggle for turning the SSH server on/off on (jailbroken) iOS.

This used to be an all-in-one tweak called `SSHonCC` ("SSH Toggle and Port") and it had the [OpenSSH Settings](https://gitlab.com/blanxd/OpenSshPort) and [SSHswitch](https://gitlab.com/blanxd/SSHswitch) as its subprojects. It was broken up into separate packages for everyone to have a choice about some dependencies et al, most of the development really happens in `SSHswitch` anyway. It started in 2018, since there wasn't anything similar for iOS11 long after it got publicly jailbroken, like there used to be on earlier jailbreaks. And the 1st public jb for iOS11 had OpenSSH server forcibly installed without an option to turn it off so to me it actually felt like a security issue, because not everyone knows what it is in the 1st place so most were probably walking around listening for anyone to log in on the default port with the default password.

## Building
- By default this Makefile builds it for rootless jbs (since OpenSshCC ver.1.1.0), with the default toolchain on the system. To build for rootful environments and/or use the old ABI for arm64e, append RF=1 to the make commandline, eg. `make RF=1` or `make package FINALPACKAGE=1 RF=1`, in this case it tries to find an Xcode 11 toolchain for the job (don't forget to `make clean` between RF and RL).  
- A recent [Theos](https://theos.dev/) is recommended (post 2023-03-26), but it also does the rootless job with older Theos versions.  

## Changelog
The [Changelog.md](Changelog.md) shows how it has evolved, it is mostly about what changed before the projects were broken up, the CC Toggle itself has really always had one simple function.  
