#!/bin/bash

cd ~/Repositories/Amazon/backup-dynamodb

TBLS=($(aws dynamodb list-tables --query 'TableNames[*]' --output text |sed -e 's/\s\+/\n/g' |grep 'mhe_clo\|shadow'))
TMAX=$(echo ${TBLS[@]} |wc -w)
TMIN=1
LEN=$(($(echo $TMAX |wc -m)-1))

for TBL in ${TBLS[@]} ; do
  echo -e "($(printf "%0${LEN}d\n" $TMIN) / $TMAX) Backing up: ${TBL} "

  python ddb-backup.py -m backup -r us-east-1 -s ${TBL}

  TMIN=$((TMIN + 1))
done