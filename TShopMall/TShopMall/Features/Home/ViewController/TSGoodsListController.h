//
//  TSGoodsListController.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/29.
//

#import "TSBaseViewController.h"
#import "TSSearchSection.h"
#import "TSSearchResultFittleView.h"

@interface TSGoodsListController : TSBaseViewController<TSSearchResultFittleDelegate>

/* 数据源 */
@property (nonatomic, strong) NSArray<TSSearchSection *> *sections;

/* 显示样式不同，主体背景色改变 */
- (void)updateCollectionBackgroundColor:(UIColor *)color;


/** 配置上拉刷新，下拉加载，其加载操作自己实现 **/
- (void)configRefreshHeaderWithTarget:(id)target selector:(SEL)selector;
- (void)configRefreshFooterWithTarget:(id)target selector:(SEL)selector;
- (void)endRefreshIsNoMoreData:(BOOL)noMoreData isEmptyData:(BOOL)isEmptyData;
@end

