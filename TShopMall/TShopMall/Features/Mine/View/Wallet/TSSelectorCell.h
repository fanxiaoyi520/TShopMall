//
//  TSSelectorCell.h
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol TSSelectorDelegate <NSObject>
@optional
- (void)selectorHeaderCloseAction:(id _Nullable)sender;
@end
@interface TSSelectorCell : UITableViewCell

@end

@interface TSSelectorHeader : UIView
@property (nonatomic ,assign) id<TSSelectorDelegate> kDelegate;
@end

@interface TSSelectorCellHeader : UIView
@end

NS_ASSUME_NONNULL_END
