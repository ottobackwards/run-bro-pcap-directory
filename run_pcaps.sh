#!/usr/bin/env bash

 # Copyright 2019 Otto Fowler and run_pcaps.sh contributors
 # All rights reserved.
 # Licensed under the Apache License, Version 2.0 (the "License");
 # you may not use this file except in compliance with the License.
 # You may obtain a copy of the License at
 #
 #       http://www.apache.org/licenses/LICENSE-2.0
 #
 # Unless required by applicable law or agreed to in writing, software
 # distributed under the License is distributed on an "AS IS" BASIS,
 # WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 # See the License for the specific language governing permissions and
 # limitations under the License.

shopt -s nocasematch
set -u # nounset
set -e # errexit
set -E # errtrap
set -o pipefail

function help {
  echo " "
  echo "USAGE"
  echo "    --data-path                     The pcap data path
  echo "    --output-path                   the path to the directory to output test data
  echo "    -h/--help                       Usage information."
  echo " "
  echo "COMPATABILITY"
  echo "     bash >= 4.0 is required."
  echo " "
}

# Require bash >= 4
if (( BASH_VERSINFO[0] < 4 )); then
  >&2 echo "ERROR> bash >= 4.0 is required" >&2
  help
  exit 1
fi

DATE=$(date)
LOG_DATE=${DATE// /_}

#DATA_PATH is the path to a directory containing pcaps or directories with pcaps
#TEST_OUTPUT_PATH is a path to a directory where the bro output will be put
DATA_PATH=
TEST_OUTPUT_BASE=

# Handle command line options
for i in "$@"; do
  case $i in
  #
  # DATA_PATH
  #
    --data-path=*)
      DATA_PATH="${i#*=}"
      shift # past argument=value
    ;;
  #
  # TEST_OUTPUT_BASE
  #
  #   --output-path
  #
    --output-path=*)
      TEST_OUTPUT_BASE="${i#*=}"
      shift # past argument=value
    ;;
  #
  # -h/--help
  #
    -h | --help)
      help
      exit 0
      shift # past argument with no value
    ;;
  esac
done


if [[ -z "$DATA_PATH" ]]; then
  help
  exit 1
fi

if [[ -z "$TEST_OUTPUT_BASE" ]]; then
 help
 exit 1
fi


TEST_OUTPUT_PATH="${TEST_OUTPUT_BASE}/${LOG_DATE//:/_}"

if [[ ! -d "${TEST_OUTPUT_PATH}" ]]; then
 mkdir -p "${TEST_OUTPUT_PATH}" || exit 1
fi


echo "Running build_container with "
echo "DATA_PATH        = $DATA_PATH"
echo "TEST_OUTPUT_PATH = $TEST_OUTPUT_PATH"
echo "==================================================="


for file in "${DATA_PATH}"/**/*.pcap*
do
  # get the file name
  BASE_FILE_NAME=$(basename "${file}")
  OUTPUT_DIRECTORY_NAME=${BASE_FILE_NAME//\./_}

  mkdir "${TEST_OUTPUT_PATH}/${OUTPUT_DIRECTORY_NAME}" || exit 1

  echo "MADE ${TEST_OUTPUT_PATH}/${OUTPUT_DIRECTORY_NAME}"

  cd "${TEST_OUTPUT_PATH}/${OUTPUT_DIRECTORY_NAME}" || exit 1
  pwd
  echo "Processing ${file}"
  bro site/local -C -r "${file}"
  rc=$?; if [[ ${rc} != 0 ]]; then
    exit ${rc}
  fi
done

