# World APN list
PRODUCT_COPY_FILES += \
    $(PREBUILT)/etc/apns-conf.xml:system/etc/apns-conf.xml

# Telephony
PRODUCT_BOOT_JARS += \
    telephony-ext

# Telephony packages
PRODUCT_PACKAGES += \
    CellBroadcastReceiver \
    messaging \
    Stk \
    telephony-ext
