//
//  UploadImageApi.m
//  Solar
//
//  Created by tangqiao on 8/7/14.
//  Copyright (c) 2014 fenbi. All rights reserved.
//

#import "UploadImageApi.h"
#import <AFNetworking/AFURLRequestSerialization.h>
#import "NSDate+Plugin.h"

@implementation UploadImageApi {
    UIImage *_image;
}

- (id)initWithImage:(UIImage *)image {
    self = [super init];
    if (self) {
        _image = image;
    }
    return self;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {

    return kUploadImageUrl;
}

- (NSString *)baseUrl {
    return kMallApiPrefix;
}

- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
        NSData *data = UIImageJPEGRepresentation(_image, 0.9);
        NSString *name = [NSString stringWithFormat:@"image%@.jpg", [NSDate mr_Timestamp13]];
        NSString *formKey = @"file";
        NSString *type = @"image/jpg";
        [formData appendPartWithFileData:data name:formKey fileName:name mimeType:type];
    };
}

@end
