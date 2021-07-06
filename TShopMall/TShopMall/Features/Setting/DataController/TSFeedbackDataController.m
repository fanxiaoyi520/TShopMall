//
//  TSFeedbackDataController.m
//  TShopMall
//
//  Created by oneyian on 2021/7/6.
//

#import "TSFeedbackDataController.h"
#import "TSFeedbackRequest.h"

@implementation TSFeedbackDataController

/// 提交反馈
/// @param content 反馈内容
/// @param complete 反馈完成回调
- (void)fetchFeedbackWithContent:(NSString *)content Complete:(void(^)(BOOL isSucess))complete {
    
    if (content == nil || content.length < 1) {
        [Popover popToastOnWindowWithText:@"请填写您需要反馈的内容"];
        if (complete) {
            complete(NO);
        }
        return;
    }
    
    TSFeedbackRequest *webRequest = [[TSFeedbackRequest alloc] initWithContent:content];
    webRequest.animatingView = self.context.view;
    [webRequest startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        
        NSLog(@"oneyian!");
        BOOL status = request.responseModel.isSucceed;
        
        //延时
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC));
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            if (status) {
                [Popover popToastOnWindowWithText:@"反馈成功"];
            }else{
                [Popover popToastOnWindowWithText:request.responseModel.responseMsg];
            }
        });
        
        {
            //延时
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC));
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                if (complete) {
                    complete(status);
                }
            });
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (complete) {
            complete(NO);
        }
    }];
}

@end
