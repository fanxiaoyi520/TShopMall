//
//  TSInvoiceModel.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSInvoiceModel : NSObject
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *customerNo;
@property (nonatomic, copy) NSString *customerUuid;
@property (nonatomic, copy) NSString *email;

///类型：1-个人，2-企业普通，3-企业增值税
@property (nonatomic, assign) NSInteger formType;
@property (nonatomic, assign) BOOL isChecked;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *titleContent;
@property (nonatomic, copy) NSString *uuid;

@property (nonatomic, copy) NSString *companyName;
@property (nonatomic, copy) NSString *registerAddress;
@property (nonatomic, copy) NSString *bankName;
@property (nonatomic, copy) NSString *bankNo;


+ (TSInvoiceModel *)creatWithInvoice:(NSDictionary *)invoice;
@end

NS_ASSUME_NONNULL_END


/*个人
 {
     code = "<null>";
     content = "<null>";
     customerNo = "<null>";
     customerUuid = 5582e8df2f5d4d08948cd77b12e60dac;
     delFlag = 1;
     email = "<null>";
     formType = 1;
     isChecked = 0;
     mobile = 13545678909;
     opeTime = "2021-06-29 16:27:58";
     oper = 5582e8df2f5d4d08948cd77b12e60dac;
     titleContent = "\U6a59\U5b50\U53d1\U7968\U6d4b\U8bd5";
   
 */
