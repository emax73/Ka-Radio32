#!/bin/bash
echo python ../../esp-idf/components/nvs_flash/nvs_partition_generator/nvs_partition_gen.py $1.csv build/$1.bin 8192
python ../../esp-idf/components/nvs_flash/nvs_partition_generator/nvs_partition_gen.py $1.csv build/$1.bin 8192
echo done
