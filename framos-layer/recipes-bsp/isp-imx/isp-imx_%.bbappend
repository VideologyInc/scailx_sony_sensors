FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "git://github.com/framosimaging/framos-nxp-drivers.git;name=framos;branch=lf-6.6.3_1.0.0-beta-v2.1.0;destsuffix=${S}/framos;protocol=https"
SRCREV_framos = "18483cb7d3ad802122db291dbe88bdd055ac260e"
SRCREV_FORMAT .= "_framos"

SRC_URI += "\
    file://0002-patch-scripts.patch \
    file://0003-isi-cmake.patch \
    file://0004-buildall-isp.patch \
"

do_copy_files() {
    cp -rf ${S}/framos/isp-imx-4.2.2.24.1/dewarp/* ${S}/dewarp/
    cp -rf ${S}/framos/isp-imx-4.2.2.24.1/units/isi/* ${S}/units/isi/
}
addtask copy_files after do_patch before do_configure

FILES_SOLIBS_VERSIONED += " \
    ${libdir}/libimx662.so \
    ${libdir}/libimx676.so \
    ${libdir}/libimx678.so \
    ${libdir}/libimx900.so \
"
