# Inherit device configuration
$(call inherit-product, device/samsung/r950/full_r950.mk)

# Inherit common product files.
$(call inherit-product, vendor/xenonhd/products/common.mk)

# Release name
PRODUCT_RELEASE_NAME := r950

# Boot animation
TARGET_SCREEN_HEIGHT := 1280
TARGET_SCREEN_WIDTH := 720

# Inherit common build.prop overrides
-include vendor/xenonhd/products/common_versions.mk\

# Copy maguro specific prebuilt files
PRODUCT_COPY_FILES +=  \
	vendor/xenonhd/proprietary/hybrid/hybrid_xhdpi_no_nav.conf:system/etc/beerbong/properties.conf \
    vendor/xenonhd/proprietary/tuna/media/bootanimation.zip:system/media/bootanimation.zip \
    vendor/xenonhd/proprietary/tuna/media/audio/notifications/Nexus.mp3:system/media/audio/notifications/Nexus.mp3 \
    vendor/xenonhd/proprietary/common/media/LMprec_508.emd:system/media/LMprec_508.emd \
    vendor/xenonhd/proprietary/common/media/PFFprec_600.emd:system/media/PFFprec_600.emd

# Inherit drm blobs
-include vendor/xenonhd/products/common_drm.mk

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := r950
PRODUCT_NAME := xenonhd_r950
PRODUCT_BRAND := samsung
PRODUCT_MODEL := SCH-R950
PRODUCT_MANUFACTURER := samsung

# Set build fingerprint / ID / Product Name ect.
PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=t0lteusc TARGET_DEVICE=t0lteusc BUILD_FINGERPRINT="samsung/t0lteusc/t0lteusc:4.1.2/JZO54K/R950VXAME2:user/release-keys" PRIVATE_BUILD_DESC="t0lteusc-user 4.1.2 JZO54K R950VXAME2 release-keys"
