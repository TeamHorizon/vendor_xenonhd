# Inherit common stuff
$(call inherit-product, vendor/xenonhd/products/common.mk)

PRODUCT_PACKAGE_OVERLAYS += vendor/xenonhd/overlay/common_tablet
