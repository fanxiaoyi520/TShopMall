//
//  TSPhoneNumVeriCell.h
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/15.
//

#import "TSUniversalCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class TSPhoneNumVeriCell;

@protocol TSPhoneNumVeriCellDelegate <NSObject>

- (void)commitActionWithCode:(NSString *)code mobile:(NSString *)mobile commitButton:(UIButton *)commitButton;

- (void)sendCodeWithMobile:(NSString *)mobile codeButton:(UIButton *)codeButton cell:(TSPhoneNumVeriCell *)cell;

@end

@interface TSPhoneNumVeriCell : TSUniversalCollectionViewCell
/** 代理  */
@property(nonatomic, weak) id<TSPhoneNumVeriCellDelegate> actionDelegate;

- (void)startTimer;

@end

NS_ASSUME_NONNULL_END
