# Inherit device configuration
$(call inherit-product, device/samsung/trltetmo/full_trltetmo.mk)

# Inherit common product files.
$(call inherit-product, vendor/xenonhd/products/common.mk)

# Telephony
$(call inherit-product, vendor/xenonhd/configs/telephony.mk)

# Enhanced NFC
$(call inherit-product, vendor/xenonhd/configs/nfc_enhanced.mk)

# Release name
PRODUCT_RELEASE_NAME := trltetmo

# Boot animation
TARGET_SCREEN_HEIGHT := 2560
TARGET_SCREEN_WIDTH := 1440

# Inherit common build.prop overrides
-include vendor/xenonhd/products/common_versions.mk

# Copy trlte specific prebuilt files
PRODUCT_COPY_FILES +=  \
	vendor/xenonhd/proprietary/hybrid/hybrid_xhdpi_no_nav.conf:system/etc/beerbong/properties.conf \
    vendor/xenonhd/proprietary/tuna/media/bootanimation.zip:system/media/bootanimation.zip \
    vendor/xenonhd/proprietary/tuna/media/audio/notifications/Nexus.mp3:system/media/audio/notifications/Nexus.mp3 \
    vendor/xenonhd/proprietary/common/media/LMprec_508.emd:system/media/LMprec_508.emd \
    vendor/xenonhd/proprietary/common/media/PFFprec_600.emd:system/media/PFFprec_600.emd
    
# Inherit drm blobs
-include vendor/xenonhd/products/common_drm.mk

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := trltetmo
PRODUCT_NAME := xenonhd_trltetmo
PRODUCT_BRAND := samsung
PRODUCT_MODEL := trltetmo
PRODUCT_MANUFACTURER := samsung


