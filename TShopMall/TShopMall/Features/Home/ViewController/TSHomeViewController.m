//
//  TSHomeViewController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/3.
//

#import "TSHomeViewController.h"

@interface TSHomeViewController ()

@property (nonatomic, strong) NSArray *fontFamilyArray;
@property (nonatomic, strong) NSMutableArray *fontArray;

@end

@implementation TSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _fontFamilyArray = [UIFont familyNames];
    _fontArray = [NSMutableArray array];
    for (NSString* familyName in _fontFamilyArray) {
        NSArray *fontArray = [UIFont fontNamesForFamilyName:familyName];
        [_fontArray addObject:fontArray];
    }
    
    [self.navigationController.navigationBar setBackgroundImage:UIImage.new forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = UIImage.new;

    self.view.backgroundColor = [UIColor grayColor];
}


@end
