//
//  TSAreaSelectedController.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/18.
//

#import "TSAreaSelectedController.h"
#import "TSAreaCard.h"

@interface TSAreaSelectedController ()
@property (nonatomic, strong) TSAreaCard *card;
@end

@implementation TSAreaSelectedController


+ (void)showAreaSelectedOnController:(UIViewController *)controller{
    TSAreaSelectedController *con = [TSAreaSelectedController new];
    con.modalPresentationStyle = UIModalPresentationOverCurrentContext | UIModalPresentationFullScreen;
    [controller presentViewController:con animated:NO completion:^{
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [KHexColor(@"#333333") colorWithAlphaComponent:0.5];
    [self layouView];
    
    [self performSelector:@selector(showCard) afterDelay:0.1];
}

- (void)showCard{
    [self.card layoutIfNeeded];
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.card.frame;
        frame.origin.y = KRateW(118);
        self.card.frame = frame;
    }];
}

- (void)hideCard{
    [self.card layoutIfNeeded];
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.card.frame;
        frame.origin.y = self.view.frame.size.height;
        self.card.frame = frame;
        self.view.alpha = 0;
    } completion:^(BOOL finished) {
        [self dismiss];
    }];
}

- (void)layouView{
    [self.card mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(kScreenHeight - KRateW(118.0));
    }];
}

- (void)dismiss{
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}

- (TSAreaCard *)card{
    if (_card) {
        return _card;
    }
    self.card = [TSAreaCard new];
    self.card.controller = self;
    [self.view addSubview:self.card];
    
    return self.card;
}
@end
