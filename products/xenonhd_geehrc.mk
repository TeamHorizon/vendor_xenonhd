# Inherit AOSP device configuration for LG Optimus G (geehrc).
$(call inherit-product, device/lge/geehrc/geehrc.mk)

# Inherit common product files.
$(call inherit-product, vendor/xenonhd/products/common.mk)

# Telephony
$(call inherit-product, vendor/xenonhd/configs/telephony.mk)

# Enhanced NFC
$(call inherit-product, vendor/xenonhd/configs/nfc_enhanced.mk)

# Inherit common build.prop overrides
-include vendor/xenonhd/products/common_versions.mk

# Copy specific prebuilt files
PRODUCT_COPY_FILES +=  \
    vendor/xenonhd/proprietary/tuna/media/bootanimation.zip:system/media/bootanimation.zip \
    vendor/xenonhd/proprietary/tuna/media/audio/notifications/Nexus.mp3:system/media/audio/notifications/Nexus.mp3 \
    vendor/xenonhd/proprietary/common/media/LMprec_508.emd:system/media/LMprec_508.emd \
    vendor/xenonhd/proprietary/common/media/PFFprec_600.emd:system/media/PFFprec_600.emd

# Inherit drm blobs
-include vendor/xenonhd/products/common_drm.mk

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := geehrc
PRODUCT_NAME := xenonhd_geehrc
PRODUCT_BRAND := lge
PRODUCT_MODEL := LG-E975
PRODUCT_MANUFACTURER := LGE

# Boot animation
TARGET_SCREEN_HEIGHT := 1280
TARGET_SCREEN_WIDTH := 768

# Enable Torch
PRODUCT_PACKAGES += Torch

# build.prop overrides
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=geehrc_open_eu \
    BUILD_FINGERPRINT=lge/geehrc_open_eu/geehrc:6.0.1/MMB29M/2431559:user/release-keys \
    PRIVATE_BUILD_DESC="geehrc_open_eu-user 6.0.1 MMB29M 2431559 release-keys"