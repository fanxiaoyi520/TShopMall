//
//  TSAddressViewModel.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/24.
//

#import "TSAddressViewModel.h"

@implementation TSAddressViewModel
- (instancetype)initWithAddress:(TSAddressModel *)address{
    if (self == [super init]) {
        self.name = address.consignee;
        self.phone = address.mobile;
        self.address = address.area;
        self.detailAddress = address.address;
        self.isDefault = address.isDefault;
        self.mark = address.tag;
        self.provice = address.provinceName;
        self.proviceUUid = address.province;
        self.city = address.cityName;
        self.cityUUid = address.city;
        self.area = address.regionName;
        self.areaUUid = address.region;
        self.street = address.streetName;
        self.streetUUid = address.street;
        self.zipcode = address.zipcode;
        self.uuid = address.uuid;
    }
    return self;
}
@end
