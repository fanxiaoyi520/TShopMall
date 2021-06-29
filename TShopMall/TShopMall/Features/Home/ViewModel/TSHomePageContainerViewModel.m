//
//  TSHomePageContainerViewModel.m
//  TShopMall
//
//  Created by sway on 2021/6/10.
//

#import "TSHomePageContainerViewModel.h"
#import "TSProductBaseModel.h"

@interface TSHomePageContainerViewModel()
@end
@implementation TSHomePageContainerViewModel

- (void)getSegmentHeaderData{
    
   NSArray *temp = self.model.data[@"list"];
    
    NSMutableArray *marr = @[].mutableCopy;
    
    for (NSDictionary *dic in temp) {
        TSHomePageContainerGroup *model = [TSHomePageContainerGroup new];
        model.name = dic[@"groupName"];
        model.groupId = dic[@"goodsgroupUuid"];
        [marr addObject:model];
    }
    self.segmentHeaderDatas = marr;
}

- (void)getPageContainerDataWithStartPageIndex:(NSInteger)startIndex count:(NSInteger)count group:(TSHomePageContainerGroup *)group success:(void(^_Nullable)(NSArray * list))success failure:(void(^_Nullable)(NSError *_Nonnull error))failure{
    
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
    [body setValue:[NSString stringWithFormat:@"%ld",startIndex] forKey:@"nowPage"];
    [body setValue:[NSString stringWithFormat:@"%ld",count] forKey:@"pageShow"];
    [body setValue:group.groupId forKey:@"cateGroupUuid"];

    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kProducts
                                                               requestMethod:YTKRequestMethodPOST
                                                       requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:NSMutableDictionary.dictionary
                                                                 requestBody:body
                                                              needErrorToast:NO];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        
        if (request.responseModel.isSucceed) {
            NSDictionary *data = request.responseModel.data;
            TSHomePageContainerGroup *model = [TSHomePageContainerGroup yy_modelWithDictionary:data];
            NSArray *temp = [NSArray yy_modelArrayWithClass:TSProductBaseModel.class json:model.list];
            group.totalNum = model.totalNum;
            NSMutableArray *marr = [NSMutableArray arrayWithArray:group.list];
            [marr addObjectsFromArray:temp];
            group.list = marr;
            success(group.list);
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        failure([NSError new]);
    }];
}

- (void)loadData:(TSHomePageContainerGroup *)group success:(void (^ _Nullable)(NSArray * _Nonnull))success failure:(void (^ _Nullable)(NSError * _Nonnull))failure{
    
    NSInteger count = group.list.count?(group.totalNum/group.list.count + 1):1;
    [self getPageContainerDataWithStartPageIndex:count count:10 group:group success:success failure:failure];
}

@end
