# Inherit AOSP device configuration for d2vzw.
$(call inherit-product, device/samsung/jfltevzw/full_jfltevzw.mk)
$(call inherit-product, vendor/xenonhd/products/common.mk)

# Setup device specific product configuration.
PRODUCT_NAME := xenonhd_jfltevzw
PRODUCT_BRAND := Samsung
PRODUCT_DEVICE := jfltevzw
PRODUCT_MODEL := SCH-I545
PRODUCT_MANUFACTURER := Samsung

PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=jfltevzw TARGET_DEVICE=jfltevzw  BUILD_FINGERPRINT="Verizon/jfltevzw/jfltevzw:4.2.2/JDQ39/I545VRUAMDK:user/release-keys" PRIVATE_BUILD_DESC="jfltevzw-user 4.2.2 JDQ39 I545VRUAMDK release-keys"

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
