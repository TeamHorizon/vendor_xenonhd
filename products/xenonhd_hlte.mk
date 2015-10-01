# Inherit from hlte device
$(call inherit-product, device/samsung/hlte/full_hlte.mk)

# Inherit common product files.
$(call inherit-product, vendor/xenonhd/products/common.mk)

# Telephony
$(call inherit-product, vendor/xenonhd/configs/telephony.mk)

# Enhanced NFC
$(call inherit-product, vendor/xenonhd/configs/nfc_enhanced.mk)

# Inherit common build.prop overrides
-include vendor/xenonhd/products/common_versions.mk

TARGET_SCREEN_HEIGHT := 1920
TARGET_SCREEN_WIDTH := 1080

# Copy specific prebuilt files
PRODUCT_COPY_FILES +=  \
    vendor/xenonhd/proprietary/common/media/bootanimation.zip:system/media/bootanimation.zip \
    vendor/xenonhd/proprietary/common/media/LMprec_508.emd:system/media/LMprec_508.emd \
    vendor/xenonhd/proprietary/common/media/PFFprec_600.emd:system/media/PFFprec_600.emd

# Inherit drm blobs
-include vendor/xenonhd/products/common_drm.mk

# Set those variables here to overwrite the inherited values.
PRODUCT_DEVICE := hlte
PRODUCT_NAME := xenonhd_hlte
PRODUCT_BRAND := samsung
PRODUCT_MODEL := SM-N9005
PRODUCT_MANUFACTURER := SAMSUNG