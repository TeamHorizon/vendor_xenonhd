# Inherit AOSP device configuration for d2vzw.
$(call inherit-product, device/samsung/d2vzw/full_d2vzw.mk)

# Inherit common product files.
$(call inherit-product, vendor/xenonhd/products/common.mk)

# Setup device specific product configuration.
PRODUCT_NAME := xenonhd_d2vzw
PRODUCT_BRAND := Samsung
PRODUCT_DEVICE := d2vzw
PRODUCT_MODEL := SCH-I535
PRODUCT_MANUFACTURER := Samsung

# Extra d2vzw overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/xenonhd/overlay/d2vzw

# Copy d2 specific prebuilt files
PRODUCT_COPY_FILES +=  \
    vendor/xenonhd/proprietary/d2-common/app/Thinkfree.apk:system/app/Thinkfree.apk \
    vendor/xenonhd/proprietary/d2-common/media/bootanimation.zip:system/media/bootanimation.zip \
    vendor/xenonhd/proprietary/d2-common/media/audio/notifications/Nexus.mp3:system/media/audio/notifications/Nexus.mp3 \
    vendor/xenonhd/proprietary/common/app/Microbes.apk:system/app/Microbes.apk \
    vendor/xenonhd/proprietary/common/app/Torch.apk:system/app/Torch.apk \
    vendor/xenonhd/proprietary/common/lib/libmicrobes_jni.so:system/lib/libmicrobes_jni.so \
	vendor/xenonhd/proprietary/common/media/LMprec_508.emd:system/media/LMprec_508.emd \
    vendor/xenonhd/proprietary/common/media/PFFprec_600.emd:system/media/PFFprec_600.emd

# Inherit common build.prop overrides
-include vendor/xenonhd/products/common_versions.mk

# Inherit drm blobs
-include vendor/xenonhd/products/common_drm.mk

PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=d2vzw TARGET_DEVICE=d2vzw BUILD_FINGERPRINT="Verizon/d2vzw/d2vzw:4.0.4/IMM76D/I535VRALHD:user/release-keys" PRIVATE_BUILD_DESC="d2vzw-user 4.0.4 IMM76D I535VRALHD release-keys"
