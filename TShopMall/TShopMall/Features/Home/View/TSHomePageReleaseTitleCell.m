//
//  TSHomePageReleaseTitleCell.m
//  TShopMall
//
//  Created by sway on 2021/6/16.
//

#import "TSHomePageReleaseTitleCell.h"
#import "TSHomePageReleaseTitleViewModel.h"

@interface TSHomePageReleaseTitleCell()
@property(nonatomic, strong) UILabel *nameLabel;
@end
@implementation TSHomePageReleaseTitleCell
- (void)setupUI{
    [super setupUI];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-16);
        make.top.equalTo(self.contentView);
        make.height.equalTo(@34);
        make.bottom.equalTo(self.contentView);
    }];

}

- (void)setViewModel:(TSHomePageCellViewModel *)viewModel{
    [super setViewModel:viewModel];
    TSHomePageReleaseTitleViewModel *releaseViewModel = (TSHomePageReleaseTitleViewModel *)viewModel;
    
    if (!releaseViewModel.title) {
        [releaseViewModel getReleaseTitleData];
    }
    
    @weakify(self);
    [self.KVOController observe:releaseViewModel keyPath:@"title" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        @strongify(self)
        if (releaseViewModel.title) {
            self.nameLabel.attributedText = releaseViewModel.title;
        }
    }];
    
    
}


- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = KHexColor(@"393939");
        _nameLabel.font = KRegularFont(16);
    }
    return _nameLabel;
}

@end
