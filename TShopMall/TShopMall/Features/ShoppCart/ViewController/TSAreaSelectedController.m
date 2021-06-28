//
//  TSAreaSelectedController.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/18.
//

#import "TSAreaSelectedController.h"
#import "TSAreaCard.h"
#import "TSAreaDataController.h"

@interface TSAreaSelectedController ()<TSAreaDelegate>
@property (nonatomic, strong) TSAreaCard *card;
@property (nonatomic, strong) TSAreaDataController *dataCon;

@property (nonatomic, copy) void(^areaSelected)(TSAreaModel *, TSAreaModel *, TSAreaModel *, TSAreaModel *, NSString *);
@end

@implementation TSAreaSelectedController


+ (void)showAreaSelected:(void (^)(TSAreaModel *, TSAreaModel *, TSAreaModel *, TSAreaModel *, NSString *))selected OnController:(UIViewController *)controller{
    TSAreaSelectedController *con = [TSAreaSelectedController new];
    con.areaSelected = selected;
    con.modalPresentationStyle = UIModalPresentationOverCurrentContext | UIModalPresentationFullScreen;
    [controller presentViewController:con animated:NO completion:^{
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UIView *view = [touches anyObject].view;
    if (view == self.card) {
        return;
    }
    [self hideCard];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [KHexColor(@"#333333") colorWithAlphaComponent:0.5];
    self.dataCon = [TSAreaDataController new];
    [self layouView];
    
    [self performSelector:@selector(showCard) afterDelay:0.1];
    [self reloadDataWiteType:0 uuid:@""];
}

- (void)reloadDataWiteType:(NSInteger)type uuid:(NSString *)uuid{
    if (type == 4) return;
    self.dataCon.requestType = type;
    self.dataCon.uuid = uuid;
    __weak typeof(self) weakSelf = self;
    [self.dataCon fetachAddressData:^{
        weakSelf.card.datas = weakSelf.dataCon.currentDatas;
    }];
}

- (void)reloadData{
    __weak typeof(self) weakSelf = self;
    [self.dataCon fetachAddressData:^{
        weakSelf.card.datas = weakSelf.dataCon.currentDatas;
    }];
}

- (void)exit{
    [self hideCard];
}

- (void)showCard{
    [self.card layoutIfNeeded];
    [UIView animateWithDuration:0.5 animations:^{
        [self.card mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_bottom).offset(-(kScreenHeight - KRateW(118.0)));
        }];
        
        [self.view layoutIfNeeded];
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
    self.areaSelected(self.card.provice, self.card.city, self.card.area, self.card.street, self.card.location);
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}



- (TSAreaCard *)card{
    if (_card) {
        return _card;
    }
    self.card = [TSAreaCard new];
    self.card.controller = self;
    self.card.delegate = self;
    [self.view addSubview:self.card];
    
    return self.card;
}
@end
