//
//  TSMakeOrderInvoiceViewModel.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/24.
//

#import "TSMakeOrderInvoiceViewModel.h"

@implementation TSMakeOrderInvoiceViewModel

- (NSString *)message{
    if (_message.length == 0) {
        return @"";
    }
    return _message;
}
@end
