DESCRIPTION = "Kernel loadable module for Framos FSM-GO modules"
LICENSE = "GPL-2.0-or-later"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/GPL-2.0-or-later;md5=fed54355545ffd980b814dab4a3b312c"

require framos_nxp_drivers.inc
SRC_URI += "    file://0001-AB-2948.-framos-imx-driver-changes.patch;patchdir=../../../.."
SRCREV_framos = "${FRAMOS_NXP_DRIVERS_REV}"

inherit module

MODULES_MODULE_SYMVERS_LOCATION = "max9679x"

S = "${WORKDIR}/git/isp-vvcam/vvcam/v4l2/sensor"

COMPATIBLE_MACHINE = "(mx8mp-nxp-bsp)"
