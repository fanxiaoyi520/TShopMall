//
//  TSGridGoodsCollectionViewCell.h
//  TShopMall
//
//  Created by sway on 2021/6/27.
//

#import <UIKit/UIKit.h>
#import "TSRecomendGoodsProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface TSGridGoodsCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) id<TSRecomendGoodsProtocol> item;
@end

NS_ASSUME_NONNULL_END
