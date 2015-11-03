# Version information used on all builds
PRODUCT_BUILD_PROP_OVERRIDES += BUILD_VERSION_TAGS=release-keys USER=android-build BUILD_UTC_DATE=$(shell date +"%s")

# XenonHD version
BOARD := $(subst xenonhd_,,$(TARGET_PRODUCT))
PRODUCT_NAME := $(TARGET_PRODUCT)

XENONHD_VERSION :=  XenonHD-$(shell date +"%m-%d-%y")-$(OTA_TYPE)

# Rom Manager properties
PRODUCT_PROPERTY_OVERRIDES += \
    ro.xehdversion=XenonHD-$(shell date +"%m-%d-%y") \
    ro.modversion=XenonHD-$(shell date +"%m-%d-%y") \
    ro.rommanager.developerid=TeamHorizon

# ROM Statistics and ROM Identification
PRODUCT_PROPERTY_OVERRIDES += \
ro.romstats.url=http://iceandfire.co/stats/ \
ro.romstats.name=XenonHD \
ro.romstats.version=$(shell date +"%m-%d-%y") \
ro.romstats.tframe=2


# OTA
ifeq ($(OTA_TYPE),)
OTA_TYPE=experimental
endif

# Create ota_conf, Rudimentary, but it works for now
$(shell echo -n "" > $(ANDROID_BUILD_TOP)/ota_conf)

$(shell echo -e "#       **** This_is_an_auto-generated_configuration_file_used_by_XenonOTA****\n \
\n \
# OTA_build_product\n \
ota-device=$(TARGET_PRODUCT)\n \
\n \
# Build_Location\n \
ota_url=https://mirrors.c0urier.net/android/teamhorizon/OTA/$(TARGET_PRODUCT)/ota_marshmallow.xml\n \
\n \
# release_type. This value never changes and is not build type dependent\n \
release_type=Stable\n \
\n \
# Build.prop\n \
device_name=ro.ota.device\n \
version_source=ro.ota.version\n \
\n \
# Build_identifier\n \
version_delimiter=-\n \
version_position=2\n \
version_format=yyyyMMdd" > $(ANDROID_BUILD_TOP)/ota_conf)

$(shell sed -i "s/\( \|xenonhd_\)//g" $(ANDROID_BUILD_TOP)/ota_conf)

PRODUCT_PROPERTY_OVERRIDES += \
    ro.ota.device=$(shell sed -n -e'/ota-device/s/^.*=//p' $(ANDROID_BUILD_TOP)/ota_conf) \
    ro.ota.type=$(OTA_TYPE) \
    ro.ota.version=XenonHD-$(shell date +"%m-%d-%y")