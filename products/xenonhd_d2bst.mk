# Inherit AOSP device configuration for d2bst.
$(call inherit-product, device/samsung/d2bst/full_d2bst.mk)
$(call inherit-product, vendor/xenonhd/products/common.mk)

# Setup device specific product configuration.
PRODUCT_NAME := xenonhd_d2bst
PRODUCT_DEVICE := d2bst
PRODUCT_BRAND := samsung
PRODUCT_MANUFACTURER := samsung
PRODUCT_MODEL := d2bst

PRODUCT_BUILD_PROP_OVERRIDES += \
    TARGET_DEVICE=d2bst \
    BUILD_FINGERPRINT="samsung/d2bst/d2bst:5.0.2/LRX22G/L710TVPU0AO3:user/release-keys" \
    PRIVATE_BUILD_DESC="d2bst-user 5.0.2 LRX22G L710TVPU0AO3 release-keys"

# Copy d2 specific prebuilt files
PRODUCT_COPY_FILES += \
    vendor/xenonhd/proprietary/hybrid/hybrid_xhdpi_no_nav.conf:system/etc/beerbong/properties.conf \
    vendor/xenonhd/proprietary/tuna/media/bootanimation.zip:system/media/bootanimation.zip \
    vendor/xenonhd/proprietary/d2-common/media/audio/notifications/Nexus.mp3:system/media/audio/notifications/Nexus.mp3 \
    vendor/xenonhd/proprietary/common/media/LMprec_508.emd:system/media/LMprec_508.emd \
    vendor/xenonhd/proprietary/common/media/PFFprec_600.emd:system/media/PFFprec_600.emd

# Inherit common build.prop overrides
-include vendor/xenonhd/products/common_versions.mk

# Inherit drm blobs
-include vendor/xenonhd/products/common_drm.mk
