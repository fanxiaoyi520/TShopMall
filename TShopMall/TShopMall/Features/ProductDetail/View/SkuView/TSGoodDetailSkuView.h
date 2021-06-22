//
//  TSGoodDetailSkuView.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TSGoodDetailSkuView;

@protocol GoodDetailSkuViewDelegate <NSObject>

-(void)goodDetailSkuView:(TSGoodDetailSkuView *)skuView addShoppingCart:(UIButton *)addButton;
-(void)goodDetailSkuView:(TSGoodDetailSkuView *)skuView buyImmediately:(UIButton *)buyButton;
-(void)goodDetailSkuView:(TSGoodDetailSkuView *)skuView specificationExchange:(NSDictionary *)detail;
-(void)goodDetailSkuView:(TSGoodDetailSkuView *)skuView numberChange:(NSString *)currentNumber;

@end

@interface TSGoodDetailSkuView : UIView

@property (nonatomic, weak) id<GoodDetailSkuViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
