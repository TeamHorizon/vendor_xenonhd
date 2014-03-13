# Get the sample verizon list of APNs
PRODUCT_COPY_FILES += device/sample/etc/apns-conf_verizon.xml:system/etc/apns-conf.xml

# Inherit AOSP device configuration for d2lte.
$(call inherit-product, device/samsung/d2lte/full_d2lte.mk)
$(call inherit-product, vendor/xenonhd/products/common.mk)

# Setup device specific product configuration.
PRODUCT_NAME := xenonhd_d2lte

PRODUCT_GMS_CLIENTID_BASE := android-verizon

# Copy d2 specific prebuilt files
PRODUCT_COPY_FILES +=  \
	vendor/xenonhd/proprietary/hybrid/hybrid_xhdpi_no_nav.conf:system/etc/beerbong/properties.conf \
    vendor/xenonhd/proprietary/tuna/media/bootanimation.zip:system/media/bootanimation.zip \
    vendor/xenonhd/proprietary/d2-common/media/audio/notifications/Nexus.mp3:system/media/audio/notifications/Nexus.mp3 \
	vendor/xenonhd/proprietary/common/media/LMprec_508.emd:system/media/LMprec_508.emd \
    vendor/xenonhd/proprietary/common/media/PFFprec_600.emd:system/media/PFFprec_600.emd
    
# Inherit common build.prop overrides
-include vendor/xenonhd/products/common_versions.mk

# Inherit common Verizon Wireless Perms and Lib
$(call inherit-product, vendor/xenonhd/configs/vzw.mk)

# Inherit drm blobs
-include vendor/xenonhd/products/common_drm.mk
