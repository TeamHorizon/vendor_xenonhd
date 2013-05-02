#Permissions and Lib for Verizon Wireless Apps
PRODUCT_PACKAGES += \
    VerizonSSO

PRODUCT_COPY_FILES += \
    vendor/xenonhd/proprietary/vzw/etc/permissions/com.vzw.hardware.ehrpd.xml:system/etc/permissions/com.vzw.hardware.ehrpd.xml \
    vendor/xenonhd/proprietary/vzw/etc/permissions/com.vzw.hardware.lte.xml:system/etc/permissions/com.vzw.hardware.lte.xml \
    vendor/xenonhd/proprietary/vzw/etc/permissions/com.vzw.vzwapnlib.xml:system/etc/permissions/com.vzw.vzwapnlib.xml \
    vendor/xenonhd/proprietary/vzw/lib/libmotricity.so:system/lib/libmotricity.so

