//
//  TSWalletAreaIndexView.h
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/7/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSWalletAreaIndexView : UIView

@property (nonatomic, strong) NSArray<NSString *> *indexs;
@property (nonatomic, strong) UIImageView *indeImg;
@property (nonatomic, strong) UILabel *indeDes;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, assign) CGFloat btnHeight;
@property (nonatomic, assign) NSInteger lastTag;
@property (nonatomic, copy) void(^indexChanged)(NSInteger index);
@end

NS_ASSUME_NONNULL_END
