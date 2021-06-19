//
//  TSCompletedViewController.m
//  TShopMall
//  已完成
//  Created by EDY on 2021/6/17.
//

#import "TSCompletedViewController.h"

@interface TSCompletedViewController ()

@end

@implementation TSCompletedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
}

#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView{
    return self.view;
}

@end
