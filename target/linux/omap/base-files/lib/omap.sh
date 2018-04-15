#!/bin/sh
#
# Copyright (C) 2018 Lucian Cristian
#

OMAP_BOARD_NAME=
OMAP_MODEL=

omap_board_detect() {
	local machine
	local name
	local board

	machine=$(cat /proc/device-tree/model)
	board=$(cat /proc/device-tree/compatible)

	case "$board" in
	*"ti,am335x-evm""ti,am33xx")
		name="am335x-evm"
		;;
	*"ti,am335x-bone-black""ti,am335x-bone""ti,am33xx")
		name="am335x-boneblack"
		;;
	*"ti,omap4-panda""ti,omap4430""ti,omap4")
		name="omap4-panda"
		;;
	*"ti,omap3-beagle""ti,omap3")
		name="omap3-beagle"
		;;
	esac

	[ -z "$name" ] && name="unknown"

	[ -z "$OMAP_BOARD_NAME" ] && OMAP_BOARD_NAME="$name"
	[ -z "$OMAP_MODEL" ] && OMAP_MODEL="$machine"

	[ -e "/tmp/sysinfo/" ] || mkdir -p "/tmp/sysinfo/"

	echo "$OMAP_BOARD_NAME" > /tmp/sysinfo/board_name
	echo "$OMAP_MODEL" > /tmp/sysinfo/model
	echo "Detected $OMAP_BOARD_NAME - $OMAP_MODEL"
}
