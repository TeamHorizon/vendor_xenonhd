# Inherit AOSP device configuration for m7.
$(call inherit-product, device/htc/m7/full_m7.mk)

# Telephony
$(call inherit-product, vendor/xenonhd/configs/telephony.mk)

# Release name
PRODUCT_RELEASE_NAME := m7

$(call inherit-product, vendor/xenonhd/products/common.mk)

# Inherit device configuration
$(call inherit-product, device/htc/m7/device.mk)

# Inherit common build.prop overrides
-include vendor/xenonhd/products/common_versions.mk

# Inherit drm blobs
-include vendor/xenonhd/products/common_drm.mk

# Device naming
PRODUCT_DEVICE := m7
PRODUCT_NAME := xenonhd_m7
PRODUCT_BRAND := htc
PRODUCT_MODEL := HTC One
PRODUCT_MANUFACTURER := HTC

     
PRODUCT_COPY_FILES += \
        vendor/xenonhd/proprietary/hybrid/hybrid_m7_no_nav.conf:system/etc/beerbong/properties.conf \
        vendor/xenonhd/proprietary/m7/media/bootanimation.zip:system/media/bootanimation.zip
