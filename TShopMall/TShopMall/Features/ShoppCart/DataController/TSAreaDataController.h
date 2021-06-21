//
//  TSAreaDataController.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/18.
//

#import <UIKit/UIKit.h>
#import "TSAreaModel.h"

@interface TSAreaDataController : UIViewController
@property (nonatomic, assign) NSInteger requestType;
@property (nonatomic, copy) NSString *uuid;
@property (nonatomic, strong) NSDictionary<NSString *, NSArray<TSAreaModel *> *> *provices;
@property (nonatomic, strong) NSDictionary<NSString *, NSArray<TSAreaModel *> *> *cities;
@property (nonatomic, strong) NSDictionary<NSString *, NSArray<TSAreaModel *> *> *areas;
@property (nonatomic, strong) NSDictionary<NSString *, NSArray<TSAreaModel *> *> *streets;

@property (nonatomic, strong) NSDictionary<NSString *, NSArray<TSAreaModel *> *> *currentDatas;

- (void)fetachAddressData:(void(^)(void))finished;
@end
