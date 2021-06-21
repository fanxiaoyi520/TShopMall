//
//  UIFont+Plugin.m
//  TCLSmartHome
//
//  Created by LeonDeng on 2019/5/23.
//  Copyright © 2019 TCLIOT. All rights reserved.
//

#import "UIFont+Plugin.h"


@implementation UIFont (Plugin)

+ (instancetype)TCLFont:(TCLFontType)type {
    switch (type) {
        case TCLFontType30Medium:
            return [UIFont systemFontOfSize:30 weight:UIFontWeightMedium];
        case TCLFontType18Medium:
            return [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
        case TCLFontType16Medium:
            return [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
        case TCLFontType18Regular:
            return [UIFont systemFontOfSize:18];
        case TCLFontType16Regular:
            return [UIFont systemFontOfSize:16];
        case TCLFontType14Regular:
            return [UIFont systemFontOfSize:14];
        case TCLFontType14:
            return [UIFont systemFontOfSize:14];
        case TCLFontType13:
            return [UIFont systemFontOfSize:13];
        case TCLFontType12:
            return [UIFont systemFontOfSize:12];
        case TCLFontType10:
            return [UIFont systemFontOfSize:10];
        case TCLFontType8:
            return [UIFont systemFontOfSize:8];
    }
}

@end
