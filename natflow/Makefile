#
# Copyright (C) 2017-2019 Chen Minqiang <ptpt52@gmail.com>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include ../version.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=natflow
PKG_VERSION:=20240104_$(strip $(call findrev))
PKG_RELEASE:=1

LOCAL_DEV:=0
ifneq ($(LOCAL_DEV),1)
PKG_SOURCE_PROTO=git
PKG_SOURCE_URL:=https://github.com/ihotray/natflow.git
PKG_SOURCE_VERSION:=d240163aab32cc95a060cac35cf5038607dd27c2
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz
PKG_MIRROR_HASH:=skip
endif

PKG_MAINTAINER:=Chen Minqiang <ptpt52@gmail.com>
PKG_LICENSE:=GPL-2.0

include $(INCLUDE_DIR)/package.mk

define KernelPackage/natflow
  CATEGORY:=IOTWRT
  SUBMENU:=Modules
  TITLE:=Natflow kernel driver
  KCONFIG:= \
	    CONFIG_NF_CONNTRACK_MARK=y \
	    CONFIG_NETFILTER_INGRESS=y
  FILES:=$(PKG_BUILD_DIR)/natflow.ko
  AUTOLOAD:=$(call AutoLoad,96,natflow)
  DEPENDS:= +kmod-ipt-conntrack +kmod-ipt-nat +kmod-ipt-ipset +kmod-br-netfilter +LINUX_5_4:kmod-nf-flow
endef

define KernelPackage/natflow/description
  fast nat forward kmod
endef

ifeq ($(LOCAL_DEV),1)
define Build/Prepare
	$(CP) -rf ~/git/code/natflow/* $(PKG_BUILD_DIR)/
endef
endif

include $(INCLUDE_DIR)/kernel-defaults.mk

EXTRA_CFLAGS += -DCONFIG_NATFLOW_PATH -DCONFIG_NATFLOW_URLLOGGER
ifneq ($(CONFIG_TARGET_mediatek_mt7622),)
EXTRA_CFLAGS += -DCONFIG_HWNAT_EXTDEV_USE_VLAN_HASH
endif

define Build/Compile/natflow
	+$(MAKE) $(PKG_JOBS) -C "$(LINUX_DIR)" \
		EXTRA_CFLAGS="$(EXTRA_CFLAGS)" \
		$(KERNEL_MAKE_FLAGS) \
		ARCH="$(LINUX_KARCH)" \
		CROSS_COMPILE="$(KERNEL_CROSS)" \
		M="$(PKG_BUILD_DIR)" \
		$(if $(CONFIG_KERNEL_DEBUG_INFO),,NO_DEBUG=1) \
		modules
endef

define Build/Compile
	$(call Build/Compile/natflow)
endef

define Package/natflow-boot
  CATEGORY:=IOTWRT
  SUBMENU:=Modules
  TITLE:=Natflow boot init script
  DEPENDS:= +kmod-natflow
endef

define Package/natflow-boot/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/natflow-boot $(1)/etc/init.d/natflow-boot
	$(INSTALL_DIR) $(1)/etc/hotplug.d/iface
	$(INSTALL_BIN) ./files/etc/hotplug.d/iface/21-natflow-boot $(1)/etc/hotplug.d/iface/21-natflow-boot
	$(INSTALL_DIR) $(1)/lib/preinit
	$(INSTALL_BIN) ./files/lib/preinit/95_natflow-boot $(1)/lib/preinit/95_natflow-boot
endef

define Package/natflow-auth
  CATEGORY:=IOTWRT
  SUBMENU:=Modules
  TITLE:=Natflow auth init script
  DEPENDS:= +kmod-natflow +ipset
endef

define Package/natflow-auth/conffiles
/etc/config/natflow
endef

define Package/natflow-auth/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/natflow-simple-qos $(1)/etc/init.d/natflow-simple-qos
	$(INSTALL_BIN) ./files/etc/init.d/natflow-qos $(1)/etc/init.d/natflow-qos
	$(INSTALL_BIN) ./files/etc/init.d/natflow-user $(1)/etc/init.d/natflow-user
	$(INSTALL_BIN) ./files/etc/init.d/natflow-zone $(1)/etc/init.d/natflow-zone
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./files/etc/config/natflow $(1)/etc/config/natflow
	$(INSTALL_DIR) $(1)/etc/hotplug.d/iface
	$(INSTALL_BIN) ./files/etc/hotplug.d/iface/20-natflow-zone $(1)/etc/hotplug.d/iface/20-natflow-zone
	$(INSTALL_DIR) $(1)/usr/share/natflow
	$(INSTALL_DATA) ./files/usr/share/natflow/ipops.lua $(1)/usr/share/natflow/ipops.lua
endef

$(eval $(call KernelPackage,natflow))
$(eval $(call BuildPackage,natflow-boot))
$(eval $(call BuildPackage,natflow-auth))