//
//  TSSearchHeaderView.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSSearchHeaderView : UICollectionReusableView
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIButton *deleteBtn;

@property (nonatomic, copy) NSString *str;
@property (nonatomic, copy) void(^deleteAction)(NSString *title);
@end

NS_ASSUME_NONNULL_END
