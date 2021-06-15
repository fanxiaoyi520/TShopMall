//
//  TSGoodDetailPriceCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/15.
//

#import "TSGoodDetailPriceCell.h"

@interface TSGoodDetailPriceCell()

/// 统一售价
@property (nonatomic, strong) UILabel *unifiedPriceLable;
/// 提货价
@property (nonatomic, strong) UILabel *deliveryLable;

@end

@implementation TSGoodDetailPriceCell

-(void)fillCustomContentView{
    self.contentView.backgroundColor = [UIColor orangeColor];
}

@end
