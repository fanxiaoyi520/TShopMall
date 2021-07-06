//
//  TSFeedbackDataController.h
//  TShopMall
//
//  Created by oneyian on 2021/7/6.
//

#import "TSBaseDataController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSFeedbackDataController : TSBaseDataController

/// 提交反馈
/// @param content 反馈内容
/// @param complete 反馈完成回调
- (void)fetchFeedbackWithContent:(NSString *)content Complete:(void(^)(BOOL isSucess))complete;

@end

NS_ASSUME_NONNULL_END
