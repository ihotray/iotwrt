include $(TOPDIR)/rules.mk
include ../version.mk

PKG_NAME:=libiot
PKG_VERSION:=1.0.0_$(strip $(call findrev))

LOCAL_DEV=0
ifneq ($(LOCAL_DEV),1)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=7fe4fb2efbe32fb2de6b7a43d3b87f5a2e95ee6a
PKG_SOURCE_URL:=https://github.com/ihotray/libiot.git
PKG_MAINTAINER:=richard.sheh
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)_$(PKG_SOURCE_VERSION).tar.xz
PKG_MIRROR_HASH:=skip
endif

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/libiot
  CATEGORY:=IOTWRT
  SUBMENU:=Libraries
  MENU:=1
  TITLE:= Common helper library (libiot)
  DEPENDS:=+libmbedtls
endef

ifeq ($(LOCAL_DEV),1)
define Build/Prepare
	$(CP) -rf ~/git/code/libiot/* $(PKG_BUILD_DIR)/
endef
endif

define Package/libiot/description
  Library provides common utility functions
endef

define Build/InstallDev/libiot
	$(INSTALL_DIR) $(1)/usr/include/iot
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_BUILD_DIR)/*.h $(1)/usr/include/iot/
	$(CP) $(PKG_BUILD_DIR)/libiot*.so* $(1)/usr/lib/
endef

define Build/InstallDev
	$(call Build/InstallDev/libiot,$(1),$(2))
endef

define Package/libiot/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_BUILD_DIR)/libiot*.so* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,libiot))
