//
//  NSArray+FUDSafeKit.m
//  FUDSafeKit
//
//  Created by lanfudong on 2019/10/28.
//

#import "NSArray+FUDSafeKit.h"
#import "FUDSafeKit.h"

@implementation NSArray (FUDSafeKit)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class iclass = NSClassFromString(@"__NSArrayI");
        fud_safekit_swizzleSelectors(iclass, @selector(objectAtIndex:), self, @selector(fud_safekit_objectAtIndex:));
        fud_safekit_swizzleSelectors(iclass, @selector(objectAtIndexedSubscript:), self, @selector(fud_safekit_objectAtIndexedSubscript:));
        
        Class oclass = NSClassFromString(@"__NSArray0");
        fud_safekit_swizzleSelectors(oclass, @selector(objectAtIndex:), self, @selector(fud_safekit_array0_objectAtIndex:));
        fud_safekit_swizzleSelectors(oclass, @selector(objectAtIndexedSubscript:), self, @selector(fud_safekit_array0_objectAtIndexedSubscript:));
        
        Class sclass = NSClassFromString(@"__NSSingleObjectArrayI");
        fud_safekit_swizzleSelectors(sclass, @selector(objectAtIndex:), self, @selector(fud_safekit_array1_objectAtIndex:));
        fud_safekit_swizzleSelectors(sclass, @selector(objectAtIndexedSubscript:), self, @selector(fud_safekit_array1_objectAtIndexedSubscript:));
    });
}

- (id)fud_safekit_objectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        NSString *method = [NSString stringWithFormat:@"****** Method: [%p objectAtIndex:%ld] ******", self, index];
        NSString *reason = [NSString stringWithFormat:@"****** Reason: %ld beyond boundary of NSArray(0 ... %ld) ******", index, self.count - 1];
        NSString *error = [NSString stringWithFormat:@"%@\n%@", method, reason];
        fud_reportError(error);
        return nil;
    }
    
    return [self fud_safekit_objectAtIndex:index];
}

- (id)fud_safekit_objectAtIndexedSubscript:(NSUInteger)index {
    if (index >= self.count) {
        NSString *method = [NSString stringWithFormat:@"****** Method: [%p objectAtIndexedSubscript:%ld] ******", self, index];
        NSString *reason = [NSString stringWithFormat:@"****** Reason: %ld beyond boundary of NSArray(0 ... %ld) ******", index, self.count - 1];
        NSString *error = [NSString stringWithFormat:@"%@\n%@", method, reason];
        fud_reportError(error);
        return nil;
    }
    
    return [self fud_safekit_objectAtIndexedSubscript:index];
}

- (id)fud_safekit_array0_objectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        NSString *method = [NSString stringWithFormat:@"****** Method: [%p objectAtIndex:%ld] ******", self, index];
        NSString *reason = [NSString stringWithFormat:@"****** Reason: %ld beyond boundary of NSArray(0 ... %ld) ******", index, self.count - 1];
        NSString *error = [NSString stringWithFormat:@"%@\n%@", method, reason];
        fud_reportError(error);
        return nil;
    }
    
    return [self fud_safekit_array0_objectAtIndex:index];
}

- (id)fud_safekit_array0_objectAtIndexedSubscript:(NSUInteger)index {
    if (index >= self.count) {
        NSString *method = [NSString stringWithFormat:@"****** Method: [%p objectAtIndexedSubscript:%ld] ******", self, index];
        NSString *reason = [NSString stringWithFormat:@"****** Reason: %ld beyond boundary of NSArray(0 ... %ld) ******", index, self.count - 1];
        NSString *error = [NSString stringWithFormat:@"%@\n%@", method, reason];
        fud_reportError(error);
        return nil;
    }
    
    return [self fud_safekit_array0_objectAtIndexedSubscript:index];
}

- (id)fud_safekit_array1_objectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        NSString *method = [NSString stringWithFormat:@"****** Method: [%p objectAtIndex:%ld] ******", self, index];
        NSString *reason = [NSString stringWithFormat:@"****** Reason: %ld beyond boundary of NSArray(0 ... %ld) ******", index, self.count - 1];
        NSString *error = [NSString stringWithFormat:@"%@\n%@", method, reason];
        fud_reportError(error);
        return nil;
    }
    
    return [self fud_safekit_array1_objectAtIndex:index];
}

- (id)fud_safekit_array1_objectAtIndexedSubscript:(NSUInteger)index {
    if (index >= self.count) {
        NSString *method = [NSString stringWithFormat:@"****** Method: [%p objectAtIndexedSubscript:%ld] ******", self, index];
        NSString *reason = [NSString stringWithFormat:@"****** Reason: %ld beyond boundary of NSArray(0 ... %ld) ******", index, self.count - 1];
        NSString *error = [NSString stringWithFormat:@"%@\n%@", method, reason];
        fud_reportError(error);
        return nil;
    }
    
    return [self fud_safekit_array1_objectAtIndexedSubscript:index];
}

@end
