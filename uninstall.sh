#!/bin/bash -e
cd `dirname $0`
. backups-config
[[ -f /etc/cron.d/backups-lvm-mysql ]] && rm -rf /etc/cron.d/backups-lvm-mysql
[[ -d /etc/backups-lvm-mysql/ ]] && rm -rf /etc/backups-lvm-mysql
