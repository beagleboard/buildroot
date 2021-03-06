################################################################################
#
# beaglev-secondboot
#
################################################################################

# Commit on the 'starfive' branch
BEAGLEV_SECONDBOOT_VERSION = e976d186e69a1a84884265b0689626fa254a950d
BEAGLEV_SECONDBOOT_SITE = $(call github,starfive-tech,beagle_secondBoot,$(BEAGLEV_SECONDBOOT_VERSION))
BEAGLEV_SECONDBOOT_INSTALL_TARGET = NO
BEAGLEV_SECONDBOOT_INSTALL_IMAGES = YES
BEAGLEV_SECONDBOOT_DEPENDENCIES = host-riscv64-elf-toolchain
# unfortunately, no real license file, but several sources files are
# under GPL-2.0+, making the whole work GPL-2.0+
BEAGLEV_SECONDBOOT_LICENSE = GPL-2.0+

define BEAGLEV_SECONDBOOT_BUILD_CMDS
	$(MAKE) -C $(@D)/build \
		CROSSCOMPILE=$(HOST_DIR)/bin/riscv64-unknown-elf- \
		SUFFIX=buildroot \
		GIT_VERSION=$(BEAGLEV_SECONDBOOT_VERSION)
endef

define BEAGLEV_SECONDBOOT_INSTALL_IMAGES_CMDS
	$(INSTALL) -D -m 0644 $(@D)/build/bootloader-BEAGLEV-buildroot.bin.out \
		$(BINARIES_DIR)/bootloader-BEAGLEV-buildroot.bin.out
endef

$(eval $(generic-package))
