//
//  TSLoginSMSModel.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSLoginSMSModel : NSObject

@property(nonatomic, copy) NSString *failCause;

@property(nonatomic, copy) NSString *key;
@property(nonatomic, copy) NSString *text;
@property(nonatomic, copy) NSString *expirationTime;

@end

NS_ASSUME_NONNULL_END
