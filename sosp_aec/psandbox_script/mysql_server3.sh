#!/bin/bash

mysqld --defaults-file=${PSP_DIR}/sosp_aec/psandbox_script/mysql1.cnf &
sleep 5

sysbench --mysql-socket=$PSANDBOX_MYSQL_DIR/mysqld.sock --mysql-db=test --tables=6 --table-size=1000 --threads=1 --time=90 --percentile=50 $SYSBEN_DIR/oltp_insert.lua --report-interval=5 cleanup >> /dev/null
sysbench --mysql-socket=$PSANDBOX_MYSQL_DIR/mysqld.sock --mysql-db=test --tables=6 --table-size=1000 --threads=1 --time=90 --percentile=50 $SYSBEN_DIR/oltp_insert.lua --report-interval=5 prepare >> /dev/null

if [[ $1 == 1 ]]; then
  sudo ${PSP_DIR}/build/src/c++/apps/app/psp-app --cfg ${PSP_DIR}/sosp_aec/configs/base_psp_cfg_mysql.yml --label test
else
  sudo ${PSP_DIR}/build/src/c++/apps/app/psp-app --cfg ${PSP_DIR}/sosp_aec/configs/base_psp_darc_cfg_mysql.yml --label test
fi

