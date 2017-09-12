# Inherit full common XenonHD stuff
$(call inherit-product, vendor/xenonhd/config/common_full.mk)

PRODUCT_PACKAGES += TvSettings

DEVICE_PACKAGE_OVERLAYS += vendor/lineage/overlay/tv
