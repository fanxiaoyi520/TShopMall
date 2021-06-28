//
//  TSImageBaseModel.h
//  TShopMall
//
//  Created by sway on 2021/6/17.
//

#import <Foundation/Foundation.h>
#import "TSLinkDataModel.h"
#import "TSImageDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSImageBaseModel : NSObject
@property (nonatomic, strong) TSLinkDataModel *linkData;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) TSImageDataModel *imageData;
@property (nonatomic, strong, readonly) NSString *uri;

@end

NS_ASSUME_NONNULL_END
