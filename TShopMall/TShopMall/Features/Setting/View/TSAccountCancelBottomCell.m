//
//  TSAccountCancelBottomCell.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/15.
//

#import "TSAccountCancelBottomCell.h"
#import "TSAccountCancelSectionModel.h"

@interface TSAccountCancelBottomCell ()
/** 取消 */
@property(nonatomic, weak) UIButton *cancelButton;
/** 确认按钮 */
@property(nonatomic, weak) UIButton *confirmButton;

@end

@implementation TSAccountCancelBottomCell

- (void)fillCustomContentView {
    [super fillCustomContentView];
    ///添加约束
    [self addConstraints];
}

- (void)addConstraints {
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(25);
        make.right.equalTo(self.confirmButton.mas_left).with.offset(-16);
        make.width.equalTo(self.confirmButton.mas_width).with.offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-48);
        make.height.mas_equalTo(40);
    }];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cancelButton.mas_right).with.offset(16);
        make.right.equalTo(self.contentView.mas_right).with.offset(-25);
        make.width.equalTo(self.cancelButton.mas_width).with.offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-48);
        make.height.mas_equalTo(40);
    }];
}

- (UIButton *)cancelButton {
    if (_cancelButton == nil) {
        UIButton *cancelButton = [[UIButton alloc] init];
        _cancelButton = cancelButton;
        _cancelButton.titleLabel.font = KRegularFont(14);
        _cancelButton.layer.masksToBounds = YES;
        _cancelButton.layer.cornerRadius = 20;
        _cancelButton.clipsToBounds = YES;
        _cancelButton.layer.borderWidth = 1.0;
        _cancelButton.layer.borderColor = KHexColor(@"#FF4D49").CGColor;
        [_cancelButton setTitleColor:KHexColor(@"#FF4D49") forState:UIControlStateNormal];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [self.contentView addSubview:_cancelButton];
    }
    return _cancelButton;
}

- (UIButton *)confirmButton {
    if (_confirmButton == nil) {
        UIButton *confirmButton = [[UIButton alloc] init];
        _confirmButton = confirmButton;
        _confirmButton.titleLabel.font = KRegularFont(14);
        _confirmButton.layer.masksToBounds = YES;
        _confirmButton.layer.cornerRadius = 20;
        _confirmButton.clipsToBounds = YES;
        _confirmButton.layer.borderWidth = 1.0;
        _confirmButton.layer.borderColor = KHexColor(@"#FF4D49").CGColor;
        [_confirmButton setTitleColor:KHexColor(@"#FF4D49") forState:UIControlStateNormal];
        [self.contentView addSubview:_confirmButton];
    }
    return _confirmButton;
}

- (void)setDelegate:(id<UniversalCollectionViewCellDataDelegate>)delegate {
    TSAccountCancelSectionItemModel *item = [delegate universalCollectionViewCellModel:self.indexPath];
    [self.confirmButton setTitle:item.nextTitle forState:UIControlStateNormal];
}

@end
