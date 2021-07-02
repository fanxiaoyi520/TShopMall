//
//  ImageCompresser.h
//  TCLPlus
//
//  Created by OwenChen on 2020/8/25.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface ImageCompresser : NSObject

+ (UIImage *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size;

@end

NS_ASSUME_NONNULL_END
