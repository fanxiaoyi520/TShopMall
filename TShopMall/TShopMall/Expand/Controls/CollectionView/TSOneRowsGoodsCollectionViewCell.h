//
//  TSOneRowsGoodsCollectionViewCell.h
//  TShopMall
//
//  Created by  on 2021/6/29.
//

#import <UIKit/UIKit.h>
#import "TSRecomendGoodsProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSOneRowsGoodsCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) id<TSRecomendGoodsProtocol> item;

@end

NS_ASSUME_NONNULL_END
