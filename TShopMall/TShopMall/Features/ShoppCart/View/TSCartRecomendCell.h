//
//  TSCartRecomendCell.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/9.
//

#import "TSCartBaseCell.h"

@class TSCartRecomendView;
@class TSCartEarnView;

@interface TSCartRecomendCell : TSCartBaseCell

@end

@interface TSCartRecomendView : UIView
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *thPrice;
@property (nonatomic, strong) TSCartEarnView *earnView;
@end

@interface TSCartEarnView : UIView
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UIView *tipsBg;
@property (nonatomic, strong) UILabel *tips;
- (void)updatePrice:(NSString *)price;
@end
