LOCAL_PATH := $(call my-dir)

#--- libBugly.so ---

include $(CLEAR_VARS)

LOCAL_MODULE := cocos2dlua_shared

LOCAL_MODULE_FILENAME := libcocos2dlua

LOCAL_IOS_SDK := ios

FILTER_OUT = $(foreach v,$(2),$(if $(findstring $(1),$(v)),,$(v)))

define addfile
$(wildcard $(1)) $(foreach e,$(wildcard $(1)/*),$(call addfile,$(e)))
endef
ALLFILES = $(call addfile,$(LOCAL_PATH)/../../../Classes)
ALLFILES_O =  $(call FILTER_OUT,$(LOCAL_IOS_SDK),$(ALLFILES))
FILE_LIST := hellolua/main.cpp
FILE_LIST += $(filter %.cpp %.c,$(ALLFILES_O))
LOCAL_SRC_FILES := $(FILE_LIST:$(LOCAL_PATH)/%=%)

LOCAL_C_INCLUDES := \
$(LOCAL_PATH)/../../../Classes \
$(LOCAL_PATH)/../../../Classes/core \
$(LOCAL_PATH)/../../../Classes/core/logic \
$(LOCAL_PATH)/../../../Classes/core/luabindings \
$(LOCAL_PATH)/../../../Classes/core/platform \
$(LOCAL_PATH)/../../../Classes/core/utils \
$(COCOS2DX_ROOT)/external \
$(COCOS2DX_ROOT)/quick/lib/quick-src \
$(COCOS2DX_ROOT)/quick/lib/quick-src/extra

LOCAL_STATIC_LIBRARIES := extra_static
LOCAL_STATIC_LIBRARIES += cocos2d_lua_static
LOCAL_STATIC_LIBRARIES += lua_extensions_static

include $(BUILD_SHARED_LIBRARY)

$(call import-module,scripting/lua-bindings/proj.android)

$(call import-module, quick-src/lua_extensions)
$(call import-module, quick-src/extra)
