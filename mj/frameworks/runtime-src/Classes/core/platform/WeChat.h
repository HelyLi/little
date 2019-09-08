
#import <Foundation/Foundation.h>
#include "cocos2d.h"
USING_NS_CC;

@interface WeChat : NSObject

+(int)isInstalled:(NSDictionary * )dict;
+(void)openApp:(NSDictionary * )dict;
+(void)doLoginReq:(NSDictionary * )dict;
+(void)doShare:(NSDictionary * )dict;

@end
