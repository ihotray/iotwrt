include $(TOPDIR)/rules.mk
include ../version.mk

PKG_NAME:=iot-client
PKG_VERSION:=1.0.0_$(strip $(call findrev))
PKG_RELEASE:=1

LOCAL_DEV:=0
ifneq ($(LOCAL_DEV),1)
PKG_SOURCE_PROTO=git
PKG_SOURCE_URL:=https://github.com/ihotray/iot-client.git
PKG_SOURCE_VERSION:=7c7691224844c89f5f022ffd7378064213c201b5
PKG_MAINTAINER:=richard.sheh
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz
PKG_MIRROR_HASH:=skip
endif

PKG_LICENSE:=GPL-2.0-only
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/iot-client
	CATEGORY:=IOTWRT
	SUBMENU:=Applications
	TITLE:=iot-client
	DEPENDS:=+libiot +iot-mqtt +iot-rpcd +liblua
	MENU:=1
endef

define Package/iot-client/description
	iot-client, a general-purpose mqtt client with lua callback.
endef

ifeq ($(LOCAL_DEV),1)
define Build/Prepare
	$(CP) -rf ~/git/code/iot-client/* $(PKG_BUILD_DIR)/
endef
endif

define Package/iot-client/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/* $(1)/etc/init.d/
	$(INSTALL_DIR) $(1)/www/iot/handler
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/iot-client $(1)/www/iot
	$(CP) ./files/www/iot/handler/* $(1)/www/iot/handler
endef

$(eval $(call BuildPackage,iot-client))
