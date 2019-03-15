#!/usr/bin/env bash

ANALYZER="analyzer-gui"

if [ "x${SHAREMIND_INSTALL_PREFIX}" = "x" ]; then
    SHAREMIND_INSTALL_PREFIX="/usr"
fi

echo "Using SHAREMIND_INSTALL_PREFIX='${SHAREMIND_INSTALL_PREFIX}'"

EMULATOR="${SHAREMIND_INSTALL_PREFIX}/bin/sharemind-emulator"
EMULATOR_PROFILE="emulator-profile.csv"
SCC="${SHAREMIND_INSTALL_PREFIX}/bin/scc"
STDLIB="${SHAREMIND_INSTALL_PREFIX}/lib/sharemind/stdlib"

if [ $# -eq 0 ]; then
    echo "No arguments given."
    exit 1
fi

for SC in "$@"; do
    SC_ABSS=`readlink -f "${SC}"`

    if [ ! -f "${SC_ABSS}" ]; then
        exit 1
    fi

    SC_ABSSP=`dirname "${SC_ABSS}"`
    SC_BN=`basename "${SC}"`
    SB_BN=`echo "${SC_BN}" | sed 's/sc$//' | sed 's/$/sb/'`

    SC_CPY="${SC_ABSSP}/.${SB_BN}.src"
    SB="${SC_ABSSP}/${SB_BN}"

    cmp -s "${SC_CPY}" "${SC}"
    if [ $? -eq 0 ]; then
        echo "Up-to-date: '${SB}'"
    else
        echo "Compiling: '${SC}' to '${SB}'"
        "${SCC}" --include "${SC_ABSSP}" --include "${STDLIB}" --input "${SC}" --output "${SB}"
        if [ $? -ne 0 ]; then
            exit 1
        fi
        cp -L "${SC}" "${SC_CPY}" 2>/dev/null
    fi

    echo "Running: '${SB}'"
    "${EMULATOR}" -d "${SB}"
    if [ $? -ne 0 ]; then
        exit 1
    fi

    "${ANALYZER}" "${EMULATOR_PROFILE}"
done
