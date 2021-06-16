//
//  TSChangePictureDataController.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/16.
//

#import "TSChangePictureDataController.h"

@interface TSChangePictureDataController ()

@property (nonatomic, strong) NSMutableArray <TSChangePictureSectionModel *> *sections;

@end

@implementation TSChangePictureDataController

- (void)fetchChangePictureContentsComplete:(void (^)(BOOL))complete {
    NSMutableArray *sections = [NSMutableArray array];
    {
        NSMutableArray *items = [NSMutableArray array];
        NSArray *images = @[@"mall_setting_xiaoxiannv", @"mall_setting_scenery", @"mall_setting_classic", @"mall_setting_ming", @"mall_setting_wang", @"mall_setting_ba"];
        NSArray *titles = @[@"小仙女", @"风景", @"经典", @"明明", @"旺财", @"巴比龙"];
        for (int i = 0; i < images.count; i++) {
            NSString *image = images[i];
            NSString *title = titles[i];
            TSChangePictureSectionItemModel *item = [[TSChangePictureSectionItemModel alloc] init];
            item.cellHeight = 138 + 24;
            item.identify = @"TSChangePictureCell";
            item.icon = image;
            item.title = title;
            [items addObject:item];
        }
        TSChangePictureSectionModel *section = [[TSChangePictureSectionModel alloc] init];
        section.column = 3;
        section.items = items;
        [sections addObject:section];
    }
    self.sections = sections;
    if (complete) {
        complete(YES);
    }
}

@end
