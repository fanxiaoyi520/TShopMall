//
//  TSMineAdsCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/11.
//

#import "TSMineAdsCell.h"
#import "TSImageBaseModel.h"
#import "TSMineSectionModel.h"
@interface TSMineAdsCell()

@property(nonatomic, strong) UIImageView *adsImageView;

@end

@implementation TSMineAdsCell

-(void)fillCustomContentView{
    [super fillCustomContentView];
    
    [self.contentView addSubview:self.adsImageView];
    [self.adsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)setDelegate:(id<UniversalCollectionViewCellDataDelegate>)delegate {

    TSMineSectionAdsItemModel *item = [delegate universalCollectionViewCellModel:self.indexPath];
    if (item.imageAdModel) {
        CGFloat height = (kScreenWidth-32)/(CGFloat)item.imageAdModel.imageData.width * item.imageAdModel.imageData.height;
        item.cellHeight = height;
        [self collectionViewReloadCell];
        [_adsImageView sd_setImageWithURL:[NSURL URLWithString:item.imageAdModel.imageData.url]];
    }
    
//    if (content.length > 0 ) { //^http://([\\w-]+.)+[\\w-]+(/[\\w-./?%&=])?$
//        NSError *error;
//        NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:@"(https{1}|http{1})://([\\w-]+.)+[\\w-]+(/[\\w-./?%&=])?" options: NSRegularExpressionCaseInsensitive | NSRegularExpressionAnchorsMatchLines
//                                                                                   error:&error];
//
//       NSRange matchRange = [regular rangeOfFirstMatchInString:content options:0 range:NSMakeRange(0, content.length)];
//        if (matchRange.location != NSNotFound) {
//            NSString *url = [content substringWithRange:matchRange];
//            [_adsImageView sd_setImageWithURL:[NSURL URLWithString:url]];
//        }
//
//    }
   
}

#pragma mark - Getter
-(UIImageView *)adsImageView{
    if (!_adsImageView) {
        _adsImageView = [[UIImageView alloc] init];
        _adsImageView.backgroundColor = KWhiteColor;
        _adsImageView.layer.cornerRadius = 8;
        _adsImageView.clipsToBounds = YES;
    }
    return _adsImageView;
}

@end
