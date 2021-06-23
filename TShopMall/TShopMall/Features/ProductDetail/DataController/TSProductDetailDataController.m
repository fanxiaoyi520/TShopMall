//
//  TSProductDetailDataController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/15.
//

#import "TSProductDetailDataController.h"
#import "SSGenaralRequest.h"


@interface TSProductDetailDataController()

@property (nonatomic, strong) NSMutableArray <TSGoodDetailSectionModel *> *sections;

@end

@implementation TSProductDetailDataController

-(void)fetchProductDetailWithUuid:(NSString *)uuid
                         complete:(void(^)(BOOL isSucess))complete{

}

-(void)fetchProductDetailComplete:(void(^)(BOOL isSucess))complete{
    
    NSMutableArray *sections = [NSMutableArray array];
    
    {
        TSGoodDetailItemBannerModel *item = [[TSGoodDetailItemBannerModel alloc] init];
        item.urls = @[@"http://f0.testpc.tclo2o.cn",@"http://f0.testpc.tclo2o.cn"];
        item.cellHeight = floor(kScreenWidth * 1.04);
        item.identify = @"TSGoodDetailBannerCell";

        TSGoodDetailSectionModel *section = [[TSGoodDetailSectionModel alloc] init];
        section.column = 1;
        section.items = @[item];
        
        [sections addObject:section];
    }
    
    {
        TSGoodDetailItemPriceModel *item = [[TSGoodDetailItemPriceModel alloc] init];
        item.cellHeight = 78;
        item.identify = @"TSGoodDetailPriceCell";

        TSGoodDetailSectionModel *section = [[TSGoodDetailSectionModel alloc] init];
        section.column = 1;
        section.items = @[item];

        [sections addObject:section];
    }

    {
        TSGoodDetailItemPriceModel *item = [[TSGoodDetailItemPriceModel alloc] init];
        item.identify = @"TSGoodDetailIntroduceCell";
        item.title = @"标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标";
        item.content = @"卖点提炼，卖点介绍卖点介绍卖点介绍卖点介绍卖点介绍卖点介绍卖点介绍卖点介绍卖点介绍卖点介绍卖点标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标";
        
       CGFloat titleH = [item.title sizeForFont:KRegularFont(16)
                                           size:CGSizeMake(kScreenWidth - 32, 1000)
                                           mode:NSLineBreakByWordWrapping].height;
        
        if (titleH > 45) {
            titleH = 45;
        }
        
       CGFloat contentH = [item.content sizeForFont:KRegularFont(14)
                                               size:CGSizeMake(kScreenWidth - 32, 1000)
                                               mode:NSLineBreakByWordWrapping].height;
        if (contentH > 40) {
            contentH = 40;
        }
        item.cellHeight = 8 + titleH + 4 + contentH + 16;

        TSGoodDetailSectionModel *section = [[TSGoodDetailSectionModel alloc] init];
        section.column = 1;
        section.items = @[item];

        [sections addObject:section];
    }

    {
        TSGoodDetailItemPriceModel *item = [[TSGoodDetailItemPriceModel alloc] init];
        item.cellHeight = 189;
        item.identify = @"TSGoodDetailImageCell";

        TSGoodDetailSectionModel *section = [[TSGoodDetailSectionModel alloc] init];
        section.column = 1;
        section.spacingWithLastSection = 12;
        section.items = @[item];

        [sections addObject:section];
    }

    {
        TSGoodDetailItemPriceModel *item = [[TSGoodDetailItemPriceModel alloc] init];
        item.cellHeight = 151;
        item.identify = @"TSGoodDetailCopyWriterCell";

        TSGoodDetailSectionModel *section = [[TSGoodDetailSectionModel alloc] init];
        section.column = 1;
        section.spacingWithLastSection = 12;
        section.items = @[item];

        [sections addObject:section];
    }

    {
        TSGoodDetailItemPriceModel *item = [[TSGoodDetailItemPriceModel alloc] init];
        item.cellHeight = 227;
        item.identify = @"TSProductDetailPurchaseCell";

        TSGoodDetailSectionModel *section = [[TSGoodDetailSectionModel alloc] init];
        section.column = 1;
        section.spacingWithLastSection = 12;
        section.items = @[item];

        [sections addObject:section];
    }

    {
        TSGoodDetailItemPriceModel *item = [[TSGoodDetailItemPriceModel alloc] init];
        item.cellHeight = 300;
        item.identify = @"TSProductDetailImageCell";

        TSGoodDetailSectionModel *section = [[TSGoodDetailSectionModel alloc] init];
        section.hasHeader = YES;
        section.headerSize = CGSizeMake(0, 46);
        section.headerIdentify = @"TSProductDetailHeaderView";
        section.spacingWithLastSection = 12;
        section.column = 1;
        section.items = @[item];

        [sections addObject:section];
    }
    
    self.sections = sections;
    
    if (complete) {
        complete(YES);
    }
}

@end
