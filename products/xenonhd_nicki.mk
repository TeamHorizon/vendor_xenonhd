# Copyright (C) 2013 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Enhanced NFC
$(call inherit-product, vendor/xenonhd/configs/nfc_enhanced.mk)

# Inherit some common CM stuff.
$(call inherit-product, vendor/xenonhd/products/common.mk)

# Inherit device configuration
$(call inherit-product, device/sony/nicki/nicki.mk)

# Add Proprietary files
TARGET_SCREEN_HEIGHT := 854
TARGET_SCREEN_WIDTH := 480
PRODUCT_COPY_FILES +=  \
    vendor/xenonhd/proprietary/nicki/media/bootanimation.zip:system/media/bootanimation.zip \
    vendor/xenonhd/proprietary/nicki/media/audio/notifications/Nexus.mp3:system/media/audio/notifications/Nexus.mp3 \
    vendor/xenonhd/proprietary/common/media/LMprec_508.emd:system/media/LMprec_508.emd \
    vendor/xenonhd/proprietary/common/media/PFFprec_600.emd:system/media/PFFprec_600.emd

# Inherit common build.prop overrides
-include vendor/xenonhd/products/common_versions.mk

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=0


## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := nicki
PRODUCT_NAME := xenonhd_nicki
PRODUCT_BRAND := Sony
PRODUCT_MODEL := nicki
PRODUCT_MANUFACTURER := Sony
PRODUCT_CHARACTERISTICS := phone

# Release name
PRODUCT_RELEASE_NAME := Xperiam

