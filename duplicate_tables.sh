#!/bin/bash
#EJECUTAR CON TERMINAL GIT BASH

services=("ms_compras" "ms_stock" "ms_catalogo" "ms_pago")
source_db="main_app_dev_db"
target_dbs=("main_app_test_db" "main_app_prod_db")

for target_db in "${target_dbs[@]}"
do
  echo "Duplicando tablas de $source_db a $target_db"
  docker exec -it db psql -U main_app_user -d $target_db -c "DROP SCHEMA IF EXISTS public CASCADE; CREATE SCHEMA public;"
  docker exec -it db pg_dump -U main_app_user -d $source_db | docker exec -i db psql -U main_app_user -d $target_db
done