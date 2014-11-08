# Inherit AOSP device configuration for jflte.
$(call inherit-product, device/samsung/jflte/full_jflte.mk)
$(call inherit-product, vendor/xenonhd/products/common.mk)

# Setup device specific product configuration.
PRODUCT_NAME := xenonhd_jflte
PRODUCT_BRAND := Samsung
PRODUCT_DEVICE := jflte
PRODUCT_MODEL := jflte
PRODUCT_MANUFACTURER := Samsung

# Copy d2 specific prebuilt files
PRODUCT_COPY_FILES +=  \
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
