# Inherit common XenonHD stuff
$(call inherit-product, vendor/xenonhd/config/common.mk)

PRODUCT_SIZE := full

# Recorder
PRODUCT_PACKAGES += \
    Recorder
