//
//  TSHomePageContainerModel.h
//  TShopMall
//
//  Created by sway on 2021/6/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSHomePageContainerModel : NSObject
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *getPrice;
@property (nonatomic, copy) NSString *highPrice;
@property (nonatomic, copy) NSString *uri;
@property (nonatomic, assign) BOOL isSelected;

@end

NS_ASSUME_NONNULL_END
