//
//  TSCategoryDataController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/10.
//

#import "TSCategoryDataController.h"

@interface TSCategoryDataController()

@property (nonatomic, strong) NSMutableArray <TSCategoryKindModel *> *kinds;

@end

@implementation TSCategoryDataController

-(void)fetchKindsComplete:(void(^)(BOOL isSucess))complete{
    NSArray *titles = @[@"智屏",@"冰箱",@"洗衣机",@"空调",@"厨卫大电",@"全屋智能",@"美妆个护",@"附近商品"];
    
    NSMutableArray *kindsArr = [NSMutableArray array];
    for (NSString *title in titles) {
        TSCategoryKindModel *kindModel = [[TSCategoryKindModel alloc] init];
        kindModel.kind = title;
        
        [kindsArr addObject:kindModel];
    }
    
    self.kinds = kindsArr;
    
    complete(YES);
}

@end
