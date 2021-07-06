//
//  TSUploadImageService.h
//  TShopMall
//
//  Created by edy on 2021/6/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSUploadImageService : NSObject

/** 上传图片 */
- (void)uploadImage:(UIImage *)image
            success:(void(^_Nullable)(NSString *imageURL))success
            failure:(void(^_Nullable)(NSString *errorMsg))failure;

@end

NS_ASSUME_NONNULL_END
