#!/usr/bin/env bash

DIRNAME="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
cd "$DIRNAME" || exit

# Removes the test directories created by hooks
rm -rf ./hook-test

# Default script for running command line in services
bash ./docker-helper nginx-cli bash -c "cd / && ls -l"
echo -e "Test 1 finished\n"
sleep 1

# Script in the docker-helper.d directory
bash ./docker-helper nginx bash -c "cd / && ls -l"
echo -e "Test 2 finished\n"
sleep 1

# Script in the docker-helper.yml
bash ./docker-helper test1
echo -e "Test 3 finished\n"
sleep 1

# Script in the docker-helper.d directory
bash ./docker-helper test2
echo -e "Test 4 finished\n"
sleep 1

