//
//  TSServicesManager.h
//  TShopMall
//
//  Created by sway on 2021/6/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol TSUriHandler <NSObject>

- (void)openURI:(NSString *_Nullable)uri;

@end
@interface TSServicesManager : NSObject
+ (instancetype)sharedInstance;
@property (nonatomic, strong) id<TSUriHandler> uriHandler;

@end

NS_ASSUME_NONNULL_END
