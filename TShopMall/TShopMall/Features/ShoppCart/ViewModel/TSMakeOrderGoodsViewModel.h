//
//  TSMakeOrderGoodsViewModel.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/24.
//

#import <Foundation/Foundation.h>
#import "TSBalanceModel.h"

@interface TSMakeOrderGoodsViewModel : NSObject
@property (nonatomic, copy) NSString *productImgUrl;
@property (nonatomic, copy) NSString *productName;
@property (nonatomic, copy) NSString *attr;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, assign) NSInteger buyNum;
@property (nonatomic, copy) NSString *productUuid;

- (instancetype)initWithDetail:(TSBalanceCartManagerDetailModel *)detail;
@end

