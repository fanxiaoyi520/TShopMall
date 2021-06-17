//
//  TSCartCell.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/8.
//

#import "TSCartBaseCell.h"

@class TSCartGiftButton;

@interface TSCartCell : TSCartBaseCell

@end


@interface TSCartGiftButton : UIButton
@property (nonatomic, strong) UILabel *tips;
@property (nonatomic, strong) UIImageView *img;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UIImageView *indeImg;
@end
