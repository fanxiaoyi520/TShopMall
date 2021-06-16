//
//  TSAccountCancelContentCell.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/15.
//

#import "TSAccountCancelContentCell.h"
#import "TSAccountCancelSectionModel.h"

@interface TSAccountCancelContentCell ()
/** 显示昵称 */
@property(nonatomic, weak) UILabel *contentLabel;

@end

@implementation TSAccountCancelContentCell

- (void)fillCustomContentView {
    [super fillCustomContentView];
    ///添加约束
    [self addConstraints];
}

- (void)addConstraints {
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(25);
        make.right.equalTo(self.contentView.mas_right).with.offset(-25);
        make.top.equalTo(self.contentView.mas_top).with.offset(30);
    }];
}

- (UILabel *)contentLabel {
    if (_contentLabel == nil) {
        UILabel *contentLabel = [[UILabel alloc] init];
        _contentLabel = contentLabel;
        _contentLabel.textColor = KHexAlphaColor(@"#2D3132", 0.6);
        _contentLabel.font = KRegularFont(14);
        _contentLabel.numberOfLines = 0;
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
}

- (void)setDelegate:(id<UniversalCollectionViewCellDataDelegate>)delegate {
    TSAccountCancelSectionItemModel *item = [delegate universalCollectionViewCellModel:self.indexPath];
    self.contentLabel.text = item.content;
}

@end
