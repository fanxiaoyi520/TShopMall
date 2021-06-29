//
//  TSHomePageContainerHeaderView.m
//  TShopMall
//
//  Created by sway on 2021/6/11.
//

#import "TSHomePageContainerHeaderView.h"
#import "TSCategoryGroup.h"
@interface TSHomePageContainerHeaderView ()<JXCategoryViewDelegate>
@property (nonatomic, strong) JXCategoryTitleView *segmentHeader;

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
        make.height.equalTo(@48).priorityLow();;
    }];
}

- (void)setViewModel:(TSCategoryGroupViewModel *)viewModel{
    _viewModel = viewModel;
    _viewModel = (TSCategoryGroupViewModel *)viewModel;
    if (!_viewModel.segmentHeaderDatas.count) {
        [_viewModel getSegmentHeaderData];
    }
    @weakify(self);
    [self.KVOController observe:_viewModel keyPath:@"segmentHeaderDatas" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        @strongify(self)
        NSMutableArray *titles = @[].mutableCopy;
        for (int i = 0; i < self.viewModel.segmentHeaderDatas.count; i ++) {
            TSCategoryGroup *model = self.viewModel.segmentHeaderDatas[i];
            [titles addObject:model.name];
        }
        self.segmentHeader.titles = titles;
    }];
    
    [self.KVOController observe:_viewModel keyPath:@"pageIndex" options:(NSKeyValueObservingOptionInitial) block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        @strongify(self)
        if (self.segmentHeader.selectedIndex != self.viewModel.pageIndex) {
            [self.segmentHeader selectItemAtIndex:self.viewModel.pageIndex];
        }
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

#pragma mark - categoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index{
    _viewModel.pageIndex = index;
}

@end
