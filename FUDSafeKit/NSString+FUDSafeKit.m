//
//  NSString+FUDSafeKit.m
//  FUDSafeKit
//
//  Created by lanfudong on 2019/8/29.
//

#import "NSString+FUDSafeKit.h"
#import "FUDSafeKit.h"

@implementation NSString (FUDSafeKit)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [NSString class];
        fud_safekit_swizzleSelectors(class, @selector(forwardingTargetForSelector:), class, @selector(fud_safekit_forwardingTargetForSelector:));
        Class cfclass = NSClassFromString(@"__NSCFString");
        fud_safekit_swizzleSelectors(cfclass, @selector(substringWithRange:), class, @selector(fud_safekit_substringWithRange:));
    });
}

- (id)fud_safekit_forwardingTargetForSelector:(SEL)selector {
    // 是否把 NSString 当成 NSNumber 用了，常见于解析 json 时
    if ([NSNumber instancesRespondToSelector:selector]) {
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        NSNumber *number = [formatter numberFromString:self];
        if (number) {
            fud_reportErrorForUnrecognizedSelector([self class], selector);
            return number;
        }
    }
    
    return [self fud_safekit_forwardingTargetForSelector:selector];
}

- (NSString *)fud_safekit_substringWithRange:(NSRange)range {
    if (range.location > self.length || range.location + range.length > self.length) {
        NSString *error = [NSString stringWithFormat:@"NSRange(%ld, %ld) 超出了字符串边界（%ld）", range.location, range.length, self.length];
        fud_reportError(error);
        return @"";
    }
        
    return [self fud_safekit_substringWithRange:range];
}

@end
