# Videology FLIR MIPI Driver
#

SUMMARY = "Videology FLIR mipi driver"
LICENSE = "MIT"

inherit devicetree
PROVIDES:remove = "virtual/dtb"

RDEPENDS:${PN} += "scailx-devicetrees"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
COMPATIBLE_MACHINE = ".*(mx8).*"
RM_WORK_EXCLUDE += "${PN}"

S = "${WORKDIR}/dts"

SRC_URI += "file://scailx-imx8mp-cam0-gmsl-serializer.dts;subdir=${S}"
SRC_URI += "file://scailx-imx8mp-cam0-imx662.dts;subdir=${S}"
SRC_URI += "file://scailx-imx8mp-cam0-imx676.dts;subdir=${S}"
SRC_URI += "file://scailx-imx8mp-cam0-imx678.dts;subdir=${S}"
SRC_URI += "file://scailx-imx8mp-cam0-imx900.dts;subdir=${S}"
SRC_URI += "file://scailx-imx8mp-cam1-gmsl-serializer.dts;subdir=${S}"
SRC_URI += "file://scailx-imx8mp-cam1-imx662.dts;subdir=${S}"
SRC_URI += "file://scailx-imx8mp-cam1-imx676.dts;subdir=${S}"
SRC_URI += "file://scailx-imx8mp-cam1-imx678.dts;subdir=${S}"
SRC_URI += "file://scailx-imx8mp-cam1-imx900.dts;subdir=${S}"


pkg_postinst:${PN} () {
    echo "0x3d imx900.dtbo" >> $D/boot/devicetree/cam-overlays
    echo "0x37 imx662.dtbo" >> $D/boot/devicetree/cam-overlays
    echo "0x10 imx676.dtbo" >> $D/boot/devicetree/cam-overlays
    echo "0x1a imx678.dtbo" >> $D/boot/devicetree/cam-overlays
}

do_install:append(){
	install -d ${D}${exec_prefix}/src/scailx-devicetrees/src/arm64/scailx/
	cp -rf ${S}/*.dts* ${D}${exec_prefix}/src/scailx-devicetrees/src/arm64/scailx/
}

FILES:${PN}-dbg += "${exec_prefix}/src"
