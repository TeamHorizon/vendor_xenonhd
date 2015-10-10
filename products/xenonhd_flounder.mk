# Inherit device configuration
$(call inherit-product, device/htc/flounder/aosp_flounder.mk)

# Inherit common product files.
$(call inherit-product, vendor/xenonhd/products/common.mk)

$(call inherit-product-if-exists, vendor/htc/flounder/device-vendor.mk)

# Inherit common build.prop overrides
-include vendor/xenonhd/products/common_versions.mk

# Copy shamu specific prebuilt files
PRODUCT_COPY_FILES +=  \
    vendor/xenonhd/proprietary/tuna/media/bootanimation.zip:system/media/bootanimation.zip \
    vendor/xenonhd/proprietary/tuna/media/audio/notifications/Nexus.mp3:system/media/audio/notifications/Nexus.mp3 \
    vendor/xenonhd/proprietary/common/media/LMprec_508.emd:system/media/LMprec_508.emd \
    vendor/xenonhd/proprietary/common/media/PFFprec_600.emd:system/media/PFFprec_600.emd

# Inherit drm blobs
-include vendor/xenonhd/products/common_drm.mk

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=flounder \
    BUILD_FINGERPRINT=google/volantis/flounder:5.1.1/LMY48I/2074855:user/release-keys \
    PRIVATE_BUILD_DESC="volantis-user 5.1.1 LMY48I 2074855 release-keys"

## Device identifier. This must come after all inclusions
PRODUCT_NAME := xenonhd_flounder
PRODUCT_BRAND := google
PRODUCT_MODEL := Nexus 9
