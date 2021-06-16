//
//  TSChangePictureDataController.h
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/16.
//

#import "TSBaseDataController.h"
#import "TSChangePictureSectionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSChangePictureDataController : TSBaseDataController


@property (nonatomic, strong, readonly) NSMutableArray <TSChangePictureSectionModel *> *sections;

- (void)fetchChangePictureContentsComplete:(void(^)(BOOL isSucess))complete;

@end

NS_ASSUME_NONNULL_END
