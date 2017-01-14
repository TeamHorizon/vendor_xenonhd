# OTA default build type
ifeq ($(OTA_TYPE),)
OTA_TYPE=Unofficial
endif

# XenonHD version
XENONHD_VERSION := XenonHD-$(shell date +"%y%m%d")-$(OTA_TYPE)
DEVICE := $(subst xenonhd_,,$(TARGET_PRODUCT))

# XenonHD OTA app
PRODUCT_PACKAGES += \
    XenonOTA

# Build.prop overrides
PRODUCT_PROPERTY_OVERRIDES += \
    ro.xenonhd.version=$(XENONHD_VERSION) \
    ro.ota.device=$(DEVICE) \
    ro.ota.type=$(OTA_TYPE)

$(shell echo -e "# OTA_configuration\n \
ota_url=https://mirrors.c0urier.net/android/teamhorizon/N/OTA/ota_nougat_$(DEVICE).xml\n \
ota-device=$(DEVICE)\n \
device_name=ro.ota.device\n \
release_type=Stable\n \
version_source=ro.xenonhd.version\n \
version_delimiter=-\n \
version_position=1\n \
version_format=yyMMdd" > $(ANDROID_BUILD_TOP)/ota_conf)
