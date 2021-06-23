//
//  TSMineOrderHeaderView.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/11.
//

#import "TSUniversalHeaderView.h"
#import "TSMineSectionModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol TSMineOrderHeaderViewDelegate <NSObject>

@optional
-(void)moreAction:(id _Nullable)sender;
@end

@interface TSMineOrderHeaderView : TSUniversalTopHeaderView

@property (nonatomic ,assign) id<TSMineOrderHeaderViewDelegate> mineOrderDelegate;
-(void)bindMineSectionModel:(TSMineSectionModel *)model;

@end

NS_ASSUME_NONNULL_END
