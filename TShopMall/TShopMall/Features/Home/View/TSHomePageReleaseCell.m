//
//  TSHomePageReleaseCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/8.
//

#import "TSHomePageReleaseCell.h"
#import "TSHomePageReleaseViewModel.h"
#import "UIImageView+WebCache.h"
#import "TSImageBaseModel.h"
@interface TSHomePageReleaseCell()

@property(nonatomic, strong) UIImageView *iconImageView;
@property(nonatomic, strong) UILabel *nameLabel;
@end

@implementation TSHomePageReleaseCell
-(void)setupUI{
    [self.contentView addSubview:self.iconImageView];
    CGFloat height = kScreenWidth/345 * 447;

    [self.iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-16);
        make.top.equalTo(self.contentView);
        make.height.equalTo(@(height));
        make.bottom.equalTo(self.contentView);
    }];
}

- (void)setViewModel:(TSHomePageCellViewModel *)viewModel{
    [super setViewModel:viewModel];
    TSHomePageReleaseViewModel *releaseViewModel = (TSHomePageReleaseViewModel *)viewModel;

    if (!releaseViewModel.releaseModel) {
        [releaseViewModel getReleaseData];
    }
    @weakify(self);
    [self.KVOController observe:releaseViewModel keyPath:@"releaseModel" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        @strongify(self)
        if (releaseViewModel.releaseModel) {
            CGFloat height = kScreenWidth/releaseViewModel.releaseModel.imageData.width * releaseViewModel.releaseModel.imageData.height;
            [self.iconImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@(height));
            }];
            
            [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:releaseViewModel.releaseModel.imageData.url]];
        }
    }];

    

}



#pragma mark - Getter
-(UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.backgroundColor = KHexColor(@"EFEFEF");
        _iconImageView.clipsToBounds = YES;
        _iconImageView.layer.cornerRadius = 8;
    }
    return _iconImageView;
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
