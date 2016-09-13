#!/bin/bash
#### Author: Michael McDonnell <michael@winterstorm.ca>
#### Purpose: Generate a valid ioProx ID (with valid CRC) 
####          from the FACILITY and CARDNUM.
#### Instructions: Edit the FACILITY and the CARDNUM1/2
####               Then run the script.
#### Output: A hex number suitable for cloning with proxmark3
#### Example: lf io clone <outputfromthisscript>

PREAMBLE1=2#00000000
PREAMBLE2=2#11110000
FACILITY=2#11111111
VERSION=2#00000001
CARDNUM1=2#10001010
CARDNUM2=2#00100110

SUM=$((${PREAMBLE1} + ${PREAMBLE2} \
  + ${FACILITY} + ${VERSION} \
  + ${CARDNUM1} + ${CARDNUM2} ))

CRC=$((255-(255&${SUM})))
CRCBIN=$(echo "obase=2; ${CRC}" | bc)

CARDBIN=2#$(echo "${PREAMBLE1}0${PREAMBLE2}1${FACILITY}1${VERSION}1${CARDNUM1}1${CARDNUM2}1${CRCBIN}11" | sed -e 's/2\#//g')

printf "%x\n" $(($CARDBIN))

