//
//  TSHomePageReleaseViewModel.m
//  TShopMall
//
//  Created by sway on 2021/6/10.
//

#import "TSHomePageReleaseViewModel.h"
#import "TSHomePageBaseModel.h"
#import "SDWebImageDownloader.h"

@implementation TSHomePageReleaseViewModel
- (void)getReleaseData{
    ///模拟数据 请求
    TSHomePageBaseModel *model = [TSHomePageBaseModel new];
    model.imageUrl = @"https://www.baidu.com/img/bdlogo.png";
    model.uri = @"http://www.baidu.com";
    model.title = @"新品发布";

    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:model.imageUrl] completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        if (finished && !error) {
            CGFloat width = [UIScreen mainScreen].bounds.size.width - 32;
            CGFloat scale = width/image.size.width;
            CGFloat height = image.size.height * scale;

            model.image = [self imageCompressWithSimple:image scaledToSize:CGSizeMake(width, height)];
            self.releaseModel = model;
        }
        
    }];

}

- (UIImage *)imageCompressWithSimple:(UIImage *)image scaledToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0,size.width,size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
