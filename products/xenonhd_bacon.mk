$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit AOSP device configuration for bacon.
$(call inherit-product, device/oneplus/bacon/full_bacon.mk)

# Inherit common product files.
$(call inherit-product, vendor/xenonhd/products/common.mk)

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
PRODUCT_NAME := xenonhd_bacon
PRODUCT_BRAND := oneplus
PRODUCT_DEVICE := bacon
PRODUCT_MODEL := A001
PRODUCT_MANUFACTURER := OnePlus

TARGET_CONTINUOUS_SPLASH_ENABLED := true

PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=bacon BUILD_FINGERPRINT=oneplus/bacon/A0001:4.4.2/KVT49L/XNPH25R:user/release-keys PRIVATE_BUILD_DESC="bacon-user 4.4.2 KVT49L XNPH25R release-keys"
