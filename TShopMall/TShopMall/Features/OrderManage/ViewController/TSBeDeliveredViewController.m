//
//  TSBeDeliveredViewController.m
//  TShopMall
//  待发货
//  Created by EDY on 2021/6/17.
//

#import "TSBeDeliveredViewController.h"

@interface TSBeDeliveredViewController ()

@end

@implementation TSBeDeliveredViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
}

#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView{
    return self.view;
}

@end
