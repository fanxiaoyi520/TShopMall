//
//  TSSecurityController.h
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/13.
//

#import "TSBaseDataController.h"
#import "TSSettingSectionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSSecurityDataController : TSBaseDataController

@property (nonatomic, strong, readonly) NSMutableArray <TSSettingSectionModel *> *sections;

- (void)fetchSecurityContentsComplete:(void(^)(BOOL isSucess))complete;

@end

NS_ASSUME_NONNULL_END
