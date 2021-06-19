//
//  TSHomePageLoginBarView.h
//  TShopMall
//
//  Created by sway on 2021/6/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^LoginBarViewClickBlock)(void);
@interface TSHomePageLoginBarView : UIView
@property(nonatomic,copy) LoginBarViewClickBlock clickBlock;

@end

NS_ASSUME_NONNULL_END
