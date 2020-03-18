//
//  FUDSafeKit.h
//  SafeKit
//
//  Created by lanfudong on 2019/8/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern void fud_safekit_swizzleSelectors(Class originClass, SEL originSelector, Class swizzleClass, SEL swizzleSelector);
extern void fud_reportErrorForUnrecognizedSelector(Class class, SEL selector);
extern void fud_reportError(NSString *reason);

@interface FUDSafeKit : NSObject

- (void)addMethod:(SEL)selector;

@end

NS_ASSUME_NONNULL_END
