//
//  TSPersonalDataController.h
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/13.
//

#import "TSBaseDataController.h"
#import "TSPersonalSectionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSPersonalDataController : TSBaseDataController


@property (nonatomic, strong, readonly) NSMutableArray <TSPersonalSectionModel *> *sections;

- (void)fetchPersonalContentsComplete:(void(^)(BOOL isSucess))complete;

@end

NS_ASSUME_NONNULL_END
