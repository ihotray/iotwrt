include $(TOPDIR)/rules.mk
include ../version.mk

PKG_NAME:=iot-ubusd
PKG_VERSION:=1.0.0_$(strip $(call findrev))
PKG_RELEASE:=1

LOCAL_DEV:=0
ifneq ($(LOCAL_DEV),1)
PKG_SOURCE_PROTO=git
PKG_SOURCE_URL:=https://github.com/ihotray/iot-ubusd.git
PKG_SOURCE_VERSION:=c7bebe73ec573ca37e4e19c52503a4276613dc8d
PKG_MAINTAINER:=richard.sheh
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz
PKG_MIRROR_HASH:=skip
endif

PKG_LICENSE:=GPL-2.0-only
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/iot-ubusd
	CATEGORY:=IOTWRT
	SUBMENU:=Applications
	TITLE:=iot-ubusd
	DEPENDS:=+libiot +libubus +libubox +libblobmsg-json
	MENU:=1
endef

define Package/iot-ubusd/description
	iot-ubusd, a general-purpose ubus service with iot-rpcd.
endef

ifeq ($(LOCAL_DEV),1)
define Build/Prepare
	$(CP) -rf ~/git/code/iot-ubusd/* $(PKG_BUILD_DIR)/
endef
endif

define Package/iot-ubusd/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/* $(1)/etc/init.d/
	$(INSTALL_DIR) $(1)/www/iot/etc
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/iot-ubusd $(1)/www/iot
	$(CP) ./files/www/iot/etc/* $(1)/www/iot/etc

endef

$(eval $(call BuildPackage,iot-ubusd))
