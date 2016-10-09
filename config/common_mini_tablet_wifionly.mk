# Inherit common XenonHD stuff
$(call inherit-product, vendor/xenonhd/config/common_mini.mk)

# Required XenonHD packages
PRODUCT_PACKAGES += \
    LatinIME
