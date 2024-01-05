include $(TOPDIR)/rules.mk
include ../version.mk

PKG_NAME:=apmgr
PKG_VERSION:=1.0.0_$(strip $(call findrev))
PKG_RELEASE:=1

LOCAL_DEV:=0
ifneq ($(LOCAL_DEV),1)
PKG_SOURCE_PROTO=git
PKG_SOURCE_URL:=https://github.com/ihotray/apmgr.git
PKG_SOURCE_VERSION:=5a48af2d8e724690123bfffe255fbc7f795f45bc
PKG_MAINTAINER:=richard.sheh
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz
PKG_MIRROR_HASH:=skip
endif

PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/apmgr
	CATEGORY:=IOTWRT
	SUBMENU:=Applications
	TITLE:=apmgr daemon
	DEPENDS:=+uci +libiot +liblua
	MENU:=1
endef

define Package/apmgr/description
	apmgr is a daemon for ap management.
endef


ifeq ($(LOCAL_DEV),1)
define Build/Prepare
	$(CP) -rf ~/git/code/apmgr/* $(PKG_BUILD_DIR)/
endef
endif

define Package/apmgr/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/* $(1)/etc/init.d/
	$(INSTALL_DIR) $(1)/www/iot
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/apmgr $(1)/www/iot/
endef

$(eval $(call BuildPackage,apmgr))
