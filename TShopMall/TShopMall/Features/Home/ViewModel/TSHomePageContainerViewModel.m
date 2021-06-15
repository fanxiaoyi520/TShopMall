//
//  TSHomePageContainerViewModel.m
//  TShopMall
//
//  Created by sway on 2021/6/10.
//

#import "TSHomePageContainerViewModel.h"
#import "TSHomePageContainerModel.h"

@interface TSHomePageContainerViewModel()
@property (nonatomic,strong) NSMutableArray *mockDataList;

@end
@implementation TSHomePageContainerViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        {
            [self refreshData];
        }
    }
    return self;
}

- (void)getPageContainerDataWithStartIndex:(NSInteger)startIndex count:(NSInteger)count group:(TSHomePageContainerGroup *)group callback:(void (^)(NSMutableDictionary<NSString *,NSArray<TSHomePageContainerModel *> *> * _Nonnull))callback{
    if (self.mockDataList.count) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            // 处理耗时操作的代码块...
            NSArray *tempArr;

                if (startIndex + count <= self.mockDataList.count) {
                    tempArr = [self.mockDataList subarrayWithRange:NSMakeRange(startIndex, count)];
                } else {
                    tempArr = [self.mockDataList subarrayWithRange:NSMakeRange(startIndex, self.mockDataList.count - startIndex)];
                }

            //通知主线程刷新
            dispatch_async(dispatch_get_main_queue(), ^{
                //回调或者说是通知主线程刷新，
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                   NSArray <TSHomePageContainerModel *> *items = self.allGroupDict[group.groupId];
                    if (items.count) {
                        NSMutableArray *marr = [NSMutableArray arrayWithArray:items];
                        [marr addObjectsFromArray:tempArr];
                        self.allGroupDict[group.groupId] = marr;
                        
                    }else{
                        self.allGroupDict[group.groupId] = tempArr;
                    }
                    self.allGroupDict = self.allGroupDict;
                        callback(self.allGroupDict);
                });
            });

        });
    }
}

- (void)getPageContainerDataWithStartIndex:(NSInteger)startIndex count:(NSInteger)count group:(TSHomePageContainerGroup *)group{
    if (self.mockDataList.count) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            // 处理耗时操作的代码块...
            NSArray *tempArr;

                if (startIndex + count <= self.mockDataList.count) {
                    tempArr = [self.mockDataList subarrayWithRange:NSMakeRange(startIndex, count)];
                } else {
                    tempArr = [self.mockDataList subarrayWithRange:NSMakeRange(startIndex, self.mockDataList.count - startIndex)];
                }

            //通知主线程刷新
            dispatch_async(dispatch_get_main_queue(), ^{
                //回调或者说是通知主线程刷新，
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                   NSArray <TSHomePageContainerModel *> *items = self.allGroupDict[group.groupId];
                    if (items.count) {
                        NSMutableArray *marr = [NSMutableArray arrayWithArray:items];
                        [marr addObjectsFromArray:tempArr];
                        self.allGroupDict[group.groupId] = marr;
                    }else{
                        self.allGroupDict[group.groupId] = tempArr;
                    }
                    self.allGroupDict = self.allGroupDict;

                });
            });

        });
    }
}

- (void)loadMoreData{
    TSHomePageContainerGroup *group = self.containerHeaderViewModel.segmentHeaderDatas[self.containerHeaderViewModel.currentIndex];
    NSArray <TSHomePageContainerModel *> *items = self.allGroupDict[group.groupId];

    [self getPageContainerDataWithStartIndex:items.count count:10 group:group];
}

- (void)refreshData{
    
    NSMutableArray *marr = @[].mutableCopy;
    for (int i = 0; i < 500; i ++) {
        @autoreleasepool {
            
            TSHomePageContainerModel *model = [TSHomePageContainerModel new];
            model.title = [NSString stringWithFormat:@"XESS 55寸艺术电55寸艺术电55寸%d", i];
            model.price = @"18990";
            model.highPrice = @"￥19999";
            model.getPrice = @"提货价￥23990";
            model.imageUrl = @"https://www.baidu.com/img/bdlogo.png";
            model.uri = [NSString stringWithFormat:@"%d", i];
            [marr addObject:model];
        }
    }
    self.mockDataList = marr;
}

- (NSMutableDictionary<NSString *,NSArray<TSHomePageContainerModel *> *> *)allGroupDict{
    if (!_allGroupDict) {
        _allGroupDict = [NSMutableDictionary dictionary];
    }
    return _allGroupDict;
}

@end
