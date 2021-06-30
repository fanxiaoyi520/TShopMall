//
//  TSSettingDataController.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/12.
//

#import "TSSettingDataController.h"
#import "TSModifyUserInfoRequest.h"

#import <SDImageCache.h>
#import "Popover.h"

@interface TSSettingDataController ()

@property (nonatomic, strong) NSMutableArray <TSSettingSectionModel *> *sections;

@end

@implementation TSSettingDataController

- (void)fetchSettingContentsComplete:(void (^)(BOOL))complete {
    
    NSMutableArray *sections = [NSMutableArray array];
    {
        NSMutableArray *items = [NSMutableArray array];
        TSSettingSectionItemModel *item = [[TSSettingSectionItemModel alloc] init];
        item.cellHeight = 74;
        item.identify = @"TSSettingUserCell";
        [items addObject:item];
        TSSettingSectionModel *section = [[TSSettingSectionModel alloc] init];
        section.column = 1;
        section.sectionInset = UIEdgeInsetsMake(0, 0, 10, 0);
        section.items = items;
        [sections addObject:section];
    }
    {
        NSMutableArray *items = [NSMutableArray array];
        TSSettingCommonSectionItemModel *item1 = [[TSSettingCommonSectionItemModel alloc] init];
        item1.title = @"账号安全";
        item1.detail = @"";
        item1.showLine = NO;
        item1.cellHeight = 56;
        item1.identify = @"TSSettingCommonCell";
        [items addObject:item1];
        TSSettingCommonSectionItemModel *item2 = [[TSSettingCommonSectionItemModel alloc] init];
        item2.title = @"地址管理";
        item2.detail = @"";
        item2.showLine = NO;
        item2.cellHeight = 56;
        item2.identify = @"TSSettingCommonCell";
        [items addObject:item2];
        TSSettingSectionModel *section = [[TSSettingSectionModel alloc] init];
        section.column = 1;
        section.sectionInset = UIEdgeInsetsMake(0, 0, 10, 0);
        section.lineSpacing = 10;
        section.items = items;
        [sections addObject:section];
    }
    {
        NSMutableArray *items = [NSMutableArray array];
        TSSettingCommonSectionItemModel *item1 = [[TSSettingCommonSectionItemModel alloc] init];
        item1.title = @"清理缓存";
        item1.detail = [self getWebImageCache];
        item1.showLine = YES;
        item1.cellHeight = 56.5;
        item1.identify = @"TSSettingCommonCell";
        [items addObject:item1];
        
        TSSettingCommonSectionItemModel *item2 = [[TSSettingCommonSectionItemModel alloc] init];
        item2.title = @"关于我们";
        item2.detail = @"";
        item2.showLine = NO;
        item2.cellHeight = 56;
        item2.identify = @"TSSettingCommonCell";
        [items addObject:item2];
        
        TSSettingSectionModel *section = [[TSSettingSectionModel alloc] init];
        section.column = 1;
        section.spacingWithLastSection = 10;
        section.lineSpacing = 0;
        section.items = items;
        [sections addObject:section];
    }
    
    {
        NSMutableArray *items = [NSMutableArray array];
        TSSettingExitSectionItemModel *item = [[TSSettingExitSectionItemModel alloc] init];
        item.cellHeight = 56;
        item.identify = @"TSSettingExitCell";
        [items addObject:item];
        TSSettingSectionModel *section = [[TSSettingSectionModel alloc] init];
        section.column = 1;
        section.spacingWithLastSection = 10;
        section.lineSpacing = 0;
        section.items = items;
        [sections addObject:section];
    }
    self.sections = sections;
    
    if (complete) {
        complete(YES);
    }
}
/**
 *@params key 可以为nickname（昵称）、city（城市）、province（省份）、country（国家）、sex（性别 1: 男 2:女）、area（区）
 *@params value 为对应key的修改值
 *@params accountId 用户账号的唯一标识
 */
- (void)fetchModifyUserInfoWithKey:(NSString *)key
                             value:(NSString *)value
                         accountId:(NSString *)accountId
                          complete:(void(^)(BOOL isSucess))complete {
    TSModifyUserInfoRequest *request = [[TSModifyUserInfoRequest alloc] initWithAccountId:accountId modifyKey:key modifyValue:value];
//    request.animatingText = @"正在提交...";
//    request.animatingView = self.context.view;
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            if (complete) {
                complete(YES);
            }
        } else {
            [Popover popToastOnWindowWithText:request.responseModel.originalData[@"failCause"]];
            if (complete) {
                complete(NO);
            }
        }
    } failure:^(__kindof SSBaseRequest * _Nonnull request) {
        if (complete) {
            complete(NO);
        }
    }];
}
    
#pragma mark - <本地缓存>
/// 获取缓存大小
- (NSString *)getWebImageCache {
    return [self getFileSizeString:[[SDImageCache sharedImageCache] totalDiskSize]];
}

/// 文件占用内存
/// @param fileSize 文件大小
- (NSString *)getFileSizeString:(NSInteger)fileSize {
    CGFloat unit = 1024;
    if (fileSize >= unit *unit * unit) {
        return  [NSString stringWithFormat:@"%.1fG",fileSize/(unit * unit * unit)];
    } else if (fileSize >= unit * unit) {
        return  [NSString stringWithFormat:@"%.1fM",fileSize/(unit * unit)];
    } else if (fileSize >=unit) {
        return [NSString stringWithFormat:@"%.1fK",fileSize/unit];
    } else if (fileSize > 0) {
        return [NSString stringWithFormat:@"%ldB",fileSize];
    } else {
        return @"清理干净啦";
    }
}

/// 清理缓存
- (void)clearCacheWithComplete:(void(^)(BOOL isSucess))complete {
    @weakify(self);
    [Popover popProgressOnWindowWithText:@"清理中"];
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        @strongify(self);
        //延时
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC));
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            @strongify(self);
            //更新数据
            TSSettingSectionItemModel *model = self.sections[2].items[0];
            TSSettingCommonSectionItemModel *subModel = (TSSettingCommonSectionItemModel *)model;
            subModel.detail = [self getWebImageCache];
            //移除提示
            [Popover removePopoverOnWindow];
            complete(YES);
        });
    }];
}

@end
