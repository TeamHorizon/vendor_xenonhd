PRODUCT_PROPERTY_OVERRIDES += \
    drm.service.enabled=true

# Inherit AOSP device configuration for bacon.
$(call inherit-product, device/oneplus/baconcaf/full_baconcaf.mk)

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
PRODUCT_NAME := xenonhd_baconcaf
PRODUCT_BRAND := oneplus
PRODUCT_DEVICE := baconcaf
PRODUCT_MODEL := A0001
PRODUCT_MANUFACTURER := OnePlus
PRODUCT_GMS_CLIENTID_BASE := android-oneplus
TARGET_CONTINUOUS_SPLASH_ENABLED := true

PRODUCT_BUILD_PROP_OVERRIDES += \
    BUILD_FINGERPRINT=oneplus/bacon/A0001:5.0.2/LRX22G/YNG1TAS2I3:user/release-keys \
    PRIVATE_BUILD_DESC="bacon-user 5.0.2 LRX22G YNG1TAS2I3 release-keys"
