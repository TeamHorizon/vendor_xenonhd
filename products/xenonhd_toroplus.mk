# Inherit AOSP device configuration for toro.
$(call inherit-product, device/samsung/toroplus/full_toroplus.mk)

# Inherit common product files.
$(call inherit-product, vendor/xenonhd/products/common.mk)

# Inherit common build.prop overrides
-include vendor/xenonhd/products/common_versions.mk

# Extra toro overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/xenonhd/overlay/toroplus

# Extra tuna overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/xenonhd/overlay/tuna

# Copy toro specific prebuilt files
PRODUCT_COPY_FILES +=  \
	vendor/xenonhd/proprietary/hybrid/hybrid_xhdpi.conf:system/etc/beerbong/properties.conf \
    vendor/xenonhd/proprietary/tuna/media/bootanimation.zip:system/media/bootanimation.zip \
    vendor/xenonhd/proprietary/tuna/media/audio/notifications/Nexus.mp3:system/media/audio/notifications/Nexus.mp3 \
    vendor/xenonhd/proprietary/common/media/LMprec_508.emd:system/media/LMprec_508.emd \
    vendor/xenonhd/proprietary/common/media/PFFprec_600.emd:system/media/PFFprec_600.emd

# Inherit drm blobs
-include vendor/xenonhd/products/common_drm.mk

# Setup device specific product configuration.
PRODUCT_NAME := xenonhd_toroplus
PRODUCT_BRAND := google
PRODUCT_DEVICE := toroplus
PRODUCT_MODEL := Galaxy Nexus
PRODUCT_MANUFACTURER := samsung

PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=mysidspr BUILD_FINGERPRINT="samsung/mysidspr/toroplus:4.2.1/JOP40D/L700GA02:user/release-keys" PRIVATE_BUILD_DESC="mysidspr-user 4.2.1 JOP40D L700GA02 release-keys"
