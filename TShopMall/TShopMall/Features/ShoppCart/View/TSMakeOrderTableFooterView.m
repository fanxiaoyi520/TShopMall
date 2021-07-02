//
//  TSMakeOrderTableFooterView.m
//  TShopMall
//
//  Created by 橙子 on 2021/7/2.
//

#import "TSMakeOrderTableFooterView.h"

@implementation TSMakeOrderTableFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithReuseIdentifier:reuseIdentifier]) {
        UIView *view = [UIView new];
        view.backgroundColor = KHexColor(@"#f4f4f4");
        self.backgroundView = view;
    }
    return self;
}

@end
