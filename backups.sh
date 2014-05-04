#!/bin/bash -e
# Alternative to using rsnapshot. Just sync the LVM some where.
# Remote backups should take care of revisions if needed.
#

function fail() {
  echo "$@";
  exit 1;
}

function post() {
  rm -f ${BACKUPLOCKFILE}
  [[ -f ./backups-post ]] && ./backups-post
}

cd `dirname $0`
. backups-config

exec 3>${BACKUPLOCKFILE}
flock -w 120 3 || fail  "Could not obtain lock."
trap "post" EXIT

[[ -f ./backups-pre ]] && ./backups-pre
[[ ! -d ${BACKUPROOT} ]] && fail "Error: backup destination '${BACKUPROOT}' does not exist. Will not create.";
rsync -av --delete ${LVMMOUNT}/${MYSQLDATADIR}/ ${BACKUPROOT}/

