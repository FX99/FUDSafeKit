//
//  NSNumber+SafeKit.m
//  FUDSafeKit
//
//  Created by lanfudong on 2019/8/29.
//

#import "NSNumber+FUDSafeKit.h"
#import "FUDSafeKit.h"

@implementation NSNumber (FUDSafeKit)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [NSNumber class];
        fud_safekit_swizzleSelectors(class, @selector(forwardingTargetForSelector:), class, @selector(fud_safekit_forwardingTargetForSelector:));
    });
}

- (id)fud_safekit_forwardingTargetForSelector:(SEL)selector {
    if ([NSString instancesRespondToSelector:selector]) {
        fud_reportErrorForUnrecognizedSelector([self class], selector);
        NSString *string = [NSString stringWithFormat:@"%@", self];
        return string;
    }
    
    return [self fud_safekit_forwardingTargetForSelector:selector];
}

@end
