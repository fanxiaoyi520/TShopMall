//
//  TSEmptyAlertView.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/10.
//

#import <UIKit/UIKit.h>

@interface TSEmptyAlertView : UIView

@property (nonatomic, copy) TSEmptyAlertView *(^alertBackColor)(UIColor *bgColor);
@property (nonatomic, copy) TSEmptyAlertView *(^alertImage)(NSString *alertImg);
@property (nonatomic, copy) TSEmptyAlertView *(^alertInfo)(NSString *tips, NSString *btnStr);
@property (nonatomic, copy) TSEmptyAlertView *(^show)(UIView *onView, void(^btnAction)(void));

+ (void)hideInView:(UIView *)inView;
@end
