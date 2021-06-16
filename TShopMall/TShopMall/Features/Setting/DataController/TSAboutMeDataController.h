//
//  TSAboutMeDataController.h
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/13.
//

#import "TSBaseDataController.h"
#import "TSAboutMeSectionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSAboutMeDataController : TSBaseDataController

@property (nonatomic, strong, readonly) NSMutableArray <TSAboutMeSectionModel *> *sections;

- (void)fetchContentsComplete:(void(^)(BOOL isSucess))complete;

@end

NS_ASSUME_NONNULL_END
