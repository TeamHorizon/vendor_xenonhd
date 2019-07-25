# Allow vendor/extra to override any property by setting it first
$(call inherit-product-if-exists, vendor/extra/product.mk)

PRODUCT_BRAND ?= XenonHD

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    persist.sys.disable_rescue=true \
    ro.build.selinux=1 \
    ro.opa.eligible_device=true \
    ro.storage_manager.enabled=true

# Default alarm/notification/ringtone sounds
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.config.alarm_alert=Bright_morning.ogg \
    ro.config.notification_sound=Popcorn.ogg \
    ro.config.ringtone=The_big_adventure.ogg

ifneq ($(TARGET_BUILD_VARIANT),user)
# Thank you, please drive thru!
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.sys.dun.override=0
endif

ifeq ($(TARGET_BUILD_VARIANT),eng)
# Disable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=0
else
# Enable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/xenonhd/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/xenonhd/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/xenonhd/prebuilt/common/bin/50-xenonhd.sh:system/addon.d/50-xenonhd.sh \
    vendor/xenonhd/prebuilt/common/bin/blacklist:system/addon.d/blacklist

ifeq ($(AB_OTA_UPDATER),true)
PRODUCT_COPY_FILES += \
    vendor/xenonhd/prebuilt/common/bin/backuptool_ab.sh:system/bin/backuptool_ab.sh \
    vendor/xenonhd/prebuilt/common/bin/backuptool_ab.functions:system/bin/backuptool_ab.functions \
    vendor/xenonhd/prebuilt/common/bin/backuptool_postinstall.sh:system/bin/backuptool_postinstall.sh
endif

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/xenonhd/config/permissions/backup.xml:system/etc/sysconfig/backup.xml

# XenonHD-specific broadcast actions whitelist
PRODUCT_COPY_FILES += \
    vendor/xenonhd/config/permissions/xenonhd-sysconfig.xml:system/etc/sysconfig/xenonhd-sysconfig.xml

# init.d support
PRODUCT_COPY_FILES += \
    vendor/xenonhd/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/xenonhd/prebuilt/common/bin/sysinit:system/bin/sysinit

ifneq ($(TARGET_BUILD_VARIANT),user)
# userinit support
PRODUCT_COPY_FILES += \
    vendor/xenonhd/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit
endif

# Copy all XenonHD-specific init rc files
$(foreach f,$(wildcard vendor/xenonhd/prebuilt/common/etc/init/*.rc),\
	$(eval PRODUCT_COPY_FILES += $(f):system/etc/init/$(notdir $f)))

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
    vendor/xenonhd/config/permissions/org.lineageos.android.xml:system/etc/permissions/org.lineageos.android.xml \
    vendor/xenonhd/config/permissions/privapp-permissions-lineage.xml:system/etc/permissions/privapp-permissions-lineage.xml
    vendor/xenonhd/config/permissions/privapp-permissions-cm-legacy.xml:system/etc/permissions/privapp-permissions-cm-legacy.xml

# Enforce privapp-permissions whitelist
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.control_privapp_permissions=enforce

# Hidden API whitelist
PRODUCT_COPY_FILES += \
    vendor/xenonhd/config/permissions/lineage-hiddenapi-package-whitelist.xml:system/etc/permissions/lineage-hiddenapi-package-whitelist.xml

# Include XenonOTA config
include vendor/xenonhd/config/ota.mk

# Fix Google dialer
PRODUCT_COPY_FILES += \
    vendor/xenonhd/prebuilt/common/etc/dialer_experience.xml:system/etc/sysconfig/dialer_experience.xml

# Power whitelist
PRODUCT_COPY_FILES += \
    vendor/xenonhd/config/permissions/lineage-power-whitelist.xml:system/etc/sysconfig/lineage-power-whitelist.xml

ifneq ($(TARGET_DISABLE_LINEAGE_SDK), true)
# Lineage SDK
include vendor/xenonhd/config/lineage_sdk_common.mk
endif

# TWRP
ifeq ($(WITH_TWRP),true)
include vendor/xenonhd/config/twrp.mk
endif

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Bootanimation
PRODUCT_PACKAGES += \
    bootanimation.zip

# Required XenonHD packages
PRODUCT_PACKAGES += \
    LineageParts \
    Development \
    Profiles \
    SubstratumSignature \
    Turbo \
    turbo.xml \
    privapp-permissions-turbo.xml

# Optional packages
PRODUCT_PACKAGES += \
    LiveWallpapersPicker \
    PhotoTable \
    Terminal

# Custom XenonHD packages
PRODUCT_PACKAGES += \
    BrowserInstaller \
    Backgrounds \
    LineageSettingsProvider \
    LineageSetupWizard \
    Eleven \
    ExactCalculator \
    LockClock \
    SoundPicker \
    TrebuchetQuickStep \
    WeatherProvider

ifneq ($(DISABLE_AUDIOFX), true)
PRODUCT_PACKAGES += \
    AudioFX
endif

# Exchange support
PRODUCT_PACKAGES += \
    Exchange2

# Berry styles
include packages/overlays/XenonHD/product_packages.mk

# Extra tools in XenonHD
PRODUCT_PACKAGES += \
    7z \
    awk \
    bash \
    bzip2 \
    curl \
    getcap \
    htop \
    lib7z \
    libsepol \
    pigz \
    powertop \
    setcap \
    unrar \
    unzip \
    vim \
    wget \
    zip

# Charger
PRODUCT_PACKAGES += \
    charger_res_images

# Custom off-mode charger
ifeq ($(WITH_LINEAGE_CHARGER),true)
PRODUCT_PACKAGES += \
    lineage_charger_res_images \
    font_log.png \
    libhealthd.lineage
endif

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.exfat \
    fsck.ntfs \
    mke2fs \
    mkfs.exfat \
    mkfs.ntfs \
    mount.ntfs \
    ntfsfix \
    ntfs-3g

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

# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

# These packages are excluded from user builds
PRODUCT_PACKAGES_DEBUG += \
    micro_bench \
    procmem \
    procrank \
    strace

# Conditionally build in su
ifneq ($(TARGET_BUILD_VARIANT),user)
ifeq ($(WITH_SU),true)
PRODUCT_PACKAGES += \
    su
endif
endif

PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/xenonhd/overlay
DEVICE_PACKAGE_OVERLAYS += vendor/xenonhd/overlay/common

PRODUCT_EXTRA_RECOVERY_KEYS += \
    vendor/xenonhd/build/target/product/security/lineage

-include $(WORKSPACE)/build_env/image-auto-bits.mk
-include vendor/xenonhd/config/partner_gms.mk

# Use release-keys with Official builds if possible
include vendor/xenonhd/config/release_keys.mk
