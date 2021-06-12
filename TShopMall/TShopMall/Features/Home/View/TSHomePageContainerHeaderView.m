//
//  TSHomePageContainerHeaderView.m
//  TShopMall
//
//  Created by sway on 2021/6/11.
//

#import "TSHomePageContainerHeaderView.h"
#import "KVOController.h"
#import "TSHomePageBaseModel.h"

@interface TSHomePageContainerHeaderView ()


@end

@implementation TSHomePageContainerHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
  
}

- (void)setViewModel:(TSHomePageViewModel *)viewModel{
    _viewModel = viewModel;
    [viewModel getSegmentHeaderData];
    __weak typeof(self) weakSelf = self;
    [self.KVOController observe:_viewModel keyPath:@"segmentHeaderDatas" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
          NSArray *data = change[@"new"];
          if (data.count > 0) {
              NSInteger index = 0;
              NSMutableArray *marr = [NSMutableArray array];
             

          }
      }];
}

@end
