//
//  TSBePaidViewController.m
//  TShopMall
//  待付款
//  Created by EDY on 2021/6/17.
//

#import "TSBePaidViewController.h"

@interface TSBePaidViewController ()

@end

@implementation TSBePaidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
}

#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView{
    return self.view;
}

@end
