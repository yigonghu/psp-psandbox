#!/bin/bash

mysqld --defaults-file=${PSP_DIR}/sosp_aec/psandbox_script/mysql.cnf/mysql.cnf &
sysbench --mysql-socket=$PSANDBOX_MYSQL_DIR/mysqld.sock --mysql-db=test --tables=1 --table-size=100000 $SYSBEN_DIR/oltp_update_index.lua --report-interval=3 cleanup >> /dev/null
sysbench --mysql-socket=$PSANDBOX_MYSQL_DIR/mysqld.sock --mysql-db=test --tables=1 --table-size=100000 $SYSBEN_DIR/oltp_update_index.lua --report-interval=3 prepare >> /dev/null

if [[ $1 == 1 ]]; then
  sudo ${PSP_DIR}/build/src/c++/apps/app/psp-app --cfg ${PSP_DIR}/sosp_aec/configs/base_psp_cfg.yml --label test
else
  sudo ${PSP_DIR}/build/src/c++/apps/app/psp-app --cfg ${PSP_DIR}/sosp_aec/configs/base_psp_darc_cfg.yml --label test
fi