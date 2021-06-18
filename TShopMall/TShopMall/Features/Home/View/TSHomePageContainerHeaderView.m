//
//  TSHomePageContainerHeaderView.m
//  TShopMall
//
//  Created by sway on 2021/6/11.
//

#import "TSHomePageContainerHeaderView.h"
#import "KVOController.h"
#import "TSHomePageContainerGroup.h"
@interface TSHomePageContainerHeaderView ()<JXCategoryViewDelegate>

@end

@implementation TSHomePageContainerHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
        self.contentView.backgroundColor = KGrayColor;
    }
    return self;
}

- (void)setupUI{
    [self.contentView addSubview:self.segmentHeader];
    [self.segmentHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
        make.height.equalTo(@48);
    }];
}

- (void)setViewModel:(TSHomePageCellViewModel *)viewModel{
    _viewModel = viewModel;
    TSHomePageContainerViewModel *headerViewModel = (TSHomePageContainerViewModel *)viewModel;
    if (!headerViewModel.segmentHeaderDatas.count) {
        [headerViewModel getSegmentHeaderData];
    }
    @weakify(self);
    [self.KVOController observe:headerViewModel keyPath:@"segmentHeaderDatas" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        @strongify(self)
        NSMutableArray *titles = @[].mutableCopy;
        for (int i = 0; i < headerViewModel.segmentHeaderDatas.count; i ++) {
            TSHomePageContainerGroup *model = headerViewModel.segmentHeaderDatas[i];
            [titles addObject:model.name];
        }
        self.segmentHeader.titles = titles;
    }];

}

- (JXCategoryTitleView *)segmentHeader{
    if (!_segmentHeader) {
        _segmentHeader = [[JXCategoryTitleView alloc] init];
        _segmentHeader.delegate = self;
        _segmentHeader.separatorLineShowEnabled = YES;
        _segmentHeader.titleSelectedColor = KHexColor(@"#E64C3D");
        _segmentHeader.titleColor = KHexAlphaColor(@"#2D3132", .4);
        _segmentHeader.titleFont = KFont(PingFangSCRegular, 16.0);
        _segmentHeader.titleSelectedFont = KFont(PingFangSCRegular, 16.0);

    }
    return _segmentHeader;
}
@end
