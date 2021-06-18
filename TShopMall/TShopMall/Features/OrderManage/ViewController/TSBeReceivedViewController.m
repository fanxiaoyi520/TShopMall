//
//  TSBeReceivedViewController.m
//  TShopMall
//  待收货
//  Created by EDY on 2021/6/17.
//

#import "TSBeReceivedViewController.h"

@interface TSBeReceivedViewController ()

@end

@implementation TSBeReceivedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
}

#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView{
    return self.view;
}

@end
