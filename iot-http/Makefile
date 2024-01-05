include $(TOPDIR)/rules.mk
include ../version.mk

PKG_NAME:=iot-http
PKG_VERSION:=1.0.0_$(strip $(call findrev))
PKG_RELEASE:=1

LOCAL_DEV:=0
ifneq ($(LOCAL_DEV),1)
PKG_SOURCE_PROTO=git
PKG_SOURCE_URL:=https://github.com/ihotray/iot-http.git
PKG_SOURCE_VERSION:=21943479d2b3beb3d7591e7390e2b41fa691ee24
PKG_MAINTAINER:=richard.sheh
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz
PKG_MIRROR_HASH:=skip
endif

PKG_LICENSE:=GPL-2.0-only
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/iot-http
	CATEGORY:=IOTWRT
	SUBMENU:=Applications
	TITLE:=iot-http
	DEPENDS:=+libiot +iot-mqtt +iot-rpcd
	MENU:=1
endef

define Package/iot-http/description
	iot-http, a simple http server for iot devices.
endef

ifeq ($(LOCAL_DEV),1)
define Build/Prepare
	$(CP) -rf ~/git/code/iot-http/* $(PKG_BUILD_DIR)/
endef
endif

define Package/iot-http/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/* $(1)/etc/init.d/
	$(INSTALL_DIR) $(1)/www/iot
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/iot-http $(1)/www/iot
endef

$(eval $(call BuildPackage,iot-http))
