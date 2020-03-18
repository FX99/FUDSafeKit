//
//  NSObject+FUDSafeKit.m
//  FUDSafeKit
//
//  Created by lanfudong on 2019/8/29.
//

#import "NSObject+FUDSafeKit.h"
#import "FUDSafeKit.h"

@implementation NSObject (FUDSafeKit)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [NSObject class];
        fud_safekit_swizzleSelectors(class, @selector(forwardingTargetForSelector:), class, @selector(fud_safekit_forwardingTargetForSelector:));
    });
}

- (id)fud_safekit_forwardingTargetForSelector:(SEL)selector {
    BOOL response = [self respondsToSelector:selector];
    NSMethodSignature *sign = [self methodSignatureForSelector:selector];
    if (response || sign) {
        return [self fud_safekit_forwardingTargetForSelector:selector];
    } else {
        fud_reportErrorForUnrecognizedSelector([self class], selector);
        FUDSafeKit *safeKit = [FUDSafeKit new];
        [safeKit addMethod:selector];
        
        return safeKit;
    }
}

@end
