# Inherit common XenonHD stuff
$(call inherit-product, vendor/xenonhd/config/common_full.mk)

PRODUCT_PACKAGES += TvSettings

DEVICE_PACKAGE_OVERLAYS += vendor/xenonhd/overlay/tv
