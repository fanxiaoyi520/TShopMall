//
//  TSHomePageContainerScrollView.h
//  TShopMall
//
//  Created by sway on 2021/6/14.
//

#import <UIKit/UIKit.h>
#import "TSHomePageContainerViewModel.h"
#import "TSProductBaseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TSHomePageContainerScrollView : UIScrollView
@property(nonatomic, strong) NSMutableArray *collectionViewGroup;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger pageIndex;

//@property (nonatomic, strong) NSArray<TSHomePageContainerModel *> * items;
- (void)loadPageContainer:(NSInteger)headerCount;
- (void)updatePageContainerWithItems:(NSArray<TSProductBaseModel *> * )items pageIndex:(NSInteger)pageIndex;
@end

NS_ASSUME_NONNULL_END
