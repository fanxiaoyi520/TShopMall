//
//  TSURLRouter.m
//  TShopMall
//
//  Created by  on 2021/6/26.
//

#import "TSURLRouter.h"
#import "NSString+Plugin.h"
#import "NSObject+TSProperty.h"

@implementation TSURLRouter
+ (instancetype)sharedInstance {
    static dispatch_once_t pred;
    static id instance = nil;
    dispatch_once(&pred, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (UIViewController *)getCurrentVC{
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    //其他框架可能会改我们的keywindow，比如支付宝支付，qq登录都是在一个新的window上，这时候的keywindow就不是appdelegate中的window。 当然这里也可以直接用APPdelegate里的window。
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIViewController* currentViewController = window.rootViewController;
    while (YES) {
        if (currentViewController.presentedViewController) {
            currentViewController = currentViewController.presentedViewController;
        } else {
            if ([currentViewController isKindOfClass:[UINavigationController class]]) {
                currentViewController = ((UINavigationController *)currentViewController).visibleViewController;
            } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
                currentViewController = ((UITabBarController* )currentViewController).selectedViewController;
            } else {
                break;
            }
        }
    }
    
    return currentViewController;
}

- (NSString *)configUriWithTypeValue:(NSString *_Nullable)typeValue objectValue:(NSString *)objectValue{
    NSString *uri;
    if ([typeValue isEqualToString:@"APP_PAGE"]) {
        uri = @"page://quote/category";
    }
    else if([typeValue isEqualToString:@"goodsGroup"]){
        uri = [NSString stringWithFormat:@"page://quote/categoryDetail?uuid=%@", objectValue];

    }
    else if([typeValue isEqualToString:@"Goods"] || [typeValue isEqualToString:@"GOODS"]){
        uri = [NSString stringWithFormat:@"page://quote/productDetail?uuid=%@", objectValue];
    }
    
    return uri;
}

- (void)openURI:(NSString *)uri{
   
    NSLog(@"TSURLRouter 中 uri==%@",uri);
    
    Class cls = NSClassFromString([self getClassDict][[uri componentsSeparatedByString:@"?"].firstObject]);
    if (cls == nil) { return; }
    
    UIViewController *obj = [[cls alloc] init];
    if (obj == nil || ![obj isKindOfClass:[UIViewController class]]) {
        return;
    }

    for (NSString *propertyKey in obj.ts_validProperties) {
        NSObject *propertyValue = [uri.ts_urlParsing objectForKey:propertyKey];
        if (propertyValue) {
            [obj setValue:propertyValue forKey:propertyKey];
        }
    }
    
    [self.getCurrentVC.navigationController pushViewController:obj animated:YES];
}

- (NSDictionary *)getClassDict {
    return @{
        @"page://quote/productDetail": @"TSProductDetailController",
        @"page://quote/category": @"TSCategoryViewController",
        @"page://quote/categoryDetail": @"TSCategoryDetailViewController",
    };
}
@end
