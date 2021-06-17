//
//  TSRankCurrentMonthController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/17.
//

#import "TSRankCurrentMonthController.h"

@interface TSRankCurrentMonthController ()

@end

@implementation TSRankCurrentMonthController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor orangeColor];
}

#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView{
    return self.view;
}

@end
