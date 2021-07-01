//
//  TSConstant.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/3.
//

#import <Foundation/Foundation.h>

typedef enum {
    none = 0,
    male = 1,
    female = 2,
} Sex;

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
#define KGrayColor  KHexColor(@"#F4F4F4")
#define KPlaceholderColor KHexColor(@"#D5D6D6")
#define KDisableColor KHexColor(@"#DDDDDD")
#define KlineColor  KHexColor(@"#F4F4F4")
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

/**
 *简单单例宏H和M配套使用
 *H放于声明文件
 */
#define SingletonH(name) + (instancetype)shared##name;

/**
 *简单单例宏H和M配套使用
 *M放于实现文件
 */
#define SingletonM(name) \
static id _instance; \
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
\
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return _instance; \
}\
\
- (id)mutableCopyWithZone:(NSZone *)zone { \
return _instance; \
}
@end

NS_ASSUME_NONNULL_END
