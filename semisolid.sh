#!/usr/bin/env bash

# Runs solid in SemiSolid mode on the provided benchmark and logs the results to
# the output folder.

### Configuration ###

OUTPUT_DIR=output
QUERY_TIMEOUT=10000
TOTAL_TIMEOUT=600

### Script code ###

[[ $# -lt 2 ]] && echo "Usage: $0 <source file> <invariant>" && exit 1

FILE="$1"
CINV="$2"

run_solid() {
    local SOLC_VER="$1"
    local f="$2"
    solid --solc "$SOLC_VER" --only-last --query-timeout "$QUERY_TIMEOUT" --total-timeout "$TOTAL_TIMEOUT" "${@:2}"
}

NAME="$(basename "$FILE")"
SOLC_VER=$(cat ./solc_vers.csv | grep "${NAME%.*}" | cut -d, -f 2)
[[ -z "$SOLC_VER" ]] && echo "Error: could not find solc version in ./solc_vers.csv" && exit 1

CDIR="$OUTPUT_DIR"/"$NAME"/
mkdir -p "$CDIR"

echo "Running SemiSolid (cinv = $CINV) on $NAME" && \
    (time run_solid "$SOLC_VER" "$FILE" --task check -i "$CINV") 2>&1 | tee "$CDIR"/semi.log 2>&1
