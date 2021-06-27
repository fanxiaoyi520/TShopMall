//
//  TSRecomendGoodsProtocol.h
//  TShopMall
//
//  Created by sway on 2021/6/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TSRecomendGoodsProtocol <NSObject>
@property (nonatomic, copy) NSString *goodsPrice;
@property (nonatomic, copy) NSString *staffPrice;
@property (nonatomic, copy) NSString *earnMost;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *uuid;//商品UUID

@end

NS_ASSUME_NONNULL_END
