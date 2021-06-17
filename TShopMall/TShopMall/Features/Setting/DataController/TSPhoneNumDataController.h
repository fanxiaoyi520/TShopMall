//
//  TSPhoneNumDataController.h
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/15.
//

#import "TSBaseDataController.h"
#import "TSPhoneNumSectionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSPhoneNumDataController : TSBaseDataController

@property (nonatomic, strong, readonly) NSMutableArray <TSPhoneNumSectionModel *> *sections;

- (void)fetchPhoneNumContentsComplete:(void(^)(BOOL isSucess))complete;

@end

NS_ASSUME_NONNULL_END
