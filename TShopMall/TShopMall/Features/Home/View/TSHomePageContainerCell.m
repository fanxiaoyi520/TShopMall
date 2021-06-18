//
//  TSHomePageContainerCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/8.
//

#import "TSHomePageContainerCell.h"
#import "TSHomePageContainerViewModel.h"
#import "TSHomePageContainerCollectionView.h"

@interface TSHomePageContainerCell()
@property(nonatomic, strong) TSHomePageContainerViewModel *containerViewModel;

@end
@implementation TSHomePageContainerCell

- (void)setupUI{
//    [self.contentView addSubview:self.containerView];
//    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.contentView);
//        make.width.equalTo(@(kScreenWidth));
//        make.height.equalTo(@([TSHomePageContainerCell getContainerHeight]));
//       }];
}

- (void)setViewModel:(TSHomePageCellViewModel *)viewModel{
    [super setViewModel:viewModel];
    self.containerViewModel = (TSHomePageContainerViewModel *)viewModel;
    
}

@end

