//
//  TSHomePageViewModel.h
//  TShopMall
//
//  Created by sway on 2021/6/10.
//

#import <Foundation/Foundation.h>
#import "TSHomePageCellViewModel.h"
#import "TSHomePageCellTemplateModel.h"
#import "TSTableViewSectionModel.h"
#import "TSHomePageContainerViewModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface TSHomePageViewModel : NSObject
@property (nonatomic, strong) NSArray <TSTableViewSectionModel *> *dataSource;
@property (nonatomic, strong) NSMutableArray *segmentHeaderDatas;
@property (nonatomic, strong) TSHomePageContainerViewModel *containerViewModel;
- (void)loadData;
- (void)getSegmentHeaderData;

@end

NS_ASSUME_NONNULL_END
