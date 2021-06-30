//
//  TSDropDownView.h
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSDropDownView : UIView
- (void)setModel:(id _Nullable)model;
@property (nonatomic ,copy)void (^selectBranchBlock)(id _Nullable info);
@end

NS_ASSUME_NONNULL_END
