include $(TOPDIR)/rules.mk
include ../version.mk

PKG_NAME:=iot-rpcd
PKG_VERSION:=1.0.0_$(strip $(call findrev))
PKG_RELEASE:=1

LOCAL_DEV:=0
ifneq ($(LOCAL_DEV),1)
PKG_SOURCE_PROTO=git
PKG_SOURCE_URL:=https://github.com/ihotray/iot-rpcd.git
PKG_SOURCE_VERSION:=5d1fe6b4bc7f147cc2e4c2e718e57c8c3f463722
PKG_MAINTAINER:=richard.sheh
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz
PKG_MIRROR_HASH:=skip
endif

PKG_LICENSE:=GPL-2.0-only
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/iot-rpcd
	CATEGORY:=IOTWRT
	SUBMENU:=Applications
	TITLE:=iot-rpcd
	DEPENDS:=+libiot +iot-mqtt +liblua +iot-rpc
	MENU:=1
endef

define Package/iot-rpcd/description
	iot-rpcd, a rpcd server for iot devices.
endef

ifeq ($(LOCAL_DEV),1)
define Build/Prepare
	$(CP) -rf ~/git/code/iot-rpcd/* $(PKG_BUILD_DIR)/
endef
endif

define Package/iot-rpcd/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/* $(1)/etc/init.d/
	$(INSTALL_DIR) $(1)/www/iot
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/iot-rpcd $(1)/www/iot
endef

$(eval $(call BuildPackage,iot-rpcd))
