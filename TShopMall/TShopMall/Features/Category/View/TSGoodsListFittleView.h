//
//  TSGoodsListFittleView.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/13.
//

#import <UIKit/UIKit.h>

@protocol TSGoodsListFittleDelegate <NSObject>
- (void)operationType:(NSInteger)type sortType:(NSInteger)sortType;

@end

@interface TSGoodsListFittleView : UIView
@property (nonatomic, weak) id<TSGoodsListFittleDelegate> delegate;
@end

