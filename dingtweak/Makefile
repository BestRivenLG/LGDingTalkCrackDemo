export THEOS_DEVICE_IP=127.0.0.1
export THEOS_DEVICE_PORT=12345
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = DingTweak
DingTweak_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
