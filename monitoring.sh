#!/bin/bash

ARCHITECTURE=$(uname -a)

CPU_PHYSICAL=$(grep "physical id" /proc/cpuinfo | uniq | wc -l)

V_CPU=$(grep "processor" /proc/cpuinfo | uniq | wc -l)

# free -m display the amount of memory in Mb
USED_MEM=$(free -m | awk '$1 == "Mem:" {print $3}')
TOTAL_MEM=$(free -m | awk '$1 == "Mem:" {print $2}')
MEM_LOAD=$(free | awk '$1 == "Mem:" {printf("%.2f"), $3/$2*100}')

# df reports file system disk usage
#  -B -> block size (m for Mega; g for Giga)
USED_DISK=$(df -Bm | grep '^/dev/' | grep -v '/boot$' | awk '{ud += $3} END {print ud}')
TOTAL_DISK=$(df -Bm | grep '^/dev/' | grep -v '/boot$' | awk '{td += $2} END {print td}')
DISK_LOAD=$(df -Bm | grep '^/dev/' | grep -v '/boot$' | awk '{td += $2} {ud += $3} END {printf("%d"), ud/td*100}')

CPU_LOAD=$(uptime | awk '{print $8}' | tr "," "%" )

LAST_BOOT=$(who -b | awk '$1 = "system" {print $3 " " $4}')

LVM_COUNT=$(lsblk | grep "lvm" | wc -l)
LVM_USE=$(if [$LVM_COUNT -eq 0]; then echo no; else echo yes; fi)

TCP_CONNECTION=$(ss -s | grep '^TCP:' | awk '{print $4}' | tr -d ",")

USER_LOG=$(users | wc -w)

IP=$(hostname -I)
MAC=$(ip link | awk '$1 == "link/ether" {print $2}')

# Count of sudo commands execution
SUDO=$(journalctl _COMM=sudo | grep COMMAND | wc -l)

wall "  #Architecture: $ARCHITECTURE
        #CPU physical: $CPU_PHYSICAL
        #vCPU: $V_CPU
        #Memory Usage: $USED_MEM/${TOTAL_MEM}Mb ($MEM_LOAD%)
        #Disk Usage: $USED_DISK/${TOTAL_DISK}Mb ($DISK_LOAD%)
        #CPU load: $CPU_LOAD
        #Last boot: $LAST_BOOT
        #LVM use: $LVM_USE
        #TCP Connections: $TCP_CONNECTION ESTABLISHED
        #User log: $USER_LOG
        #Network: IP $IP ($MAC)
        #Sudo: $SUDO cmd"
