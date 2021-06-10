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
- (void)goodsSelected:(TSCart *)cartModel indexPath:(NSIndexPath *)indexPath;
- (void)allSelected:(BOOL)status;
- (void)checkGift:(TSCart *)cartModel;
- (void)goToShopping;
@end

