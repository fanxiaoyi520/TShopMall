//
//  TSBaseListController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/17.
//

#import "TSBaseListController.h"

@interface TSBaseListController ()

@end

@implementation TSBaseListController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView{
    return self.view;
}

@end
