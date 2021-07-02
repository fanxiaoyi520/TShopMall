//
//  TSPersonalRankView.h
//  TShopMall
//
//  Created by oneyian on 2021/6/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSPersonalRankView : UIView
/** 个人头像  */
@property(nonatomic, weak) UIImageView *headImgV;
/** 个人名称  */
@property(nonatomic, weak) UILabel *usernameLabel;
/** 排名显示  */
@property(nonatomic, weak) UILabel *rankNumLabel;
/** 销售收益数目显示  */
@property(nonatomic, weak) UILabel *salesNumLabel;
@end

NS_ASSUME_NONNULL_END
