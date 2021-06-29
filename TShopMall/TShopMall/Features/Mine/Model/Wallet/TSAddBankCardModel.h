//
//  TSAddBankCardModel.h
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSAddBankCardModel : NSObject

@property (nonatomic ,copy) NSString *bankCardNo;//银行卡号
@property (nonatomic ,copy) NSString *accountBank;//开户银行
@property (nonatomic ,copy) NSString *accountBankCode;//开户银行编码
@property (nonatomic ,copy) NSString *bankName;//开户行支行
@property (nonatomic ,copy) NSString *bankBranchId;//开户支行编码
@property (nonatomic ,copy) NSString *bankAddressProvince;//开户省
@property (nonatomic ,copy) NSString *bankAddressProvinceCode;//开户省编码
@property (nonatomic ,copy) NSString *bankAddressCity;//开户市
@property (nonatomic ,copy) NSString *bankAddressCityCode;//开户市编码
@end

NS_ASSUME_NONNULL_END
