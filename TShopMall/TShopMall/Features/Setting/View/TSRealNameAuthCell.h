//
//  TSRealNameAuthCell.h
//  TShopMall
//
//  Created by edy on 2021/6/22.
//

#import "TSUniversalCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TSRealNameAuthCellDelegate <NSObject>
/** 打开协议 */
- (void)openAgreement;
/** 开始认证 */
- (void)startAuthWithRealname:(NSString *)realname idcard:(NSString *)idcard authButton:(UIButton *)authButton;

@end

@interface TSRealNameAuthCell : TSUniversalCollectionViewCell
/** 点击代理  */
@property(nonatomic, weak) id<TSRealNameAuthCellDelegate> actionDelegate;

@end

NS_ASSUME_NONNULL_END
