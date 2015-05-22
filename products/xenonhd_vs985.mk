PRODUCT_PROPERTY_OVERRIDES += \
    drm.service.enabled=true

# Inherit AOSP device configuration for bacon.
$(call inherit-product, device/lge/vs985/full_vs985.mk)

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
PRODUCT_NAME := xenonhd_vs985
PRODUCT_BRAND := lge
PRODUCT_DEVICE := vs985
PRODUCT_MODEL := vs985
PRODUCT_MANUFACTURER := LG
TARGET_CONTINUOUS_SPLASH_ENABLED := true

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_DEVICE="g3" \
    PRODUCT_NAME="g3_vzw_us" \
    BUILD_FINGERPRINT="lge/g3_vzw/g3:5.0.1/LRX21Y/150271517d422:user/release-keys" \
    PRIVATE_BUILD_DESC="g3_vzw-user 5.0.1 LRX21Y 150271517d422 release-keys"

PRIVATE_BUILD_DESC="vs985-user 5.1 LMY47O YNG1TAS0YL release-keys"

PRODUCT_GMS_CLIENTID_BASE := android-verizon
