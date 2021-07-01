//
//  TSUploadImageService.m
//  TShopMall
//
//  Created by edy on 2021/6/30.
//

#import "TSUploadImageService.h"
#import "UploadImageApi.h"

@implementation TSUploadImageService

/** 上传图片 */
- (void)uploadImage:(UIImage *)image
            success:(void(^_Nullable)(NSString *imageURL))success
            failure:(void(^_Nullable)(NSString *errorMsg))failure
{
    UploadImageApi *uploadRequest = [[UploadImageApi alloc] initWithImage:image];
    [uploadRequest startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSError *error;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
        NSDictionary *data = json[@"data"];
        if (error) {
            if (failure) {
                failure(@"数据格式错误！");
            }
            return;
        }
        if (data) {
            NSString *imageURL = data[@"fileUrl"];
            if (success) {
                success(imageURL);
            }
        } else {
            if (failure) {
                failure(@"发生未知错误~~~");
            }
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure) {
            failure(@"发生未知错误~~~");
        }
    }];
}

@end
