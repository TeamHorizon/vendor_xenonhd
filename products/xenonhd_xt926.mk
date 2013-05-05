# Inherit AOSP device configuration for vanquish.
$(call inherit-product, vendor/xenonhd/configs/cdma.mk)
$(call inherit-product, vendor/xenonhd/configs/vzw.mk)

# Inherit common product files.
$(call inherit-product, vendor/xenonhd/products/common.mk)

TARGET_SCREEN_WIDTH := 720
TARGET_SCREEN_HEIGHT := 1280

# Setup device specific product configuration.
PRODUCT_NAME := xenonhd_xt926
PRODUCT_BRAND := motorola
PRODUCT_DEVICE := xt926
PRODUCT_MODEL := Razr HD
PRODUCT_MANUFACTURER := motorola
$(call inherit-product, device/motorola/xt926/full_xt926.mk)

PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=xt926 BUILD_FINGERPRINT=motorola/XT926_verizon/vanquish:4.1.1/9.8.1Q37/39:user/release-keys

# Inherit common build.prop overrides
-include vendor/xenonhd/products/common_versions.mk

# Extra maguro overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/xenonhd/overlay/mako

# Copy maguro specific prebuilt files
PRODUCT_COPY_FILES +=  \
    vendor/xenonhd/proprietary/tuna/media/bootanimation.zip:system/media/bootanimation.zip \
    vendor/xenonhd/proprietary/tuna/media/audio/notifications/Nexus.mp3:system/media/audio/notifications/Nexus.mp3 \
    vendor/xenonhd/proprietary/common/media/LMprec_508.emd:system/media/LMprec_508.emd \
    vendor/xenonhd/proprietary/common/media/PFFprec_600.emd:system/media/PFFprec_600.emd

# Inherit drm blobs
-include vendor/xenonhd/products/common_drm.mk

