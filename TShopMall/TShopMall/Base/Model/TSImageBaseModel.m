//
//  TSImageBaseModel.m
//  TShopMall
//
//  Created by sway on 2021/6/17.
//

#import "TSImageBaseModel.h"

@implementation TSImageBaseModel
- (NSString *)uri{
    if ([self.linkData.typeValue isEqualToString:@"APP_PAGE"]) {
        return @"page://quote/category";
    }
    else if([self.linkData.typeValue isEqualToString:@"goodsGroup"]){
        return [NSString stringWithFormat:@"page://quote/searchResult?goodsGroupUuid=%@",self.linkData.objectValue];

    }
    else if([self.linkData.typeValue isEqualToString:@"Goods"]){
        return [NSString stringWithFormat:@"page://quote/productDetail?uuid=%@",self.linkData.objectValue];
    }
    return nil;
}
@end
