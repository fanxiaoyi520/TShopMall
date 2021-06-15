//
//  TSHomePageContainerHeaderViewModel.m
//  TShopMall
//
//  Created by sway on 2021/6/12.
//

#import "TSHomePageContainerHeaderViewModel.h"
#import "TSHomePageContainerGroup.h"

@implementation TSHomePageContainerHeaderViewModel
- (void)getSegmentHeaderData{
    NSMutableArray *marr = @[].mutableCopy;
    for (int i = 0; i < 10; i ++) {
        TSHomePageContainerGroup *model = [TSHomePageContainerGroup new];
        model.name = [NSString stringWithFormat:@"标题%d",i];
        model.groupId = [NSString stringWithFormat:@"%d",i];
        if (i == 4) {
            model.name = @"特别长的aaa";
        }
        [marr addObject:model];
    }
    self.segmentHeaderDatas = marr;
    self.currentIndex = 0;
}

@end
