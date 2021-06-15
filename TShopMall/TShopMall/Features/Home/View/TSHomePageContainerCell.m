//
//  TSHomePageContainerCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/8.
//

#import "TSHomePageContainerCell.h"
#import "TSHomePageContainerViewModel.h"
#import "UIView+TSFrameValueBlock.h"
#import "TSHomePageContainerScrollView.h"

@interface TSHomePageContainerCell()<UIScrollViewDelegate>
@property(nonatomic, strong) TSHomePageContainerViewModel *containerViewModel;
@property(nonatomic, strong) TSHomePageContainerScrollView *containerScrollView;

@end
@implementation TSHomePageContainerCell

- (void)setupUI{
    [self.contentView addSubview:self.containerScrollView];
    [self.containerScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    __weak typeof(self) weakSelf = self;
    self.containerScrollView.frameValueBlock = ^{
        [weakSelf tableviewReloadCell];
    };
}

- (void)setViewModel:(TSHomePageCellViewModel *)viewModel{
    [super setViewModel:viewModel];
    self.containerScrollView.viewModel = (TSHomePageContainerViewModel *)viewModel;
}

- (TSHomePageContainerScrollView *)containerScrollView{
    if (!_containerScrollView) {
        _containerScrollView = [TSHomePageContainerScrollView new];
    }
    return _containerScrollView;
}



@end
