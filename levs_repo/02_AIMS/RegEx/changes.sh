#!/bin/bash
sed -i '
s/GA/\$1/gI
s/TA/\$2/gI
s/CA/\$3/gI
' "$@"
