include $(TOPDIR)/rules.mk
include ../version.mk

PKG_NAME:=iot-finder
PKG_VERSION:=1.0.0_$(strip $(call findrev))
PKG_RELEASE:=1

LOCAL_DEV:=0
ifneq ($(LOCAL_DEV),1)
PKG_SOURCE_PROTO=git
PKG_SOURCE_URL:=https://github.com/ihotray/iot-finder.git
PKG_SOURCE_VERSION:=545ace9ebb020c8744e4d80059a288f747145e49
PKG_MAINTAINER:=richard.sheh
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz
PKG_MIRROR_HASH:=skip
endif

PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/iot-finder
	CATEGORY:=IOTWRT
	SUBMENU:=Applications
	TITLE:=iot-finder daemon
	DEPENDS:=+uci +libiot +liblua
	MENU:=1
endef

define Package/iot-finder/description
	iot-finder is a client daemon for service discovery via broadcast.
endef

define Package/iot-finder/conffiles
/etc/config/iot-finder
endef

#CMAKE_OPTIONS:=-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON

ifeq ($(LOCAL_DEV),1)
define Build/Prepare
	$(CP) -rf ~/git/code/iot-finder/* $(PKG_BUILD_DIR)/
endef
endif

define Package/iot-finder/install
	$(INSTALL_DIR) $(1)/etc/config
	$(CP) ./files/etc/config/* $(1)/etc/config/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/* $(1)/etc/init.d/
	$(INSTALL_DIR) $(1)/www/iot/handler
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/iot-finder $(1)/www/iot
	$(CP) ./files/www/iot/handler/* $(1)/www/iot/handler
endef

$(eval $(call BuildPackage,iot-finder))
