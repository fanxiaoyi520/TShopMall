//
//  TSBindMobileDataController.h
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/15.
//

#import "TSBaseDataController.h"
#import "TSBindMobileSectionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSBindMobileDataController : TSBaseDataController

@property (nonatomic, strong, readonly) NSMutableArray <TSBindMobileSectionModel *> *sections;

- (void)fetchBindMobileContentsComplete:(void(^)(BOOL isSucess))complete;

@end

NS_ASSUME_NONNULL_END
