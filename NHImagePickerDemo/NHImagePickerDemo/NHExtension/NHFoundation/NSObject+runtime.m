
//
//  NSObject+runtime.m
//  NHExtension
//
//  Created by neghao on 2016/10/13.
//  Copyright © 2016年 facebac. All rights reserved.
//

#import "NSObject+runtime.h"
#import <objc/runtime.h>


@implementation NSObject (runtime)

+ (void)swizzleClassMethod:(Class)class originSelector:(SEL)originSelector otherSelector:(SEL)otherSelector
{
    Method otherMehtod = class_getClassMethod(class, otherSelector);
    Method originMehtod = class_getClassMethod(class, originSelector);
    if ([NSStringFromClass(class) isEqualToString:@"__NSArrayI"] ||
        [NSStringFromClass(class) isEqualToString:@"__NSArrayM"] ||
        [NSStringFromClass(class) isEqualToString:@"__NSPlaceholderDictionary"] ||
        [NSStringFromClass(class) isEqualToString:@"__NSDictionaryM"]) {
    // 交换2个方法的实现
        method_exchangeImplementations(otherMehtod, originMehtod);
    }
}

+ (void)swizzleInstanceMethod:(Class)class originSelector:(SEL)originSelector otherSelector:(SEL)otherSelector
{
    Method otherMehtod = class_getInstanceMethod(class, otherSelector);
    Method originMehtod = class_getInstanceMethod(class, originSelector);
    if ([NSStringFromClass(class) isEqualToString:@"__NSArrayI"] ||
        [NSStringFromClass(class) isEqualToString:@"__NSArrayM"] ||
        [NSStringFromClass(class) isEqualToString:@"__NSPlaceholderDictionary"] ||
        [NSStringFromClass(class) isEqualToString:@"__NSDictionaryM"]) {
    // 交换2个方法的实现
        method_exchangeImplementations(otherMehtod, originMehtod);
    }
}

@end

@implementation NSArray (runtime)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethod:NSClassFromString(@"__NSArrayI") originSelector:@selector(objectAtIndex:) otherSelector:@selector(yb_objectAtIndex:)];
    });
}

- (id)yb_objectAtIndex:(NSInteger)index
{
    if (index < self.count) {
        return [self yb_objectAtIndex:index];
    } else {
        
#if DEBUG
        NSAssert(NO, @"数组越界了。。。。。。。");
#else

#endif
        return nil;
    }
}

@end

@implementation NSMutableArray (runtime)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethod:NSClassFromString(@"__NSArrayM") originSelector:@selector(insertObject:atIndex:) otherSelector:@selector(yb_insertObject:atIndex:)];
        [self swizzleInstanceMethod:NSClassFromString(@"__NSArrayM") originSelector:@selector(objectAtIndex:) otherSelector:@selector(yb_objectAtIndex:)];
    });
}

- (void)yb_insertObject:(id)anObject atIndex:(NSUInteger)index
{
    if (anObject != nil && index<=self.count) {
        [self yb_insertObject:anObject atIndex:index];
    }
}

- (id)yb_objectAtIndex:(NSInteger)index
{
    if (index < self.count) {
        return [self yb_objectAtIndex:index];
    } else {
#if DEBUG
        NSAssert(NO, @"数组越界了。。。。。。。");
#else

#endif
        return nil;
    }
}

@end

@implementation NSDictionary (runtime)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethod:NSClassFromString(@"__NSPlaceholderDictionary") originSelector:@selector(initWithObjects:forKeys:count:) otherSelector:@selector(yb_initWithObjects:forKeys:count:)];
    });
}

- (instancetype)yb_initWithObjects:(const id  _Nonnull __unsafe_unretained *)objects forKeys:(const id<NSCopying>  _Nonnull __unsafe_unretained *)keys count:(NSUInteger)cnt
{
    for (int i=0; i<cnt; i++) {
        if (objects[i] == nil) {

            return nil;
        }
    }
    return [self yb_initWithObjects:objects forKeys:keys count:cnt];
}

@end

@implementation NSMutableDictionary (runtime)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethod:NSClassFromString(@"__NSDictionaryM") originSelector:@selector(setObject:forKey:) otherSelector:@selector(yb_setObject:forKey:)];
    });
}

- (void)yb_setObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (anObject!=nil) {
        [self yb_setObject:anObject forKey:aKey];
    } else {
#if DEBUG
        NSAssert(NO, @"设置了字典的value为nil");
#else

#endif
    }
}


@end
