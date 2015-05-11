EnPRODUCT_PROPERTY_OVERRIDES += \
    drm.service.enabled=true

# Inherit AOSP device configuration for bacon.
$(call inherit-product, device/motorola/victara/full_victara.mk)

# Inherit common product files.
$(call inherit-product, vendor/xenonhd/products/common.mk)

# Telephony
$(call inherit-product, vendor/xenonhd/configs/telephony.mk)

# Enhanced NFC
$(call inherit-product, vendor/xenonhd/configs/nfc_enhanced.mk)

# Inherit common build.prop overrides
-include vendor/xenonhd/products/common_versions.mk

# Copy hammerhead specific prebuilt files
PRODUCT_COPY_FILES +=  \
    vendor/xenonhd/proprietary/tuna/media/bootanimation.zip:system/media/bootanimation.zip \
    vendor/xenonhd/proprietary/tuna/media/audio/notifications/Nexus.mp3:system/media/audio/notifications/Nexus.mp3 \
    vendor/xenonhd/proprietary/common/media/LMprec_508.emd:system/media/LMprec_508.emd \
    vendor/xenonhd/proprietary/common/media/PFFprec_600.emd:system/media/PFFprec_600.emd

# Inherit drm blobs
-include vendor/xenonhd/products/common_drm.mk

# Setup device specific product configuration.
PRODUCT_NAME := xenonhd_victara
PRODUCT_BRAND := motorola
PRODUCT_DEVICE := victara
PRODUCT_MODEL := X (2014)
PRODUCT_MANUFACTURER := Motorola
TARGET_CONTINUOUS_SPLASH_ENABLED := true

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_FINGERPRINT=motorola/victara_tmo/victara:5.1.1/LXE22.46-11/10:user/release-keys PRIVATE_BUILD_DESC="victara_tmo-user 5.1.1 LXE22.46-11 10 release-keys"
