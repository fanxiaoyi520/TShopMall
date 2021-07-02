
#import "WechatShareManager.h"
#import <WXApi.h>

@interface WechatShareManager()<WXApiDelegate>

@end

@implementation WechatShareManager

+ (id)shareInstance {
    static WechatShareManager *weChatShareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        weChatShareInstance = [[WechatShareManager alloc] init];
    });
    return weChatShareInstance;
}

+ (BOOL)handleOpenUrl:(NSURL *)url {
    return [WXApi handleOpenURL:url delegate:[WechatShareManager shareInstance]];
}

+ (void)hangleWechatShareWith:(SendMessageToWXReq *)req {
    
    
    [WXApi sendReq:req completion:^(BOOL success) {
        //
    }];
}
+ (BOOL)registerApp:(NSString *)appid universalLink:(NSString *)universalLink{
    return [WXApi registerApp:appid universalLink:universalLink];
}

#pragma mark - 微信分享回调

- (void)onResp:(BaseResp *)resp {
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        /*
         enum  WXErrCode {
         WXSuccess           = 0,    < 成功
         WXErrCodeCommon     = -1,  < 普通错误类型
         WXErrCodeUserCancel = -2,   < 用户点击取消并返回
         WXErrCodeSentFail   = -3,   < 发送失败
         WXErrCodeAuthDeny   = -4,   < 授权失败
         WXErrCodeUnsupport  = -5,   < 微信不支持
         };
         */
        SendMessageToWXResp *response = (SendMessageToWXResp *)resp;
        switch (response.errCode) {
            case WXSuccess: {
                NSLog(@"微信分享成功");
                if (self.WXSuccess) {
                    self.WXSuccess();
                }
                break;
            }
            case WXErrCodeCommon: {
                NSLog(@"微信分享异常");
                if (self.WXFail) {
                    self.WXFail(@"微信分享异常");
                }
                break;
            }
            case WXErrCodeUserCancel: {
                NSLog(@"微信分享取消");
                if (self.WXFail) {
                    self.WXFail(@"微信分享取消");
                }
                break;
            }
            case WXErrCodeSentFail: {
                if (self.WXFail) {
                    self.WXFail(@"微信分享失败");
                }
                NSLog(@"微信分享失败");
                break;
            }
            case WXErrCodeAuthDeny: {
                if (self.WXFail) {
                    self.WXFail(@"微信分享授权失败");
                }
                NSLog(@"微信分享授权失败");
                break;
            }
            case WXErrCodeUnsupport: {
                if (self.WXFail) {
                    self.WXFail(@"微信分享版本暂不支持");
                }
                NSLog(@"微信分享版本暂不支持");
                break;
            }
            default: {
                break;
            }
        }
    }
}
-(void)shareWXWithTitle:(NSString *)title andDescription:(NSString *)description andShareURL:(NSString *)URL andThumbImage:(UIImage *)thumbImage andWXScene:(WechatShareType)WXScene{
    if (![WXApi isWXAppInstalled]) {
        [Popover popToastOnWindowWithText:@"请安装微信再进行分享~"];
        return;
    }
    // 分享到微信
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = description;
    //图片宽高，大小进行压缩，避免提及过大分享失败
    [message setThumbImage:[UIImage imageWithData:[self imageWithImage:thumbImage scaledToSize:CGSizeMake(300, 300)]]];
    WXWebpageObject *webpageObject = [WXWebpageObject object];
    webpageObject.webpageUrl = URL;
    message.mediaObject = webpageObject;
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = (int) WXScene;
    [WXApi sendReq:req completion:^(BOOL success) {
        //
        if (success == NO) {
            [Popover popToastOnWindowWithText:@"微信分享失败"];
        }
    }];
}

//分享小程序
-(void)shareWXSmallCodeImage:(UIImage *)image andUserName:(NSString *)userName andPath:(NSString *)path andParams:(NSDictionary *)params{
    if (![WXApi isWXAppInstalled]) {
        [Popover popToastOnWindowWithText:@"请安装微信再进行分享~"];
        return;
    }

    WXMiniProgramObject *object = [WXMiniProgramObject object];
//    object.webpageUrl = @"https://www.tcl.com/";
//    object.userName = @"gh_99b9b7fce84a";
    object.userName = userName;
//    object.userName = @"gh_2e76decadbc8";//生产
    /** 小程序页面的路径
     * @attention 不填默认拉起小程序首页
     */
    
//    NSString *path = [NSString stringWithFormat:@"pages/index/index?storeUuid=%@",params[@"storeUuid"]];
    
    object.path = path;
    /** 小程序新版本的预览图
     * @attention 大小不能超过128k
     */
    object.hdImageData = [self imageWithImage:image scaledToSize:CGSizeMake(300, image.size.height/image.size.width*300)];
    /** 是否使用带 shareTicket 的转发 */
    object.withShareTicket = NO;
    //正式版
    object.miniProgramType = WXMiniProgramTypeRelease;
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = params[@"appName"];
    message.description = params[@"appContent"];
//    message.thumbData = thumbImage;  //兼容旧版本节点的图片，小于32KB，新版本优先
                              //使用WXMiniProgramObject的hdImageData属性
    message.mediaObject = object;
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;  //目前只支持会话
    [WXApi sendReq:req completion:^(BOOL success) {
        if (success == NO) {
            [Popover popToastOnWindowWithText:@"分享失败"];
        }
    }];
}
- (void)lanchWXWithUserName:(NSString *)userName andPath:(NSString *)path  andExtMsg:(NSString *)msg andExtDic:(NSDictionary *)dic {
    if (![WXApi isWXAppInstalled]) {
        [Popover popToastOnWindowWithText:@"请安装微信再进行分享~"];
        return;
    }

    WXLaunchMiniProgramReq *object = [WXLaunchMiniProgramReq object];
    object.userName = userName;
    object.path = path;
    object.extMsg = msg;
    object.extDic = dic;
    //正式版
    object.miniProgramType = WXMiniProgramTypeRelease;
    WXMediaMessage *message = [WXMediaMessage message];
    message.mediaObject = object;
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;  //目前只支持会话
    [WXApi sendReq:req completion:^(BOOL success) {
        if (success == NO) {
            [Popover popToastOnWindowWithText:@"打开小程序失败"];
        }
    }];
}

- (NSData *)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return UIImageJPEGRepresentation(newImage, 0.8);
}

@end
