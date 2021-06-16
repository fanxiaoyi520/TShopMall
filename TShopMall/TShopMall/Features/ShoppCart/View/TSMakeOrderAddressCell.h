//
//  TSMakeOrderAddressCell.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/16.
//

#import "TSCartBaseCell.h"

@class TSMakeOrderAddressTipsCell;

@interface TSMakeOrderAddressCell : TSCartBaseCell

@end


@interface TSMakeOrderAddressTipsCell : TSCartBaseCell
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *tips;
@property (nonatomic, strong) UIImageView *indeImg;
@end
