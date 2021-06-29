//
//  TSCartProtocol.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/9.
//

#import <Foundation/Foundation.h>
#import "TSCartModel.h"

@protocol TSCartProtocol <NSObject>

@optional
- (void)goodsSelected:(TSCart *)cart indexPath:(NSIndexPath *)indexPath;
- (void)changeGoodsBuyNumberOfCart:(TSCart *)cart;
- (void)allSelected:(BOOL)status;
- (void)checkGift:(TSCart *)cart;
- (void)goToShopping;
- (void)goToSettle;

- (void)recomendGoodsSelected:(NSString *)uuid;
@end

