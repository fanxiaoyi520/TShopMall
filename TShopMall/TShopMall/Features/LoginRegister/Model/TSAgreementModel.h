//
//  TSAgreementModel.h
//  TShopMall
//
//  Created by edy on 2021/6/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSAgreementModel : NSObject
/** 服务器链接  */
@property(nonatomic, copy) NSString *serverUrl;
/** 协议标题  */
@property(nonatomic, copy) NSString *title;

@end

NS_ASSUME_NONNULL_END
