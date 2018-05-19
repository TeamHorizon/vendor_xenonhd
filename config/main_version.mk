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

# XenonHD System Version
ADDITIONAL_BUILD_PROPERTIES += \
    ro.xenonhd.version=$(XENONHD_VERSION) \
    ro.xenonhd.type=$(OTA_TYPE)

# LineageOS Platform SDK Version
ADDITIONAL_BUILD_PROPERTIES += \
    ro.lineage.build.version.plat.sdk=$(LINEAGE_PLATFORM_SDK_VERSION)

# LineageOS Platform Internal Version
ADDITIONAL_BUILD_PROPERTIES += \
    ro.lineage.build.version.plat.rev=$(LINEAGE_PLATFORM_REV)

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
version_format=yyMMdd" > $(ANDROID_BUILD_TOP)/out/ota_conf)
endif
