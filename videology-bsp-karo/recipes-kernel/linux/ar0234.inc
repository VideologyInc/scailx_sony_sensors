LICENSE = "GPL-2.0-or-later"
LIC_FILES_CHKSUM = "file://LICENSE;md5=b234ee4d69f5fce4486a80fdaf4a4263"

SRC_URI = "git://github.com/VideologyInc/kernel_mod_vid_ap1302.git;branch=main;protocol=https"
SRCREV ="d9785978d77322285cebb4a1ac64bc99d2c8d5be"
S = "${WORKDIR}/git"

PV = "0.1.30"
# RM_WORK_EXCLUDE += "${PN}"
