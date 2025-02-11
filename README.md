# Scailx Customer BSP or Override layer

## Overview
This repo will help make your own modifications to th Scailx Yocto Linux distro.

This layer provides two configurations for use with [kas](https://kas.readthedocs.io/en/2.1.1/index.html):
1. A simple configuration with a few package additions (simple.yaml)
2. A more complex configuration that includes an additional layer which can be used to create custom images or modify the Scailx Distro.
This layer includes a custom image and a kernel kmeta entry to add to the default kernel config.

# Usage

Is recommended to use Visual Studio Code with the Yocto extension to develop with this repo. This will provide syntax highlighting and autocompletion for the Yocto files.

Install kas:
```bash
pip3 install kas
```

## Simple Configuration
To build the simple configuration, run the following command:
```bash
kas build simple.yaml
```
Alternatively, to open a terminal with bitbake to perform various Yocto rleasted tasks, run the following command:
```bash
kas shell simple.yaml
```

## Complex Configuration
To build the complex configuration, run the following command:
```bash
kas build complex.yaml
```
Alternatively, to open a terminal with bitbake to perform various Yocto rleasted tasks, run the following command:
```bash
kas shell complex.yaml
# build our custome image
bitbake my-image
# clean up some recipes if they fail so they can be rebuilt
bitbake -c cleansstate linux-imx scailx-ml
# build a recipe without cleaning so we can inspect the build folder
bitbake -c cleansstate              gstreamer1.0-plugins-bad
bitbake -c do_build_without_rm_work gstreamer1.0-plugins-bad
```

# Troubleshooting

Note that this release of the Yocto extension supports only a small set of Linux distro's for host environment.
Its recommended to use **Ubuntu 22.04**.
If your system does not match the supported distros, The best options is to use the provided [devcontainer config](.devcontainer/devcontainer.json) in conjunction with vscode's [vscode's devcontainer extension](https://code.visualstudio.com/docs/devcontainers/containers) to build the image.

Alternatively you could use [kas-container](https://kas.readthedocs.io/en/latest/userguide/kas-container.html) instead of kas in the commands listed above, but note that the kas-container may not have the necessary packages required for a full build.

# Further Reading
Refer to the [Yocto manual](https://docs.yoctoproject.org/) or [Wiki](https://wiki.yoctoproject.org/wiki/Main_Page) n how to perform tasks such as adding packages, creating custom images, etc.

Refer to the [Yocto Kernel development manual](https://docs.yoctoproject.org/kernel-dev/index.html) for information regarding how to add to the default kernel config with a kmeta entry, createing recipes, or patching exiting ones.

