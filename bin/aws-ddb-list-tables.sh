#!/bin/bash

aws dynamodb list-tables --query 'TableNames[*]' --output text |sed -e 's/\s\+/\n/g' |grep 'mhe_clo\|shadow'