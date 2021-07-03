//
//  TSBankCardCell.h
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/24.
//

#import <UIKit/UIKit.h>
#import "TSBankCardModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSBankCardCell : UICollectionViewCell
@property (nonatomic ,assign) NSInteger sourceInt;
- (void)setModel:(id _Nullable)model indexPath:(NSIndexPath *)indexPath;
@end

@interface TSBankCardHeader : UICollectionReusableView

@end


@protocol TSBankCardFooterDelegate <NSObject>
- (void)bankCardFooterAddBankCardAction:(id _Nullable)sender;
@end

@interface TSBankCardFooter : UICollectionReusableView

@property (nonatomic ,assign)id <TSBankCardFooterDelegate> kDelegate;
@end



@protocol TSBankCardUnbundlingFooterDelegate <NSObject>
- (void)bankCardFooterBankCardUnbundlingAction:(id _Nullable)sender;
@end
@interface TSBankCardUnbundlingFooter : UICollectionReusableView

@property (nonatomic ,assign)id <TSBankCardUnbundlingFooterDelegate> kDelegate;
@end
NS_ASSUME_NONNULL_END
