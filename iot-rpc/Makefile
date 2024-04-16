include $(TOPDIR)/rules.mk
include ../version.mk

PKG_NAME:=iot-rpc
PKG_VERSION:=1.0.0_$(strip $(call findrev))
PKG_RELEASE:=1

LOCAL_DEV:=0
ifneq ($(LOCAL_DEV),1)
PKG_SOURCE_PROTO=git
PKG_SOURCE_URL:=https://github.com/ihotray/iot-rpc.git
PKG_SOURCE_VERSION:=6fad100323ec2c7759aa4ac9047e1970df3d59d5
PKG_MAINTAINER:=richard.sheh
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz
PKG_MIRROR_HASH:=skip
endif

PKG_LICENSE:=GPL-2.0-only
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/iot-rpc
	CATEGORY:=IOTWRT
	SUBMENU:=Applications
	TITLE:=iot-rpc
	DEPENDS:=+lua-cjson +liblua +libuci-lua +libubus-lua +luaposix
	MENU:=1
endef

define Package/iot-rpc/description
	iot-rpc, a rpc function set for iot devices.
endef

ifeq ($(LOCAL_DEV),1)
define Build/Prepare
	$(CP) -rf ~/git/code/iot-rpc/* $(PKG_BUILD_DIR)/
endef
endif

MAKE_PATH:=lib

define Package/iot-rpc/install
	$(INSTALL_DIR) $(1)/etc/config
	$(CP) ./files/etc/config/* $(1)/etc/config/
	$(INSTALL_DIR) $(1)/www/iot $(1)/usr/lib/lua/iot/internal $(1)/usr/share/iot
	$(CP) $(PKG_BUILD_DIR)/files/iot-rpc.lua $(1)/www/iot
	$(CP) $(PKG_BUILD_DIR)/files/test-iot-rpc.lua $(1)/www/iot
	$(CP) $(PKG_BUILD_DIR)/files/lua/iot $(1)/usr/lib/lua
	$(CP) $(PKG_BUILD_DIR)/files/lua/rpc $(1)/usr/share/iot
	$(CP) $(PKG_BUILD_DIR)/lib/md5.so $(1)/usr/lib/lua/iot
	$(CP) $(PKG_BUILD_DIR)/lib/fs.so $(1)/usr/lib/lua/iot/internal
	$(CP) $(PKG_BUILD_DIR)/lib/network.so $(1)/usr/lib/lua/iot/internal
endef

$(eval $(call BuildPackage,iot-rpc))
