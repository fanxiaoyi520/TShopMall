//
//  TSHomePageReleaseCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/8.
//

#import "TSHomePageReleaseCell.h"
#import "TSHomePageReleaseViewModel.h"
#import "UIButton+WebCache.h"
#import "TSImageBaseModel.h"
#import "TSRecomendGoodsView.h"
@interface TSHomePageReleaseCell()
@property(nonatomic, strong) NSMutableArray *iconButtons;

//@property(nonatomic, strong) UIButton *iconButton;
//@property(nonatomic, strong) UILabel *nameLabel;
//@property(nonatomic, strong) TSRecomendGoodsView *goodsView;
@property(nonatomic, strong) TSHomePageReleaseViewModel *releaseViewModel;

@end

@implementation TSHomePageReleaseCell
-(void)setupUI{
//    [self.contentView addSubview:self.iconButton];
//    CGFloat height = kScreenWidth/345 * 447;
//
//    [self.iconButton mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView).offset(16);
//        make.right.equalTo(self.contentView).offset(-16);
//        make.top.equalTo(self.contentView);
//        make.height.equalTo(@(height));
//        make.bottom.equalTo(self.contentView).priorityLow();
//    }];
    
//    [self.contentView addSubview:self.goodsView];
//
//    [self.goodsView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.contentView);
//    }];
   
}

- (void)setViewModel:(TSHomePageCellViewModel *)viewModel{
    [super setViewModel:viewModel];
//    self.releaseViewModel = (TSHomePageReleaseViewModel *)viewModel;
//    @weakify(self);
//    if (!self.releaseViewModel.datas.count) {
//        [self.goodsView getRecommendListWithType:@"searchResult_page" success:^(NSArray * _Nullable list) {
//            @strongify(self)
//            self.releaseViewModel.datas = list;
//            [self tableviewReloadCell];
//        }];
//
//    }else{
//        self.goodsView.items = self.releaseViewModel.datas;
//    }
    
    TSHomePageReleaseViewModel *releaseViewModel = (TSHomePageReleaseViewModel *)viewModel;

    if (!releaseViewModel.ReleaseDatas) {
        [releaseViewModel getReleaseData];
    }
    @weakify(self);
    [self.KVOController observe:releaseViewModel keyPath:@"ReleaseDatas" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        @strongify(self)
        if (releaseViewModel.ReleaseDatas.count) {
            [self.iconButtons removeAllObjects];
            for (TSImageBaseModel *model in releaseViewModel.ReleaseDatas) {
                UIButton *iconButton = [[UIButton alloc] init];
                iconButton.backgroundColor = [UIColor clearColor];
                iconButton.clipsToBounds = YES;
                iconButton.layer.cornerRadius = 8;
                [iconButton addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
                iconButton.adjustsImageWhenHighlighted = NO;
                [self.contentView addSubview:iconButton];
                [iconButton sd_setImageWithURL:[NSURL URLWithString:model.imageData.url] forState:UIControlStateNormal];
                [self.iconButtons addObject:iconButton];
            }
            
            for (int i = 0; i < self.iconButtons.count; i ++) {
                TSImageBaseModel *model = releaseViewModel.ReleaseDatas[i];
                UIButton *iconButton = self.iconButtons[i];
                CGFloat top = 0.0;
                if (i == 0) {
                    top = 0;
                }
                else{
                    UIButton *iconButton = self.iconButtons[i-1];
                    top = iconButton.height;
                }
                CGFloat height = (kScreenWidth-32)/model.imageData.width * model.imageData.height;
                [iconButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(@(top));
                    make.centerX.equalTo(self.contentView);
                    make.width.equalTo(@(kScreenWidth-32));
                    make.height.equalTo(@(height));
                    if (self.iconButtons.count-1 == i) {
                        make.bottom.equalTo(self.contentView);
                    }
                    
                }];
                [iconButton layoutIfNeeded];
            }
        }
    }];
}

- (void)clickAction{
//    TSHomePageReleaseViewModel *releaseViewModel = (TSHomePageReleaseViewModel *)self.viewModel;
//    NSLog(@"uri:%@", releaseViewModel.releaseModel.linkData.objectValue);
}

#pragma mark - Getter
//-(UIButton *)iconButton{
//    if (!_iconButton) {
//        _iconButton = [[UIButton alloc] init];
//        _iconButton.backgroundColor = [UIColor clearColor];
//        _iconButton.clipsToBounds = YES;
//        _iconButton.layer.cornerRadius = 8;
//        [_iconButton addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
//        _iconButton.adjustsImageWhenHighlighted = NO;
//    }
//    return _iconButton;
//}

//- (UILabel *)nameLabel{
//    if (!_nameLabel) {
//        _nameLabel = [UILabel new];
//        _nameLabel.textColor = KHexColor(@"393939");
//        _nameLabel.font = KRegularFont(16);
//    }
//    return _nameLabel;
//}
//
//- (TSRecomendGoodsView *)goodsView{
//    if (!_goodsView) {
//        _goodsView = [TSRecomendGoodsView new];
//    }
//    return _goodsView;
//}

- (NSMutableArray *)iconButtons{
    if (!_iconButtons) {
        _iconButtons = @[].mutableCopy;
    }
    return _iconButtons;
}
@end
