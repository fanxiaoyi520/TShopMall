//
//  NTESQLHomePageCustomUIModel.m
//  NTESQuickPassPublicDemo
//
//  Created by 罗礼豪 on 2020/3/19.
//  Copyright © 2020 Xu Ke. All rights reserved.
//

#import "NTESQLHomePageCustomUIModel.h"
#import "NTESQPDemoDefines.h"

@implementation NTESQLHomePageCustomUIModel

+ (instancetype)getInstance {
    return [[NTESQLHomePageCustomUIModel alloc] init];
}

- (NTESQuickLoginModel *)configCustomUIModel:(NSInteger)popType
                                    withType:(NSInteger)portraitType
                             faceOrientation:(UIInterfaceOrientation)faceOrientation {
    
    NTESQuickLoginModel *model = [[NTESQuickLoginModel alloc] init];
    model.presentDirectionType = NTESPresentDirectionPush;
    model.backgroundColor = KWhiteColor;
    model.navBgColor = KWhiteColor;
    model.navText = @"";
    model.navReturnImg = [UIImage imageNamed:@"mall_login_close"];
    model.navReturnImgLeftMargin = 21;
    model.faceOrientation = faceOrientation;
    model.navBarHidden = NO;
   

    /// logo
    model.logoImg = [UIImage imageNamed:@"mall_login_logo"];
    model.logoWidth = 96;
    model.logoHeight = 96;
    model.logoHidden = NO;
    model.logoOffsetTopY = 81;

    /// 手机号码
    model.numberFont = [UIFont fontWithName:@"PingFangSC-Semibold" size:18];
    model.numberOffsetX = 0;
    model.numberHeight = 27;
    model.numberOffsetTopY = 190;

    ///  品牌
    model.brandHidden = YES;
    
    model.customViewBlock = ^(UIView * _Nullable customView) {
        
        UILabel *otherLabel = [[UILabel alloc] init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTapped)];
        [otherLabel addGestureRecognizer:tap];
        otherLabel.userInteractionEnabled = YES;
        otherLabel.text = @"其他登录方式";
        otherLabel.textAlignment = NSTextAlignmentCenter;
        otherLabel.textColor = KHexAlphaColor(@"#2D3132", 0.6);
        otherLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        [customView addSubview:otherLabel];
        
        [otherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(customView);
            make.top.equalTo(customView).mas_offset(355);
            make.height.mas_equalTo(16);
        }];
        

        UIButton *weChatButton = [UIButton new];
        UIButton *appleButton = [UIButton new];
        [weChatButton setBackgroundImage:KImageMake(@"mall_login_wechat") forState:UIControlStateNormal];
        [weChatButton addTarget:self action:@selector(goToWechat) forControlEvents:UIControlEventTouchUpInside];
        
        [appleButton setBackgroundImage:KImageMake(@"mall_login_apple") forState:UIControlStateNormal];
        [appleButton addTarget:self action:@selector(goToApple) forControlEvents:UIControlEventTouchUpInside];
        [customView addSubview:weChatButton];
        [customView addSubview:appleButton];

        [@[weChatButton, appleButton] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:100 leadSpacing:108 tailSpacing:108];
        // 设置array的垂直方向的约束
        [@[weChatButton, appleButton] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(customView.mas_bottom).offset(-135);
            make.height.equalTo(@(30));
        }];
        
    };
    
        /// 登录按钮
    model.logBtnTextFont = [UIFont systemFontOfSize:14];
    model.logBtnTextColor = [UIColor whiteColor];
    model.logBtnText = @"本机号码一键登录";
    model.logBtnRadius = 20;
    model.logBtnHeight = 40;
    model.logBtnUsableBGColor = KHexColor(@"#FF4D49");
    model.logBtnOffsetTopY = 293;
    
    model.loadingViewBlock = ^(UIView * _Nullable customLoadingView) {
    };
    
        /// 隐私协议
    model.appPrivacyText = @"已阅读并同意以下协议：《默认》《服务协议》《隐私政策》";
    model.appFPrivacyText = @"《服务协议》";
    model.appSPrivacyText = @"《隐私政策》";

    model.uncheckedImg = [[UIImage imageNamed:@"mall_login_uncheck"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    model.checkedImg = [[UIImage imageNamed:@"mall_login_checked"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    model.checkboxWH = 18;
    model.checkBoxAlignment = NSCheckBoxAlignmentCenter;
    model.privacyState = YES;
    model.privacyFont = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    model.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    model.protocolColor = KHexColor(@"#FF4D49");
    model.privacyColor = KHexColor(@"#666666");
    model.appPrivacyWordSpacing = 1;
    model.appPrivacyLineSpacing = 1;
    model.appPrivacyOriginBottomMargin = 36;
    model.progressColor = KHexColor(@"#FF4D49");
    
    
    if (@available(iOS 13.0, *)) {
        model.statusBarStyle = UIStatusBarStyleDarkContent;
    } else {
        model.statusBarStyle = UIStatusBarStyleDefault;
    }

    model.backActionBlock = ^{
        NSLog(@"backAction===返回按钮点击");
    };

    model.loginActionBlock = ^(BOOL isChecked) {
        NSLog(@"loginAction");
        if (isChecked) {
            NSLog(@"loginAction====复选框已勾选");
        } else {
            NSLog(@"loginAction====复选框未勾选");
        }
    };

    model.checkActionBlock = ^(BOOL isChecked) {
        NSLog(@"checkAction");
        if (isChecked) {
            NSLog(@"checkAction===选中复选框");
        } else {
            NSLog(@"checkAction===取消复选框");
        }
    };

    model.privacyActionBlock = ^(int privacyType) {
        if (privacyType == 0) {
            NSLog(@"点击默认协议");
        } else if (privacyType == 1) {
            NSLog(@"点击客户第1个协议");
        } else if (privacyType == 2) {
            NSLog(@"点击客户第2个协议");
        }
        NSLog(@"privacyAction");
    };

    return model;
}

- (void)labelTapped {
    [[NTESQuickLoginManager sharedInstance] closeAuthController:^{
        if (self.otherLoginBlock) {
            self.otherLoginBlock();
        }
    }];;
}

- (void)goToWechat{
    if (self.weChatLoginBlock) {
        self.weChatLoginBlock();
    }
}

- (void)goToApple{
    if (self.appleLoginBlock) {
        self.appleLoginBlock();
    }
}

@end

