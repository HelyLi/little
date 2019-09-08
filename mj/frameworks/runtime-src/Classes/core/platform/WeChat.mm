//
//  WeChat.m
//  mj iOS
//
//  Created by  triangle on 2019/9/6.
//

#import <Foundation/Foundation.h>
#include "WeChat.h"
#include "WXApi.h"
#include "WXApiObject.h"
#include "AppController.h"

#import "cocos2d.h"
#import "CCLuaEngine.h"
#import "CCLuaBridge.h"

@implementation WeChat

static AppController* appController = nil;
static int handlerID = -1;
static int isCircle = 0;

+(int)isInstalled:(NSDictionary * )dict{
    
}

+(void)openApp:(NSDictionary * )dict{
    
}

+(void)doLoginReq:(NSDictionary * )dict{
    
}

+(void)doShare:(NSDictionary * )dict{
    
}

+(void)callbackStringToLua:(NSString*) code{
    if (handlerID > 0) {
        LuaBridge::pushLuaFunctionById(handlerID); //压入需要调用的方法id（假设方法为XG）
        LuaStack *stack = LuaBridge::getStack();  //获取lua栈
        stack->pushInt(0);
        stack->pushString([code UTF8String]);  //将需要通过方法XG传递给lua的参数压入lua栈
        stack->executeFunction(2);  //根据压入的方法id调用方法XG，并把XG方法参数传递给lua代码
        LuaBridge::releaseLuaFunctionById(handlerID); //最后记得释放一下function
        handlerID = -1;
    }
}

+(void)callbackIntToLua:(int) code{
    if (handlerID >= 0) {
        LuaBridge::pushLuaFunctionById(handlerID); //压入需要调用的方法id（假设方法为XG）
        LuaStack *stack = LuaBridge::getStack();  //获取lua栈
        stack->pushInt(code);
        stack->executeFunction(1);  //根据压入的方法id调用方法XG，并把XG方法参数传递给lua代码
        LuaBridge::releaseLuaFunctionById(handlerID); //最后记得释放一下function
        handlerID = -1;
    }
}

@end
