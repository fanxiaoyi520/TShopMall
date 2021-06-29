//
//  TSLocationInfoModel.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/29.
//

#import "TSLocationInfoModel.h"

@interface TSLocationInfoModel()<NSCoding,NSCopying>

@end

@implementation TSLocationInfoModel

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        self.provinceId = [aDecoder decodeObjectForKey:@"provinceId"];
        self.cityId = [aDecoder decodeObjectForKey:@"cityId"];
        self.areaUuid = [aDecoder decodeObjectForKey:@"areaUuid"];
        self.region = [aDecoder decodeObjectForKey:@"region"];
        self.localaddress = [aDecoder decodeObjectForKey:@"localaddress"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.provinceId forKey:@"provinceId"];
    [aCoder encodeObject:self.cityId forKey:@"cityId"];
    [aCoder encodeObject:self.areaUuid forKey:@"areaUuid"];
    [aCoder encodeObject:self.region forKey:@"region"];
    [aCoder encodeObject:self.localaddress forKey:@"localaddress"];
}

-(id)copyWithZone:(NSZone *)zone {
    TSLocationInfoModel *copy =[[[self class] allocWithZone:zone] init];
    copy.provinceId = [self.provinceId copy];
    copy.cityId = [self.cityId copy];
    copy.areaUuid = [self.areaUuid copy];
    copy.region = [self.region copy];
    copy.localaddress = [self.localaddress copy];
    
    return copy;
    
}

+(TSLocationInfoModel *)locationInfoModel{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults objectForKey:@"good_detail_location"];
    TSLocationInfoModel *obj = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (!obj) {
        obj = [[TSLocationInfoModel alloc] init];
        obj.provinceId = @"05";
        obj.cityId = @"154";
        obj.areaUuid = @"15845";
        obj.region = @"1385";
        obj.localaddress = @"广东省 深圳市 南山区 西丽街道";
    }
    return obj;
}

-(void)saveLocationInfo{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:data forKey:@"good_detail_location"];
        [userDefaults synchronize];
    });
}

@end
