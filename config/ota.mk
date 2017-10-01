# OTA default build type
ifeq ($(OTA_TYPE),)
OTA_TYPE=Unofficial
endif

# XenonHD version
XENONHD_VERSION := XenonHD-$(shell date +"%y%m%d")-$(OTA_TYPE)
DEVICE := $(subst xenonhd_,,$(TARGET_PRODUCT))

# Build.prop overrides
PRODUCT_PROPERTY_OVERRIDES += \
    ro.xenonhd.version=$(XENONHD_VERSION) \
    ro.xenonhd.type=$(OTA_TYPE)

ifneq ($(OTA_TYPE),Unofficial)
# XenonHD OTA app
PRODUCT_PACKAGES += \
    XenonOTA

$(shell echo -e "# OTA_configuration\n \
ota_url=https://mirrors.c0urier.net/android/teamhorizon/O/OTA/ota_$(DEVICE).xml\n \
device_name=ro.xenonhd.device\n \
release_type=Oreo\n \
version_source=ro.xenonhd.version\n \
version_delimiter=-\n \
version_position=1\n \
version_format=yyMMdd" > $(ANDROID_BUILD_TOP)/ota_conf)
endif
