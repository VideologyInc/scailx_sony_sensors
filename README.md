# Scailx Customer Overlay for Sony sensor support

## Overview
This repo is a kas overlay layer on top of [scailx-yocto](https://github.com/VideologyInc/scailx_yocto) with recipes for [framos NXP drivers](https://github.com/framosimaging/framos-nxp-drivers).
Also Videology's own framos driver in [https://github.com/VideologyInc/framos-vvcam-module].

-------------------------------------------------------------------------------------------

Updates.

2026.1030.	Added framos imx662, imx678 and imx900 drivers updates for vvget and Scailx Studio to get / set correct camera values.



-------------------------------------------------------------------------------------------

The kernel modules are built and installed sepperately.
The vvcam driver is patched to support the Sony sensors via the built-in ISP.
The image also includes devicetree overlays for the scailx-ml platform board.

# Usage

Is recommended to use Visual Studio Code with the Yocto extension to develop with this repo. This will provide syntax highlighting and autocompletion for the Yocto files.

Install kas:
```bash
pip3 install kas
```

Build scailx-ml image:
```bash
kas build
```

Alternatively, to open a terminal with bitbake to perform various Yocto rleasted tasks, run the following command:
```bash
kas shell
# build scailx image
bitbake scailx-ml
```

