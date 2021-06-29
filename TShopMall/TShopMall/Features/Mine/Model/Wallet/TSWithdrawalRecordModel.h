//
//  TSWithdrawalRecordModel.h
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface TSWithdrawalRecordModel : NSObject

@property (nonatomic ,copy) NSString *accountNo;
@property (nonatomic ,copy) NSString *arrivalAmount;
@property (nonatomic ,copy) NSString *arrivalTime;
@property (nonatomic ,copy) NSString *bankBranch;
@property (nonatomic ,copy) NSString *bankName;
@property (nonatomic ,copy) NSString *businessLocation;
@property (nonatomic ,copy) NSString *createTime;
@property (nonatomic ,copy) NSString *createUser;
@property (nonatomic ,copy) NSString *customerUuid;
@property (nonatomic ,copy) NSString *delFlag;
@property (nonatomic ,copy) NSString *examineTime;
@property (nonatomic ,copy) NSString *examineUser;
@property (nonatomic ,copy) NSString *opeTime;
@property (nonatomic ,copy) NSString *oper;
@property (nonatomic ,copy) NSString *reason;
@property (nonatomic ,copy) NSString *serviceCharge;
@property (nonatomic ,copy) NSString *status;
@property (nonatomic ,copy) NSString *statusName;
@property (nonatomic ,copy) NSString *storeUuid;
@property (nonatomic ,copy) NSString *uuid;
@property (nonatomic ,copy) NSString *withdrawalAmount;
@property (nonatomic ,copy) NSString *withdrawalNo;
@property (nonatomic ,copy) NSString *withdrawalPhone;
@property (nonatomic ,copy) NSString *withdrawalType;
@property (nonatomic ,copy) NSString *withdrawalTypeName;
@property (nonatomic ,copy) NSString *withdrawalUserName;

+ (NSArray *)getFixedFata;
@end

NS_ASSUME_NONNULL_END
