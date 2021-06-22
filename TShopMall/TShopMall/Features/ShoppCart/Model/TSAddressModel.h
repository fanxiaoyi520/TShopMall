//
//  TSAddressModel.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/17.
//

#import <Foundation/Foundation.h>


@interface TSAddressModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *detailAddress;
@property (nonatomic, copy) NSString *mark;
@property (nonatomic, assign) BOOL isDefault;
@end

