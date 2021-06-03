//
//  TSDeviceHelper.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/3.
//

#import "TSDeviceHelper.h"
#include <mach-o/dyld.h>
#include <mach-o/nlist.h>

@implementation TSDeviceHelper

+ (BOOL)isJailBreak {
    return monstercrashdl_imageNamed("MobileSubstrate", false) != UINT32_MAX;
}

+ (BOOL)isSimulator {
    if (TARGET_IPHONE_SIMULATOR == 1 && TARGET_OS_IPHONE == 1) {
        //模拟器
        return YES;
    }
    //真机
    return NO;
}

#pragma mark - Private
uint32_t monstercrashdl_imageNamed(const char* const imageName, bool exactMatch)
{
    if(imageName != NULL)
    {
        const uint32_t imageCount = _dyld_image_count();

        for(uint32_t iImg = 0; iImg < imageCount; iImg++)
        {
            const char* name = _dyld_get_image_name(iImg);
            if(exactMatch)
            {
                if(strcmp(name, imageName) == 0)
                {
                    return iImg;
                }
            }
            else
            {
                if(strstr(name, imageName) != NULL)
                {
                    return iImg;
                }
            }
        }
    }
    return UINT32_MAX;
}

@end
