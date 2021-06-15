//
//  TSHomePageBaseModel.h
//  TShopMall
//
//  Created by sway on 2021/6/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSHomePageBaseModel : NSObject
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *uri;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) NSInteger index;
@end

NS_ASSUME_NONNULL_END
