//
//  TSHighPriceTagView.m
//  TShopMall
//
//  Created by sway on 2021/6/15.
//

#import "TSHighPriceTagView.h"
@interface TSHighPriceTagView()
@property (nonatomic, strong) UIImageView *redTagImageView;
@property (nonatomic, strong) UIImageView *yellowTagImageView;
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@end
@implementation TSHighPriceTagView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        [self addSubview:self.redTagImageView];
        [self addSubview:self.yellowTagImageView];

        [self addSubview:self.leftLabel];
        [self addSubview:self.rightLabel];
        
        [self.redTagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [self.yellowTagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(self);
            make.width.equalTo(@34);
        }];
        
        [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.right.equalTo(self).offset(-2);
        }];

    }
    return self;
}

- (void)setLeftText:(NSString *)leftText rightText:(NSString *)rightText{
    self.leftLabel.text = leftText;
    self.rightLabel.text = rightText;
    self.redTagImageView.hidden = NO;
    self.yellowTagImageView.hidden = NO;

}

- (UILabel *)leftLabel{
    if (!_leftLabel) {
        _leftLabel = [UILabel new];
        _leftLabel.font = KFont(PingFangSCRegular, 10.0);
        _leftLabel.textColor = [UIColor whiteColor];
    }
    return _leftLabel;
}

- (UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [UILabel new];
        _rightLabel.font = KFont(PingFangSCRegular, 9.0);
        _rightLabel.textColor = [UIColor whiteColor];
        _rightLabel.textAlignment = NSTextAlignmentRight;
    }
    return _rightLabel;
}

- (UIImageView *)redTagImageView{
    if (!_redTagImageView) {
        _redTagImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"homePage_container_tag_red"]];
        _redTagImageView.hidden = YES;
    }
    return _redTagImageView;
}

- (UIImageView *)yellowTagImageView{
    if (!_yellowTagImageView) {
        _yellowTagImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"homePage_container_tag_yellow"]];
        _yellowTagImageView.hidden = YES;
    }
    return _yellowTagImageView;
}
@end
