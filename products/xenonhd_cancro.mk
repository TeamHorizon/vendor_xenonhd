# Inherit AOSP device configuration for cancro.
$(call inherit-product, device/xiaomi/cancro/full_cancro.mk)

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
PRODUCT_NAME := xenonhd_cancro
PRODUCT_BRAND := XIAOMI
PRODUCT_DEVICE := cancro
PRODUCT_MODEL := Mi 3W
PRODUCT_MANUFACTURER := XIAOMI
PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
TARGET_CONTINUOUS_SPLASH_ENABLED := true

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_FINGERPRINT=Xiaomi/cancro/cancro:5.1.1/LMY47V/5.4.24:userdebug/test-keys PRIVATE_BUILD_DESC="cancro-userdebug 5.1.1 LMY47V 5.4.24 test-keys"
