//
//  TSRecomendView.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/22.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PageType) {
    Search     = 0,
    SearchResult   ,
    Cart                ,
};

@interface TSRecomendView : UICollectionReusableView
+ (TSRecomendView *)configRecomendViewWithType:(PageType)type layoutFinished:(void(^)(void))layoutFinished goodsSelected:(void(^)(NSString *))goodsSelected;

- (void)updateDateWithType:(PageType)type goodsSelected:(void(^)(NSString *))goodsSelected;
@end

