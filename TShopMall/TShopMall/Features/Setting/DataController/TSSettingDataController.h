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

@end

NS_ASSUME_NONNULL_END
