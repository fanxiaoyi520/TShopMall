//
//  SSNetworkAlertUtil.h
//  SSBaseTemplate
//
//  Created by 陈结 on 2021/5/21.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSNetworkAlertUtil : NSObject

+(void)showLoadingAlertViewInView:(__kindof UIView *)inView;
+(void)hideLoadingAlertView:(__kindof UIView *)inView;

@end

NS_ASSUME_NONNULL_END
