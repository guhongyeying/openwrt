#!/bin/sh

do_omap() {
	. /lib/omap.sh

	omap_board_detect
}

boot_hook_add preinit_main do_omap
