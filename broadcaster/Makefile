include $(TOPDIR)/rules.mk
include ../version.mk

PKG_NAME:=broadcaster
PKG_VERSION:=1.0.0_$(strip $(call findrev))
PKG_RELEASE:=1

LOCAL_DEV:=0
ifneq ($(LOCAL_DEV),1)
PKG_SOURCE_PROTO=git
PKG_SOURCE_URL:=https://github.com/ihotray/broadcaster.git
PKG_SOURCE_VERSION:=7b4f1bd453817fb62bfd6958af9d8d23b743a4a8
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz
PKG_MIRROR_HASH:=skip
endif

PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/broadcaster
	CATEGORY:=IOTWRT
	SUBMENU:=Applications
	TITLE:=broadcaster daemon
	DEPENDS:=+uci +libiot +liblua
	MENU:=1
endef

define Package/broadcaster/description
	broadcaster is a server daemon for service discovery via broadcast.
endef

#CMAKE_OPTIONS:=-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON

ifeq ($(LOCAL_DEV),1)
define Build/Prepare
	$(CP) -rf ~/git/code/broadcaster/* $(PKG_BUILD_DIR)/
endef
endif

define Package/broadcaster/install
	$(INSTALL_DIR) $(1)/etc/config
	$(CP) ./files/etc/config/* $(1)/etc/config/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/* $(1)/etc/init.d/
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/broadcaster $(1)/usr/bin/
endef

$(eval $(call BuildPackage,broadcaster))
