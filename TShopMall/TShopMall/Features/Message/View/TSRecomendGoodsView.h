//
//  TSRecomendGoodsView.h
//  TShopMall
//
//  Created by sway on 2021/6/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSRecomendGoodsView : UIView

@property (nonatomic, strong)   NSArray   *items;
@property (nonatomic, assign, readonly)   CGFloat   height;
- (void)getRecommendListWithType:(NSString * _Nullable)type
                         success:(void(^_Nullable)(NSArray * _Nullable))success;
@end

NS_ASSUME_NONNULL_END
