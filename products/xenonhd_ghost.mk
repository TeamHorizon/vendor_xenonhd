$(call inherit-product, device/motorola/ghost/full_ghost.mk)

# Inherit some common CM stuff.
$(call inherit-product, vendor/xenonhd/products/common.mk)

# Enhanced NFC
$(call inherit-product, vendor/xenonhd/configs/nfc_enhanced.mk)

# Copy ghost specific prebuilt files
PRODUCT_COPY_FILES +=  \
    vendor/xenonhd/proprietary/tuna/media/bootanimation.zip:system/media/bootanimation.zip \
    vendor/xenonhd/proprietary/tuna/media/audio/notifications/Nexus.mp3:system/media/audio/notifications/Nexus.mp3 \
    vendor/xenonhd/proprietary/common/media/LMprec_508.emd:system/media/LMprec_508.emd \
    vendor/xenonhd/proprietary/common/media/PFFprec_600.emd:system/media/PFFprec_600.emd

# Inherit drm blobs
-include vendor/xenonhd/products/common_drm.mk

# Setup device specific product configuration.
PRODUCT_NAME := xenonhd_ghost
PRODUCT_BRAND := motorola
PRODUCT_DEVICE := ghost
PRODUCT_MODEL := Moto X
PRODUCT_MANUFACTURER := Motorola
