include $(TOPDIR)/rules.mk
include ../version.mk

PKG_NAME:=iot-mproxy
PKG_VERSION:=1.0.0_$(strip $(call findrev))
PKG_RELEASE:=1

LOCAL_DEV:=1
ifneq ($(LOCAL_DEV),1)
PKG_SOURCE_PROTO=git
PKG_SOURCE_URL:=https://github.com/ihotray/iot-mproxy.git
PKG_SOURCE_VERSION:=82d709e3d4b475be3ab548e87d51aea7fae3b60c
PKG_MAINTAINER:=richard.sheh
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz
PKG_MIRROR_HASH:=skip
endif

PKG_LICENSE:=GPL-2.0-only
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/iot-mproxy
	CATEGORY:=IOTWRT
	SUBMENU:=Applications
	TITLE:=iot-mproxy
	DEPENDS:=+libiot +iot-mqtt
	MENU:=1
endef

define Package/iot-mproxy/description
	iot-mproxy, a mqtt proxy for iot devices.
endef

ifeq ($(LOCAL_DEV),1)
define Build/Prepare
	$(CP) -rf ~/workspace/github/ihotray/iot-mproxy/* $(PKG_BUILD_DIR)/
endef
endif

define Package/iot-mproxy/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/* $(1)/etc/init.d/
	$(INSTALL_DIR) $(1)/www/iot
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/iot-mproxy $(1)/www/iot
endef

$(eval $(call BuildPackage,iot-mproxy))
