//
//  UIFont+Plugin.h
//  TCLSmartHome
//
//  Created by LeonDeng on 2019/5/23.
//  Copyright © 2019 TCLIOT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TCLFontType) {
    TCLFontType30Medium,
    TCLFontType18Medium,
    TCLFontType18Regular,
    TCLFontType16Medium,
    TCLFontType16Regular,
    TCLFontType14Regular,
    TCLFontType14,
    TCLFontType13,
    TCLFontType12,
    TCLFontType10,
    TCLFontType8
};


@interface UIFont (Plugin)

/**
 根据选择的标准字号返回字体

 @param type 字号类型
 @return 字体
 */
+ (instancetype)TCLFont:(TCLFontType)type;

@end

NS_ASSUME_NONNULL_END
