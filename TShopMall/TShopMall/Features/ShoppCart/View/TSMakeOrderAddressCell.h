//
//  TSMakeOrderAddressCell.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/16.
//

#import "TSMakeOrderBaseCell.h"

@class TSMakeOrderAddressTipsCell;

@interface TSMakeOrderAddressCell : TSMakeOrderBaseCell

@end


@interface TSMakeOrderAddressTipsCell : TSMakeOrderBaseCell
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *tips;
@property (nonatomic, strong) UIImageView *indeImg;
@end
