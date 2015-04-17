<<<<<<< HEAD
PRODUCT_MAKEFILES := \
        $(LOCAL_DIR)/xenonhd_bacon.mk \
	$(LOCAL_DIR)/xenonhd_crespo.mk \
	$(LOCAL_DIR)/xenonhd_d2spr.mk \
	$(LOCAL_DIR)/xenonhd_d2bst.mk \
	$(LOCAL_DIR)/xenonhd_d2att.mk \
 	$(LOCAL_DIR)/xenonhd_d2tmo.mk \
 	$(LOCAL_DIR)/xenonhd_d2usc.mk \
 	$(LOCAL_DIR)/xenonhd_d2vzw.mk \
	$(LOCAL_DIR)/xenonhd_e975.mk \
	$(LOCAL_DIR)/xenonhd_endeavoru.mk \
	$(LOCAL_DIR)/xenonhd_find5.mk \
	$(LOCAL_DIR)/xenonhd_find7.mk \
	$(LOCAL_DIR)/xenonhd_flo.mk \
	$(LOCAL_DIR)/xenonhd_galaxysmtd.mk \
	$(LOCAL_DIR)/xenonhd_grouper.mk \
	$(LOCAL_DIR)/xenonhd_hammerhead.mk \
	$(LOCAL_DIR)/xenonhd_hammerheadcaf.mk \
	$(LOCAL_DIR)/xenonhd_honami.mk \
	$(LOCAL_DIR)/xenonhd_i605.mk \
	$(LOCAL_DIR)/xenonhd_i9100.mk \
	$(LOCAL_DIR)/xenonhd_i9100g.mk \
	$(LOCAL_DIR)/xenonhd_i9300.mk \
	$(LOCAL_DIR)/xenonhd_i9305.mk \
	$(LOCAL_DIR)/xenonhd_jflte.mk \
	$(LOCAL_DIR)/xenonhd_l900.mk \
	$(LOCAL_DIR)/xenonhd_m7.mk \
	$(LOCAL_DIR)/xenonhd_m8.mk \
	$(LOCAL_DIR)/xenonhd_maguro.mk \
	$(LOCAL_DIR)/xenonhd_mako.mk \
	$(LOCAL_DIR)/xenonhd_mb886.mk \
	$(LOCAL_DIR)/xenonhd_m7tmo.mk \
	$(LOCAL_DIR)/xenonhd_n7000.mk \
	$(LOCAL_DIR)/xenonhd_n7100.mk \
	$(LOCAL_DIR)/xenonhd_r950.mk \
	$(LOCAL_DIR)/xenonhd_shamu.mk \
	$(LOCAL_DIR)/xenonhd_t0lte.mk \
	$(LOCAL_DIR)/xenonhd_t0lteatt.mk \
	$(LOCAL_DIR)/xenonhd_t0ltetmo.mk \
	$(LOCAL_DIR)/xenonhd_tilapia.mk \
	$(LOCAL_DIR)/xenonhd_toro.mk \
	$(LOCAL_DIR)/xenonhd_toroplus.mk \
	$(LOCAL_DIR)/xenonhd_trltetmo.mk \
	$(LOCAL_DIR)/xenonhd_trltexx.mk \
	$(LOCAL_DIR)/xenonhd_vigor.mk \
	$(LOCAL_DIR)/xenonhd_xt925.mk \
	$(LOCAL_DIR)/xenonhd_xt926.mk \
	$(LOCAL_DIR)/xenonhd_xt907.mk
=======
# Copyright (C) 2013 ParanoidAndroid Project
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

include vendor/pa/configs/sm_clear_vars.mk

ifeq (pa_deb,$(TARGET_PRODUCT))
    PRODUCT_MAKEFILES += $(LOCAL_DIR)/pa_deb.mk
endif
ifeq (pa_flo,$(TARGET_PRODUCT))
    PRODUCT_MAKEFILES += $(LOCAL_DIR)/pa_flo.mk
endif
ifeq (pa_flounder,$(TARGET_PRODUCT))
    PRODUCT_MAKEFILES += $(LOCAL_DIR)/pa_flounder.mk
endif
ifeq (pa_grouper,$(TARGET_PRODUCT))
    PRODUCT_MAKEFILES += $(LOCAL_DIR)/pa_grouper.mk
endif
ifeq (pa_hammerhead,$(TARGET_PRODUCT))
    PRODUCT_MAKEFILES += $(LOCAL_DIR)/pa_hammerhead.mk
endif
ifeq (pa_mako,$(TARGET_PRODUCT))
    PRODUCT_MAKEFILES += $(LOCAL_DIR)/pa_mako.mk
endif
ifeq (pa_manta,$(TARGET_PRODUCT))
    PRODUCT_MAKEFILES += $(LOCAL_DIR)/pa_manta.mk
endif
ifeq (pa_shamu,$(TARGET_PRODUCT))
    PRODUCT_MAKEFILES += $(LOCAL_DIR)/pa_shamu.mk
endif
ifeq (pa_tilapia,$(TARGET_PRODUCT))
    PRODUCT_MAKEFILES += $(LOCAL_DIR)/pa_tilapia.mk
endif

>>>>>>> 80d7837... Fix build for hammerhead, create sm_clear_vars.mk and add -pipe
