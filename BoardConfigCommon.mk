#
# Copyright 2016 The Android Open-Source Project
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

TARGET_NO_RECOVERY := true

TARGET_ARCH := x86
TARGET_ARCH_VARIANT := atom
TARGET_CPU_ABI := x86
TARGET_CPU_ABI2 := armeabi-v7a
TARGET_CPU_ABI_LIST := x86,armeabi-v7a,armeabi
TARGET_CPU_ABI_LIST_32_BIT := x86,armeabi-v7a,armeabi
TARGET_KERNEL_CROSS_COMPILE_PREFIX := x86_64-linux-android-
TARGET_BOARD_PLATFORM := clovertrail
TARGET_BOOTLOADER_BOARD_NAME := clovertrail
TARGET_USERIMAGES_USE_EXT4 := true

TARGET_DROIDBOOT_LIBS := libintel_droidboot

# ADB
BOARD_FUNCTIONFS_HAS_SS_COUNT := true

# NFC
BOARD_HAVE_NFC := false

# Audio
BOARD_USES_ALSA_AUDIO := true
BUILD_WITH_ALSA_UTILS := true
BOARD_USES_TINY_ALSA_AUDIO := true
BOARD_USES_AUDIO_HAL_CONFIGURABLE := true

# ALAC CODEC
USE_FEATURE_ALAC := true

# Binder API version
TARGET_USES_64_BIT_BINDER := true

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/asus/ctp-common/bluetooth

# Bootloader
TARGET_OTA_ASSERT_DEVICE := T00F,T00G,Z002,ASUS_T00F,ASUS_T00G,ASUS_Z002

# Skip some proccess to speed up build
BOARD_SKIP_ANDROID_DOC_BUILD := true
BUILD_EMULATOR := false

# Charger
BOARD_CHARGER_ENABLE_SUSPEND := true
BOARD_CHARGER_SHOW_PERCENTAGE := true
BOARD_HEALTHD_CUSTOM_CHARGER_RES := device/asus/ctp-common/charger/images

# Dex-preoptimization: Speeds up initial boot
WITH_DEXPREOPT := true

# Hardware
BOARD_HARDWARE_CLASS += device/asus/ctp-common/cmhw

# Healthd
BOARD_HAL_STATIC_LIBRARIES := libhealthd.clovertrail

# Houdini: enable ARM codegen for x86
BUILD_ARM_FOR_X86 := true

# IMG graphics
ENABLE_IMG_GRAPHICS := true
COMMON_GLOBAL_CFLAGS += -DASUS_ZENFONE2_LP_BLOBS
HWUI_IMG_FBO_CACHE_OPTIM := true

# IMG Graphics: System's VSYNC phase offsets in nanoseconds
VSYNC_EVENT_PHASE_OFFSET_NS := 7500000
SF_VSYNC_EVENT_PHASE_OFFSET_NS := 5000000

COMMON_GLOBAL_CFLAGS += -DWORKAROUND_BUG_10194508
BOARD_EGL_CFG := device/asus/ctp-common/blobs/raw/egl.cfg

ADDITIONAL_DEFAULT_PROPERTIES += \
    ro.opengles.version=131072

MAX_EGL_CACHE_ENTRY_SIZE := 65536
MAX_EGL_CACHE_SIZE := 1048576
COMMON_GLOBAL_CFLAGS += -DGFX_BUF_EXT

# enabled to carry out all drawing operations performed on a View's canvas with GPU for 2D rendering pipeline.
USE_OPENGL_RENDERER := true

# Disable an optimization that causes rendering issues for us
TARGET_REQUIRES_SYNCHRONOUS_SETSURFACE := true

# Init
TARGET_INIT_VENDOR_LIB := libinit_ctp
TARGET_LIBINIT_DEFINES_FILE := device/asus/ctp-common/init/init_ctp.cpp

# SELinux
HAVE_SELINUX := false

# Boot Image / OTA Package
USE_OSIP := true
REF_PRODUCT_NAME := redhookbay
BOARD_CANT_BUILD_RECOVERY_FROM_BOOT_PATCH := true
TARGET_RECOVERY_PIXEL_FORMAT := "BGRA_8888"
COMMON_GLOBAL_CFLAGS += -DNO_SECURE_DISCARD
NEED_KERNEL_MODULE_ROOT := true

BOARD_CUSTOM_BOOTIMG := true
BOARD_CUSTOM_BOOTIMG_MK := device/asus/ctp-common/kernel/mkbootimg.mk

TARGET_PREBUILT_KERNEL := device/asus/ctp-common/kernel/blobs/kernel
DEVICE_BASE_BOOT_IMAGE := device/asus/ctp-common/kernel/blobs/boot.img
BOARD_KERNEL_CMDLINE := init=/init pci=noearly earlyprintk=nologger loglevel=0 kmemleak=off androidboot.bootmedia=sdcard androidboot.hardware=redhookbay watchdog.watchdog_thresh=60 androidboot.spid=xxxx:xxxx:xxxx:xxxx:xxxx:xxxx androidboot.serialno=01234567890123456789 ip=50.0.0.2:50.0.0.1::255.255.255.0::usb0:on vmalloc=172M slub_max_order=2

TARGET_RECOVERY_FSTAB := device/asus/ctp-common/blobs/raw/ota.fstab
TARGET_RECOVERY_UPDATER_LIBS += libintel_updater

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE := 16777216
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1363148800
BOARD_FLASH_BLOCK_SIZE := 131072

# PowerHAL
TARGET_POWERHAL_VARIANT := clovertrail

# Radio
BOARD_PROVIDES_LIBRIL := true

# MultiDisplay
TARGET_USE_DUMMY_MULTIPLE_DISPLAY := false
TARGET_HAS_MULTIPLE_DISPLAY := true
USE_MDS_LEGACY := true

# Font
EXTENDED_FONT_FOOTPRINT := true

# Double-Tap-To-Wake
TARGET_TAP_TO_WAKE_NODE := "/sys/devices/pci0000:00/0000:00:00.3/i2c-0/0-0020/input/input1/dclick_mode"

# StageFright
BUILD_WITH_FULL_STAGEFRIGHT := true
ENABLE_IMG_GRAPHICS := true

# OpenMAX Interaction Layer Implementation for Intel VA API
BOARD_USES_MRST_OMX := true
BOARD_USES_WRS_OMXIL_CORE := true
TARGET_HAS_ISV := false

# Video Acceleration API for Video Encoding and Decoding
INTEL_VA := true
BOARD_USE_LIBVA := true
BOARD_USE_LIBVA_INTEL_DRIVER := true
USE_INTEL_SECURE_AVC := true

# Intel Moorestown Mix Library
BOARD_USE_LIBMIX := true

# Minikin Text Layout Engine
USE_MINIKIN := true

# HWcomposer
BOARD_USES_HWCOMPOSER := true
INTEL_HWC := true
TARGET_SUPPORT_HWC_SYS_LAYER := true

# Wi-Fi
BOARD_WLAN_DEVICE           := bcmdhd
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_HOSTAPD_PRIVATE_LIB   := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
WPA_SUPPLICANT_VERSION      := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_HOSTAPD_DRIVER        := NL80211
WIFI_DRIVER_FW_PATH_PARAM   := "/sys/module/bcm43362/parameters/firmware_path"
WIFI_DRIVER_FW_PATH_AP      := "/system/etc/firmware/fw_bcmdhd_43362_apsta.bin"
WIFI_DRIVER_FW_PATH_STA     := "/system/etc/firmware/fw_bcmdhd_43362.bin"
WIFI_DRIVER_MODULE_ARG      := "iface_name=wlan0 firmware_path=/system/etc/firmware/fw_bcmdhd_43362.bin"

# Use the non-open-source parts, if they're present
-include vendor/asus/ctp-common/BoardConfigVendor.mk
