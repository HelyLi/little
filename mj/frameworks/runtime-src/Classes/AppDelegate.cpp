#include "AppDelegate.h"
#include "CCLuaEngine.h"
#include "cocos2d.h"
#include "lua_module_register.h"
#include "xxtea/xxtea.h"

// extra lua module
#include "cocos2dx_extra.h"
#include "lua_extensions/lua_extensions_more.h"
#include "luabinding/cocos2dx_extra_luabinding.h"
#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
#include "luabinding/cocos2dx_extra_ios_iap_luabinding.h"
#endif


USING_NS_CC;
using namespace std;

#define RESOURCE_ENCRYPTION 1

static void quick_module_register(lua_State *L)
{
    luaopen_lua_extensions_more(L);

    lua_getglobal(L, "_G");
    if (lua_istable(L, -1))//stack:...,_G,
    {
        register_all_quick_manual(L);
        // extra
        luaopen_cocos2dx_extra_luabinding(L);
#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
        luaopen_cocos2dx_extra_ios_iap_luabinding(L);
#endif
    }
    lua_pop(L, 1);
}

//
AppDelegate::AppDelegate()
{
}

AppDelegate::~AppDelegate()
{
}

//if you want a different context,just modify the value of glContextAttrs
//it will takes effect on all platforms
void AppDelegate::initGLContextAttrs()
{
    //set OpenGL context attributions,now can only set six attributions:
    //red,green,blue,alpha,depth,stencil
    GLContextAttrs glContextAttrs = { 8, 8, 8, 8, 24, 8 };

    GLView::setGLContextAttrs(glContextAttrs);
}

static void decoder(Data &data)
{
    unsigned char sign[] = "Xt";
    unsigned char key[] = "aaa";
    
    // decrypt XXTEA
    if (!data.isNull()) {
        bool isEncoder = false;
        unsigned char *buf = data.getBytes();
        ssize_t size = data.getSize();
        ssize_t len = strlen((char *)sign);
        if (size <= len) {
            return;
        }
        
        for (int i = 0; i < len; ++i) {
            isEncoder = buf[i] == sign[i];
            if (!isEncoder) {
                break;
            }
        }
        
        if (isEncoder) {
            xxtea_long newLen = 0;
            unsigned char* buffer = xxtea_decrypt(buf + len,
                                                  (xxtea_long)(size - len),
                                                  (unsigned char*)key,
                                                  (xxtea_long)strlen((char *)key),
                                                  &newLen);
            data.clear();
            data.fastSet(buffer, newLen);
        }
    }
}

bool AppDelegate::applicationDidFinishLaunching()
{
    // initialize director
    auto director = Director::getInstance();
    auto glview = director->getOpenGLView();    
    if(!glview) {
        string title = "mj";
        glview = cocos2d::GLViewImpl::create(title.c_str());
        director->setOpenGLView(glview);
        director->startAnimation();
    }
   
    auto engine = LuaEngine::getInstance();
    ScriptEngineManager::getInstance()->setScriptEngine(engine);
    lua_State* L = engine->getLuaStack()->getLuaState();
    lua_module_register(L);

    // use Quick-Cocos2d-X
    quick_module_register(L);
    
#ifdef RESOURCE_ENCRYPTION
    //0xb04030e1 0xfcaee09c 0xf008e930 0xd39c521e (加密的 必须是32位十六进制值)
    
    ZipUtils::setPvrEncryptionKeyPart(0, 0xb04030e1);
    ZipUtils::setPvrEncryptionKeyPart(1, 0xfcaee09c);
    ZipUtils::setPvrEncryptionKeyPart(2, 0xf008e930);
    ZipUtils::setPvrEncryptionKeyPart(3, 0xd39c521e);
#endif
    
#if 1
    engine->executeScriptFile("src/main.lua");
#else
    #ifdef CC_TARGET_OS_IPHONE
        if (sizeof(long) == 4) {
            engine->executeScriptFile("src_et/main.lua");
        } else {
            //模拟器上不能跑64位的Luajit，只能跑32位,在模拟器上注意修改
            engine->executeScriptFile("src_et_64/main64.lua");
        }
    #else
        engine->executeScriptFile("src_et/main.lua");
    #endif
#endif

    return true;
}

// This function will be called when the app is inactive. When comes a phone call,it's be invoked too
void AppDelegate::applicationDidEnterBackground()
{
    Director::getInstance()->stopAnimation();
    Director::getInstance()->pause();

    Director::getInstance()->getEventDispatcher()->dispatchCustomEvent("APP_ENTER_BACKGROUND_EVENT");
}

// this function will be called when the app is active again
void AppDelegate::applicationWillEnterForeground()
{
    Director::getInstance()->resume();
    Director::getInstance()->startAnimation();

    Director::getInstance()->getEventDispatcher()->dispatchCustomEvent("APP_ENTER_FOREGROUND_EVENT");
}
