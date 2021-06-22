//
//  TSProductDetailPurchaseCell.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/15.
//

#import "TSUniversalCollectionViewCell.h"

typedef NS_ENUM(NSUInteger, PurchaseCellMoreType){
    PurchaseCellMoreTypeGift,       //赠品
    PurchaseCellMoreTypeSelected,   //已选
    PurchaseCellMoreTypeDelivery,   //配送
    PurchaseCellMoreTypeFee         //运费
};

NS_ASSUME_NONNULL_BEGIN

@interface TSProductDetailPurchaseCell : TSUniversalCollectionViewCell

@end

NS_ASSUME_NONNULL_END
