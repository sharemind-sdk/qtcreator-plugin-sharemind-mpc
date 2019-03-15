#!/usr/bin/env bash

if [ $# -eq 0 ]; then
    exit 1
fi

PROFILE="$1"

US_TIME=0
for T in `tail -n +2 "${PROFILE}" | cut -d \; -f 4`; do
    US_TIME=$[ US_TIME + T ]
done

S_TIME=$[ US_TIME / 1000000 ]

echo "Estimated running time: ${US_TIME} microseconds (${S_TIME} seconds)"
echo "(This is the estimated running time of the program on the Sharemind Application Server, running on a 1 Gbit network)"
