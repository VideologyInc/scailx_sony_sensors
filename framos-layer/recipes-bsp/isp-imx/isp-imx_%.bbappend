FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

require framos_nxp_drivers.inc

SRC_URI += "${FRAMOS_NXP_DRIVERS_REPO};name=framos;destsuffix=${S}/framos"
SRCREV_framos = "${FRAMOS_NXP_DRIVERS_REV}"
SRCREV_FORMAT .= "_framos"

SRC_URI += "\
    file://0001-fix-isi-drv-cmakes.patch;patchdir=framos \
    file://0003-isi-cmake.patch \
"

do_copy_files() {
    cp -rf ${S}/framos/isp-imx-4.2.2.24.1/dewarp/* ${S}/dewarp/
    cp -rf ${S}/framos/isp-imx-4.2.2.24.1/units/isi/drv/* ${S}/units/isi/drv/
}
addtask copy_files after do_patch before do_configure

FILES_SOLIBS_VERSIONED += " \
    ${libdir}/libimx662.so \
    ${libdir}/libimx676.so \
    ${libdir}/libimx678.so \
    ${libdir}/libimx900.so \
"
