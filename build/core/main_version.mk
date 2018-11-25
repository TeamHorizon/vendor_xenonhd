# XenonHD System Version
ADDITIONAL_BUILD_PROPERTIES += \
    ro.xenonhd.version=$(XENONHD_VERSION) \
    ro.xenonhd.type=$(OTA_TYPE) \
    ro.xenonhd.timestamp=$(shell date +%s)

# LineageOS Platform SDK Version
ADDITIONAL_BUILD_PROPERTIES += \
    ro.lineage.build.version.plat.sdk=$(LINEAGE_PLATFORM_SDK_VERSION)

# LineageOS Platform Internal Version
ADDITIONAL_BUILD_PROPERTIES += \
    ro.lineage.build.version.plat.rev=$(LINEAGE_PLATFORM_REV)
