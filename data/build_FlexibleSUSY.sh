#!/bin/sh

set -eux

# Usage:
# cd FlexibleSUSY/
# $PWD/build_FlexibleSUSY.sh 

HIMALAYA_DIR=$HOME/research/Himalaya
TSIL_DIR=$HOME/research/TSIL-1.46

MODELS="\
HSSUSY \
NUHMSSMNoFVHimalaya \
NUHMSSMNoFVHimalayaEFTHiggs \
"

for m in ${MODELS}; do
    ./createmodel -f --name=${m}
done

./configure \
    --with-models="${MODELS}" \
    --with-tsil-incdir=${TSIL_DIR}/ \
    --with-tsil-libdir=${TSIL_DIR}/ \
    --with-himalaya-incdir=${HIMALAYA_DIR}/include/ \
    --with-himalaya-libdir=${HIMALAYA_DIR}/build/

make -j2

echo "Finished successfully!"
