//
//  BrowserConfig.m
//  TCLPlus
//
//  Created by OwenChen on 2020/8/24.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import "BrowserConfig.h"


@implementation BrowserConfig

- (instancetype)init {
    self = [super init];
    if (self) {
        self.allowPickingImage = YES;
        self.showTakePhotoBtn = YES;
        self.maxImagesCount = 1;
        self.columnNumber = 4;
        self.showSelectBtn = YES;
        self.allowCrop = YES;
    }
    return self;
}

@end
