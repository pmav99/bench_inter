#!/usr/bin/env bash

set -xeuo pipefail

ldconfig;

python "${@}"
