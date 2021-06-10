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
