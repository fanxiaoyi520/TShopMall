//
//  UIView+TSFrameValueBlock.m
//  TShopMall
//
//  Created by sway on 2021/6/13.
//

#import "UIView+TSFrameValueBlock.h"
static const void *returnBlockKey = &returnBlockKey;
@implementation UIView (TSFrameValueBlock)
@dynamic frameValueBlock;

- (TSFrameValueBlock)frameValueBlock {
    return objc_getAssociatedObject(self, returnBlockKey);
}

- (void)setFrameValueBlock:(TSFrameValueBlock)frameValueBlock{
    objc_setAssociatedObject(self, returnBlockKey, frameValueBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end
