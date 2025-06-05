FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI += "file://0001-Included-YUY2-draw_rectangle-draw_text-draw_line-dra.patch;patchdir=../.."
SRC_URI += "file://0001-install-cpython-and-gsthailo-in-site-packages.patch;patchdir=../.."
SRC_URI += "file://0002-use-system-python-installation-and-pybind.patch;patchdir=../.."

inherit python3targetconfig

PACKAGECONFIG:append = " python"
PACKAGECONFIG[python] = "-Dinclude_python=true,-Dinclude_python=false,python3-pygobject python3-pybind11,python3-core"

FILES:${PN} += "${PYTHON_SITEPACKAGES_DIR} ${libdir}/gstreamer-1.0/"
FILES:${PN}-lib += "${PYTHON_SITEPACKAGES_DIR} ${libdir}/gstreamer-1.0/"