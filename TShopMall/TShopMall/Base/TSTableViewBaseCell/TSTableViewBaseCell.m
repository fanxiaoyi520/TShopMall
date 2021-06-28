//
//  TSTableViewBaseCell.m
//  TShopMall
//
//  Created by  on 2021/6/28.
//

#import "TSTableViewBaseCell.h"

@implementation TSTableViewBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
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
    
}

@end
