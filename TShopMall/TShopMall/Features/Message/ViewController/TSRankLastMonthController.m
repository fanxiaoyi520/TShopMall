//
//  TSRankLastMonthController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/17.
//

#import "TSRankLastMonthController.h"

@interface TSRankLastMonthController ()

@end

@implementation TSRankLastMonthController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor redColor];
}

#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView{
    return self.view;
}


@end
