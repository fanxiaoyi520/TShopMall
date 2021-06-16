//
//  TSSearchHotKeyModel.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/15.
//

#import <Foundation/Foundation.h>

@interface TSSearchHotKeyModel : NSObject
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *descript;
@property (nonatomic, copy) NSString *hitCount;
@property (nonatomic, copy) NSString *keyWordUrl;
@property (nonatomic, copy) NSString *opeTime;
@property (nonatomic, copy) NSString *platformUuid;
@property (nonatomic, copy) NSString *searchWord;
@property (nonatomic, assign) NSInteger sortNumer;
@property (nonatomic, assign) BOOL state;
@property (nonatomic, copy) NSString *storeUuid;
@property (nonatomic, copy) NSString *terminalType;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *unionWord;
@property (nonatomic, copy) NSString *uuid;
@property (nonatomic, copy) NSString *wapHitCount;

@end
