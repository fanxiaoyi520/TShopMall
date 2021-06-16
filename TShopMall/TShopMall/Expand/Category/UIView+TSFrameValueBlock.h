//
//  UIView+TSFrameValueBlock.h
//  TShopMall
//
//  Created by sway on 2021/6/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^TSFrameValueBlock) (void);

@interface UIView (TSFrameValueBlock)
@property (nonatomic,copy) TSFrameValueBlock frameValueBlock;

@end

NS_ASSUME_NONNULL_END
