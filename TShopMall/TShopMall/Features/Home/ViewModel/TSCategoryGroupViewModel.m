//
//  TSCategoryGroupViewModel.m
//  TShopMall
//
//  Created by sway on 2021/6/10.
//

#import "TSCategoryGroupViewModel.h"
#import "TSProductBaseModel.h"

@interface TSCategoryGroupViewModel()
@end
@implementation TSCategoryGroupViewModel

- (void)getSegmentHeaderData{
    
   NSArray *temp = self.model.data[@"list"];
    
    NSMutableArray *marr = @[].mutableCopy;
    
    for (NSDictionary *dic in temp) {
        TSCategoryGroup *model = [TSCategoryGroup new];
        model.name = dic[@"groupName"];
        model.groupId = dic[@"goodsgroupUuid"];
        [marr addObject:model];
    }
    self.segmentHeaderDatas = marr;
}

- (void)getCategoryGroupDataWithStartPageIndex:(NSInteger)startIndex count:(NSInteger)count group:(TSCategoryGroup *)group sortType:(NSString *)sortType sortBy:(NSString *)sortBy success:(void(^_Nullable)(NSArray * list))success failure:(void(^_Nullable)(NSError *_Nonnull error))failure{
    
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
    [body setValue:[NSString stringWithFormat:@"%ld",startIndex] forKey:@"nowPage"];
    [body setValue:[NSString stringWithFormat:@"%ld",count] forKey:@"pageShow"];
    [body setValue:group.groupId forKey:@"cateGroupUuid"];
    if (sortType) {
        [body setValue:sortType forKey:@"sortType"];
    }
    if (sortBy) {
        [body setValue:sortBy forKey:@"sortBy"];
    }
    

    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kProducts
                                                               requestMethod:YTKRequestMethodPOST
                                                       requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:NSMutableDictionary.dictionary
                                                                 requestBody:body
                                                              needErrorToast:NO];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        
        if (request.responseModel.isSucceed) {
            NSDictionary *data = request.responseModel.data;
            TSCategoryGroup *model = [TSCategoryGroup yy_modelWithDictionary:data];
            NSArray *temp = [NSArray yy_modelArrayWithClass:TSProductBaseModel.class json:model.list];
            group.totalNum = model.totalNum;
            if (group.name == nil) {
                group.name = data[@"searcheName"];
            }
            NSMutableArray *marr;
            if (startIndex == 1) {
                marr = [NSMutableArray array];
            }else{
                marr = [NSMutableArray arrayWithArray:group.list];
            }
            [marr addObjectsFromArray:temp];
            group.list = marr;
            success(group.list);
        }
        else{
            failure([NSError new]);
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        failure([NSError new]);
    }];
}

- (void)loadData:(TSCategoryGroup *)group success:(void (^ _Nullable)(NSArray * _Nonnull))success failure:(void (^ _Nullable)(NSError * _Nonnull))failure{
    
    NSInteger count = group.list.count?(group.totalNum/group.list.count + 1):1;
    [self getCategoryGroupDataWithStartPageIndex:count count:10 group:group sortType:@"1" sortBy:@"sortWeight" success:success failure:failure];
}

- (NSString *)getSortByWithIndex:(NSInteger)index{
    switch (index) {
        case 0:
            return @"sortWeight";
            break;
        case 1:
            return @"commission";
            break;
        case 2:
            return @"salsnum";
            break;
        case 3:
            return @"price";
            break;
        default:
            break;
    }
    return @"";
}

@end
