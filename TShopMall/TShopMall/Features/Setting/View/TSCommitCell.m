//
//  TSCommitCell.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/15.
//

#import "TSCommitCell.h"
#import "TSAccountCancelSectionModel.h"

@interface TSCommitCell ()
/** 取消 */
@property(nonatomic, weak) UIButton *commitButton;

@end

@implementation TSCommitCell

- (void)fillCustomContentView {
    [super fillCustomContentView];
    ///添加约束
    [self addConstraints];
}

- (void)addConstraints {
    [self.commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(25);
        make.right.equalTo(self.contentView.mas_right).with.offset(-25);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-48);
        make.height.mas_equalTo(40);
    }];
}

- (UIButton *)commitButton {
    if (_commitButton == nil) {
        UIButton *commitButton = [[UIButton alloc] init];
        _commitButton = commitButton;
        _commitButton.backgroundColor = KHexColor(@"#FF4D49");
        _commitButton.layer.cornerRadius = 20;
        _commitButton.clipsToBounds = YES;
        _commitButton.titleLabel.font = KRegularFont(16);
        //[_commitButton setTitle:@"确认" forState:UIControlStateNormal];
        [_commitButton addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_commitButton];
    }
    return _commitButton;
}

- (void)commitAction {
    if ([self.actionDelegate respondsToSelector:@selector(commitAction)]) {
        [self.actionDelegate commitAction];
    }
}

- (void)setDelegate:(id<UniversalCollectionViewCellDataDelegate>)delegate {
    TSAccountCancelSectionItemModel *item = [delegate universalCollectionViewCellModel:self.indexPath];
    [self.commitButton setTitle:item.title forState:UIControlStateNormal];
}

@end
