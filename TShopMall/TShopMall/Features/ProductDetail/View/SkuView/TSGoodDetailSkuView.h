//
//  TSGoodDetailSkuView.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/21.
//

#import <UIKit/UIKit.h>
#import "TSGoodDetailItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@class TSGoodDetailSkuView;

@protocol GoodDetailSkuViewDelegate <NSObject>

-(void)goodDetailSkuViewCloseClick:(TSGoodDetailSkuView *)skuView;
-(void)goodDetailSkuView:(TSGoodDetailSkuView *)skuView addShoppingCartNum:(NSString *)buyNum;
-(void)goodDetailSkuView:(TSGoodDetailSkuView *)skuView buyImmediatelyNum:(NSString *)buyNum;
-(void)goodDetailSkuView:(TSGoodDetailSkuView *)skuView specificationExchange:(NSDictionary *)detail;
-(void)goodDetailSkuView:(TSGoodDetailSkuView *)skuView numberChange:(NSString *)currentNumber;

@end

@interface TSGoodDetailSkuView : UIView

@property(nonatomic, strong) TSGoodDetailItemPurchaseModel *purchaseModel;

@property (nonatomic, weak) id<GoodDetailSkuViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
