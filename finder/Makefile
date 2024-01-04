include $(TOPDIR)/rules.mk
include ../version.mk

PKG_NAME:=finder
PKG_VERSION:=1.0.0_$(strip $(call findrev))
PKG_RELEASE:=1

LOCAL_DEV:=0
ifneq ($(LOCAL_DEV),1)
PKG_SOURCE_PROTO=git
PKG_SOURCE_URL:=https://github.com/ihotray/finder.git
PKG_SOURCE_VERSION:=54fd2e54345e9c42d1a2d8f86acacdc95afe5dd4
PKG_MAINTAINER:=richard.sheh
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz
PKG_MIRROR_HASH:=skip
endif

PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/finder
	CATEGORY:=IOTWRT
	SUBMENU:=Applications
	TITLE:=finder daemon
	DEPENDS:=+uci +libiot +liblua
	MENU:=1
endef

define Package/finder/description
	finder is a client daemon for service discovery via broadcast.
endef

#CMAKE_OPTIONS:=-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON

ifeq ($(LOCAL_DEV),1)
define Build/Prepare
	$(CP) -rf ~/git/code/finder/* $(PKG_BUILD_DIR)/
endef
endif

define Package/finder/install
	$(INSTALL_DIR) $(1)/etc/config
	$(CP) ./files/etc/config/* $(1)/etc/config/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/* $(1)/etc/init.d/
	$(INSTALL_DIR) $(1)/www/iot
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/finder $(1)/www/iot
endef

$(eval $(call BuildPackage,finder))
