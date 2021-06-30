//
//  TSHomePageReleaseViewModel.m
//  TShopMall
//
//  Created by sway on 2021/6/10.
//

#import "TSHomePageReleaseViewModel.h"
#import "TSHomePageBaseModel.h"

@implementation TSHomePageReleaseViewModel
- (void)getReleaseData{
    
    NSArray *temp = [NSArray yy_modelArrayWithClass:TSImageBaseModel.class json:self.model.data[@"list"]];
    self.ReleaseDatas = temp;
}


@end
