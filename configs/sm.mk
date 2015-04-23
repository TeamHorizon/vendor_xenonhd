# Copyright (C) 2014-2015 The SaberMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Written for SaberMod toolchains
# TARGET_SM_AND and TARGET_SM_KERNEL can be set before this file, to override the default of gcc 4.8 for ROM.
# This is to avoid hardcoding the gcc versions for the ROM and kernels.

# Inherit sabermod configs.  Default to arm if TARGET_ARCH is not defined.
ifndef TARGET_ARCH
  $(warning ********************************************************************************)
  $(warning *  TARGET_ARCH not defined, defaulting to arm.)
  $(warning *  To use arm64 set TARGET_ARCH := arm64)
  $(warning *  in device makefile before this file is called.)
  $(warning ********************************************************************************)
  TARGET_ARCH := arm
endif

ifndef TARGET_SM_AND
  $(warning ********************************************************************************)
  $(warning *  TARGET_SM_AND not defined.)
  $(warning *  Defaulting to gcc 4.8 for ROM.)
  $(warning *  To change this set TARGET_SM_AND in device makefile before this file is called.)
  $(warning *  This is required for arm64 devices for the kernel TARGET_SM_KERNEL := SM-4.9)
  $(warning ********************************************************************************)
  TARGET_SM_AND := 4.8
endif

ifdef TARGET_SM_KERNEL
  TARGET_SM_KERNEL_DEFINED := true
else
  $(warning ********************************************************************************)
  $(warning *  TARGET_SM_KERNEL not defined.)
  $(warning *  This needs to be set in device makefile before this file is called for inline kernel building.)
  $(warning *  Skipping kernel bits.)
  $(warning ********************************************************************************)
  TARGET_SM_KERNEL_DEFINED := false
endif

# Set GCC colors
export GCC_COLORS := 'error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Find host os
UNAME := $(shell uname -s)

ifeq ($(strip $(UNAME)),Linux)
  HOST_OS := linux
endif

# Enable -O3 for all builds.
export O3_OPTIMIZATIONS := true

# Only use these compilers on linux host.
ifeq ($(strip $(HOST_OS)),linux)
  ifneq ($(filter arm arm64,$(TARGET_ARCH)),)
    ifeq ($(strip $(TARGET_ARCH)),arm)

      TARGET_ARCH_LIB_PATH := $(ANDROID_BUILD_TOP)/prebuilts/gcc/$(HOST_PREBUILT_TAG)/arm/arm-linux-androideabi-$(TARGET_SM_AND)/lib

      # Path to ROM toolchain
      SM_AND_PATH := prebuilts/gcc/$(HOST_PREBUILT_TAG)/arm/arm-linux-androideabi-$(TARGET_SM_AND)
      SM_AND := $(shell $(SM_AND_PATH)/bin/arm-linux-androideabi-gcc --version)

      # Find strings in version info
      ifneq ($(filter %sabermod,$(SM_AND)),)
        SM_AND_NAME := $(filter %sabermod,$(SM_AND))
        SM_AND_DATE := $(filter 20140% 20141% 20150% 20151%,$(SM_AND))
        SM_AND_STATUS := $(filter (release) (prerelease) (experimental),$(SM_AND))
        SM_AND_VERSION := $(SM_AND_NAME)-$(SM_AND_DATE)-$(SM_AND_STATUS)

        # Write version info to build.prop
        PRODUCT_PROPERTY_OVERRIDES += \
          ro.sm.android=$(SM_AND_VERSION)

        OPT1 := (graphite)

        # Graphite flags and friends
        BASE_GRAPHITE_FLAGS := \
          -fgraphite \
          -fgraphite-identity \
          -floop-flatten \
          -ftree-loop-linear \
          -floop-interchange \
          -floop-strip-mine \
          -floop-block

        # Check if there's already something set in a device make file somewhere.
        # Make dependent on -O3 optimizations.
        # These are extra loop optmizations, that act as helpers for -O3 and other loop optimization flags.
        ifeq ($(strip $(O3_OPTIMIZATIONS)),true)
          ifndef GRAPHITE_FLAGS
            GRAPHITE_FLAGS := \
              $(BASE_GRAPHITE_FLAGS)
          else
            GRAPHITE_FLAGS += \
              $(BASE_GRAPHITE_FLAGS)
          endif

          # Legacy gcc doesn't understand this flag
          ifneq ($(strip $(USE_LEGACY_GCC)),true)
            GRAPHITE_FLAGS += \
              -Wno-error=maybe-uninitialized
          endif
        endif
      endif

      # Skip kernel bits if TARGET_SM_KERNEL is not defined.
      ifeq ($(strip $(TARGET_SM_KERNEL_DEFINED)),true)

        # Path to kernel toolchain
        SM_KERNEL_PATH := prebuilts/gcc/$(HOST_PREBUILT_TAG)/arm/arm-eabi-$(TARGET_SM_KERNEL)
        SM_KERNEL := $(shell $(SM_KERNEL_PATH)/bin/arm-eabi-gcc --version)

        ifneq ($(filter %sabermod,$(SM_KERNEL)),)
          SM_KERNEL_NAME := $(filter %sabermod,$(SM_KERNEL))
          SM_KERNEL_DATE := $(filter 20140% 20141% 20150% 20151%,$(SM_KERNEL))
          SM_KERNEL_STATUS := $(filter (release) (prerelease) (experimental),$(SM_KERNEL))
          SM_KERNEL_VERSION := $(SM_KERNEL_NAME)-$(SM_KERNEL_DATE)-$(SM_KERNEL_STATUS)

          # Write version info to build.prop
          PRODUCT_PROPERTY_OVERRIDES += \
            ro.sm.kernel=$(SM_KERNEL_VERSION)

          # Make dependent on -O3 optimizations.
          # These are extra loop optmizations, that act as helpers for -O3 and other loop optimization flags.
          ifeq ($(strip $(O3_OPTIMIZATIONS)),true)

            # Graphite flags for kernel

            # Some graphite flags are only available for certain gcc versions
            GRAPHITE_UNROLL_AND_JAM := $(filter 5.0.x-sabermod 6.0.x-sabermod,$(SM_KERNEL))

            BASE_GRAPHITE_KERNEL_FLAGS := \
              -fgraphite \
              -fgraphite-identity \
              -floop-flatten \
              -ftree-loop-linear \
              -floop-interchange \
              -floop-strip-mine \
              -floop-block \
              -floop-nest-optimize
            ifneq ($(GRAPHITE_UNROLL_AND_JAM),)
              BASE_GRAPHITE_KERNEL_FLAGS += \
                -floop-unroll-and-jam
            endif

            # Check if there's already something set in a device make file somewhere.
            ifndef GRAPHITE_KERNEL_FLAGS
       export GRAPHITE_KERNEL_FLAGS := \
                $(BASE_GRAPHITE_KERNEL_FLAGS)
            else
       export GRAPHITE_KERNEL_FLAGS := \
                $(BASE_GRAPHITE_KERNEL_FLAGS) \
                $(GRAPHITE_KERNEL_FLAGS)
            endif
          endif
        endif
      endif
    endif

    ifeq ($(strip $(TARGET_ARCH)),arm64)

      TARGET_ARCH_LIB_PATH := $(ANDROID_BUILD_TOP)/prebuilts/gcc/$(HOST_PREBUILT_TAG)/aarch64/aarch64-linux-android-$(TARGET_SM_AND)/lib

      # Path to toolchain
      SM_AND_PATH := prebuilts/gcc/$(HOST_PREBUILT_TAG)/aarch64/aarch64-linux-android-$(TARGET_SM_AND)
      SM_AND := $(shell $(SM_AND_PATH)/bin/aarch64-linux-android-gcc --version)

      # Find strings in version info
      ifneq ($(filter %sabermod,$(SM_AND)),)
        SM_AND_NAME := $(filter %sabermod,$(SM_AND))
        SM_AND_DATE := $(filter 20140% 20141% 20150% 20151%,$(SM_AND))
        SM_AND_STATUS := $(filter (release) (prerelease) (experimental),$(SM_AND))
        SM_AND_VERSION := $(SM_AND_NAME)-$(SM_AND_DATE)-$(SM_AND_STATUS)

        # Write version info to build.prop
        PRODUCT_PROPERTY_OVERRIDES += \
          ro.sm.android=$(SM_AND_VERSION)

        OPT1 := (graphite)

        # Graphite flags and friends
        BASE_GRAPHITE_FLAGS := \
            -fgraphite \
            -fgraphite-identity \
            -floop-flatten \
            -ftree-loop-linear \
            -floop-interchange \
            -floop-strip-mine \
            -floop-block

       # Check if there's already something set in a device make file somewhere.
        # Make dependent on -O3 optimizations.
        # These are extra loop optmizations, that act as helpers for -O3 and other loop optimization flags.
        ifeq ($(strip $(O3_OPTIMIZATIONS)),true)
          ifndef GRAPHITE_FLAGS
            GRAPHITE_FLAGS := \
              $(BASE_GRAPHITE_FLAGS)
          else
            GRAPHITE_FLAGS += \
              $(BASE_GRAPHITE_FLAGS)
          endif

          # Legacy gcc doesn't understand this flag
          ifneq ($(strip $(USE_LEGACY_GCC)),true)
            GRAPHITE_FLAGS += \
              -Wno-error=maybe-uninitialized
          endif
        endif
      endif

      # Skip kernel bits if TARGET_SM_KERNEL is not defined.
      ifeq ($(strip $(TARGET_SM_KERNEL_DEFINED)),true)

        # Path to kernel toolchain
        SM_KERNEL_PATH := prebuilts/gcc/$(HOST_PREBUILT_TAG)/aarch64/aarch64-$(TARGET_SM_KERNEL)
        SM_KERNEL := $(shell $(SM_KERNEL_PATH)/bin/aarch64-gcc --version)

        ifneq ($(filter %sabermod,$(SM_KERNEL)),)
          SM_KERNEL_NAME := $(filter %sabermod,$(SM_KERNEL))
          SM_KERNEL_DATE := $(filter 20140% 20141% 20150% 20151%,$(SM_KERNEL))
          SM_KERNEL_STATUS := $(filter (release) (prerelease) (experimental),$(SM_KERNEL))
          SM_KERNEL_VERSION := $(SM_KERNEL_NAME)-$(SM_KERNEL_DATE)-$(SM_KERNEL_STATUS)

          # Write version info to build.prop
          PRODUCT_PROPERTY_OVERRIDES += \
            ro.sm.kernel=$(SM_KERNEL_VERSION)

          # Make dependent on -O3 optimizations.
          # These are extra loop optmizations, that act as helpers for -O3 and other loop optimization flags.
          ifeq ($(strip $(O3_OPTIMIZATIONS)),true)

            # Graphite flags for kernel

            # Some graphite flags are only available for certain gcc versions
            GRAPHITE_UNROLL_AND_JAM := $(filter 5.0.x-sabermod 6.0.x-sabermod,$(SM_KERNEL))

            BASE_GRAPHITE_KERNEL_FLAGS := \
              -fgraphite \
              -fgraphite-identity \
              -floop-flatten \
              -ftree-loop-linear \
              -floop-interchange \
              -floop-strip-mine \
              -floop-block \
              -floop-nest-optimize
            ifneq ($(GRAPHITE_UNROLL_AND_JAM),)
              BASE_GRAPHITE_KERNEL_FLAGS += \
                -floop-unroll-and-jam
            endif

            # Check if there's already something set in a device make file somewhere.
            ifndef GRAPHITE_KERNEL_FLAGS
       export GRAPHITE_KERNEL_FLAGS := \
                $(BASE_GRAPHITE_KERNEL_FLAGS)
            else
       export GRAPHITE_KERNEL_FLAGS := \
                $(BASE_GRAPHITE_KERNEL_FLAGS) \
                $(GRAPHITE_KERNEL_FLAGS)
            endif
          endif
        endif
      endif
    endif

    ifdef TARGET_ARCH_LIB_PATH
      # Add extra libs for the compilers to use
      export LD_LIBRARY_PATH := $(TARGET_ARCH_LIB_PATH):$(LD_LIBRARY_PATH)
      export LIBRARY_PATH := $(TARGET_ARCH_LIB_PATH):$(LIBRARY_PATH)
    endif

    ifneq ($(GRAPHITE_FLAGS),)
      # Force disable some modules that are not compatible with graphite flags.
      # Add more modules if needed for devices in a device make file somewhere with
      # LOCAL_DISABLE_GRAPHITE:=

      LOCAL_BASE_DISABLE_GRAPHITE := \
        libunwind \
        libFFTEm \
        libicui18n \
        libskia \
        libvpx \
        libmedia_jni \
        libstagefright_mp3dec \
        libart \
        mdnsd \
        libwebrtc_spl \
        third_party_WebKit_Source_core_webcore_svg_gyp \
        libjni_filtershow_filters \
        libavformat \
        libavcodec \
        skia_skia_library_gyp \
        libSR_Core \
        third_party_libvpx_libvpx_gyp \
        ui_gl_gl_gyp \
        fio

      # Check if there's already something set in a device make file somewhere.
      ifndef LOCAL_DISABLE_GRAPHITE
        LOCAL_DISABLE_GRAPHITE := \
          $(LOCAL_BASE_DISABLE_GRAPHITE)
      else
        LOCAL_DISABLE_GRAPHITE += \
          $(LOCAL_BASE_DISABLE_GRAPHITE)
      endif
    endif

    # SABERMOD_ARM_MODE
    # The LOCAL_COMPILERS_WHITELIST will allow modules that absolutely have to be complied with thumb instructions,
    # or the clang compiler, to skip replacing the default overrides.
    ifeq ($(strip $(ENABLE_SABERMOD_ARM_MODE)),true)
      LOCAL_COMPILERS_WHITELIST := \
        libmincrypt \
        libc++abi \
        libjni_latinime_common_static \
        libcompiler_rt \
        libnativebridge \
        libc++ \
        libRSSupport \
        netd \
        libscrypt_static \
        libRSCpuRef \
        libRSDriver
    endif
  endif
else
    $(warning ********************************************************************************)
    $(warning *  Limited optimization options are available outside of linux host OS.)
    $(warning *  To take advantage of all optimization options, build on linux host OS.)
    $(warning ********************************************************************************)
endif

# BUGFIX for AOSP
# strict-aliasing has a long well known history of breaking code when allowed to pass with warnings.
# AOSP has blindly turned on strict-aliasing in various places locally throughout the source.
# This causes warnings and should be dealt with, by turning strict-aliasing off to fix the warnings,
# until AOSP gets around to fixing the warnings locally in the code.

LOCAL_BASE_DISABLE_STRICT_ALIASING := \
    libpdfiumcore \
    libpdfium \
    libc_bionic \
    libc_dns \
    libc_gdtoa \
    libc_openbsd \
    libfs_mgr \
    libcutils \
    liblog \
    libc \
    adbd \
    libunwind \
    libziparchive \
    libsync \
    libnetutils \
    libRS \
    libbcinfo \
    libbccCore \
    libbccSupport \
    libstagefright_foundation \
    libusbhost \
    bluetooth.default \
    libbt-brcm_bta \
    libnetd_client \
    libbt-brcm_stack \
    bcc \
    debuggerd \
    toolbox \
    clatd \
    ip \
    libnetlink \
    libc_nomalloc \
    linker \
    libstagefright_avc_common \
    logd \
    libstagefright_webm \
    libstagefright_httplive \
    libstagefright_rtsp \
    sdcard \
    netd \
    libdiskconfig \
    audio.a2dp.default \
    libjavacore \
    libstagefright_avcenc \
    libRSDriver

# Check if there's already something set in a device make file somewhere.
ifndef LOCAL_DISABLE_STRICT_ALIASING
  LOCAL_DISABLE_STRICT_ALIASING := \
    $(LOCAL_BASE_DISABLE_STRICT_ALIASING)
else
  LOCAL_DISABLE_STRICT_ALIASING += \
    $(LOCAL_BASE_DISABLE_STRICT_ALIASING)
endif

# O3 optimizations
# To enable this set O3_OPTIMIZATIONS=true in a device makefile somewhere.
ifeq ($(strip $(O3_OPTIMIZATIONS)),true)

  # If -O3 is enabled, force disable on thumb flags.
  # loop optmizations are not really usefull in thumb mode.
  DISABLE_O3_OPTIMIZATIONS_THUMB := true
  OPT2 := (max)

  # Disable some modules that break with -O3
  # Add more modules if needed for devices in a device make file somewhere with
  # LOCAL_DISABLE_O3 :=

  # Check if there's already something set in a device make file somewhere.
  ifndef LOCAL_DISABLE_O3
    LOCAL_DISABLE_O3 := \
      libaudioflinger \
      skia_skia_library_gyp
  else
    LOCAL_DISABLE_O3 += \
      libaudioflinger \
      skia_skia_library_gyp
  endif

  # -O3 flags and friends
  O3_FLAGS := \
    -O3 \
    -Wno-error=array-bounds \
    -Wno-error=strict-overflow
else
  OPT2:=

endif

# posix thread optimizations
# To enable this set ENABLE_PTHREAD=true in a device makefile somewhere.
ifeq ($(strip $(ENABLE_PTHREAD)),true)
  OPT3 := (pthread)

  # Disable some modules that break with -pthread
  # Add more modules if needed for devices in a device make file somewhere with
  # LOCAL_DISABLE_PTHREAD :=
  # Check if there's already something set in a device make file somewhere.
  ifndef LOCAL_DISABLE_PTHREAD
    LOCAL_DISABLE_PTHREAD := \
      libc_netbsd
  else
    LOCAL_DISABLE_PTHREAD += \
      libc_netbsd
  endif
else
  OPT3:=
endif

# General flags for gcc 4.9 to allow compilation to complete.
# Commented out for now since there's no common (non-device specific) modules to list here.
# Add more modules if needed for devices in a device make file somewhere with
# MAYBE_UNINITIALIZED :=

# Check if there's already something set in a device make file somewhere.
ifndef MAYBE_UNINITIALIZED
  MAYBE_UNINITIALIZED := \
    fastboot
else
  MAYBE_UNINITIALIZED += \
    fastboot
endif

# Enable some basic host gcc optimizations
# None that are cpu specific but arch is ok. It's already known that we are on linux-x86.
# Many people claim that host binaries are not useful, this can be proven as false, and that there is some benifit.
# Especially when used with -O3
# Most of the host binary files are linked with ld or gcc as shared and static libraries for arch and clang binaries.
EXTRA_SABERMOD_HOST_GCC_CFLAGS := \
  -march=x86-64 \
  -ftree-vectorize \
  -pipe

# Only enable loop optimizations if -O3 is enabled.
# These's no graphite here on host, so extra loop optimzations by themselves can be bad.
ifeq ($(strip $(O3_OPTIMIZATIONS)),true)
  EXTRA_SABERMOD_HOST_GCC_O3_CFLAGS := \
    -ftree-loop-distribution \
    -ftree-loop-if-convert \
    -ftree-loop-im \
    -ftree-loop-ivcanon \
    -fprefetch-loop-arrays
endif

GCC_OPTIMIZATION_LEVELS := $(OPT1)$(OPT2)$(OPT3)$(OPT4)
ifneq ($(GCC_OPTIMIZATION_LEVELS),)
  PRODUCT_PROPERTY_OVERRIDES += \
    ro.sm.flags=$(GCC_OPTIMIZATION_LEVELS)
endif
