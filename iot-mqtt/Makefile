include $(TOPDIR)/rules.mk
include ../version.mk

PKG_NAME:=iot-mqtt
PKG_VERSION:=1.0.0_$(strip $(call findrev))
PKG_RELEASE:=1

LOCAL_DEV:=0
ifneq ($(LOCAL_DEV),1)
PKG_SOURCE_PROTO=git
PKG_SOURCE_URL:=https://github.com/ihotray/iot-mqtt.git
PKG_SOURCE_VERSION:=074e0fb650e0b70fedb172d2eb945fb4a027165b
PKG_MAINTAINER:=richard.sheh
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz
PKG_MIRROR_HASH:=skip
endif

PKG_LICENSE:=GPL-2.0-only
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/iot-mqtt
	CATEGORY:=IOTWRT
	SUBMENU:=Applications
	TITLE:=iot-mqtt
	DEPENDS:=+libiot
	MENU:=1
endef

define Package/iot-mqtt/description
	iot-mqtt, a simple mqtt(s) server.
endef

ifeq ($(LOCAL_DEV),1)
define Build/Prepare
	$(CP) -rf ~/git/code/iot-mqtt/* $(PKG_BUILD_DIR)/
endef
endif

define Package/iot-mqtt/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/* $(1)/etc/init.d/
	$(INSTALL_DIR) $(1)/www/iot
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/iot-mqtt $(1)/www/iot
endef

$(eval $(call BuildPackage,iot-mqtt))
