//
//  TSAreaModel.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/18.
//

#import <Foundation/Foundation.h>


@interface TSAreaModel : NSObject
@property (nonatomic, copy) NSString *areaNumber;
@property (nonatomic, copy) NSString *available;
@property (nonatomic, assign) BOOL delFlag;
@property (nonatomic, copy) NSString *enName;
@property (nonatomic, copy) NSString *opeTime;
@property (nonatomic, copy) NSString *oper;
@property (nonatomic, copy) NSString *pinYin;
@property (nonatomic, copy) NSString *postCode;
@property (nonatomic, assign) NSInteger stationCode;
@property (nonatomic, copy) NSString *stationName;
@property (nonatomic, copy) NSString *uuid;

//省
@property (nonatomic, copy) NSString *provinceName;

//市
@property (nonatomic, copy) NSString *provinceUuid;
@property (nonatomic, copy) NSString *cityName;

//区
@property (nonatomic, copy) NSString *regionName;
@property (nonatomic, copy) NSString *cityUuid;

//街道
@property (nonatomic, copy) NSString *streetName;
@property (nonatomic, copy) NSString *regionUuid;



@property (nonatomic, copy) NSString *currentShowName;
@property (nonatomic, copy) NSString *currentUUid;
@property (nonatomic, copy) NSString *belongUuid;



+ (NSArray<TSAreaModel *> *)hotCities;
@end

/*
 
 {
areaNumber = "<null>";
available = "<null>";
delFlag = "<null>";
enName = "<null>";
opeTime = "<null>";
oper = "<null>";
pinYin = "ning dun zhen";
postCode = "<null>";
regionUuid = 1103;
stationCode = "<null>";
stationName = "<null>";
streetName = "\U5b81\U58a9\U9547";
uuid = 11610;
}
 */
