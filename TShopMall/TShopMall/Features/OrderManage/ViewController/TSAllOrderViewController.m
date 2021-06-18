//
//  TSAllOrderViewController.m
//  TShopMall
//
//  Created by EDY on 2021/6/17.
//

#import "TSAllOrderViewController.h"

@interface TSAllOrderViewController ()

@end

@implementation TSAllOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
}

#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView{
    return self.view;
}

@end
