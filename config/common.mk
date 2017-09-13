# XenonHD product
PRODUCT_BRAND ?= xenonhd
PRODUCT_NAME ?= xenonhd

# Definitions
CONFIG := vendor/xenonhd/config
OVERLAY := vendor/xenonhd/overlay
PREBUILT := vendor/xenonhd/prebuilt/common

DEVICE_PACKAGE_OVERLAYS += $(OVERLAY)/common

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=$(shell date +"%s")

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

# XenonHD Overrides
PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    media.sf.extractor-plugin=libffmpeg_extractor.so \
    media.sf.omx-plugin=libffmpeg_omx.so \
    persist.sys.dun.override=0 \
    persist.sys.root_access=3 \
    ro.adb.secure=0 \
    ro.build.selinux=1 \
    ro.opa.eligible_device=true \
    ro.secure=0 \
    ro.storage_manager.enabled=true

# Telephony
PRODUCT_PACKAGES += \
    telephony-ext

PRODUCT_BOOT_JARS += \
    telephony-ext

# Backup Tool & init.d support
PRODUCT_COPY_FILES += \
    $(PREBUILT)/bin/50-cm.sh:system/addon.d/50-cm.sh \
    $(PREBUILT)/bin/backuptool.functions:install/bin/backuptool.functions \
    $(PREBUILT)/bin/backuptool.sh:install/bin/backuptool.sh \
    $(PREBUILT)/bin/blacklist:system/addon.d/blacklist \
    $(PREBUILT)/bin/sysinit:system/bin/sysinit \
    $(PREBUILT)/etc/init.d/00banner:system/etc/init.d/00banner

# userinit support
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_COPY_FILES += \
    $(PREBUILT)/etc/init.d/90userinit:system/etc/init.d/90userinit
endif

# XenonHD-specific files
# Backup Services whitelist
# Signature compatibility validation
# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    $(CONFIG)/permissions/backup.xml:system/etc/sysconfig/backup.xml \
    $(CONFIG)/permissions/com.cyanogenmod.android.xml:system/etc/permissions/com.cyanogenmod.android.xml \
    $(CONFIG)/permissions/power-whitelist.xml:system/etc/sysconfig/power-whitelist.xml \
    $(PREBUILT)/etc/init.local.rc:root/init.xenonhd.rc \
    $(PREBUILT)/lib/content-types.properties:system/lib/content-types.properties \
    $(PREBUILT)/media/bootanimation.zip:system/media/bootanimation.zip

# Enable SIP+VoIP on all targets & wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Include OTA config, XenonHD audio files, Theme engine
include $(CONFIG)/ota.mk
include $(CONFIG)/themes_common.mk
include $(CONFIG)/xenonhd_audio.mk

# CMSDK
ifneq ($(TARGET_DISABLE_CMSDK), true)
include $(CONFIG)/cmsdk_common.mk
endif

# TWRP
ifeq ($(WITH_TWRP),true)
include vendor/xenonhd/config/twrp.mk
endif

# XenonHD packages
PRODUCT_PACKAGES += \
    BluetoothExt \
    CMAudioService \
    CMParts \
    CMSettingsProvider \
    Development \
    ExactCalculator \
    Jelly \
    libemoji \
    libffmpeg_omx \
    libffmpeg_extractor \
    libprotobuf-cpp-full \
    librsjni \
    LiveWallpapersPicker \
    LockClock \
    media_codecs_ffmpeg.xml \
    mnml \
    NovaLauncher \
    OmniClockOSS \
    Phonograph \
    PhotoTable \
    Profiles \
    Recorder \
    Terminal \
    WallpaperPicker \
    WeatherManagerService \
    WeatherProvider

# These packages are excluded from user builds
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_PACKAGES += \
    procmem \
    procrank

ifeq ($(ROOT_METHOD),su)
PRODUCT_PACKAGES += \
    su
endif

ifeq ($(ROOT_METHOD),magisk)
PRODUCT_PACKAGES += \
    Magisk \
    MagiskManager
endif
endif

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
    rsync \
    scp \
    sftp \
    sqlite3 \
    ssh \
    ssh-keygen \
    sshd \
    sshd_config \
    start-ssh \
    strace \
    tune2fs \
    unrar \
    unzip \
    vim \
    wget \
    zip

# ExFAT support
WITH_EXFAT ?= true
ifeq ($(WITH_EXFAT),true)
TARGET_USES_EXFAT := true
PRODUCT_PACKAGES += \
    fsck.exfat \
    mkfs.exfat \
    mount.exfat
endif

-include $(CONFIG)/partner_gms.mk
-include $(WORKSPACE)/build_env/image-auto-bits.mk
-include vendor/cyngn/product.mk

$(call prepend-product-if-exists, vendor/extra/product.mk)
