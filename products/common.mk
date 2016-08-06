# Generic product
PRODUCT_NAME := xenonhd
PRODUCT_BRAND := xenonhd
PRODUCT_DEVICE := generic

# Common overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/xenonhd/overlay/common

PRODUCT_PACKAGES += \
    BluetoothExt \
    Busybox \
    DeskClock \
    Development \
    Dialer \
    Eleven \
    LatinIME \
    LatinImeDictionaryPack \
    libemoji \
    LockClock \
    messaging \
    Screencast \
    Launcher3 \
    SoundRecorder \
    Torch \
    XenonOTA \
    masquerade

PRODUCT_PACKAGES += \
    Basic \
    Galaxy4 \
    HoloSpiralWallpaper \
    LiveWallpapers \
    LiveWallpapersPicker \
    MagicSmokeWallpapers \
    NoiseField \
    PhaseBeam \
    PhotoTable

# CM Hardware Abstraction Framework
PRODUCT_PACKAGES += \
    org.cyanogenmod.hardware \
    org.cyanogenmod.hardware.xml

#Extras
PRODUCT_PACKAGES += \
    procmem \
    procrank

# Openssh
PRODUCT_PACKAGES += \
    libssh \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# Extra tools in XenonHD
PRODUCT_PACKAGES += \
    libsepol \
    mke2fs \
    tune2fs \
    nano \
    htop \
    mkfs.ntfs \
    fsck.ntfs \
    mount.ntfs \
    gdbserver \
    micro_bench \
    oprofiled \
    sqlite3 \
    strace \
    pigz

WITH_EXFAT ?= true
ifeq ($(WITH_EXFAT),true)
TARGET_USES_EXFAT := true
PRODUCT_PACKAGES += \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat
endif

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.google.clientidbase=android-google \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.error.receiver.system.apps=com.google.android.feedback \
    ro.com.google.locationfeatures=1 \
    ro.setupwizard.mode=OPTIONAL \
    ro.setupwizard.enterprise_mode=1 \
    ro.media.enc.jpeg.quality=100 \
    ro.media.dec.jpeg.memcap=8000000 \
    ro.media.enc.hprof.vid.bps=8000000 \
    wifi.supplicant_scan_interval=180 \
    ro.ril.disable.power.collapse=1 \
    pm.sleep_mode=1

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/xenonhd/proprietary/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/xenonhd/proprietary/common/bin/backuptool.functions:install/bin/backuptool.functions

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/xenonhd/configs/permissions/backup.xml:system/etc/sysconfig/backup.xml

# Audio
$(call inherit-product-if-exists, frameworks/base/data/sounds/OldAudio.mk)
$(call inherit-product-if-exists, frameworks/base/data/sounds/NewAudio.mk)
$(call inherit-product-if-exists, frameworks/base/data/sounds/AudioPackageStars.mk)
$(call inherit-product-if-exists, frameworks/base/data/sounds/AudioPackageNewWave.mk)
$(call inherit-product-if-exists, frameworks/base/data/sounds/AudioPackageElements.mk)
$(call inherit-product-if-exists, frameworks/base/data/sounds/AudioPackage8.mk)
$(call inherit-product-if-exists, frameworks/base/data/sounds/AudioPackage9.mk)
$(call inherit-product-if-exists, frameworks/base/data/sounds/AudioPackage10.mk)
$(call inherit-product-if-exists, frameworks/base/data/sounds/AudioPackage11.mk)
$(call inherit-product-if-exists, frameworks/base/data/sounds/AudioPackage12.mk)
$(call inherit-product-if-exists, frameworks/base/data/sounds/AudioPackage12_48.mk)

# Enable ADB authentication and root
ifneq ($(TARGET_BUILD_VARIANT),eng)
ADDITIONAL_DEFAULT_PROPERTIES += \
    ro.adb.secure=0 \
    ro.secure=0 \
    persist.sys.root_access=1
endif

# Blobs common to all devices
PRODUCT_COPY_FILES += \
    vendor/xenonhd/proprietary/common/etc/resolv.conf:system/etc/resolv.conf

# init.d support
PRODUCT_COPY_FILES += \
    vendor/xenonhd/proprietary/common/etc/init.local.rc:root/init.xenonhd.rc \
    vendor/xenonhd/proprietary/common/etc/init.d/03firstboot:system/etc/init.d/03firstboot \
    vendor/xenonhd/proprietary/common/etc/init_trigger.enabled:system/etc/init_trigger.enabled \
    vendor/xenonhd/proprietary/common/bin/sysinit:system/bin/sysinit

# SELinux filesystem labels
PRODUCT_COPY_FILES += \
    vendor/xenonhd/proprietary/common/etc/init.d/50selinuxrelabel:system/etc/init.d/50selinuxrelabel

# Term info for nano support
PRODUCT_COPY_FILES += \
    vendor/xenonhd/proprietary/common/etc/terminfo/l/linux:system/etc/terminfo/l/linux \
    vendor/xenonhd/proprietary/common/etc/terminfo/u/unknown:system/etc/terminfo/u/unknown

# Added xbin files
PRODUCT_COPY_FILES += \
    vendor/xenonhd/proprietary/common/xbin/backup:system/xbin/backup \
    vendor/xenonhd/proprietary/common/xbin/btool:system/xbin/btool \
    vendor/xenonhd/proprietary/common/xbin/drm1_func_test:system/xbin/drm1_func_test \
    vendor/xenonhd/proprietary/common/xbin/gdb:system/xbin/gdb \
    vendor/xenonhd/proprietary/common/xbin/gdbserver:system/xbin/gdbserver \
    vendor/xenonhd/proprietary/common/xbin/market_history:system/xbin/market_history \
    vendor/xenonhd/proprietary/common/xbin/rm_apks:system/xbin/rm_apks \
    vendor/xenonhd/proprietary/common/xbin/run_backup:system/xbin/run_backup \
    vendor/xenonhd/proprietary/common/xbin/run_restore:system/xbin/run_restore \
    vendor/xenonhd/proprietary/common/xbin/ssmgrd:system/xbin/ssmgrd \
    vendor/xenonhd/proprietary/common/xbin/sysro:system/xbin/sysro \
    vendor/xenonhd/proprietary/common/xbin/sysrw:system/xbin/sysrw \
    vendor/xenonhd/proprietary/common/xbin/zip:system/xbin/zip \
    vendor/xenonhd/proprietary/common/xbin/zipalign:system/xbin/zipalign

# LatinIME swyping support
ifneq ($(filter angler flounder h811, $(TARGET_DEVICE)),)
PRODUCT_COPY_FILES += \
    vendor/xenonhd/proprietary/common/lib/libjni_latinimegoogle64.so:system/lib64/libjni_latinimegoogle.so
else
PRODUCT_COPY_FILES += \
    vendor/xenonhd/proprietary/common/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so
endif

# Common dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/xenonhd/overlay/dictionaries

# AdAway
PRODUCT_COPY_FILES += \
    vendor/xenonhd/proprietary/common/app/org.adaway.apk:system/app/Adaway/Adaway.apk

# Substratum Theme Engine
PRODUCT_COPY_FILES += \
    vendor/xenonhd/proprietary/common/app/projekt.substratum.apk:system/app/Substratum/Substratum.apk

# Kernel Adiutor
PRODUCT_COPY_FILES += \
    vendor/xenonhd/proprietary/common/app/com.grarak.kerneladiutor.apk:system/priv-app/KernelAdiutor/KernelAdiutor.apk

# SuperSU
PRODUCT_COPY_FILES += \
     vendor/xenonhd/proprietary/common/app/UPDATE-SuperSU.zip:system/addon.d/UPDATE-SuperSU.zip \
     vendor/xenonhd/proprietary/common/etc/init.d/99SuperSUDaemon:system/etc/init.d/99SuperSUDaemon

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Camera shutter sound property
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.camera-sound=1


ifeq ($(PRODUCT_PREBUILT_WEBVIEWCHROMIUM), yes)
    -include prebuilts/chromium/$(TARGET_DEVICE)/chromium_prebuilt.mk
endif

# Inherit telephony configs
    -include vendor/xenonhd/products/telephony.mk

# Inherit drm blobs
    -include vendor/xenonhd/products/common_drm.mk

# Inherit common build.prop overrides
    -include vendor/xenonhd/products/common_versions.mk
