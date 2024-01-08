include $(TOPDIR)/rules.mk
include ../../version.mk

PKG_NAME:=rulengd
PKG_VERSION:=1.2.9_$(strip $(call findrev))
PKG_RELEASE:=1

LOCAL_DEV:=0
ifneq ($(LOCAL_DEV),1)
PKG_SOURCE_PROTO=git
PKG_SOURCE_URL:=https://github.com/ihotray/rulengd.git
PKG_SOURCE_VERSION:=a32e325090d4303fe9aec786f81f0699006d21ab
PKG_MAINTAINER:=richard.sheh
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz
PKG_MIRROR_HASH:=skip
endif

PKG_LICENSE:=GPL-2.0-only
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/rulengd
	CATEGORY:=IOTWRT
	SUBMENU:=Applications
	TITLE:=RuleEngine daemon
	DEPENDS:=+ubox +uci +ubus +libjson-c
	MENU:=1
endef

define Package/rulengd/description
	rulengd listens for events and executes speficied methods if the incoming event arguments contain speficied ones.
endef

#CMAKE_OPTIONS:=-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON

ifeq ($(LOCAL_DEV),1)
define Build/Prepare
	$(CP) -rf ~/git/code/rulengd/* $(PKG_BUILD_DIR)/
endef
endif

define Package/rulengd/install
	$(INSTALL_DIR) $(1)/etc/config $(1)/etc/init.d
	$(CP) ./files/etc/config/* $(1)/etc/config
	$(INSTALL_BIN) ./files/etc/init.d/* $(1)/etc/init.d/
	$(INSTALL_DIR) $(1)/www/iot/config $(1)/www/iot/handler
	$(CP) ./files/www/iot/config/* $(1)/www/iot/config
	$(INSTALL_BIN) ./files/www/iot/handler/* $(1)/www/iot/handler/
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/rulengd $(1)/usr/bin/
endef

$(eval $(call BuildPackage,rulengd))
