//
//  TSUnbundlingCardViewCell.h
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/7/5.
//

#import <UIKit/UIKit.h>
#import "TSBankCardModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSUnbundlingCardViewCell : UICollectionViewCell
@property (nonatomic ,assign) NSInteger sourceInt;
- (void)setModel:(id _Nullable)model indexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
