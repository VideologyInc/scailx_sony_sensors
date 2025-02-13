FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "\
	    file://vvsensor.h \
	    file://vvcam.mk \
		file://SensorMakefile \
"
SRC_URI += "git://github.com/framosimaging/framos-nxp-drivers.git;name=framos;branch=lf-6.6.3_1.0.0-beta-v2.1.0;destsuffix=${S}/framos;protocol=https"
SRCREV_framos = "18483cb7d3ad802122db291dbe88bdd055ac260e"
SRCREV_FORMAT .= "_framos"

do_copy_files() {
    cp -rf ${S}/framos/isp-vvcam/vvcam/v4l2/sensor/imx* ${S}/sensor/
	cp -rf ${S}/framos/isp-vvcam/vvcam/v4l2/sensor/max* ${S}/sensor/

    cp -f ${WORKDIR}/vvsensor.h ${WORKDIR}/git/vvcam/common
    cp -f ${WORKDIR}/vvcam.mk ${WORKDIR}/git/vvcam
	cp -f ${WORKDIR}/SensorMakefile ${WORKDIR}/git/vvcam/v4l2/sensor/Makefile
}

addtask copy_files after do_patch before do_configure
