//
//  TSCartProtocol.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/9.
//

#import <Foundation/Foundation.h>

@class TSCartModel;

@protocol TSCartProtocol <NSObject>

@optional
- (void)goodsSelected:(TSCartModel *)cartModel indexPath:(NSIndexPath *)indexPath;
- (void)allSelected:(BOOL)status;
- (void)checkGift:(TSCartModel *)cartModel;
@end

