//
//  TSSelectProvincesCitiesCell.h
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/7/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol TSSelectorCellAddressDelegate <NSObject>
- (void)selectorHeaderCloseAction:(id _Nullable)sender;
- (void)selectorCellAddressHeaderAction:(id _Nullable)sender;
@end
@interface TSSelectProvincesCitiesCell : UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withIndexPath:(NSIndexPath *)indexPath;
- (void)setModel:(id _Nullable)model titles:(NSString *)title;
@end

@interface TSSelectorCellAddressHeader : UIView

@property (nonatomic ,assign) id<TSSelectorCellAddressDelegate> kDelegate;
@property (nonatomic ,strong) UIButton *oneTitleBtn;
@property (nonatomic ,strong) UIButton *secondTitleBtn;
@end

@interface TSSelectorAddressHeader : UIView
@property (nonatomic ,assign) id<TSSelectorCellAddressDelegate> kDelegate;
@end

NS_ASSUME_NONNULL_END
