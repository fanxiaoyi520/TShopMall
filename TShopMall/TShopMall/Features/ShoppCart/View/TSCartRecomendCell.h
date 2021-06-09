//
//  TSCartRecomendCell.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/9.
//

#import "TSCartBaseCell.h"

@class TSCartRecomendView;

@interface TSCartRecomendCell : TSCartBaseCell

@end

@interface TSCartRecomendView : UIView
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *thPrice;
@end
