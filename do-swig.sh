#!/bin/sh
# Copyleft 2011
# Author: pancake(at)nopcode.org
# Wrapper for valaswig-cc

LNG=$1
MOD=$2
VALABINDFLAGS="" ; [ 1 = "${DIST}" ] && VALABINDFLAGS="-C"
if [ -z "${MOD}" ]; then
	echo "Usage: ./libr-swig.sh [python] [r_foo]"
	exit 1
fi
mkdir -p ${LNG}
cd ${LNG}

#valaswig-cc ${LNG} ${MOD} -I../../libr/include ../../libr/vapi/${MOD}.vapi -l${MOD} -L../../libr/$(echo ${MOD} | sed -e s,r_,,)

echo "Build ${MOD} `pkg-config --libs ${MOD}`"

valaswig-cc ${LNG} ${MOD} ${VALABINDFLAGS} \
	-x --vapidir=../vapi ../vapi/${MOD} \
	`pkg-config --cflags --libs ${MOD}`