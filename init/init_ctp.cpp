/*
 * Copyright 2016, The CyanogenMod Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#define _REALLY_INCLUDE_SYS__SYSTEM_PROPERTIES_H_
#include <sys/_system_properties.h>

#include "log.h"
#include "property_service.h"
#include "util.h"
#include "vendor_init.h"

/* Zram */
#define ZRAM_PROP "ro.config.zram"
#define MEMINFO_FILE "/proc/meminfo"
#define MEMINFO_KEY "MemTotal:"
#define ZRAM_MEM_THRESHOLD 3000000

static void configure_zram() {
	char buf[128];
	FILE *f;

	if ((f = fopen(MEMINFO_FILE, "r")) == NULL) {
		ERROR("%s: Failed to open %s\n", __func__, MEMINFO_FILE);
		return;
	}

	while (fgets(buf, sizeof(buf), f) != NULL) {
		if (strncmp(buf, MEMINFO_KEY, strlen(MEMINFO_KEY)) == 0) {
			int mem = atoi(&buf[strlen(MEMINFO_KEY)]);
			const char *mode = mem < ZRAM_MEM_THRESHOLD ? "true" : "false";
			INFO("%s: Found total memory to be %d kb, zram enabled: %s\n", __func__, mem, mode);
			property_set(ZRAM_PROP, mode);
			break;
		}
	}

	fclose(f);
}


void vendor_load_properties() {
	configure_zram();
}
