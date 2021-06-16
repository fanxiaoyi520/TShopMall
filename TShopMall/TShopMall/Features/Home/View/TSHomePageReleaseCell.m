//
//  TSHomePageReleaseCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/8.
//

#import "TSHomePageReleaseCell.h"
#import "TSHomePageReleaseViewModel.h"

@interface TSHomePageReleaseCell()

@property(nonatomic, strong) UIImageView *iconImageView;
@property(nonatomic, strong) UILabel *nameLabel;
@end

@implementation TSHomePageReleaseCell

- (void)setViewModel:(TSHomePageCellViewModel *)viewModel{
    [super setViewModel:viewModel];
    TSHomePageReleaseViewModel *releaseViewModel = (TSHomePageReleaseViewModel *)viewModel;

    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-16);
        make.top.equalTo(self.contentView);
        make.height.equalTo(@34);

    }];
    CGFloat height = kScreenWidth/345 * 447;
    [self.contentView addSubview:self.iconImageView];
    [self.iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-16);
        make.top.equalTo(self.nameLabel.mas_bottom);
        make.height.equalTo(@(releaseViewModel.imageViewHeight?:height));
        make.bottom.equalTo(self.contentView);

    }];

    if (releaseViewModel.imageViewHeight == 0) {
        [releaseViewModel getReleaseData];
    }
    __weak typeof(self) weakSelf = self;
    [self.KVOController observe:releaseViewModel keyPath:@"releaseModel" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
          TSHomePageBaseModel *model = change[@"new"];
          if (![change[@"new"] isKindOfClass:NSNull.class]) {
              if (model && model.image) {
                  weakSelf.iconImageView.image = model.image;
                  weakSelf.nameLabel.text = model.title;
                  releaseViewModel.imageViewHeight = model.image.size.height;
                  [weakSelf tableviewReloadCell];
              }
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
