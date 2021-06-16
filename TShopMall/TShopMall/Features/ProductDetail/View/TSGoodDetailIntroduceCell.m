//
//  TSGoodDetailIntroduceCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/15.
//

#import "TSGoodDetailIntroduceCell.h"

@interface TSGoodDetailIntroduceCell()

/// 标题
@property(nonatomic, strong) UILabel *titleLabel;
/// 内容
@property(nonatomic, strong) UILabel *contentLabel;

@end

@implementation TSGoodDetailIntroduceCell

-(void)fillCustomContentView{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.contentLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(23);
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-15);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(4);
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-15);
    }];
}

#pragma mark - Getter
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = KRegularFont(16);
        _titleLabel.textColor = KTextColor;
        _titleLabel.text = @"标题标题标题标题标题";
    }
    return _titleLabel;
}

-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = KRegularFont(14);
        _contentLabel.textColor = KHexAlphaColor(@"#2D3132", 0.4);
        _contentLabel.text = @"卖点提炼，卖点介绍卖";
    }
    return _contentLabel;
}

@end
