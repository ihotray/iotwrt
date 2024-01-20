include $(TOPDIR)/rules.mk
include ../version.mk

PKG_NAME:=iot-agent
PKG_VERSION:=1.0.0_$(strip $(call findrev))
PKG_RELEASE:=1

LOCAL_DEV:=0
ifneq ($(LOCAL_DEV),1)
PKG_SOURCE_PROTO=git
PKG_SOURCE_URL:=https://github.com/ihotray/iot-agent.git
PKG_SOURCE_VERSION:=59903ac2f3ce63187ccc6f2709184bb722ed8b07
PKG_MAINTAINER:=richard.sheh
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz
PKG_MIRROR_HASH:=skip
endif

PKG_LICENSE:=GPL-2.0-only
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/iot-agent
	CATEGORY:=IOTWRT
	SUBMENU:=Applications
	TITLE:=iot-agent
	DEPENDS:=+libiot +iot-mqtt +iot-rpcd +liblua
	MENU:=1
endef

define Package/iot-agent/description
	iot-agent, a agent service for iot devices.
endef

ifeq ($(LOCAL_DEV),1)
define Build/Prepare
	$(CP) -rf ~/git/code/iot-agent/* $(PKG_BUILD_DIR)/
endef
endif

define Package/iot-agent/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/* $(1)/etc/init.d/
	$(INSTALL_DIR) $(1)/www/iot
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/iot-agent $(1)/www/iot
endef

$(eval $(call BuildPackage,iot-agent))
