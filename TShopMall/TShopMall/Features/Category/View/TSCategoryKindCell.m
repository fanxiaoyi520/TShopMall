//
//  TSCategoryKindCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/10.
//

#import "TSCategoryKindCell.h"

@interface TSCategoryKindCell()

/// 分类名称
@property(nonatomic, strong) UILabel *kindLabel;
/// 选中标识
@property(nonatomic, strong) UIView *seperateView;

@end

@implementation TSCategoryKindCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)bindKindViewModel:(TSCategoryKindCellViewModel *)viewModel{
    self.kindLabel.text = viewModel.kind;
    if (viewModel.selected) {
        self.seperateView.backgroundColor = KMainColor;
        self.kindLabel.textColor = KMainColor;
    }else{
        self.seperateView.backgroundColor = UIColor.whiteColor;
        self.kindLabel.textColor = KTextColor;
    }
}

- (void)fillCustomContentView{
    [self.contentView addSubview:self.kindLabel];
    [self.contentView addSubview:self.seperateView];
    
    [self.seperateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(4);
        make.height.mas_equalTo(24);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.kindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.seperateView.mas_right).offset(0);
        make.right.top.bottom.equalTo(self.contentView);
        make.height.equalTo(@44);
    }];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - Getter
-(UILabel *)kindLabel{
    if (!_kindLabel) {
        _kindLabel = [[UILabel alloc] init];
        _kindLabel.font = KFont(PingFangSCMedium, 14);
        _kindLabel.textAlignment = NSTextAlignmentCenter;
        _kindLabel.highlightedTextColor = KMainColor;
    }
    return _kindLabel;
}

-(UIView *)seperateView{
    if (!_seperateView) {
        _seperateView = [[UIView alloc] init];
        _seperateView.backgroundColor = [UIColor whiteColor];
    }
    return _seperateView;
}

@end
