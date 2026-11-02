#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

start=$(date +%s)

make --no-print-directory -C "$SCRIPT_DIR" BUILD_STAGE_1 "$@" &&                \
make --no-print-directory -C "$SCRIPT_DIR" BUILD_STAGE_2 -k -j $(nproc) "$@" && \
make --no-print-directory -C "$SCRIPT_DIR" BUILD_STAGE_3 "$@"

end=$(date +%s)
execution_time=$((end - start))

echo "Total execution time: $execution_time seconds"
