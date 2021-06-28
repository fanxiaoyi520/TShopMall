//
//  TSCommitCell.h
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/15.
//

#import "TSUniversalCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TSCommitCellDelegate <NSObject>
/** 提交事件 */
- (void)commitAction;

@end

@interface TSCommitCell : TSUniversalCollectionViewCell
/** 点击事件的代理  */
@property(nonatomic, weak) id<TSCommitCellDelegate> actionDelegate;

@end

NS_ASSUME_NONNULL_END
