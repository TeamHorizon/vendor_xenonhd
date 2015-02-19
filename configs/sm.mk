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

# Only use these compilers on linux host.
ifeq ($(strip $(HOST_OS)),linux)

  ifeq ($(strip $(TARGET_ARCH)),arm)

    TARGET_ARCH_LIB_PATH := $(ANDROID_BUILD_TOP)/prebuilts/gcc/$(HOST_PREBUILT_TAG)/arm/arm-linux-androideabi-$(TARGET_SM_AND)/lib/gcc/arm-linux-androideabi/$(TARGET_LIB_VERSION).x-sabermod

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
      GRAPHITE_FLAGS := \
        -fgraphite \
        -fgraphite-identity \
        -floop-flatten \
        -floop-parallelize-all \
        -ftree-loop-linear \
        -floop-interchange \
        -floop-strip-mine \
        -floop-block

      # Legacy gcc doesn't understand this flag
      ifneq ($(strip $(USE_LEGACY_GCC)),true)
        GRAPHITE_FLAGS += \
          -Wno-error=maybe-uninitialized
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

        # Graphite flags for kernel
        export GRAPHITE_KERNEL_FLAGS := \
                 -fgraphite \
                 -fgraphite-identity \
                 -floop-flatten \
                 -floop-parallelize-all \
                 -ftree-loop-linear \
                 -floop-interchange \
                 -floop-strip-mine \
                 -floop-block
      endif
    endif
  endif

  ifeq ($(strip $(TARGET_ARCH)),arm64)

    TARGET_ARCH_LIB_PATH := $(ANDROID_BUILD_TOP)/prebuilts/gcc/$(HOST_PREBUILT_TAG)/aarch64/aarch64-linux-android-$(TARGET_SM_AND)/lib/gcc/aarch64-linux-android/$(TARGET_LIB_VERSION).x-aosp-sabermod

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
      GRAPHITE_FLAGS := \
        -fgraphite \
        -fgraphite-identity \
        -floop-flatten \
        -floop-parallelize-all \
        -ftree-loop-linear \
        -floop-interchange \
        -floop-strip-mine \
        -floop-block

      # Legacy gcc doesn't understand this flag
      ifneq ($(strip $(USE_LEGACY_GCC)),true)
        GRAPHITE_FLAGS += \
          -Wno-error=maybe-uninitialized
      endif
    endif

    # Skip kernel bits if TARGET_SM_KERNEL is not defined.
    ifeq ($(strip $(TARGET_SM_KERNEL_DEFINED)),true)

      # Path to kernel toolchain
      SM_KERNEL_PATH := prebuilts/gcc/$(HOST_PREBUILT_TAG)/aarch64/aarch64-linux-android-$(TARGET_SM_KERNEL)
      SM_KERNEL := $(shell $(SM_KERNEL_PATH)/bin/aarch64-linux-android-gcc --version)

      ifneq ($(filter %sabermod,$(SM_KERNEL)),)
        SM_KERNEL_NAME := $(filter %sabermod,$(SM_KERNEL))
        SM_KERNEL_DATE := $(filter 20140% 20141% 20150% 20151%,$(SM_KERNEL))
        SM_KERNEL_STATUS := $(filter (release) (prerelease) (experimental),$(SM_KERNEL))
        SM_KERNEL_VERSION := $(SM_KERNEL_NAME)-$(SM_KERNEL_DATE)-$(SM_KERNEL_STATUS)

        # Write version info to build.prop
        PRODUCT_PROPERTY_OVERRIDES += \
          ro.sm.kernel=$(SM_KERNEL_VERSION)

        # Graphite flags for kernel
        export GRAPHITE_KERNEL_FLAGS := \
                 -fgraphite \
                 -fgraphite-identity \
                 -floop-flatten \
                 -floop-parallelize-all \
                 -ftree-loop-linear \
                 -floop-interchange \
                 -floop-strip-mine \
                 -floop-block
      endif
    endif
  endif

  # Add extra libs for the compilers to use
  export LD_LIBRARY_PATH := $(TARGET_ARCH_LIB_PATH):$(LD_LIBRARY_PATH)
  export LIBRARY_PATH := $(TARGET_ARCH_LIB_PATH):$(LIBRARY_PATH)

  # Force disable some modules that are not compatible with graphite flags.
  # Add more modules if needed for devices in a device make file somewhere with
  # LOCAL_DISABLE_GRAPHITE:=

  # Check if there's already something set in a device make file somewhere.
  ifndef LOCAL_DISABLE_GRAPHITE
    LOCAL_DISABLE_GRAPHITE := \
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
      libwebviewchromium \
      third_party_libvpx_libvpx_gyp \
      ui_gl_gl_gyp \
      fio
  else
    LOCAL_DISABLE_GRAPHITE += \
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
      libwebviewchromium \
      third_party_libvpx_libvpx_gyp \
      ui_gl_gl_gyp \
      fio
  endif

  # O3 optimizations
  # To enable this set O3_OPTIMIZATIONS=true in a device makefile somewhere.
  ifeq ($(strip $(O3_OPTIMIZATIONS)),true)
    OPT2 := (max)

    # Disable some modules that break with -O3
    # Add more modules if needed for devices in a device make file somewhere with
    # LOCAL_DISABLE_O3 :=

    # Check if there's already something set in a device make file somewhere.
    ifndef LOCAL_DISABLE_O3
      LOCAL_DISABLE_O3 := \
        libaudioflinger \
        libwebviewchromium \
        skia_skia_library_gyp
    else
      LOCAL_DISABLE_O3 += \
        libaudioflinger \
        libwebviewchromium \
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

  # Write gcc optimizations to build.prop
  GCC_OPTIMIZATION_LEVELS := $(OPT1)$(OPT2)$(OPT3)
  ifneq ($(GCC_OPTIMIZATION_LEVELS),)
    PRODUCT_PROPERTY_OVERRIDES += \
      ro.sm.flags=$(GCC_OPTIMIZATION_LEVELS)
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

else
  $(warning ********************************************************************************)
  $(warning *  SaberMod currently only works on linux host systems.)
  $(warning ********************************************************************************)
endif
