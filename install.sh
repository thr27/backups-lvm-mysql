#!/bin/bash -e
cd `dirname $0`
. backups-config
[[ -z ${MYPASS} || -z ${MYUSER} ]] && echo "Need to set MySQL credentials in conf. Exiting.." && exit;
echo "Notice: Script does not create backup root '${BACKUPROOT}'. Needs to be created."
[[ -f /etc/cron.d/backups-lvm-mysql ]] && rm -rf /etc/cron.d/backups-lvm-mysql
[[ -d /etc/backups-lvm-mysql/ ]] || mkdir /etc/backups-lvm-mysql/
rsync -av --delete --cvs-exclude ./ /etc/backups-lvm-mysql/ --exclude=install.sh
chown -R root:root /etc/backups-lvm-mysql
mv /etc/backups-lvm-mysql/backups-lvm-mysql.cron /etc/cron.d/backups-lvm-mysql

