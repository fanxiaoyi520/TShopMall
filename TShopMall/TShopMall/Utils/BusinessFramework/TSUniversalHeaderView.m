//
//  TSUniversalHeaderView.m
//  TSale
//
//  Created by 陈洁 on 2021/2/21.
//  Copyright © 2021 TCL. All rights reserved.
//

#import "TSUniversalHeaderView.h"

@interface TSUniversalHeaderView()


@end

@implementation TSUniversalHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.whiteColor;
    }
    return self;
}

@end

@interface TSUniversalTopHeaderView()

@property(nonatomic, strong) CAShapeLayer *maskLayer;

@end

@implementation TSUniversalTopHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.whiteColor;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.layer.mask = self.maskLayer;
}

-(CAShapeLayer *)maskLayer{
    if (!_maskLayer) {
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8, 8)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.bounds;
        maskLayer.path = maskPath.CGPath;
        _maskLayer = maskLayer;
    }
    return _maskLayer;
}

@end

@interface TSUniversalTopTitleHeaderView()

@property (nonatomic, strong) UILabel *headerLabel;
@property (nonatomic, strong) UIView *seperateView;

@end

@implementation TSUniversalTopTitleHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self fillCustomView];
    }
    return self;
}

-(void)fillCustomView{
    [self addSubview:self.headerLabel];
    [self addSubview:self.seperateView];
    
    [self.headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.centerY.equalTo(self);
    }];
    
    [self.seperateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self);
        make.height.mas_equalTo(0.5);
        make.bottom.equalTo(self).offset(-0.5);
    }];
}

#pragma mark - Getter
-(UILabel *)headerLabel{
    if (!_headerLabel) {
        _headerLabel = [[UILabel alloc] init];
        _headerLabel.font = KRegularFont(16);
        _headerLabel.textColor = KHexAlphaColor(@"#333333", 1.0);
        _headerLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _headerLabel;
}

-(UIView *)seperateView{
    if (!_seperateView) {
        _seperateView = [[UIView alloc] init];
        _seperateView.backgroundColor = KlineColor;
    }
    return _seperateView;
}

@end
