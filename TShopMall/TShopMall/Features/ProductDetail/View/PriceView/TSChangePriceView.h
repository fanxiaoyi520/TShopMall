//
//  TSChangePriceView.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/22.
//

#import <UIKit/UIKit.h>
#import "TSGoodDetailItemModel.h"

@class TSChangePriceView;

@protocol TSChangePriceViewDelegate <NSObject>

-(void)changePriceView:(TSChangePriceView *_Nullable)changePriceView closeClick:(UIButton *_Nonnull)sender;
-(void)changePriceView:(TSChangePriceView *_Nullable)changePriceView shareClick:(UIButton *_Nonnull)sender discountPrice:(NSString *_Nullable)discountPrice;

@end

NS_ASSUME_NONNULL_BEGIN

@interface TSChangePriceView : UIView

@property(nonatomic, strong) TSGoodDetailItemPriceModel *model;

@property(nonatomic, weak) id<TSChangePriceViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
