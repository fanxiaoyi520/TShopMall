//
//  TSProductFooterView.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSProductFooterView : UIView

@property(nonatomic, copy) void(^cartBlock) (void);
@property(nonatomic, copy) void(^buyBlock) (void);

@end

NS_ASSUME_NONNULL_END
