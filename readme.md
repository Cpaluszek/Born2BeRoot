## Users and groups
Hostname: `cpalusze42`
Group: `user42` and `sudo`

## Passwords
**Password policy:** 
- 30 days renewal
	- 2 days min before password update
	- warning 7 days before renewal
- at least 10 chars
	- 1 Uppercase
	- 1 digit
	- 3 identical chars in a row forbidden
	- Username forbidden
	- at least 7 different chars from previous password -> ==Not for root user==

### Configuration
- Edit `/etc/login.defs`
	- `PASS_MAX_DAYS 30`
	- `PASS_MIN_DAYS 2`
	- `PASS_WARN_AGE 7` -> default
- Install `sudo apt install libpam-pwquality`
	- `/etc/pam.d/common-password`
	- `password requisite pam_pwqiality.so retry=3 minlen=10 ucredit=-1 dcredit=-1 maxrepeat=3 reject_username difok=7 enforce_for_root`
		- dcredit = digit
		- ucredit = upper

## Sudo
**Policy:**
- 3 tries maximum
- Custom message on wrong password
- keep log of every sudo action -> `/var/log/sudo`
- TTY mode enabled
- sudo usable path limited to : `/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin`

### Setup
- Installation : `apt install sudo`
- `adduser <username> sudo`
- `sudo -v` -> version
- `sudo addgroup user42`
- `sudo adduser <username> user42`
- `sudo apt update`

### Configuration
- `mkdir /var/log/sudo` -> sudo log files
- `/etc/sudoers.d/sudoconfig`
```bash
Defaults      passwd_tries=3
Defaults      badpass_message="Incorrect password"
Defaults      log_input,log_output
Defaults      iolog_dir="/var/log/sudo"
Defaults      requiretty
Defaults      secure_path="that/long/paths/from/subject"
```

## Cron

## Shell script
Script name : `monitoring.sh
**Commands used:**
- `uname -a`  -> print system informatioall)
- `cat /proc/cpuinfo` -> cpu information

## SSH
PORT 4242
config file: `sshd_config`
- `Port 4242`
- `PermitRootLogin no`
config file: `ssh_config`
- `Port 4242`

### Network adapter config
- VM off
- Virtual box settings
	- Network -> adapter 1 -> Advanced -> Port Forwarding

## UFW - Firewall
- `sudo apt install ufw`
- `sudo ufw enable`
- `sudo ufw allow 4242`
- `sudo ufw status`
