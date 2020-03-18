//
//  NSNull+SafeKit.m
//  FUDSafeKit
//
//  Created by lanfudong on 2019/8/29.
//

#import "NSNull+FUDSafeKit.h"
#import "FUDSafeKit.h"

@implementation NSNull (FUDSafeKit)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [NSNull class];
        fud_safekit_swizzleSelectors(class, @selector(forwardingTargetForSelector:), class, @selector(fud_safekit_forwardingTargetForSelector:));
    });
}

- (id)fud_safekit_forwardingTargetForSelector:(SEL)selector {
    static NSArray *nullObjts;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        nullObjts = @[@"", @0, @[], @{}]; // 列举可能为空的对象
    });
    
    for (id nullObjt in nullObjts) {
        if ([nullObjt respondsToSelector:selector]) {
            fud_reportErrorForUnrecognizedSelector([self class], selector);
            return nullObjt;
        }
    }
    
    return [self fud_safekit_forwardingTargetForSelector:selector];
}

@end
