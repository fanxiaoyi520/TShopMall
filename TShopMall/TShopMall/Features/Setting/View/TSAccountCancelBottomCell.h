//
//  TSAccountCancelBottomCell.h
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/15.
//

#import "TSUniversalCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TSAccountCancelBottomCellDelegate <NSObject>
/** 提交事件 */
- (void)confirmAction;
/** 取消事件 */
- (void)cancelAction;
@end

@interface TSAccountCancelBottomCell : TSUniversalCollectionViewCell
/** 代理  */
@property(nonatomic, weak) id<TSAccountCancelBottomCellDelegate> actionDelegate;

@end

NS_ASSUME_NONNULL_END
