//
//  TSUniversalFooterView.m
//  TSale
//
//  Created by 陈洁 on 2021/2/21.
//  Copyright © 2021 TCL. All rights reserved.
//

#import "TSUniversalFooterView.h"

@interface TSUniversalFooterView()


@end

@implementation TSUniversalFooterView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.whiteColor;
    }
    return self;
}

@end

@interface TSUniversalBottomFooterView()

@property(nonatomic, strong) CAShapeLayer *maskLayer;

@end

@implementation TSUniversalBottomFooterView

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
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                       byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight
                                                             cornerRadii:CGSizeMake(8, 8)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.bounds;
        maskLayer.path = maskPath.CGPath;
        _maskLayer = maskLayer;
    }
    return _maskLayer;
}

@end
