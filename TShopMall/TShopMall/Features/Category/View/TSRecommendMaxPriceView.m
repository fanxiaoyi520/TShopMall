//
//  TSRecommendMaxPriceView.m
//  TShopMall
//
//  Created by oneyian on 2021/6/29.
//

#import "TSRecommendMaxPriceView.h"

@interface TSRecommendMaxPriceView ()
@property (nonatomic, strong) UIImageView * left_img;
@property (nonatomic, strong) UILabel * left_label;

@property (nonatomic, strong) UIImageView * right_img;
@property (nonatomic, strong) UILabel * right_label;
@end

@implementation TSRecommendMaxPriceView

- (void)setMaxPrice:(NSString *)maxPrice {
    _maxPrice = maxPrice;
    
    if (!maxPrice) {
        maxPrice= @"0";
    }
    
    self.right_label.text = [NSString stringWithFormat:@"¥%@", maxPrice];
}

- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, 0, KRateW(69), KRateH(18))];
    if (self) {
        //right
        self.right_img = [[UIImageView alloc] initWithImage:KImageMake(@"mall_category_maxPrice_right")];
        [self addSubview:self.right_img];
        
        //left
        self.left_img = [[UIImageView alloc] initWithImage:KImageMake(@"mall_category_maxPrice_left")];
        [self addSubview:self.left_img];
        
        self.left_label = [UILabel new];
        self.left_label.font = KRegularFont(10);
        self.left_label.textColor = KWhiteColor;
        self.left_label.text = @"最高赚";
        [self.left_img addSubview:self.left_label];
        
        self.right_label = [UILabel new];
        self.right_label.font = KRegularFont(9);
        self.right_label.textColor = KWhiteColor;
        [self addSubview:self.right_label];
        
        [self.right_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [self.left_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.offset(0);
            make.width.offset(KRateW(33.7));
        }];
        
        [self.left_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.left_img);
        }];
        
        [self.right_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.left_img.mas_right).offset(2);
            make.top.right.bottom.equalTo(self);
        }];
        
        self.maxPrice = @"0";
    }
    return self;
}

@end
