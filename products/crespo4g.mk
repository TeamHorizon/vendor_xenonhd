# Inherit AOSP device configuration for crespo4g.
$(call inherit-product, device/samsung/crespo4g/full_crespo4g.mk)

# Inherit common product files.
$(call inherit-product, vendor/xenonhd/products/common.mk)

# Inherit common build.prop overrides
-include vendor/xenonhd/products/common_versions.mk

# Copy crespo4g specific prebuilt files
PRODUCT_COPY_FILES +=  \
    vendor/xenonhd/proprietary/crespo/app/Thinkfree.apk:system/app/Thinkfree.apk \
    vendor/xenonhd/proprietary/crespo/media/bootanimation.zip:system/media/bootanimation.zip \
    vendor/xenonhd/proprietary/tuna/media/audio/notifications/Nexus.mp3:system/media/audio/notifications/Nexus.mp3 \
    vendor/xenonhd/proprietary/common/app/Microbes.apk:system/app/Microbes.apk \
    vendor/xenonhd/proprietary/common/app/Wallet.apk:system/app/Wallet.apk \
    vendor/xenonhd/proprietary/common/app/ApexLauncher.apk:system/app/ApexLauncher.apk \
    vendor/xenonhd/proprietary/common/lib/libmicrobes_jni.so:system/lib/libmicrobes_jni.so \
    vendor/xenonhd/proprietary/common/media/LMprec_508.emd:system/media/LMprec_508.emd \
    vendor/xenonhd/proprietary/common/media/PFFprec_600.emd:system/media/PFFprec_600.emd

# Inherit drm blobs
-include vendor/xenonhd/products/common_drm.mk

# Setup device specific product configuration.
PRODUCT_NAME := xenonhd_crespo4g
PRODUCT_BRAND := google
PRODUCT_DEVICE := crespo4g
PRODUCT_MODEL := Nexus S 4G
PRODUCT_MANUFACTURER := samsung

PRODUCT_BUILD_PROP_OVERRIDES := PRODUCT_NAME=sojus BUILD_ID=IMM26 BUILD_FINGERPRINT=google/sojus/crespo4g:4.0.4/IMM26/255454:user/release-keys PRIVATE_BUILD_DESC="sojus-user 4.0.4 IMM26 255454 release-keys" BUILD_NUMBER=255454

