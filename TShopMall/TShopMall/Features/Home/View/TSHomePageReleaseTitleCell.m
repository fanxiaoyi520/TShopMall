//
//  TSHomePageReleaseTitleCell.m
//  TShopMall
//
//  Created by sway on 2021/6/16.
//

#import "TSHomePageReleaseTitleCell.h"
#import "TSHomePageReleaseTitleViewModel.h"

@interface TSHomePageReleaseTitleCell()
@property(nonatomic, strong) UILabel *nameLabel;
@end
@implementation TSHomePageReleaseTitleCell
- (void)setupUI{
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-16);
        make.top.equalTo(self.contentView);
        make.height.equalTo(@34);
        make.bottom.equalTo(self.contentView);
    }];
}

- (void)setViewModel:(TSHomePageCellViewModel *)viewModel{
    [super setViewModel:viewModel];
    TSHomePageReleaseTitleViewModel *releaseViewModel = (TSHomePageReleaseTitleViewModel *)viewModel;
    NSAttributedString *string = [self getAttributedStringFromHTMLString:releaseViewModel.model.data[@"content"]];
    self.nameLabel.attributedText = string;
    
}

- (nullable NSAttributedString *)getAttributedStringFromHTMLString:(NSString *)string
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *options = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                              NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)};
    
    if (data)
    {
        return [[NSAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
    }
    
    return nil;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = KHexColor(@"393939");
        _nameLabel.font = KRegularFont(16);
    }
    return _nameLabel;
}

@end
