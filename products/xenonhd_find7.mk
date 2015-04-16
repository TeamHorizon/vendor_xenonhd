(call inherit-product, device/oppo/find7/full_find7.mk)

# Enhanced NFC
$(call inherit-product, vendor/xenonhd/config/nfc_enhanced.mk)

# Inherit some common xenonhd stuff.
$(call inherit-product, vendor/xenonhd/config/common_full_phone.mk)

PRODUCT_NAME := xenonhd_find7
PRODUCT_DEVICE := find7

PRODUCT_GMS_CLIENTID_BASE := android-oppo

PRODUCT_BUILD_PROP_OVERRIDES += \
   # PRODUCT_NAME=cm_find7 \
   # BUILD_FINGERPRINT=4.4.2/KVT49L/1390465867:user/release-keys \
   # PRIVATE_BUILD_DESC="msm8974-user 4.4.2 KVT49L eng.root.20141017.144947 release-keys"
