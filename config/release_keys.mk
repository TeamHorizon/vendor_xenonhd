# Whether using or not release-keys for building
# Copyright (C) 2018-2019 KudProject Development
# Copyright (C) 2018-2019 XenonHD Project
# SPDX-License-Identifier: Apache-2.0

# Don't modify; path where release-keys are hosted
RELEASE_KEYS_PATH := vendor/xenonhd/keys

# Make sure we're building Official
ifneq ($(filter Experimental Official,$(OTA_TYPE)),)
    # Whether release-keys path is exist or not
    ifneq ($(wildcard $(RELEASE_KEYS_PATH)),)
        # Exists, use them
        ifeq ($(USE_RELEASE_KEYS_SIGNING_HACK),true)
            # Using signing hack
            PRODUCT_DEFAULT_DEV_CERTIFICATE := $(RELEASE_KEYS_PATH)/testkey

            # Clear this to avoid unexpected behavior
            USE_RELEASE_KEYS :=
        else
            # Default
            USE_RELEASE_KEYS := true
        endif
    else
        # Doesn't exist, fall back to test-keys
        $(warn $(RELEASE_KEYS_PATH) doesn't exist. Continuing with test-keys...)
    endif
endif
