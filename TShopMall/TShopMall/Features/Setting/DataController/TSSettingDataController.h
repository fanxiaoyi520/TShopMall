//
//  TSSettingDataController.h
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/12.
//

#import "TSBaseDataController.h"
#import "TSSettingSectionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSSettingDataController : TSBaseDataController

@property (nonatomic, strong, readonly) NSMutableArray <TSSettingSectionModel *> *sections;

- (void)fetchSettingContentsComplete:(void(^)(BOOL isSucess))complete;
/**
 *@params key 可以为nickname（昵称）、city（城市）、province（省份）、country（国家）、sex（性别 1: 男 2:女）、area（区）
 *@params value 为对应key的修改值
 *@params accountId 用户账号的唯一标识
 */
- (void)fetchModifyUserInfoWithKey:(NSString *)key
                             value:(NSString *)value
                         accountId:(NSString *)accountId
                          complete:(void(^)(BOOL isSucess))complete;


/// 清理缓存
- (void)clearCacheWithComplete:(void(^)(BOOL isSucess))complete;

@end

NS_ASSUME_NONNULL_END
