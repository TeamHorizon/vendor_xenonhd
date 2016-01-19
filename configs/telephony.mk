# World APN list
PRODUCT_COPY_FILES += \
    vendor/xenonhd/proprietary/common/etc/apns-conf.xml:system/etc/apns-conf.xml

# World SPN overrides list
PRODUCT_COPY_FILES += \
    vendor/xenonhd/proprietary/common/etc/spn-conf.xml:system/etc/spn-conf.xml

# Selective SPN list for operator number who has the problem.
PRODUCT_COPY_FILES += \
    vendor/xenonhd/proprietary/common/etc/selective-spn-conf.xml:system/etc/selective-spn-conf.xml

# Telephony packages
PRODUCT_PACKAGES += \
    messaging \
    Stk \
    CellBroadcastReceiver

# Mms depends on SoundRecorder for recorded audio messages
PRODUCT_PACKAGES += \
    SoundRecorder

# Default ringtone
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.ringtone=RobotsforEveryone.ogg

-include vendor/xenonhd/configs/gsm.mk

VZW := $(shell grep 'verizon|vzw' vendor/xenonhd/products/$(TARGET_PRODUCT).mk)

ifeq ($(VZW), )
     -include vendor/xenonhd/configs/vzw.mk
endif