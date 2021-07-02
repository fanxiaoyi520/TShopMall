//
//  TSRankDataController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/17.
//

#import "TSRankDataController.h"
#import "TSSaleRankRequest.h"

@interface TSRankDataController()

@property (nonatomic, strong) NSMutableArray <TSRankSectionModel *> *coronalSections;

@end

@implementation TSRankDataController

- (void)fetchRankDataWithRankNum:(NSInteger)rankNum Complete:(void(^)(BOOL isSucess))complete {
    NSInteger time = self.isNowMonth ? 1 : 2;
    if (self.isProfitRank) {
        NSLog(@"财富 - %ld", time);
    }else {
        NSLog(@"冲冠 - %ld", time);
    }
    
    @weakify(self);
    TSSaleRankRequest *codeRequest = [[TSSaleRankRequest alloc] initWithTime:time rankNum:rankNum];
    [codeRequest startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        @strongify(self);
        
        if (request.responseModel.isSucceed) {
            
            NSMutableArray *sections = [NSMutableArray array];
            
            {
                NSMutableArray *items = [NSMutableArray array];
                
                TSRankSectionItemModel *item = [[TSRankSectionItemModel alloc] init];
                item.cellHeight = 280;
                item.identify = @"TSRankHonourCell";
                
                [items addObject:item];
                
                TSRankSectionModel *section = [[TSRankSectionModel alloc] init];
                section.column = 1;
                section.items = items;
                
                [sections addObject:section];
            }
            
            {
                NSMutableArray *items = [NSMutableArray array];
                
                for (int i = 1; i <= 8; i++) {
                    TSRankSectionItemModel *item = [[TSRankSectionItemModel alloc] init];
                    item.cellHeight = 55;
                    item.identify = @"TSRankCell";
                    item.rank = i;
                    item.isLast = i == 8;
                    [items addObject:item];
                }
                
                TSRankSectionModel *section = [[TSRankSectionModel alloc] init];
                section.hasHeader = YES;
                section.headerSize = CGSizeMake(0, 44);
                section.headerIdentify = @"TSRankHeaderView";
                section.column = 1;
                section.items = items;
                
                [sections addObject:section];
            }
            
            {
                NSMutableArray *items = [NSMutableArray array];

                TSRankSectionItemModel *item = [[TSRankSectionItemModel alloc] init];
                item.identify = @"TSRankRecommendCell";
                [items addObject:item];

                TSRankSectionModel *section = [[TSRankSectionModel alloc] init];
                section.hasHeader = NO;
                section.items = items;
                
                [sections addObject:section];
            }

            self.coronalSections = sections;
            
            if (complete) {
                complete(YES);
            }
        }else{
            [Popover popToastOnWindowWithText:request.responseModel.responseMsg];
            
            if (complete) {
                complete(NO);
            }
        }

    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (complete) {
            complete(NO);
        }
    }];
}

@end
