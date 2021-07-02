//
//  TSRankRecommendCell.m
//  TShopMall
//
//  Created by  on 2021/6/28.
//

#import "TSRankRecommendCell.h"
#import "TSRecomendGoodsView.h"
#import "TSRankSectionModel.h"

@interface TSRankRecommendCell () <TSRecomendGoodsViewDelegate>
@property(nonatomic, strong) TSRecomendGoodsView *goodsView;

@end

@implementation TSRankRecommendCell

- (void)setupUI{
    self.contentView.backgroundColor = KHexColor(@"#F4F4F4");
    [self.contentView addSubview:self.goodsView];
    [self.goodsView mas_remakeConstraints:^(MASConstraintMaker *make) {
       make.edges.equalTo(self.contentView);
    }];
}

- (void)setData:(id)data{
    [super setData:data];
    
    TSRankSectionItemModel *item = (TSRankSectionItemModel *)data;
    @weakify(self);
    if (!item.datas.count) {
        [self.goodsView getRecommendListWithType:@"cart_page" success:^(NSArray * _Nullable list) {
            @strongify(self)
            item.datas = list;
            [self tableviewReloadCell];
        }];

    }else{
        self.goodsView.items = item.datas;
    }
}

- (TSRecomendGoodsView *)goodsView{
    if (!_goodsView) {
        _goodsView = [TSRecomendGoodsView new];
        _goodsView.delegate = self;
    }
    return _goodsView;
}

- (void)didSelectRowAtCollectionView:(id)selectItem index:(NSInteger)index {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectRowAtCell:index:)]) {
        [self.delegate didSelectRowAtCell:selectItem index:index];
    }
}


@end
