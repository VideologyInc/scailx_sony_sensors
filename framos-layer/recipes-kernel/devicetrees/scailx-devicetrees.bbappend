
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

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
SRC_URI += "file://0001-cam-overlays-add-sony.patch;patchdir=${WORKDIR}/git"
