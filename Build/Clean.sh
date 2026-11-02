#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

make --no-print-directory -C "$SCRIPT_DIR" CLEAN

