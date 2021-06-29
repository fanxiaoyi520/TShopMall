//
//  TSMakeOrderInvoiceViewModel.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/24.
//

#import <Foundation/Foundation.h>
#import "TSInvoiceModel.h"

@interface TSMakeOrderInvoiceViewModel : NSObject
@property (nonatomic, strong) TSInvoiceModel *invoice;
@property (nonatomic, copy) NSString *message;//留言
@end

