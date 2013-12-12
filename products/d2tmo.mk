# Inherit AOSP device configuration for d2tmo.
$(call inherit-product, device/samsung/d2tmo/full_d2tmo.mk)

# Inherit common product files.
$(call inherit-product, vendor/xenonhd/products/common.mk)

# Inherit GSM common stuff.
$(call inherit-product, vendor/xenonhd/configs/gsm.mk)

# Copy d2 specific prebuilt files
PRODUCT_COPY_FILES +=  \
	vendor/xenonhd/proprietary/hybrid/hybrid_xhdpi_no_nav.conf:system/etc/beerbong/properties.conf \
    vendor/xenonhd/proprietary/tuna/media/bootanimation.zip:system/media/bootanimation.zip \
    vendor/xenonhd/proprietary/d2-common/media/audio/notifications/Nexus.mp3:system/media/audio/notifications/Nexus.mp3 \
	vendor/xenonhd/proprietary/common/media/LMprec_508.emd:system/media/LMprec_508.emd \
    vendor/xenonhd/proprietary/common/media/PFFprec_600.emd:system/media/PFFprec_600.emd
    
# Inherit common build.prop overrides
-include vendor/xenonhd/products/common_versions.mk

# Inherit drm blobs
-include vendor/xenonhd/products/common_drm.mk

# Setup device specific product configuration.
PRODUCT_NAME := xenonhd_d2tmo
PRODUCT_BRAND := Samsung
PRODUCT_DEVICE := d2tmo
PRODUCT_MODEL := SGH-T999
PRODUCT_MANUFACTURER := Samsung

PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=d2tmo TARGET_DEVICE=d2tmo BUILD_FINGERPRINT="d2tmo-user 4.1.1 JRO03L T999UVDLH3 release-keys" PRIVATE_BUILD_DESC="samsung/d2tmo/d2tmo:4.1.1/JRO03L/T999UVDLH3:user/release-keys"

