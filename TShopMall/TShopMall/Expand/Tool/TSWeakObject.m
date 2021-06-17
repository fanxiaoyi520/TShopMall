//
//  TSWeakObject.m
//  TShopMall
//
//  Created by sway on 2021/6/15.
//

#import "TSWeakObject.h"

@interface TSWeakObject()

@property (weak, nonatomic) id weakObject;

@end

@implementation TSWeakObject

- (instancetype)initWithWeakObject:(id)obj {
    _weakObject = obj;
    return self;
}

+ (instancetype)proxyWithWeakObject:(id)obj {
    return [[TSWeakObject alloc] initWithWeakObject:obj];
}


/**
 * 消息转发，让_weakObject响应事件
 */
- (id)forwardingTargetForSelector:(SEL)aSelector {
    return _weakObject;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    void *null = NULL;
    [invocation setReturnValue:&null];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return [_weakObject respondsToSelector:aSelector];
}
@end
