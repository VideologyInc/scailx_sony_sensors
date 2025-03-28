SUMMARY = "Modern and intuitive terminal-based text editor"
HOMEPAGE = "https://github.com/zyedidia/micro"
DESCRIPTION = "A modern and intuitive terminal-based text editor written in Go, \
               featuring mouse support, syntax highlighting, and plugin system."

LICENSE = "MIT"
# LIC_FILES_CHKSUM = "file://src/${GO_IMPORT}/LICENSE;md5=5d3b6c44af6e9177296f05709aab74a4"
LIC_FILES_CHKSUM = "file://LICENSE;md5=5d3b6c44af6e9177296f05709aab74a4"
# inherit go-mod

RDEPENDS:${PN} = "bash"

# GO_INSTALL = "${GO_IMPORT}/cmd/micro"
GO_IMPORT = "github.com/zyedidia/micro"
# SRC_URI = "git://${GO_IMPORT};protocol=https;branch=master"
# SRCREV = "04c577049ca898f097cd6a2dae69af0b4d4493e1"
SRC_URI = "https://github.com/zyedidia/micro/releases/download/v2.0.14/micro-2.0.14-linux-arm.tar.gz"
SRC_URI[sha256sum] = "9f490d88bd30a548af99a905f50244dc6c80f3c7a3c6f98faeb5b0a7329f7dea"
# do_compile[network] = "1"

do_install(){
    install -d ${D}${bindir}
    install -m 0755 ${S}/micro ${D}${bindir}/
}

FILES:${PN} = "${bindir}/micro"

RM_WORK_EXCLUDE += "${PN}"
INSANE_SKIP:${PN} += "already-stripped arch"
