#
# Copyright (C) 2015 TeamHorizon - XenonHD Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

PRODUCT_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

$(call inherit-product, device/lge/h345/full_h345.mk)

# Inherit common product files.
$(call inherit-product, vendor/xenonhd/products/common.mk)

# Inherit GSM common stuff.
$(call inherit-product, vendor/xenonhd/configs/gsm.mk)

# Inherit common build.prop overrides
-include vendor/xenonhd/products/common_versions.mk

# Enhanced NFC
$(call inherit-product, vendor/xenonhd/configs/nfc_enhanced.mk)

# Copy specific prebuilt files
PRODUCT_COPY_FILES +=  \
    vendor/xenonhd/proprietary/tuna/media/bootanimation.zip:system/media/bootanimation.zip \
    vendor/xenonhd/proprietary/tuna/media/audio/notifications/Nexus.mp3:system/media/audio/notifications/Nexus.mp3 \
    vendor/xenonhd/proprietary/common/media/LMprec_508.emd:system/media/LMprec_508.emd \
    vendor/xenonhd/proprietary/common/media/PFFprec_600.emd:system/media/PFFprec_600.emd

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := h345
PRODUCT_NAME := xenonhd_h345
PRODUCT_BRAND := lge
PRODUCT_MODEL := LG-H345
PRODUCT_MANUFACTURER := LGE

# Set build fingerprint / ID / Product Name ect.
PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_DEVICE="c50" PRODUCT_NAME="c50_tmo_us" BUILD_FINGERPRINT="lge/c50_tmo_us/c50:5.0.2 LRX22G 151071150b9fa:user/release-keys" 
PRIVATE_BUILD_DESC="c50_tmo_us-user 5.0.2 LRX22G 151071150b9fa release-keys"
