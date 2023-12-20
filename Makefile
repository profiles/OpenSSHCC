export COPYFILE_DISABLE=1 # for any tool in any case
export TARGET = iphone:clang:latest:12.1.2
export ARCHS = arm64 arm64e
#messages=yes

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = SSHonCC
$(BUNDLE_NAME)_BUNDLE_EXTENSION = bundle
$(BUNDLE_NAME)_CFLAGS += -fobjc-arc -I$(THEOS_PROJECT_DIR)/headers
$(BUNDLE_NAME)_FILES = SSHonCC.m
$(BUNDLE_NAME)_FRAMEWORKS = UIKit
$(BUNDLE_NAME)_PRIVATE_FRAMEWORKS = ControlCenterUIKit
$(BUNDLE_NAME)_INSTALL_PATH = /Library/ControlCenter/Bundles/

include $(THEOS_MAKE_PATH)/bundle.mk

