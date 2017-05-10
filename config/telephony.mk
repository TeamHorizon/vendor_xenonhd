# World APN list
PRODUCT_COPY_FILES += \
    $(PREBUILT)/etc/apns-conf.xml:system/etc/apns-conf.xml

# Telephony packages
PRODUCT_PACKAGES += \
    CellBroadcastReceiver \
    messaging \
    Stk
