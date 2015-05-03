# Copyright (C) 2015 The SaberMod Project
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

# Find host os
UNAME := $(shell uname -s)

ifeq ($(strip $(UNAME)),Linux)
  HOST_OS := linux
endif

# Only use these compilers on linux host.
ifeq ($(strip $(HOST_OS)),linux)

  # Sabermod configs
    # Custom Toolchains can be switched in build/core/sabermod/ELECTRIFY.mk
    include $(BUILD_SYSTEM)/sabermod/ELECTRIFY.mk
  PRODUCT_THREADS := 4

  GRAPHITE_KERNEL_FLAGS := \
    -floop-parallelize-all \
    -ftree-parallelize-loops=$(PRODUCT_THREADS) \
    -fopenmp

  # strict-aliasing kernel flags
  export KERNEL_STRICT_FLAGS := \
           -fstrict-aliasing \
           -Werror=strict-aliasing
endif

# General flags for gcc 4.9 to allow compilation to complete.
MAYBE_UNINITIALIZED := \
  hwcomposer.msm8974

# Extra SaberMod GCC C flags for arch target and Kernel
export EXTRA_SABERMOD_GCC_CFLAGS := \
         -ftree-vectorize \
         -mvectorize-with-neon-quad \
         -pipe

# Flags that should only be used with -O3 optimizations on arch target gcc.
ifneq ($(strip $(O3_OPTIMIZATIONS)),false)
export EXTRA_SABERMOD_GCC_O3_CFLAGS := \
         -ftree-loop-distribution \
         -ftree-loop-if-convert \
         -ftree-loop-im \
         -ftree-loop-ivcanon \
         -fprefetch-loop-arrays 
endif

# Extra SaberMod CLANG C flags
EXTRA_SABERMOD_CLANG_CFLAGS := \
  -ftree-vectorize \
  -pipe

# Flags that should only be used with -O3 optimizations on clang.
ifneq ($(strip $(O3_OPTIMIZATIONS)),false)
  EXTRA_SABERMOD_CLANG_O3_CFLAGS := -fprefetch-loop-arrays
endif

OPT4 := (extra)

LOCAL_DISABLE_STRICT_ALIASING := \
  libmmcamera_interface\
  camera.hammerhead

