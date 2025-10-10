LICENSE = "CLOSED"

require framos_nxp_drivers.inc

SRC_URI += "${FRAMOS_NXP_DRIVERS_REPO};name=framos;"
SRCREV_framos = "${FRAMOS_NXP_DRIVERS_REV}"

SRC_URI += " \
    file://imx662.sh \
    file://imx676.sh \
    file://imx678.sh \
    file://imx900.sh \
"

S = "${WORKDIR}/git/isp-imx/units/isi"
B = "${WORKDIR}/build"

DEPENDS += "isp-imx"
RDEPENDS:${PN} += "bash isp-imx-scailx"

CFLAGS += "-DARM64 -DHAL_ALTERA -DLINUX -DLIVE_SENSOR -DSUBDEV_V4L2"
CFLAGS += "-I${STAGING_INCDIR}/isi -I${STAGING_INCDIR}/vvcam -I${STAGING_INCDIR}/vvcam/isi"

do_compile(){
    for f in "${S}"/drv/*/source/*.c; do
        fn=$(basename "$f" .c | tr '[:upper:]' '[:lower:]')
        echo "Compiling $f"
        ${CC} ${CFLAGS} ${LDFLAGS} -c "$f" -o "${fn}.o"
        ${CC} ${CFLAGS} ${LDFLAGS} -shared -o "${fn}.drv" "${fn}.o"
    done
}

do_install(){
    install -d ${D}/opt/imx8-isp/bin/dewarp_config
    install -d ${D}/opt/imx8-isp/bin/scailx_sensors
    install -m 0755 ${WORKDIR}/imx*.sh ${D}/opt/imx8-isp/bin/scailx_sensors/
    install -m 0755 ${B}/*.drv ${D}/opt/imx8-isp/bin/
    install -m 0755 ${S}/drv/*/calib/*/*.xml ${D}/opt/imx8-isp/bin/
    install -m 0644 ${S}/../../dewarp/dewarp_config/* ${D}/opt/imx8-isp/bin/dewarp_config/
}

FILES:${PN} += "/opt/imx8-isp/bin/"
