# Changelog of OpenSshCC (u.blanxd.opensshcc)
**CHANGES 1.1.0 [2023-07-20]**
* Added rootless support
* Added compatibility with SSHswitch 1.1.0

**CHANGES 1.0.1 [2021-03-04]**
* No functional changes, some packaging improvements.

**CHANGES 1.0 [2020-12-31] (compared to SSHonCC v.1.4 where this was the master project)**
* No functional changes compared to the last few SSHonCC releases. Break-up release.

### SSHonCC changelog
**SSHonCC CHANGES 1.4 [2020-05-27]**
* Added option to turn off Password Authentication.
* Lots of internal optimizations (no more C++).
* Added some functionality to SSHswitch which might be used in the future.

**SSHonCC CHANGES 1.3.5 [2019-11-25]**
* Same as 1.3.3/1.3.4, with Checkra1n and iOS 13 compatibility.

**SSHonCC CHANGES 1.3.4 [2019-04-30]**
* Same as 1.3.3, added support for A12 devices.

**SSHonCC CHANGES 1.3.3 [2018-10-20]**
* Added the ability to change the port(s) if ssh server is not running as sshd daemon, but via launchd listener (ie. compatibility with unc0ver).

**SSHonCC CHANGES 1.3.2 [2018-09-08]**
* Incoming scp and sftp connections now also get disconnected when turning sshd off (unless specifically allowed to persist).
* Internal optimizations, not dependent on coreutils any more.

**SSHonCC CHANGES 1.3.1 [2018-08-26]**
* Enabled specifying several ports for sshd to listen on.
* Internal stability fixes (none reported, but in theory v.1.3 was capable of crashing a few things).

**SSHonCC CHANGES 1.3 [2018-08-21] (removed, see 1.3.1 changelog)**
* Added options to control whether sshd starts (or doesn't) after rebooting/re-jailbreaking, despite the running toggled state.

**SSHonCC CHANGES 1.2 [2018-07-23]**
* Added option to disallow root logins.

**SSHonCC CHANGES 1.1 [2018-05-28]**
* When turning sshd off, active sessions now get disconnected. This functionality can be turned off in Settings.

**SSHonCC CHANGES 1.0.1 [2018-05-17]**
* packaging improvements, so in case it's uninstalled, sshd gets turned on with default port.

**SSHonCC CHANGES 1.0 [2018-05-13]**
* Initial release
