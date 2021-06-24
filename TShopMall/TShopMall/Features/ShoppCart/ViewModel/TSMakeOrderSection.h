//
//  TSMakeOrderSection.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/16.
//

#import "TSCartGoodsSection.h"

@class TSMakeOrderRow;

@interface TSMakeOrderSection : TSCartGoodsSection
@end


@interface TSMakeOrderRow : TSCartGoodsRow<TSCartRowProtocol>
@end
