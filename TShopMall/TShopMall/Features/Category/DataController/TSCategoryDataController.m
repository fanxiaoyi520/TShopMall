//
//  TSCategoryDataController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/10.
//

#import "TSCategoryDataController.h"

@interface TSCategoryDataController()

@property (nonatomic, strong) NSMutableArray <TSCategoryKindModel *> *kinds;
@property (nonatomic, strong) NSMutableArray <TSCategoryContentModel *> *sections;

@end

@implementation TSCategoryDataController

-(void)fetchKindsComplete:(void(^)(BOOL isSucess))complete{

    NSMutableDictionary *body = [NSMutableDictionary dictionary];
    [body setValue:@"productGroup_page" forKey:@"pageType"];
    [body setValue:@"APP" forKey:@"uiType"];

    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kShopContentUrl
                                                               requestMethod:YTKRequestMethodPOST
                                                       requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:NSMutableDictionary.dictionary
                                                                 requestBody:body
                                                              needErrorToast:NO];
    request.animatingView = self.context.view;
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        
        if (request.responseModel.isSucceed) {
            NSString *content = request.responseModel.data[@"content"];
            NSArray *contentArr = [content jsonValueDecoded];
            
            NSMutableArray *kinds = [NSMutableArray array];
            NSMutableArray *sections = [NSMutableArray array];
            
            for (int i = 0; i < contentArr.count; i++) {
                NSDictionary *itemDic = contentArr[i];
                TSCategoryKindModel *kindModel = [[TSCategoryKindModel alloc] init];
                kindModel.kind = itemDic[@"OneLevelTitle"];
                kindModel.startSection = i * categoryContentCount;
                [kinds addObject:kindModel];
                
                TSCategoryContentModel *content = [[TSCategoryContentModel alloc] init];
                content.OneLevelTitle = itemDic[@"OneLevelTitle"];
                content.OneLevelImg = itemDic[@"OneLevelImg"];
                content.TwoLevel = itemDic[@"TwoLevel"];
                content.goodsList = itemDic[@"goodsList"];
                content.objectValue = itemDic[@"objectValue"];
                content.typeValue = itemDic[@"typeValue"];
                [sections addObject:content];
            }
            
            self.kinds = kinds;
            self.sections = sections;
            
            complete(YES);
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {

        NSLog(@"----");
    }];

}

- (NSIndexPath *)fatchContentIndexPath:(NSInteger)section {
    return [NSIndexPath indexPathForItem:section % categoryContentCount inSection:section / categoryContentCount];
}

@end
