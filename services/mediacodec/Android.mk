LOCAL_PATH := $(call my-dir)

# service library
include $(CLEAR_VARS)
LOCAL_SRC_FILES := MediaCodecService.cpp
LOCAL_SHARED_LIBRARIES := libmedia libbinder libutils liblog libstagefright_omx
LOCAL_C_INCLUDES := \
    $(TOP)/frameworks/av/media/libstagefright \
    $(TOP)/frameworks/native/include/media/openmax
LOCAL_MODULE:= libmediacodecservice
ifeq ($(strip $(MEDIASERVER_MULTILIB)),)
LOCAL_MULTILIB := 32
else
LOCAL_MULTILIB := $(MEDIASERVER_MULTILIB)
endif
include $(BUILD_SHARED_LIBRARY)


# service executable
include $(CLEAR_VARS)
LOCAL_REQUIRED_MODULES_arm := mediacodec-seccomp.policy
LOCAL_SRC_FILES := main_codecservice.cpp minijail/minijail.cpp
LOCAL_SHARED_LIBRARIES := libmedia libmediacodecservice libbinder libutils \
	liblog libminijail
LOCAL_C_INCLUDES := \
    $(TOP)/frameworks/av/media/libstagefright \
    $(TOP)/frameworks/native/include/media/openmax
LOCAL_MODULE:= mediacodec
ifeq ($(strip $(MEDIASERVER_MULTILIB)),)
LOCAL_MULTILIB := 32
else
LOCAL_MULTILIB := $(MEDIASERVER_MULTILIB)
endif
LOCAL_INIT_RC := mediacodec.rc
include $(BUILD_EXECUTABLE)

include $(call all-makefiles-under, $(LOCAL_PATH))

