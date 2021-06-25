//
//  TSGoodDetailCopyWriterCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/15.
//

#import "TSGoodDetailCopyWriterCell.h"
#import "TSGoodDetailItemModel.h"

@interface TSGoodDetailCopyWriterCell()

/// 背景视图
@property(nonatomic, strong) UIView *bgView;
/// 标题
@property(nonatomic, strong) UILabel *titleLabel;
/// 下载图片
@property(nonatomic, strong) UIButton *downloadBtn;
/// 文案
@property(nonatomic, strong) UITextView *textView;

@end

@implementation TSGoodDetailCopyWriterCell

-(void)fillCustomContentView{
    self.contentView.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.downloadBtn];
    [self.bgView addSubview:self.textView];

    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(15);
        make.top.equalTo(self.bgView).offset(14);
        make.height.mas_equalTo(20);
    }];
    
    [self.downloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView.mas_right).offset(-15);
        make.centerY.equalTo(self.titleLabel);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(70);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView.mas_right).offset(-15);
        make.left.equalTo(self.bgView.mas_left).offset(15);
        make.bottom.equalTo(self.bgView.mas_bottom).offset(-15);
        make.top.equalTo(self.downloadBtn.mas_bottom).offset(13);
    }];
}

#pragma mark - Actions
-(void)downloadAction:(UIButton *)sender{
    NSString *stringToCopy = self.textView.text;
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    if (stringToCopy) {
        pasteboard.string = stringToCopy;
    }
    
    [Popover popToastOnWindowWithText:@"复制成功"];
}

#pragma mark - Getter
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = UIColor.whiteColor;
        [_bgView setCorners:UIRectCornerAllCorners radius:9];
    }
    return _bgView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = KFont(PingFangSCMedium, 14);
        _titleLabel.textColor = KHexColor(@"#1E1C27");
        _titleLabel.text = @"商品文案";
    }
    return _titleLabel;
}


-(UIButton *)downloadBtn{
    if (!_downloadBtn) {
        _downloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_downloadBtn setImage:KImageMake(@"mall_detail_ copy") forState:UIControlStateNormal];
        [_downloadBtn setImage:KImageMake(@"mall_detail_ copy") forState:UIControlStateHighlighted];
        [_downloadBtn addTarget:self action:@selector(downloadAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _downloadBtn;
}

-(UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.backgroundColor = KHexColor(@"#DDDDDD");
        _textView.font = KRegularFont(10);
        _textView.text = @"";
        [_textView setEditable:NO];
        [_textView setCorners:UIRectCornerAllCorners radius:8];
    }
    return _textView;
}

-(void)setDelegate:(id<UniversalCollectionViewCellDataDelegate>)delegate{
    TSGoodDetailItemCopyModel *item = [delegate universalCollectionViewCellModel:self.indexPath];
    self.textView.text = item.writeStr;
}

@end
