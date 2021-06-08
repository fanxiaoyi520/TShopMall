//
//  TSHomeViewController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/3.
//

#import "TSHomeViewController.h"
#import "TSGeneralSearchButton.h"

@interface TSHomeViewController ()

@property (nonatomic, strong) NSArray *fontFamilyArray;
@property (nonatomic, strong) NSMutableArray *fontArray;

@end

@implementation TSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self hiddenNavigationBar];
}

-(void)setupNavigationBar
{
    TSGeneralSearchButton *searchButton = [TSGeneralSearchButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake(0, 0, kScreenWidth - 65, 32);
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
    searchItem.actionBlock = ^(id sender) {
        
    };
    self.navigationItem.titleView = searchButton;
}


@end
