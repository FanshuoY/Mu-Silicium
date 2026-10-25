##
#  Copyright (c) 2011 - 2022, ARM Limited. All rights reserved.
#  Copyright (c) 2014, Linaro Limited. All rights reserved.
#  Copyright (c) 2015 - 2020, Intel Corporation. All rights reserved.
#  Copyright (c) 2018, Bingxing Wang. All rights reserved.
#  Copyright (c) Microsoft Corporation.
#
#  SPDX-License-Identifier: BSD-2-Clause-Patent
##
#
#  OnePlus Ace 2 Pro (breeze) - SM8550 / Snapdragon 8 Gen 2
#  Ported from OnePlus 12R / Ace 3 (aston) by Project-Silicium.
#  NOTE: values tagged "TODO(verify)" are provisional and must be confirmed
#        against the real device (getprop / partition dump) before flashing.
##

[Defines]
  PLATFORM_NAME                  = breeze
  PLATFORM_GUID                  = 7C3E9B2A-4D71-4F8B-9A6C-2E15B8D03F47
  PLATFORM_VERSION               = 0.1
  DSC_SPECIFICATION              = 0x00010005
  OUTPUT_DIRECTORY               = Build/breezePkg
  SUPPORTED_ARCHITECTURES        = AARCH64
  BUILD_TARGETS                  = RELEASE|DEBUG
  SKUID_IDENTIFIER               = DEFAULT
  FLASH_DEFINITION               = breezePkg/breeze.fdf
  USE_CUSTOM_DISPLAY_DRIVER      = 1

  #
  # 0 = SM8550-AB (confirmed: ro.soc.model = SM8550, standard 3.2 GHz)
  # 1 = SM8550-AC (3.36 GHz, for Galaxy)
  #
  SOC_TYPE                       = 0

!include KailuaPkg/KailuaPkg.dsc.inc

[PcdsFixedAtBuild]
  #
  # DDR Memory
  #
  gArmTokenSpaceGuid.PcdSystemMemoryBase|0x80000000

  #
  # UEFI Stack (TODO(verify): confirm against device memory map)
  #
  gArmPlatformTokenSpaceGuid.PcdCPUCoresStackBase|0xA760D000
  gArmPlatformTokenSpaceGuid.PcdCPUCorePrimaryStackSize|0x40000

  #
  # SMBIOS  (values confirmed from device getprop)
  #   ro.product.device     = OP64E1L1
  #   ro.product.name       = PYB110
  #   ro.product.model      = PYB110
  #   ro.boot.prjname       = 22851
  #   ro.board.platform     = kalama
  #   ro.soc.model          = SM8550
  #   wm size               = 1240x2772
  # NOTE: "breeze" is only this scaffold's working name, not the device codename.
  #
  gSiliciumPkgTokenSpaceGuid.PcdSmbiosSystemManufacturer|"OnePlus"
  gSiliciumPkgTokenSpaceGuid.PcdSmbiosSystemModel|"Ace 2 Pro"
  gSiliciumPkgTokenSpaceGuid.PcdSmbiosSystemRetailModel|"OP64E1L1"
  gSiliciumPkgTokenSpaceGuid.PcdSmbiosSystemRetailSku|"PYB110"
  gSiliciumPkgTokenSpaceGuid.PcdSmbiosSystemBoardModel|"22851"

  #
  # Simple Frame Buffer (confirmed: adb "wm size" = 1240x2772)
  #
  gSiliciumPkgTokenSpaceGuid.PcdFrameBufferWidth|1240
  gSiliciumPkgTokenSpaceGuid.PcdFrameBufferHeight|2772
  gSiliciumPkgTokenSpaceGuid.PcdFrameBufferColorDepth|32

  #
  # Platform PEI
  #
  gQcomPkgTokenSpaceGuid.PcdPlatformType|"LA"

[LibraryClasses]
  #
  # Memory Libraries
  #
  MemoryMapLib|breezePkg/Library/MemoryMapLib/MemoryMapLib.inf

  #
  # QCOM Libraries
  #
  ConfigurationMapLib|breezePkg/Library/ConfigurationMapLib/ConfigurationMapLib.inf

[Components]
  #
  # ACPI Tables
  #
  breeze/AcpiTables.inf
