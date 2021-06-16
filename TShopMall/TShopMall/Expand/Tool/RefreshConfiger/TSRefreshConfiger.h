//
//  TSRefreshConfiger.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/12.
//

#import <Foundation/Foundation.h>
#import <MJRefresh.h>
#import <Lottie/Lottie.h>

typedef NS_ENUM(NSInteger, RefreshType) {
    Header     =0,
    Footer     ,
    Both
};


@protocol TSRefreshDelegate <NSObject>

@optional
- (BOOL)hasMoreData;
- (void)headerRefresh;
- (void)footerRefresh;
- (BOOL)isShowFooter;
@end


@class TSRefreshHeader;

@interface TSRefreshConfiger : NSObject
+ (instancetype)configScrollView:(UIScrollView *)scrollView isLight:(BOOL)isLight response:(id<TSRefreshDelegate>)target type:(RefreshType)type;
- (void)endRefresh:(BOOL)requestSuccess;
- (void)changeRefreshType:(BOOL)isLight;
@end


@interface TSRefreshHeader : MJRefreshHeader
@property (nonatomic, copy) NSString *jsonName;
@property(nonatomic, strong) LOTAnimationView *lotView;
@end
