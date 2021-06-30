//
//  TSBridgeHandler.m
//  TSale
//
//  Created by 陈洁 on 2020/12/31.
//  Copyright © 2020 TCL. All rights reserved.
//

#import "TSBridgeHandler.h"
#import "TSHybridViewController.h"
#import "TSWKAppManager.h"
#import "TSWKMessageHandlerHelper.h"

@implementation TSBridgeHandler

-(void)goForward:(NSDictionary *)params{
    NSDictionary *data = params[@"data"];
    NSDictionary *paramDic = data[@"params"];

    TSHybridViewController *controller = [[TSHybridViewController alloc] initWithURLString:paramDic[@"url"]];
    controller.rightParams = paramDic;
    controller.jsDataParams = data;
    controller.gk_navTitle = paramDic[@"title"];
    controller.rightButtonTitle = paramDic[@"rightText"];
    controller.rightClick = paramDic[@"rightClick"];
    controller.leftClick = paramDic[@"leftClick"];
    [[TSWKAppManager currentNavigationController] pushViewController:controller animated:YES];
}

-(void)close:(NSDictionary *)params{
    NSDictionary *data = params[@"data"];
    NSDictionary *paramsDic = data[@"params"];
    NSString *backUrl = @"";
    NSString *leftUrl = @"";
    TSHybridViewController *controller = [TSWKAppManager currentController:params[@"webview"]];
    if ([paramsDic isKindOfClass:[NSDictionary class]] && paramsDic.count > 0) {
        if ([paramsDic[@"leftClick"] isKindOfClass:[NSString class]] && ((NSString *)paramsDic[@"leftClick"]).length > 0) {
            leftUrl = paramsDic[@"leftClick"];
        }
        if ([paramsDic[@"backUrl"] isKindOfClass:[NSString class]] && ((NSString *)paramsDic[@"backUrl"]).length > 0) {
            backUrl = paramsDic[@"backUrl"];
        }
    }
    
    if (backUrl.length > 0) {
       NSArray *childs = controller.navigationController.childViewControllers;
        for (UIViewController *con in childs) {
            if ([con isKindOfClass:[TSHybridViewController class]]) {
                TSHybridViewController *hybrid = (TSHybridViewController *)con;
                if ([hybrid.request.URL.absoluteString isEqualToString:backUrl]) {
                    if (leftUrl.length > 0) {
                        NSDictionary *callBackDic = paramsDic[@"data"];
                        NSString *json = @"";
                        if ([callBackDic isKindOfClass:[NSDictionary class]] && callBackDic.count > 0) {
                            json = [callBackDic jsonStringEncoded];
                        }
                        [TSWKMessageHandlerHelper callbackWithMethodName:leftUrl callBackParams:json webView:hybrid.webView];
                    }
                    [controller.navigationController popToViewController:hybrid animated:YES];
                    break;
                }
            }
        }
    }else{
        NSArray *childs = controller.navigationController.childViewControllers;
        NSInteger count = childs.count;
        TSHybridViewController *hybrid = childs[count - 2];
        if (leftUrl.length > 0) {
            NSDictionary *callBackDic = paramsDic[@"data"];
            NSString *json = @"";
            if ([callBackDic isKindOfClass:[NSDictionary class]] && callBackDic.count > 0) {
                json = [callBackDic jsonStringEncoded];
            }
            [TSWKMessageHandlerHelper callbackWithMethodName:leftUrl callBackParams:json webView:hybrid.webView];
        }
        [controller.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - 修改导航栏标题
-(void)updateNavigation:(NSDictionary *)params{
    NSDictionary *data = params[@"data"];
    NSDictionary *paramsDic = data[@"params"];
    
    NSString *title = paramsDic[@"title"];
    NSString *rightText = paramsDic[@"rightText"];
    NSString *rightClick = paramsDic[@"rightClick"];
    NSString *leftClick = paramsDic[@"leftClick"];
   
    TSHybridViewController *controller = [TSWKAppManager currentController:params[@"webview"]];
    
    if ([title isKindOfClass:[NSString class]] && title.length > 0) {
        controller.gk_navTitle = title;
    }
    controller.rightButtonTitle = rightText;
    controller.rightClick = rightClick;
    controller.leftClick = leftClick;
    controller.gk_navItemRightSpace = 12;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:rightText forState:UIControlStateNormal];
    [rightButton setTitleColor:KTextColor forState:UIControlStateNormal];
    rightButton.titleLabel.font = KRegularFont(15.0);
    [rightButton addTarget:controller action:NSSelectorFromString(@"rightAction:") forControlEvents:UIControlEventTouchUpInside];
    controller.gk_navRightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

#pragma mark - 修改导航栏颜色
-(void)updateNavColor:(NSDictionary *)params{
    NSDictionary *data = params[@"data"];
    NSDictionary *paramsDic = data[@"params"];
    
    NSString *backColor = paramsDic[@"backColor"];
    NSString *textColor = paramsDic[@"textColor"];
    NSString *imageName = paramsDic[@"imgUrl"];
    
    TSHybridViewController *controller = [TSWKAppManager currentController:params[@"webview"]];
    
    if (textColor.length > 0) {
        controller.gk_navTitleColor = KHexColor(textColor);
    }
    
    if (imageName.length > 0) {
        controller.gk_navBackgroundImage = KImageMake(imageName);
    } else {
        controller.gk_navBackgroundColor = KHexColor(backColor);
    }

    controller.gk_navLineHidden = YES;

    if ([textColor isEqualToString:@"#FFFFFF"]) {
        controller.gk_backStyle = GKNavigationBarBackStyleWhite;
    } else {
        controller.gk_backStyle = GKNavigationBarBackStyleBlack;
    }
    
    [controller.gk_navigationBar layoutIfNeeded];
}

#pragma mark - 调转到原生页面
-(void)navigation:(NSDictionary *)params{
    NSDictionary *data = params[@"data"];
    NSDictionary *paramsDic = data[@"params"];
    NSString *controllerName = paramsDic[@"name"];
    Class className = NSClassFromString(controllerName);
    UIViewController *con = [[className alloc] init];
    TSHybridViewController *controller = [TSWKAppManager currentController:params[@"webview"]];
    [controller.navigationController pushViewController:con animated:YES];
}

-(void)webInitMounted:(NSDictionary *)params{
    TSHybridViewController *controller = [TSWKAppManager currentController:params[@"webview"]];
    [controller evaluateWebViewInitData];
}

#pragma mark - 登出
-(void)logOut:(NSDictionary *)params{

}

#pragma mark - Show Loading
-(void)showLoading:(NSDictionary *)params{
    dispatch_async(dispatch_get_main_queue(), ^{
        ProgressModel *model = [[ProgressModel alloc] init];
        model.text = @"加载中";
        model.inProgress = YES;
        model.showMaskView = YES;
        [Popover popProgressOnWindowWithProgressModel:model appearBlock:nil];
    });
}

#pragma mark - Dismiss Loading
-(void)dismissLoading:(NSDictionary *)params{
    dispatch_async(dispatch_get_main_queue(), ^{
        [Popover removePopoverOnWindow];
    });
}



@end

