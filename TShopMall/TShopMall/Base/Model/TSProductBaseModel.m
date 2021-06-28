//
//  TSProductBaseModel.m
//  TShopMall
//
//  Created by sway on 2021/6/17.
//

#import "TSProductBaseModel.h"

@implementation TSProductBaseModel

@synthesize earnMost = _earnMost;

@synthesize goodsPrice = _goodsPrice;
- (NSString *)goodsPrice{
    return [NSString stringWithFormat:@"%.0f",self.price];
}
@synthesize imageUrl;
- (NSString *)imageUrl{
    return self.pic;
}
@synthesize staffPrice = _staffPrice;
@synthesize goodsEarnMost = _goodsEarnMost;
- (NSString *)goodsEarnMost{
    return [NSString stringWithFormat:@"%.0f",self.earnMost];
}
@synthesize goodsStaffPrice = _goodsStaffPrice;
- (NSString *)goodsStaffPrice{
    return [NSString stringWithFormat:@"%.0f",self.staffPrice];
}
@end
