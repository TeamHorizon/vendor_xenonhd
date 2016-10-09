$(call inherit-product, vendor/xenonhd/config/common_mini.mk)

# Required XenonHD packages
PRODUCT_PACKAGES += \
    LatinIME

$(call inherit-product, vendor/xenonhd/config/telephony.mk)
