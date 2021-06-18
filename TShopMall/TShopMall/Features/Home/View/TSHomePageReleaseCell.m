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

- (void)setViewModel:(TSHomePageCellViewModel *)viewModel{
    [super setViewModel:viewModel];
    TSHomePageReleaseViewModel *releaseViewModel = (TSHomePageReleaseViewModel *)viewModel;

    NSArray *temp = [NSArray yy_modelArrayWithClass:TSImageBaseModel.class json:releaseViewModel.model.data[@"list"]];
    releaseViewModel.releaseModel = temp.firstObject;

    CGFloat height = kScreenWidth/releaseViewModel.releaseModel.imageData.width * releaseViewModel.releaseModel.imageData.height;
    [self.contentView addSubview:self.iconImageView];
    [self.iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-16);
        make.top.equalTo(self.contentView);
        make.height.equalTo(@(height));
        make.bottom.equalTo(self.contentView);
    }];
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:releaseViewModel.releaseModel.imageData.url]];

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
