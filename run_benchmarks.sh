#!/usr/bin/env bash

# set -x

OUTPUT_DIR=output
QUERY_TIMEOUT=10000
TOTAL_TIMEOUT=600

run_solid() {
    local SOLC_VER="$1"
    local f="$2"
    solid --solc "$SOLC_VER" --only-last --query-timeout "$QUERY_TIMEOUT" --total-timeout "$TOTAL_TIMEOUT" "${@:2}"
}

for f in data/*.sol; do
    NAME="$(basename "$f")"
    SOLC_VER=$(cat ./solc_vers.csv | grep "${NAME%.*}" | cut -d, -f 2)
    [[ -z "$SOLC_VER" ]] && continue
    CDIR="$OUTPUT_DIR"/"$NAME"/
    mkdir -p "$CDIR"
    [[ ! -f "$CDIR"/auto.log ]] && \
        echo "Running AutoSolid on $f" && \
        time run_solid "$SOLC_VER" "$f" > "$CDIR"/auto.log 2>&1 && \
        echo
    [[ ! -f "$CDIR"/semi-true.log ]] && \
        echo "Running SemiSolid (cinv = true) on $f" && \
        time run_solid "$SOLC_VER" "$f" --task check -i true > "$CDIR"/semi-true.log 2>&1 && \
        echo
done
