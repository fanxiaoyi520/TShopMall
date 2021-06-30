//
//  TSMineImageTextCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/11.
//

#import "TSMineImageTextCell.h"

@interface TSMineImageTextCell()

@property(nonatomic, strong) UIImageView *imgView;
@property(nonatomic, strong) UILabel *kindLabel;
@property(nonatomic, strong) UILabel *countLabel;
@end

@implementation TSMineImageTextCell

-(void)fillCustomContentView{
    self.contentView.backgroundColor = UIColor.whiteColor;
    
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.kindLabel];
    [self.contentView addSubview:self.countLabel];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(20);
        make.width.height.mas_equalTo(32);
        make.centerX.equalTo(self.contentView);
    }];
    
    [self.kindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgView.mas_bottom).offset(6);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(18);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.imgView.mas_top).offset(8);
        make.centerX.equalTo(self.imgView.mas_right).offset(-5);
        make.height.width.mas_equalTo(12);
    }];
}

 

#pragma mark - Getter
-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imgView;
}
-(UILabel *)kindLabel{
    if (!_kindLabel) {
        _kindLabel = [[UILabel alloc] init];
        _kindLabel.font = KRegularFont(12);
        _kindLabel.textAlignment = NSTextAlignmentCenter;
        _kindLabel.textColor = KTextColor;
    }
    return _kindLabel;
}

-(UILabel *)countLabel{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.font = KRegularFont(8);
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.textColor =  KWhiteColor;
        _countLabel.backgroundColor = KHexColor(@"#FF4D49");
    }
    return _countLabel;
}

-(void)setDelegate:(id<UniversalCollectionViewCellDataDelegate>)delegate{
    TSMineSectionOrderItemModel *item = [delegate universalCollectionViewCellModel:self.indexPath];
    self.imgView.image = KImageMake(item.imageName);
    self.kindLabel.text = item.title;
    if ([item.orderCount isEqualToString:@"0"] || item.orderCount == nil) {
        self.countLabel.hidden = YES;
    } else {
        self.countLabel.hidden = NO;
        self.countLabel.text = item.orderCount;
        if (item.orderCount.length > 2) {
            self.countLabel.text = @"99+";
        }
        CGFloat width = [_countLabel sizeThatFits:CGSizeMake(50, 50)].width + 8;
        [self.countLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(width);
        } ];
        _countLabel.layer.cornerRadius = width/2;
        _countLabel.layer.masksToBounds = YES;
    }
}

@end
