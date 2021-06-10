//
//  TSConstant.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSConstant : NSObject

#pragma mark - 比例宽高
#define KRateW(width)  [MyDimeScale scaleW:width]
#define KRateH(height) [MyDimeScale scaleH:height]

#define KNaviBarHeight 44.0

#pragma mark - 图片
#define KImageMake(img) [UIImage imageNamed:img]

#pragma mark - 字体
#define KFont(type, fontSize) [UIFont font:type size:fontSize]
#define KRegularFont(fontSize) [UIFont font:PingFangSCRegular size:fontSize]

#pragma mark - 颜色
#define KHexColor(hex) [UIColor colorWithHexString:hex]
#define KHexAlphaColor(hex, alpha) [[UIColor colorWithHexString:hex] colorWithAlphaComponent:alpha]

#define KMainColor  KHexColor(@"#E64C3D")
#define KWhiteColor KHexColor(@"#FFFFFF")
#define KOrangeColor KHexColor(@"#EAAF3B")
#define KBlueColor KHexColor(@"#8499FF")
#define KYellowTipColor KHexColor(@"#F7AF34")
#define KOtherLineColor  KHexColor(@"#E9E9E9")
#define KTextColor  KHexColor(@"#2D3132")
#define KGrayColor  KHexColor(@"#F4F4F5")
#define KPlaceholderColor KHexColor(@"#D5D6D6")
#define KDisableColor KHexColor(@"#DDDDDD")
#define KlineColor  KHexColor(@"#E6E6E6")
#define KBlackColor KHexColor(@"#000000")
#define KMBHudColor KHexColor(@"#646464")
#define KCellShaowColor KHexColor(@"#A9A9A9")
#define KCouponsTimeColor KHexColor(@"#333333")
#define KColletionItemColor KHexColor(@"#ECECEC")
#define KProsuctTextColor KHexColor(@"#818384")
#define KClearColor  [UIColor clearColor]
#define KGoodsDetailPriceColor KHexColor(@"#666666")
#define KPersonalPointColor KHexColor(@"#D8D8D8")
#define KOrderMsgBGColor KHexColor(@"#FAFAFA")

#pragma mark - 导航栏状态栏
// 顶部安全区域高度
#define GK_SAFEAREA_TOP                 [TSConstant safeAreaInsets].top
// 底部安全区域高度
#define GK_SAFEAREA_BTM                 [TSConstant safeAreaInsets].bottom
// 状态栏高度
#define GK_STATUSBAR_HEIGHT             [TSConstant statusBarFrame].size.height
// 导航栏高度
#define GK_NAVBAR_HEIGHT                [TSConstant navBarHeight]
// 状态栏+导航栏高度
#define GK_STATUSBAR_NAVBAR_HEIGHT      (GK_STATUSBAR_HEIGHT + GK_NAVBAR_HEIGHT)
// tabbar高度
#define GK_TABBAR_HEIGHT                (GK_SAFEAREA_BTM + 49.0f)

//判断是否为iPhone X系列
#define  kIsiPhoneX (((kScreenWidth == 375.f && kScreenHeight == 812.f) || (kScreenWidth == 414.f && kScreenHeight == 896.f) || (kScreenHeight == 375.f && kScreenWidth == 812.f) || (kScreenHeight == 414.f && kScreenWidth == 896.f)) ? YES : NO)


@property(class, nonatomic, readonly) CGFloat      navBarHeight;
@property(class, nonatomic, readonly) UIEdgeInsets safeAreaInsets;
@property(class, nonatomic, readonly) CGRect       statusBarFrame;
@property(class, nonatomic, readonly) UIWindow     *keyWindow;

@end

NS_ASSUME_NONNULL_END
