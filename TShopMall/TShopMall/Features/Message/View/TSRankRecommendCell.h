//
//  TSRankRecommendCell.h
//  TShopMall
//
//  Created by  on 2021/6/28.
//

#import "TSTableViewBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TSRankRecommendCellDelegate <NSObject>

- (void)didSelectRowAtCell:(id)selectItem index:(NSInteger)index;

@end

@interface TSRankRecommendCell : TSTableViewBaseCell
@property (nonatomic, weak) id<TSRankRecommendCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
