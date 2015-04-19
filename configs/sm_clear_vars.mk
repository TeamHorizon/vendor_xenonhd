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

# Clear SaberMod variables
$(shell unset EXTRA_SABERMOD_GCC_CFLAGS)
$(shell unset GRAPHITE_KERNEL_FLAGS)
$(shell unset KERNEL_STRICT_FLAGS)

ifeq (pa_hammerhead,$(TARGET_PRODUCT))
  $(shell unset CONFIG_MACH_MSM8974_HAMMERHEAD_STRICT_ALIASING)
endif
