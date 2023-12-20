include $(TOPDIR)/rules.mk
include ../version.mk

PKG_NAME:=libmicrodns
PKG_VERSION:=1.0.0_$(strip $(call findrev))

LOCAL_DEV=0
ifneq ($(LOCAL_DEV),1)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=c1474eeda7b39ec44ed99fe31c2415cbc4a8e4c0
PKG_SOURCE_URL:=https://github.com/ihotray/libmicrodns.git
PKG_MAINTAINER:=richard.sheh
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)_$(PKG_SOURCE_VERSION).tar.xz
PKG_MIRROR_HASH:=skip
endif

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/libmicrodns
  CATEGORY:=IOTWRT
  SUBMENU:=Libraries
  MENU:=1
  TITLE:= MDNS helper library (libmicrodns)
  DEPENDS:=
endef

ifeq ($(LOCAL_DEV),1)
define Build/Prepare
    $(CP) -rf ~/git/code/libmicrodns/* $(PKG_BUILD_DIR)/
endef
endif

define Package/libmicrodns/description
  Library provides common utility functions
endef

define Build/InstallDev/libmicrodns
	$(INSTALL_DIR) $(1)/usr/include/microdns
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_BUILD_DIR)/*.h $(1)/usr/include/microdns/
	$(CP) $(PKG_BUILD_DIR)/libmicrodns*.so* $(1)/usr/lib/
endef

define Build/InstallDev
	$(call Build/InstallDev/libmicrodns,$(1),$(2))
endef

define Package/libmicrodns/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_BUILD_DIR)/libmicrodns*.so* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,libmicrodns))
