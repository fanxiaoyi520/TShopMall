//
//  TSMineDataController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/11.
//

#import "TSMineDataController.h"

@interface TSMineDataController()

@property (nonatomic, strong) NSMutableArray <TSMineSectionModel *> *sections;

@end

@implementation TSMineDataController

-(void)fetchMineContentsComplete:(void(^)(BOOL isSucess))complete{
    NSMutableArray *sections = [NSMutableArray array];
    
    {
        NSMutableArray *items = [NSMutableArray array];
        
        NSArray *titles = @[@"待付款",@"待发货",@"待收货",@"已完成",@"退款/退货"];
        NSArray *images = @[@"mall_mine_ payment",@"mall_mine_deliver",@"mall_mine_takedelivery",@"mall_mine_complete",@"mall_mine_refund"];
        
        for (int i = 0; i < titles.count; i++) {
            NSString *title = titles[i];
            NSString *image = images[i];
            
            TSMineSectionOrderItemModel *item = [[TSMineSectionOrderItemModel alloc] init];
            item.title = title;
            item.imageName = image;
            item.cellHeight = 75;
            item.identify = @"TSMineImageTextCell";
            
            [items addObject:item];
        }

        TSMineSectionModel *section = [[TSMineSectionModel alloc] init];
        section.hasHeader = YES;
        section.headerName = @"订单";
        section.headerSize = CGSizeMake(0, 45);
        section.headerIdentify = @"TSMineOrderHeaderView";
        section.hasFooter = YES;
        section.footerSize = CGSizeMake(0, 24);
        section.footerIdentify = @"TSUniversalBottomFooterView";
        section.sectionInset = UIEdgeInsetsMake(0, 16, 0, 16);
        section.column = 5;
        section.items = items;
        
        [sections addObject:section];
    }
    
    {
        NSMutableArray *items = [NSMutableArray array];
        
        TSMineSectionEarnItemModel *item = [[TSMineSectionEarnItemModel alloc] init];
        item.cellHeight = 66;
        item.identify = @"TSMineEarningsCell";
        
        [items addObject:item];
        
        TSMineSectionModel *section = [[TSMineSectionModel alloc] init];
        section.sectionInset = UIEdgeInsetsMake(0, 16, 0, 16);
        section.column = 1;
        section.hasDecorate = YES;
        section.docorateIdentify = @"TSUniversalAllCornersDecorationView";
        section.decorateInset = UIEdgeInsetsMake(0, 16, 0, 16);
        section.spacingWithLastSection = 12;
        section.items = items;
        
        [sections addObject:section];
    }
    
    {
        TSMineSectionAdsItemModel *item = [[TSMineSectionAdsItemModel alloc] init];
        item.cellHeight = 58;
        item.identify = @"TSMineAdsCell";

        TSMineSectionModel *section = [[TSMineSectionModel alloc] init];
        section.spacingWithLastSection = 12;
        section.sectionInset = UIEdgeInsetsMake(0, 16, 0, 16);
        section.items = @[item];

        [sections addObject:section];
    }
    
    {
        NSMutableArray *items = [NSMutableArray array];
        
        TSMineSectionParterItemModel *item = [[TSMineSectionParterItemModel alloc] init];
        item.cellHeight = 182;
        item.identify = @"TSMinePartnerCenterCell";
        
        [items addObject:item];
        
        TSMineSectionModel *section = [[TSMineSectionModel alloc] init];
        section.sectionInset = UIEdgeInsetsMake(0, 16, 0, 16);
        section.column = 1;
        section.hasDecorate = YES;
        section.docorateIdentify = @"TSUniversalAllCornersDecorationView";
        section.decorateInset = UIEdgeInsetsMake(0, 16, 0, 16);
        section.spacingWithLastSection = 12;
        section.items = items;
        
        [sections addObject:section];
    }

    {
        NSMutableArray *items = [NSMutableArray array];
        
        NSArray *titles = @[@"在线客服",@"发票管理",@"地址管理",@"官方服务",@"去评分"];
        NSArray *images = @[@"mall_mine_service",@"mall_mine_invoice_manager",@"mall_mine_address_manager",@"mall_mine_official",@"mall_mine_evaluate"];
        
        for (int i = 0; i < titles.count; i++) {
            NSString *title = titles[i];
            NSString *image = images[i];
            
            TSMineSectionOrderItemModel *item = [[TSMineSectionOrderItemModel alloc] init];
            item.title = title;
            item.imageName = image;
            item.cellHeight = 75;
            item.identify = @"TSMineImageTextCell";
            
            [items addObject:item];
        }
        
        TSMineSectionModel *section = [[TSMineSectionModel alloc] init];
        section.hasHeader = YES;
        section.headerName = @"更多服务";
        section.headerSize = CGSizeMake(0, 45);
        section.headerIdentify = @"TSMineTitleHeaderView";
        section.hasFooter = YES;
        section.footerSize = CGSizeMake(0, 24);
        section.footerIdentify = @"TSUniversalBottomFooterView";
        section.sectionInset = UIEdgeInsetsMake(0, 16, 0, 16);
        section.column = 4;
        section.hasDecorate = YES;
        section.docorateIdentify = @"TSUniversalNoneCornersDecorationView";
        section.decorateInset = UIEdgeInsetsMake(0, 16, 0, 16);
        section.spacingWithLastSection = 12;
        section.items = items;
        
        [sections addObject:section];
    }
    
    self.sections = sections;
    
    if (complete) {
        complete(YES);
    }
}

@end
