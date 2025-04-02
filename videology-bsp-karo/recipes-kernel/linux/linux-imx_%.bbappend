FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

# remove the NXP preocesses that clobber the defconfig.
deltask copy_defconfig
deltask merge_delta_config

SRC_URI:append = " file://scailx-kmeta;type=kmeta;destsuffix=scailx-kmeta "

SRC_URI:append = " file://of-configfs.patch "
SRC_URI:append = " file://0001-ignore-imx-media-dev-probe-defer-if-no-sensor-i2c.patch "
SRC_URI:append = " file://0002-allow-userspace-usb-role-switch.patch "

PV:scailx = "${LINUX_VERSION}"

SCMVERSION = "n"
LINUX_VERSION_EXTENSION = ""
