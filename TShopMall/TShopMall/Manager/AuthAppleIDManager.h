//
//  AuthAppleIDManager.h
//  TShopMall
//
//  Created by  on 2021/6/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AuthAppleIDManager : NSObject
+ (id)sharedInstance;
- (void)authorizationAppleID;

@end

NS_ASSUME_NONNULL_END
