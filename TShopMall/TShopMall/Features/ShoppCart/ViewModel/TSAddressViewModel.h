//
//  TSAddressViewModel.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/24.
//

#import <Foundation/Foundation.h>
#import "TSAddressModel.h"


@interface TSAddressViewModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *detailAddress;
@property (nonatomic, copy) NSString *mark;
@property (nonatomic, assign) BOOL isDefault;
@property (nonatomic, copy) NSString *provice;
@property (nonatomic, copy) NSString *proviceUUid;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *cityUUid;
@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *areaUUid;
@property (nonatomic, copy) NSString *street;
@property (nonatomic, copy) NSString *streetUUid;
@property (nonatomic, copy) NSString *zipcode;
@property (nonatomic, copy) NSString *uuid;

- (instancetype)initWithAddress:(TSAddressModel *)address;
@end

