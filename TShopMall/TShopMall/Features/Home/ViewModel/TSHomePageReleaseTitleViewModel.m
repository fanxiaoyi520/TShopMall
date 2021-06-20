//
//  TSHomePageReleaseTitleViewModel.m
//  TShopMall
//
//  Created by sway on 2021/6/16.
//

#import "TSHomePageReleaseTitleViewModel.h"

@implementation TSHomePageReleaseTitleViewModel
- (void)getReleaseTitleData{
    if (self.model.data) {
        self.title = [self getAttributedStringFromHTMLString:self.model.data[@"content"]];
    }
}

- (nullable NSAttributedString *)getAttributedStringFromHTMLString:(NSString *)string
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *options = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                              NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)};
    
    if (data)
    {
        return [[NSAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
    }
    
    return nil;
}

@end
