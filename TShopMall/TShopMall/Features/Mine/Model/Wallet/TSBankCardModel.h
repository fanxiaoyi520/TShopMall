//
//  TSBankCardModel.h
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSBankCardModel : NSObject

@property (nonatomic ,copy) NSString *bank_id;
@property (nonatomic ,copy) NSString *bankCardNo;
@property (nonatomic ,copy) NSString *accountBank;
@property (nonatomic ,copy) NSString *accountBankCode;
@property (nonatomic ,copy) NSString *bankStatusName;
@end

NS_ASSUME_NONNULL_END
