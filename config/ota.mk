# OTA default build type
ifeq ($(OTA_TYPE),)
OTA_TYPE=Unofficial
endif

# Make sure the uppercase is used
ifeq ($(OTA_TYPE),experimental)
OTA_TYPE=Experimental
endif
ifeq ($(OTA_TYPE),official)
OTA_TYPE=Official
endif

# XenonHD version
XENONHD_VERSION := XenonHD-$(shell date +"%y%m%d")-$(OTA_TYPE)
DEVICE := $(subst xenonhd_,,$(TARGET_PRODUCT))

ifneq ($(OTA_TYPE),Unofficial)
# XenonHD OTA app
PRODUCT_PACKAGES += \
    XenonOTA

# OTA Configuration
$(shell echo -e "OTA_Configuration\n \
ota_experimental=https://mirrors.c0urier.net/android/teamhorizon/P/OTA/ota_$(DEVICE)_experimental.xml\n \
ota_official=https://mirrors.c0urier.net/android/teamhorizon/P/OTA/ota_$(DEVICE)_official.xml\n \
device_name=ro.xenonhd.device\n \
release_type=Pie\n \
version_source=ro.xenonhd.version\n \
version_delimiter=-\n \
version_position=1\n \
version_format=yyMMdd" > $(OTA_DIR)/ota_conf)
endif
