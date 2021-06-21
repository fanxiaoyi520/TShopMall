//
//  UIControl+RepeatClick.m
//  TCLPlus
//
//  Created by tangzhiqiang on 2020/9/5.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import <objc/runtime.h>

#import "UIControl+RepeatClick.h"


@implementation UIControl (RepeatClick)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self tcl_bestInstanceMethodSwizzlingWithClass:self oriSEL:@selector(sendAction:to:forEvent:) swizzledSEL:@selector(_sendAction:to:forEvent:)];
    });
}

- (void)_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if ([self isKindOfClass:[self class]]) {
        if (self.eventInterval > 0.00001) {
            if (self.eventUnavailable == NO) {
                self.eventUnavailable = YES;
                [self _sendAction:action to:target forEvent:event];
                [self performSelector:@selector(setEventUnavailable:) withObject:0 afterDelay:self.eventInterval];
            }
        } else {
            [self _sendAction:action to:target forEvent:event];
        }
    } else {
        [self _sendAction:action to:target forEvent:event];
    }
}

#pragma mark - Setter & Getter functions

- (NSTimeInterval)eventInterval {
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}

- (void)setEventInterval:(NSTimeInterval)eventInterval {
    objc_setAssociatedObject(self, @selector(eventInterval), @(eventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (BOOL)eventUnavailable {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setEventUnavailable:(BOOL)eventUnavailable {
    objc_setAssociatedObject(self, @selector(eventUnavailable), @(eventUnavailable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/// 交换对象方法
+ (void)tcl_bestInstanceMethodSwizzlingWithClass:(Class)cls oriSEL:(SEL)oriSEL swizzledSEL:(SEL)swizzledSEL {
    NSAssert(cls, @"传入的交换类不能为空");

    Method oriMethod = class_getInstanceMethod(cls, oriSEL);
    Method swiMethod = class_getInstanceMethod(cls, swizzledSEL);
    if (!oriMethod) {
        class_addMethod(cls, oriSEL, method_getImplementation(swiMethod), method_getTypeEncoding(swiMethod));
        // IMP指向了一个空的block方法（空IMP）
        method_setImplementation(swiMethod,
                                 imp_implementationWithBlock(^(id self, SEL _cmd){}));
    }

    BOOL didAddMethod = class_addMethod(cls, oriSEL, method_getImplementation(swiMethod), method_getTypeEncoding(swiMethod));
    if (didAddMethod) {
        class_replaceMethod(cls, swizzledSEL, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    } else {
        method_exchangeImplementations(oriMethod, swiMethod);
    }
}

/// 交换类方法
+ (void)tcl_bestClassMethodSwizzlingWithClass:(Class)cls oriSEL:(SEL)oriSEL swizzledSEL:(SEL)swizzledSEL {
    NSAssert(cls, @"传入的交换类不能为空");

    Method swiCLassMethod = class_getClassMethod([cls class], swizzledSEL);
    Method oriClassMethod = class_getClassMethod([cls class], oriSEL);
    if (!oriClassMethod) {
        class_addMethod(object_getClass([cls class]), oriSEL, method_getImplementation(swiCLassMethod), method_getTypeEncoding(swiCLassMethod));
        method_setImplementation(swiCLassMethod,
                                 imp_implementationWithBlock(^(id self, SEL _cmd){}));
    }
    BOOL didAddMethod = class_addMethod(object_getClass([cls class]), oriSEL, method_getImplementation(swiCLassMethod), method_getTypeEncoding(swiCLassMethod));
    if (didAddMethod) {
        class_replaceMethod(object_getClass([cls class]), swizzledSEL, method_getImplementation(oriClassMethod), method_getTypeEncoding(oriClassMethod));
    } else {
        method_exchangeImplementations(oriClassMethod, swiCLassMethod);
    }
}

@end
