//
//  ImageCompresser.m
//  TCLPlus
//
//  Created by OwenChen on 2020/8/25.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import "ImageCompresser.h"


@implementation ImageCompresser

+ (UIImage *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size {
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    CGFloat dataKBytes = data.length / 1000.0;
    CGFloat maxQuality = 0.9f;
    CGFloat lastData = dataKBytes;
    while (dataKBytes > size && maxQuality > 0.01f) {
        maxQuality = maxQuality - 0.01f;
        data = UIImageJPEGRepresentation(image, maxQuality);
        dataKBytes = data.length / 1000.0;
        if (lastData == dataKBytes) {
            break;
        } else {
            lastData = dataKBytes;
        }
    }
    UIImage *newImage = [UIImage imageWithData:data];
    return newImage;
}

@end
