//
//  TSHomePageBaseCell.m
//  TShopMall
//
//  Created by sway on 2021/6/11.
//

#import "TSHomePageBaseCell.h"

@implementation TSHomePageBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)tableviewReloadCell {
    [UIView performWithoutAnimation:^{
        [self.cellSuperViewTableView reloadRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }];
}

- (void)setupUI{
    self.backgroundColor = [UIColor clearColor];
}

- (void)setViewModel:(TSHomePageCellViewModel *)viewModel{
    _viewModel = viewModel;
}

- (void)setDatas:(NSArray<TSHomePageBaseModel *> *)datas{
    _datas = datas;
}
@end
