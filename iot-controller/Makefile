include $(TOPDIR)/rules.mk
include ../version.mk

PKG_NAME:=iot-controller
PKG_VERSION:=1.0.0_$(strip $(call findrev))
PKG_RELEASE:=1

LOCAL_DEV:=0
ifneq ($(LOCAL_DEV),1)
PKG_SOURCE_PROTO=git
PKG_SOURCE_URL:=https://github.com/ihotray/iot-controller.git
PKG_SOURCE_VERSION:=b32308492ce7151299f52bf23501807a8f8fe8ed
PKG_MAINTAINER:=richard.sheh
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz
PKG_MIRROR_HASH:=skip
endif

PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/iot-controller
	CATEGORY:=IOTWRT
	SUBMENU:=Applications
	TITLE:=iot-controller daemon
	DEPENDS:=+uci +libiot +liblua
	MENU:=1
endef

define Package/iot-controller/description
	iot-controller is a daemon for iot-agent management.
endef


ifeq ($(LOCAL_DEV),1)
define Build/Prepare
	$(CP) -rf ~/git/code/iot-controller/* $(PKG_BUILD_DIR)/
endef
endif

define Package/iot-controller/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/* $(1)/etc/init.d/
	$(INSTALL_DIR) $(1)/www/iot
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/iot-controller $(1)/www/iot/
endef

$(eval $(call BuildPackage,iot-controller))
