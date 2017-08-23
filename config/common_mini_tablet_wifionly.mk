# Inherit mini common XenonHD stuff
$(call inherit-product, vendor/xenonhd/config/common_mini.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME
