PRODUCT_BRAND ?= XenonHD

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

# Default notification/alarm sounds
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.notification_sound=Argon.ogg \
    ro.config.alarm_alert=Hassium.ogg

ifneq ($(TARGET_BUILD_VARIANT),user)
# Thank you, please drive thru!
PRODUCT_PROPERTY_OVERRIDES += persist.sys.dun.override=0
endif

ifneq ($(TARGET_BUILD_VARIANT),eng)
# Enable ADB authentication
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.adb.secure=1
endif

ifeq ($(BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE),)
  PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.device.cache_dir=/data/cache
else
  PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.device.cache_dir=/cache
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/xenonhd/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/xenonhd/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/xenonhd/prebuilt/common/bin/50-xenonhd.sh:system/addon.d/50-xenonhd.sh \
    vendor/xenonhd/prebuilt/common/bin/blacklist:system/addon.d/blacklist

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/xenonhd/config/permissions/backup.xml:system/etc/sysconfig/backup.xml

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/xenonhd/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# init.d support
PRODUCT_COPY_FILES += \
    vendor/xenonhd/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/xenonhd/prebuilt/common/bin/sysinit:system/bin/sysinit

ifneq ($(TARGET_BUILD_VARIANT),user)
# userinit support
PRODUCT_COPY_FILES += \
    vendor/xenonhd/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit
endif

# XenonHD-specific init file
PRODUCT_COPY_FILES += \
    vendor/xenonhd/prebuilt/common/etc/init.local.rc:root/init.xenonhd.rc

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/xenonhd/prebuilt/common/lib/content-types.properties:system/lib/content-types.properties

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# This is XenonHD!
PRODUCT_COPY_FILES += \
    vendor/xenonhd/config/permissions/com.cyanogenmod.android.xml:system/etc/permissions/com.cyanogenmod.android.xml

# Include XenonHD audio files
include vendor/xenonhd/config/xenonhd_audio.mk

# Theme engine
include vendor/xenonhd/config/themes_common.mk

ifneq ($(TARGET_DISABLE_CMSDK), true)
# CMSDK
include vendor/xenonhd/config/cmsdk_common.mk
endif

# TWRP
ifeq ($(WITH_TWRP),true)
include vendor/xenonhd/config/twrp.mk
endif

# Bootanimation
PRODUCT_PACKAGES += \
    bootanimation.zip

# Required XenonHD packages
PRODUCT_PACKAGES += \
    BluetoothExt \
    CMAudioService \
    CMParts \
    Development \
    Profiles \
    WeatherManagerService

# Optional packages
PRODUCT_PACKAGES += \
    libemoji \
    LiveWallpapersPicker \
    PhotoTable \
    Terminal

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni

# Custom XenonHD packages
PRODUCT_PACKAGES += \
    AudioFX \
    CMSettingsProvider \
    CMUpdater \
    LineageSetupWizard \
    Eleven \
    ExactCalculator \
    Jelly \
    LiveLockScreenService \
    LockClock \
    Trebuchet \
    WallpaperPicker \
    WeatherProvider

# Exchange support
PRODUCT_PACKAGES += \
    Exchange2

# Extra tools in XenonHD
PRODUCT_PACKAGES += \
    7z \
    bash \
    bzip2 \
    curl \
    fsck.ntfs \
    gdbserver \
    htop \
    lib7z \
    libsepol \
    micro_bench \
    mke2fs \
    mkfs.ntfs \
    mount.ntfs \
    oprofiled \
    pigz \
    powertop \
    sqlite3 \
    strace \
    tune2fs \
    unrar \
    unzip \
    vim \
    wget \
    zip

# Custom off-mode charger
ifneq ($(WITH_LINEAGE_CHARGER),false)
PRODUCT_PACKAGES += \
    charger_res_images \
    lineage_charger_res_images \
    font_log.png \
    libhealthd.lineage
endif

# ExFAT support
WITH_EXFAT ?= true
ifeq ($(WITH_EXFAT),true)
TARGET_USES_EXFAT := true
PRODUCT_PACKAGES += \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat
endif

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

# Storage manager
PRODUCT_PROPERTY_OVERRIDES += \
    ro.storage_manager.enabled=true

# Telephony
PRODUCT_PACKAGES += \
    telephony-ext

PRODUCT_BOOT_JARS += \
    telephony-ext

# These packages are excluded from user builds
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_PACKAGES += \
    procmem \
    procrank

# Conditionally build in su
ifeq ($(WITH_SU),true)
PRODUCT_PACKAGES += \
    su
endif
endif

DEVICE_PACKAGE_OVERLAYS += vendor/xenonhd/overlay/common

PRODUCT_VERSION_MAJOR = 15
PRODUCT_VERSION_MINOR = 0
PRODUCT_VERSION_MAINTENANCE := 0

ifeq ($(TARGET_VENDOR_SHOW_MAINTENANCE_VERSION),true)
    XENONHD_VERSION_MAINTENANCE := $(PRODUCT_VERSION_MAINTENANCE)
else
    XENONHD_VERSION_MAINTENANCE := 0
endif

# Set XENONHD_BUILDTYPE from the env RELEASE_TYPE, for jenkins compat

ifndef XENONHD_BUILDTYPE
    ifdef RELEASE_TYPE
        # Starting with "XENONHD_" is optional
        RELEASE_TYPE := $(shell echo $(RELEASE_TYPE) | sed -e 's|^XENONHD_||g')
        XENONHD_BUILDTYPE := $(RELEASE_TYPE)
    endif
endif

# Filter out random types, so it'll reset to UNOFFICIAL
ifeq ($(filter RELEASE NIGHTLY SNAPSHOT EXPERIMENTAL,$(XENONHD_BUILDTYPE)),)
    XENONHD_BUILDTYPE :=
endif

ifdef XENONHD_BUILDTYPE
    ifneq ($(XENONHD_BUILDTYPE), SNAPSHOT)
        ifdef XENONHD_EXTRAVERSION
            # Force build type to EXPERIMENTAL
            XENONHD_BUILDTYPE := EXPERIMENTAL
            # Remove leading dash from XENONHD_EXTRAVERSION
            XENONHD_EXTRAVERSION := $(shell echo $(XENONHD_EXTRAVERSION) | sed 's/-//')
            # Add leading dash to XENONHD_EXTRAVERSION
            XENONHD_EXTRAVERSION := -$(XENONHD_EXTRAVERSION)
        endif
    else
        ifndef XENONHD_EXTRAVERSION
            # Force build type to EXPERIMENTAL, SNAPSHOT mandates a tag
            XENONHD_BUILDTYPE := EXPERIMENTAL
        else
            # Remove leading dash from XENONHD_EXTRAVERSION
            XENONHD_EXTRAVERSION := $(shell echo $(XENONHD_EXTRAVERSION) | sed 's/-//')
            # Add leading dash to XENONHD_EXTRAVERSION
            XENONHD_EXTRAVERSION := -$(XENONHD_EXTRAVERSION)
        endif
    endif
else
    # If XENONHD_BUILDTYPE is not defined, set to UNOFFICIAL
    XENONHD_BUILDTYPE := UNOFFICIAL
    XENONHD_EXTRAVERSION :=
endif

ifeq ($(XENONHD_BUILDTYPE), UNOFFICIAL)
    ifneq ($(TARGET_UNOFFICIAL_BUILD_ID),)
        XENONHD_EXTRAVERSION := -$(TARGET_UNOFFICIAL_BUILD_ID)
    endif
endif

ifeq ($(XENONHD_BUILDTYPE), RELEASE)
    ifndef TARGET_VENDOR_RELEASE_BUILD_ID
        XENONHD_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)$(PRODUCT_VERSION_DEVICE_SPECIFIC)-$(XENONHD_BUILD)
    else
        ifeq ($(TARGET_BUILD_VARIANT),user)
            ifeq ($(XENONHD_VERSION_MAINTENANCE),0)
                XENONHD_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(TARGET_VENDOR_RELEASE_BUILD_ID)-$(XENONHD_BUILD)
            else
                XENONHD_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(XENONHD_VERSION_MAINTENANCE)-$(TARGET_VENDOR_RELEASE_BUILD_ID)-$(XENONHD_BUILD)
            endif
        else
            XENONHD_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)$(PRODUCT_VERSION_DEVICE_SPECIFIC)-$(XENONHD_BUILD)
        endif
    endif
else
    ifeq ($(XENONHD_VERSION_MAINTENANCE),0)
        XENONHD_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(shell date -u +%Y%m%d)-$(XENONHD_BUILDTYPE)$(XENONHD_EXTRAVERSION)-$(XENONHD_BUILD)
    else
        XENONHD_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(XENONHD_VERSION_MAINTENANCE)-$(shell date -u +%Y%m%d)-$(XENONHD_BUILDTYPE)$(XENONHD_EXTRAVERSION)-$(XENONHD_BUILD)
    endif
endif

PRODUCT_PROPERTY_OVERRIDES += \
    ro.xenonhd.version=$(XENONHD_VERSION) \
    ro.xenonhd.releasetype=$(XENONHD_BUILDTYPE) \
    ro.modversion=$(XENONHD_VERSION) \
    ro.lineagelegal.url=https://lineageos.org/legal

PRODUCT_EXTRA_RECOVERY_KEYS += \
    vendor/xenonhd/build/target/product/security/lineage

-include vendor/lineage-priv/keys/keys.mk

XENONHD_DISPLAY_VERSION := $(XENONHD_VERSION)

ifneq ($(PRODUCT_DEFAULT_DEV_CERTIFICATE),)
ifneq ($(PRODUCT_DEFAULT_DEV_CERTIFICATE),build/target/product/security/testkey)
    ifneq ($(XENONHD_BUILDTYPE), UNOFFICIAL)
        ifndef TARGET_VENDOR_RELEASE_BUILD_ID
            ifneq ($(XENONHD_EXTRAVERSION),)
                # Remove leading dash from XENONHD_EXTRAVERSION
                XENONHD_EXTRAVERSION := $(shell echo $(XENONHD_EXTRAVERSION) | sed 's/-//')
                TARGET_VENDOR_RELEASE_BUILD_ID := $(XENONHD_EXTRAVERSION)
            else
                TARGET_VENDOR_RELEASE_BUILD_ID := $(shell date -u +%Y%m%d)
            endif
        else
            TARGET_VENDOR_RELEASE_BUILD_ID := $(TARGET_VENDOR_RELEASE_BUILD_ID)
        endif
        ifeq ($(XENONHD_VERSION_MAINTENANCE),0)
            XENONHD_DISPLAY_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(TARGET_VENDOR_RELEASE_BUILD_ID)-$(XENONHD_BUILD)
        else
            XENONHD_DISPLAY_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(XENONHD_VERSION_MAINTENANCE)-$(TARGET_VENDOR_RELEASE_BUILD_ID)-$(XENONHD_BUILD)
        endif
    endif
endif
endif

PRODUCT_PROPERTY_OVERRIDES += \
    ro.xenonhd.display.version=$(XENONHD_DISPLAY_VERSION)

-include $(WORKSPACE)/build_env/image-auto-bits.mk
-include vendor/xenonhd/config/partner_gms.mk
-include vendor/cyngn/product.mk

$(call prepend-product-if-exists, vendor/extra/product.mk)
