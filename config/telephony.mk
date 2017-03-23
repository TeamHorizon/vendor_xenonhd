# Sensitive Phone Numbers list
PRODUCT_COPY_FILES += \
    $(PREBUILT)/etc/sensitive_pn.xml:system/etc/sensitive_pn.xml

# World APN list
PRODUCT_COPY_FILES += \
    $(PREBUILT)/etc/apns-conf.xml:system/etc/apns-conf.xml

# Telephony packages
PRODUCT_PACKAGES += \
    CellBroadcastReceiver \
    messaging \
    Stk
