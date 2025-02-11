require recipes-images/images/scailx-ml.bb

# make an image with Cargo and Rust pre-installed for example.
IMAGE_INSTALL += " \
    cargo \
    rust \
"