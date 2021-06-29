//
//  TSServicesManager.h
//  TShopMall
//
//  Created by sway on 2021/6/23.
//

#import <Foundation/Foundation.h>
#import "TSRecomendGoodsProtocol.h"
#import "AFNetworkReachabilityManager.h"

NS_ASSUME_NONNULL_BEGIN
@protocol TSUriHandler <NSObject>

- (void)openURI:(NSString *_Nullable)uri;
- (NSString *)configUriWithTypeValue:(NSString *_Nullable)typeValue objectValue:(NSString *)objectValue;

@end

@protocol TSBestSellingRecommendServiceProtocol <NSObject>
/// 获取组列表数据
- (void)getRecommendListWithType:(NSString * _Nullable)type
                         success:(void(^_Nullable)(NSArray<id<TSRecomendGoodsProtocol>> *_Nullable list))success
                         failure:(void(^_Nullable)(NSError *_Nonnull error))failure;
@end

@interface TSServicesManager : NSObject
+ (instancetype)sharedInstance;
@property (nonatomic, strong) id<TSUriHandler> uriHandler;
@property (nonatomic, strong) id<TSBestSellingRecommendServiceProtocol> bestSellingRecommendService;

@end

NS_ASSUME_NONNULL_END
