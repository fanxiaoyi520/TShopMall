//
//  TSAlertView.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/12.
//

#import <UIKit/UIKit.h>

typedef void(^AlertAction)(void);
@interface TSAlertView : UIView
@property (nonatomic, copy) TSAlertView *(^alertInfo)(NSString *title, id message);
@property (nonatomic, copy) TSAlertView *(^confirm)(NSString *str, AlertAction);
@property (nonatomic, copy) TSAlertView *(^cancel)(NSString *str, AlertAction);
@property (nonatomic, copy) TSAlertView *(^show)(void);
@end

