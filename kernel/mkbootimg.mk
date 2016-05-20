# Copyright (C) 2016 The CyanogenMod Project
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

INTEL_PACK := $(HOST_OUT_EXECUTABLES)/pack_intel$(HOST_EXECUTABLE_SUFFIX)
BASE_BOOT_IMAGE := $(DEVICE_BASE_BOOT_IMAGE)
INSTALLED_KERNEL_TARGET ?= $(PRODUCT_OUT)/kernel
recovery_kernel ?= $(PRODUCT_OUT)/kernel
cmdline := $(PRODUCT_OUT)/cmdline

$(INSTALLED_BOOTIMAGE_TARGET): $(MKBOOTIMG) \
		$(INSTALLED_KERNEL_TARGET) \
		$(INSTALLED_RAMDISK_TARGET)
	$(call pretty,"Target boot image: $@")
	@echo -e ${CL_CYN}"----- Copying Required Files ------"${CL_RST}
	cp -f device/asus/ctp-common/kernel/blobs/kernel $(PRODUCT_OUT)/kernel
	@echo -e ${CL_CYN}"----- Removing Previous Files ------"${CL_RST}
	rm -f $(PRODUCT_OUT)/ramdisk.cpio
	rm -f $(PRODUCT_OUT)/ramdisk.cpio.gz
	@echo -e ${CL_CYN}"----- Exporting Command Line ------"${CL_RST}
	@echo $(BOARD_KERNEL_CMDLINE) > $(PRODUCT_OUT)/cmdline
	@echo -e ${CL_CYN}"----- Removing Build-Generated Ramdisk Image ------"${CL_RST}
	rm -f $(PRODUCT_OUT)/ramdisk.img
	@echo -e ${CL_CYN}"----- Removing SELinux Configurations from Ramdisk ------"${CL_RST}
	rm -f $(PRODUCT_OUT)/root/property_contexts
	rm -f $(PRODUCT_OUT)/root/seapp_contexts
	rm -f $(PRODUCT_OUT)/root/selinux_version
	rm -f $(PRODUCT_OUT)/root/sepolicy
	rm -f $(PRODUCT_OUT)/root/service_contexts
	@echo -e ${CL_CYN}"----- Moving Temporarily SELinux Configuration to out of Ramdisk ------"${CL_RST}
	mv $(PRODUCT_OUT)/root/file_contexts $(PRODUCT_OUT)/file_contexts
	@echo -e ${CL_CYN}"----- Creating Needed Symlinks ------"${CL_RST}
	ln -s /init $(PRODUCT_OUT)/root/sbin/ueventd
	ln -s /init $(PRODUCT_OUT)/root/sbin/watchdogd
	@echo -e ${CL_CYN}"----- Resetting File Timestamps ------"${CL_RST}
	@echo -e ${CL_CYN}"NOTE: Please make sure your timezone is set to GMT. This way the UNIX timestamp of the files will be equal to 0 (zero)"${CL_RST}
	find $(PRODUCT_OUT)/root/ -exec touch -a -m -d "19700101" {} +
	@echo -e ${CL_CYN}"----- Generating Boot Image ------"${CL_RST}
	$(INTEL_PACK) $(BASE_BOOT_IMAGE) $(INSTALLED_KERNEL_TARGET) $(INSTALLED_RAMDISK_TARGET) $@
	@echo -e ${CL_CYN}"----- Moving Back SELinux Configuration to Ramdisk ------"${CL_RST}
	mv $(PRODUCT_OUT)/file_contexts $(PRODUCT_OUT)/root/file_contexts
	@echo -e ${CL_CYN}"Install boot os image: $@"${CL_RST}
	$(hide) $(call assert-max-image-size,$@,$(BOARD_BOOTIMAGE_PARTITION_SIZE))
