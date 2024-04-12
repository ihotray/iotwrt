include $(TOPDIR)/rules.mk
include ../version.mk

PKG_NAME:=iot-provision
PKG_VERSION:=1.0.0_$(strip $(call findrev))
PKG_RELEASE:=1

LOCAL_DEV:=0
ifneq ($(LOCAL_DEV),1)
PKG_SOURCE_PROTO=git
PKG_SOURCE_URL:=https://github.com/ihotray/iot-provision.git
PKG_SOURCE_VERSION:=8c41103e91edafe53e5e07bc341adea786e41836
PKG_MAINTAINER:=richard.sheh
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz
PKG_MIRROR_HASH:=skip
endif

PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/iot-provision
	CATEGORY:=IOTWRT
	SUBMENU:=Applications
	TITLE:=iot-provision daemon
	DEPENDS:=+uci +libiot +liblua
	MENU:=1
endef

define Package/iot-provision/description
	iot-provision is a client daemon for device provision.
endef

define Package/iot-provision/conffiles
/etc/config/provision
endef

#CMAKE_OPTIONS:=-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON

ifeq ($(LOCAL_DEV),1)
define Build/Prepare
	$(CP) -rf ~/git/code/iot-provision/* $(PKG_BUILD_DIR)/
endef
endif

define Package/iot-provision/install
	$(INSTALL_DIR) $(1)/etc/config
	$(CP) ./files/etc/config/* $(1)/etc/config/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/* $(1)/etc/init.d/
	$(INSTALL_DIR) $(1)/www/iot/handler
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/iot-provision $(1)/www/iot
	$(CP) ./files/www/iot/handler/* $(1)/www/iot/handler
endef

$(eval $(call BuildPackage,iot-provision))
