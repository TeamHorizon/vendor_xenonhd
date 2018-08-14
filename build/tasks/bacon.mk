# Copyright (C) 2017 XenonHD Project
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

# -----------------------------------------------------------------
# XenonHD OTA update package

XENONHD_PACKAGE := $(XENONHD_VERSION)-$(TARGET_DEVICE).zip
XENONHD_TARGET_PACKAGE := $(PRODUCT_OUT)/$(XENONHD_PACKAGE)

.PHONY: bacon
bacon: $(INTERNAL_OTA_PACKAGE_TARGET)
	$(hide) ./vendor/xenonhd/build/tools/ota
	$(hide) rm -rf $(PRODUCT_OUT)/XenonHD*
	$(hide) ln -f $(INTERNAL_OTA_PACKAGE_TARGET) $(XENONHD_TARGET_PACKAGE)
	$(hide) $(MD5SUM) $(XENONHD_TARGET_PACKAGE) | sed "s|$(PRODUCT_OUT)/||" > $(XENONHD_TARGET_PACKAGE).md5sum
	$(hide) rm -rf $(INTERNAL_OTA_PACKAGE_TARGET)
	@echo "$(XENONHD_TARGET_PACKAGE)"
	@echo -e "\a\n================-Package complete-================"
	@echo "file: $(XENONHD_PACKAGE)"
	@echo "md5: $(shell cat $(XENONHD_TARGET_PACKAGE).md5sum | awk '{ print $$1 }')"
	@echo "size: $(shell ls -lah $(XENONHD_TARGET_PACKAGE) | awk '{ print $$5 }')"
	@echo -e "==================================================\n"
