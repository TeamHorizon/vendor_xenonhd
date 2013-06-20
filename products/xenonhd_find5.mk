# Inherit AOSP device configuration for find 5.
$(call inherit-product, device/oppo/find5/full_find5.mk)

# Inherit GSM common stuff.
$(call inherit-product, vendor/xenonhd/configs/gsm.mk)

# Inherit common
$(call inherit-product, vendor/xenonhd/products/common.mk)

# Overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/xenonhd/overlay/find5

# Setup device specific product configuration.
PRODUCT_NAME := xenonhd_find5
PRODUCT_BRAND := Oppo
PRODUCT_DEVICE := find5
PRODUCT_MODEL := Find 5
PRODUCT_MANUFACTURER := Oppo

# Set build fingerprint / ID / Product Name ect.
PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=occam BUILD_FINGERPRINT=OPPO/oppo_12069/FIND5:4.1.1/JRO03L/1362469752:user/release-keys PRIVATE_BUILD_DESC="msm8960-user 4.1.1 JRO03L eng.oppo.20130328.172033 release-keys"

# Copy bootanimation.zip
PRODUCT_COPY_FILES += \
    vendor/xenonhd/proprietary/m7/media/bootanimation.zip:system/media/bootanimation.zip
