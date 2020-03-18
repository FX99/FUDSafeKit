//
//  NSMutableArray+FUDSafeKit.m
//  FUDSafeKit
//
//  Created by lanfudong on 2019/10/28.
//

#import "NSMutableArray+FUDSafeKit.h"
#import "FUDSafeKit.h"

@implementation NSMutableArray (FUDSafeKit)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class mclass = NSClassFromString(@"__NSArrayM");
        fud_safekit_swizzleSelectors(mclass, @selector(objectAtIndex:), self, @selector(fud_safekit_objectAtIndex:));
        fud_safekit_swizzleSelectors(mclass, @selector(objectAtIndexedSubscript:), self, @selector(fud_safekit_objectAtIndexedSubscript:));
        
        fud_safekit_swizzleSelectors(mclass, @selector(addObject:), self, @selector(fud_safekit_addObject:));
        fud_safekit_swizzleSelectors(mclass, @selector(insertObject:atIndex:), self, @selector(fud_safekit_insertObject:atIndex:));
        fud_safekit_swizzleSelectors(mclass, @selector(removeObjectAtIndex:), self, @selector(fud_safekit_removeObjectAtIndex:));
        fud_safekit_swizzleSelectors(mclass, @selector(setObject:atIndexedSubscript:), self, @selector(fud_safekit_setObject:atIndexedSubscript:));
        fud_safekit_swizzleSelectors(mclass, @selector(replaceObjectAtIndex:withObject:), self, @selector(fud_safekit_replaceObjectAtIndex:withObject:));
    });
}

- (id)fud_safekit_objectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        NSString *method = [NSString stringWithFormat:@"****** Method: [%p objectAtIndex:%ld] ******", self, index];
        NSString *reason = [NSString stringWithFormat:@"****** Reason: %ld beyond boundary of NSMutableArray(0 ... %ld) ******", index, self.count - 1];
        NSString *error = [NSString stringWithFormat:@"%@\n%@", method, reason];
        fud_reportError(error);
        return nil;
    }
    
    return [self fud_safekit_objectAtIndex:index];
}

- (id)fud_safekit_objectAtIndexedSubscript:(NSUInteger)index {
    if (index >= self.count) {
        NSString *method = [NSString stringWithFormat:@"****** Method: [%p objectAtIndexedSubscript:%ld] ******", self, index];
        NSString *reason = [NSString stringWithFormat:@"****** Reason: %ld beyond boundary of NSMutableArray(0 ... %ld) ******", index, self.count - 1];
        NSString *error = [NSString stringWithFormat:@"%@\n%@", method, reason];
        fud_reportError(error);
        return nil;
    }
    
    return [self fud_safekit_objectAtIndexedSubscript:index];
}

- (void)fud_safekit_addObject:(id)object {
    if (!object) {
        NSString *method = [NSString stringWithFormat:@"****** Method: [%p addObject:nil] ******", self];
        NSString *reason = [NSString stringWithFormat:@"****** Reason: add nil to NSMutableArray(0 ... %ld) ******", self.count - 1];
        NSString *error = [NSString stringWithFormat:@"%@\n%@", method, reason];
        fud_reportError(error);
        return;
    }
    [self fud_safekit_addObject:object];
}

- (void)fud_safekit_insertObject:(id)object atIndex:(NSUInteger)index {
    if (!object) {
        NSString *method = [NSString stringWithFormat:@"****** Method: [%p insertObject:nil atIndex:%ld] ******", self, index];
        NSString *reason = [NSString stringWithFormat:@"****** Reason: insert nil to NSMutableArray(0 ... %ld) ******", self.count - 1];
        NSString *error = [NSString stringWithFormat:@"%@\n%@", method, reason];
        fud_reportError(error);
        return;
    }
    if (index > self.count) {
        NSString *method = [NSString stringWithFormat:@"****** Method: [%p insertObject:%p atIndex:%ld] ******", self, object, index];
        NSString *reason = [NSString stringWithFormat:@"****** Reason: %ld beyond boundary of NSMutableArray(0 ... %ld) ******", index, self.count - 1];
        NSString *error = [NSString stringWithFormat:@"%@\n%@", method, reason];
        fud_reportError(error);
        return;
    }
    [self fud_safekit_insertObject:object atIndex:index];
}

- (void)fud_safekit_removeObjectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        NSString *method = [NSString stringWithFormat:@"****** Method: [%p removeObjectAtIndex:%ld] ******", self, index];
        NSString *reason = [NSString stringWithFormat:@"****** Reason: %ld beyond boundary of NSMutableArray(0 ... %ld) ******", index, self.count - 1];
        NSString *error = [NSString stringWithFormat:@"%@\n%@", method, reason];
        fud_reportError(error);
        return;
    }
    [self fud_safekit_removeObjectAtIndex:index];
}

- (void)fud_safekit_setObject:(id)object atIndexedSubscript:(NSUInteger)index {
    if (!object) {
        NSString *method = [NSString stringWithFormat:@"****** Method: [%p setObject:nil atIndexedSubscript:%ld] ******", self, index];
        NSString *reason = [NSString stringWithFormat:@"****** Reason: set nil to NSMutableArray(0 ... %ld) ******", self.count - 1];
        NSString *error = [NSString stringWithFormat:@"%@\n%@", method, reason];
        fud_reportError(error);
        return;
    }
    if (index >= self.count) {
        NSString *method = [NSString stringWithFormat:@"****** Method: [%p setObject:%p atIndexedSubscript:%ld] ******", self, object, index];
        NSString *reason = [NSString stringWithFormat:@"****** Reason: %ld beyond boundary of NSMutableArray(0 ... %ld) ******", index, self.count - 1];
        NSString *error = [NSString stringWithFormat:@"%@\n%@", method, reason];
        fud_reportError(error);
        return;
    }
    [self fud_safekit_setObject:object atIndexedSubscript:index];
}

- (void)fud_safekit_replaceObjectAtIndex:(NSUInteger)index withObject:(id)object {
    if (!object) {
        NSString *method = [NSString stringWithFormat:@"****** Method: [%p replaceObjectAtIndex:%ld withObject:nil] ******", self, index];
        NSString *reason = [NSString stringWithFormat:@"****** Reason: replace with nil to NSMutableArray(0 ... %ld) ******", self.count - 1];
        NSString *error = [NSString stringWithFormat:@"%@\n%@", method, reason];
        fud_reportError(error);
        return;
    }
    if (index >= self.count) {
        NSString *method = [NSString stringWithFormat:@"****** Method: [%p replaceObjectAtIndex:%ld withObject:%p] ******", self, index, object];
        NSString *reason = [NSString stringWithFormat:@"****** Reason: %ld beyond boundary of NSMutableArray(0 ... %ld) ******", index, self.count - 1];
        NSString *error = [NSString stringWithFormat:@"%@\n%@", method, reason];
        fud_reportError(error);
        return;
    }
    [self fud_safekit_replaceObjectAtIndex:index withObject:object];
}

@end
