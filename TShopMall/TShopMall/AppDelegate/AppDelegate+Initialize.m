//
//  AppDelegate+Initialize.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/7.
//

#import "AppDelegate+Initialize.h"
#import "MyDimeScale.h"

@implementation AppDelegate (Initialize)

-(void)setUITemplateSize
{
    [MyDimeScale setUITemplateSize:CGSizeMake(375, 667)];
}

-(void)setupRequestFilters
{
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    [config setBaseUrl:kApiPrefix];
}

@end
