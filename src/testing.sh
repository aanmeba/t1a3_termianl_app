#!/usr/bin/bash

now=$(date +"%Y-%m-%d_%H-%M")
rspec -f d >> ./test-documentation/${now}-test.log
