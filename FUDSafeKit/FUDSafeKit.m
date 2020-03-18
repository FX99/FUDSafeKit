//
//  FUDSafeKit.m
//  SafeKit
//
//  Created by lanfudong on 2019/8/29.
//

#import "FUDSafeKit.h"
#import <objc/runtime.h>

static inline BOOL safekit_enable() {
    return YES;
}

void fud_safekit_swizzleSelectors(Class originClass, SEL originSelector, Class swizzleClass, SEL swizzleSelector) {
    if (!safekit_enable()) return;
    
    Method originMethod = class_getInstanceMethod(originClass, originSelector);
    Method swizzleMethod = class_getInstanceMethod(swizzleClass, swizzleSelector);
    
    BOOL success = class_addMethod(originClass, originSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    if (success) {
        class_replaceMethod(swizzleClass, swizzleSelector, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    } else {
        method_exchangeImplementations(originMethod, swizzleMethod);
    }
}

void fud_reportErrorForUnrecognizedSelector(Class class, SEL selector) {
    NSLog(@"FUDSafeKit: %@ unrecognized selector %@", NSStringFromClass(class), NSStringFromSelector(selector));
}

void fud_reportError(NSString *reason) {
    if (DEBUG) {
        NSLog(@"FUDSafeKit: %@", reason);
    }
}

@implementation FUDSafeKit

int anyTargetIMP(id target, SEL selector, ...) {
    return 0;
}

- (void)addMethod:(SEL)selector {
    NSMutableString *selString = NSStringFromSelector(selector).mutableCopy;
    NSInteger count = [selString replaceOccurrencesOfString:@":" withString:@"_" options:NSCaseInsensitiveSearch range:NSMakeRange(0, selString.length)];
    NSMutableString *funcTypeEncoding = [NSString stringWithFormat:@"%s@", @encode(int)].mutableCopy;
    for (int i = 0; i < count; i++) {
        [funcTypeEncoding appendString:@"@"];
    }
    const char *encoding = [funcTypeEncoding UTF8String];
    class_addMethod([FUDSafeKit class], selector, (IMP)anyTargetIMP, encoding);
}

@end
