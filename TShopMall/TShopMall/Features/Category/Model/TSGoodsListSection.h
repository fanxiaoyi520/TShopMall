//
//  TSGoodsListSection.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/13.
//

#import "TSSearchSection.h"

@class TSGoodsListRow;

@interface TSGoodsListSection : TSSearchSection

@end

@interface TSGoodsListRow : TSSearchRow
@property (nonatomic, assign) CGSize rowSize;
@end

