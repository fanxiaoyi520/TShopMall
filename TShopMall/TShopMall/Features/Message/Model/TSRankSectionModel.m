//
//  TSRankSectionModel.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/17.
//

#import "TSRankSectionModel.h"

@implementation TSRankSectionModel

@end

@implementation TSRankUserModel

- (NSString *)mobile {
    if (_mobile.length >= 11) {
        NSString *centerStr = [_mobile substringWithRange:NSMakeRange(3,4)];
        return [_mobile stringByReplacingOccurrencesOfString:centerStr withString:@"****"];
    }else {
        return _mobile;
    }
}

@end

@implementation TSRankSectionItemModel

@end
