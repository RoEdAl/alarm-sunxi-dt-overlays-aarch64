#!/bin/bash -e

echoerr() { cat <<< "$@" 1>&2; }

OVL_DIR=/boot/dtbs/allwinner/overlay
OVL_FILE=/boot/overlays.txt

# calculate prefix from filename
OVL_PREFIX=$(basename $0)
OVL_PREFIX=${OVL_PREFIX%.*}
OVL_PREFIX=${OVL_PREFIX#upd-}
OVL_PREFIX=${OVL_PREFIX%-dt-overlays}

if [[ ! -d ${OVL_DIR} ]]; then
    echoerr "Directory ${OVL_DIR} does not exist"
    exit 1
fi

# get list of overlays
declare -a OVLS
OVLS=($(cd ${OVL_DIR} && ls ${OVL_PREFIX}-*.dtbo 2>/dev/null)) || true
OVLS=(${OVLS[@]#${OVL_PREFIX}-})
OVLS=(${OVLS[@]%.dtbo})

CONF_FILE=/etc/conf.d/${OVL_PREFIX}

# create overlays.txt file
(cat <<EOF
overlay_prefix=$OVL_PREFIX
overlays=${OVLS[*]}
EOF
if [[ ${#OVLS[*]} -gt 0 && -r ${CONF_FILE} && -s ${CONF_FILE} ]]; then
    cat ${CONF_FILE}
fi
) > $OVL_FILE
