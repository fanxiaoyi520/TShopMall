//
//  TSAddressEditController.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/17.
//

#import "TSAddressEditController.h"
#import "TSAddressEditView.h"
#import "TSAreaSelectedController.h"
#import "TSAreaModel.h"
#import "TSAddressEditDataController.h"

@interface TSAddressEditController (){
    BOOL isAllInfoInput;
}
@property (nonatomic, strong) TSAddressEditView *editView;
@property (nonatomic, strong) UIButton *saveBtn;
@property (nonatomic, strong) UIButton *selBtn;
@property (nonatomic, strong) UILabel *selTips;
@end

@implementation TSAddressEditController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    if (self.vm == nil) {
        self.gk_navTitle = @"新增收货地址";
        isAllInfoInput = NO;
    } else {
        self.gk_navTitle = @"编辑收货地址";
        isAllInfoInput = YES;
    }
    if (@available(iOS 11.0, *)) {
        self.editView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    [self updateSaveStatus];
    
    self.editView.vm = self.vm;
}

- (void)shouldUpdateSaveStatus:(id)status{
    BOOL s = [status boolValue];
    isAllInfoInput = s;
    
    [self updateSaveStatus];
}

- (void)updateSaveStatus{
    BOOL enable = NO;
    if (isAllInfoInput == YES) {
        enable = YES;
    } else {
        enable = NO;
    }
    
    self.saveBtn.enabled = enable;
    if (enable == NO) {
        self.saveBtn.backgroundColor = KHexColor(@"#DDDDDD");
        [self.saveBtn setTitleColor:[KHexColor(@"#2D3132") colorWithAlphaComponent:0.4] forState:UIControlStateNormal];
    } else {
        self.saveBtn.backgroundColor = KHexColor(@"FF4D49");
        [self.saveBtn setTitleColor:KHexColor(@"FFFFFF") forState:UIControlStateNormal];
    }
}

- (void)setDefaultAddress:(UIButton *)sender{
    sender.selected = !sender.selected;
    self.editView.vm.isDefault = sender.selected;
}

//选择地区
- (void)gotoSelectedAddress{
    
    __weak typeof(self) weakSelf = self;
    [TSAreaSelectedController showAreaSelected:^(TSAreaModel *provice, TSAreaModel *city, TSAreaModel *eare, TSAreaModel *street, NSString *location) {
        if (provice) {
            weakSelf.editView.vm.provinceName = provice.provinceName;
            weakSelf.editView.vm.province = provice.currentUUid;
        }
        if (city) {
            weakSelf.editView.vm.cityName = city.cityName;
            weakSelf.editView.vm.city = city.currentUUid;
        }
        if (eare) {
            weakSelf.editView.vm.regionName = eare.regionName;
            weakSelf.editView.vm.region = eare.currentUUid;
        }
        if (street) {
            weakSelf.editView.vm.streetName = street.streetName;
            weakSelf.editView.vm.street = street.currentUUid;
        }
        if (provice == nil) {
            weakSelf.editView.vm.address = location;
        } else {
            NSString *address = [NSString stringWithFormat:@"%@%@%@%@", provice.provinceName, city.cityName, eare.regionName, street.streetName];
            weakSelf.editView.vm.address = address;
        }
        [weakSelf.editView updateAddress:weakSelf.editView.vm.address];
    } OnController:self];
}

- (void)saveAddress{
    TSAddressViewModel *vm = self.editView.vm;
    NSDictionary *params = @{
        @"province" : vm.province.length==0? @"":vm.province,
        @"city" : vm.city.length==0? @"":vm.city,
        @"region" : vm.region.length==0? @"":vm.region,
        @"street" : vm.street.length==0? @"":vm.street,
        @"area" : vm.area.length==0? @"":vm.area,
        @"address" : vm.address.length==0? @"":vm.address,
        @"consignee" : vm.consignee.length==0? @"":vm.consignee,
        @"mobile" : vm.mobile.length==0? @"":vm.mobile,
        @"isDefault" : vm.isDefault==YES? @"1":@"0",
        @"zipcode" : vm.zipcode.length==0? @"":vm.zipcode,
        @"tag" : vm.tag.length==0? @"":vm.tag,
        @"uuid" : vm.uuid.length==0? @"":vm.uuid
    };
    if (self.vm == nil) {
        [TSAddressEditDataController addAddress:params finished:^(BOOL isSuccess) {
            if (isSuccess) {
                [self.navigationController popViewControllerAnimated:YES];
                if (self.addressChanged) {
                    self.addressChanged();
                }
            }
        } controller:self];
    } else {
        [TSAddressEditDataController editAddress:params finished:^(BOOL isSuccess) {
            if (isSuccess) {
                [self.navigationController popViewControllerAnimated:YES];
                if (self.addressChanged) {
                    self.addressChanged();
                }
            }
        } controller:self];
    }
    
}

- (void)viewWillLayoutSubviews{
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(KRateW(24.0));
        make.right.equalTo(self.view.mas_right).offset(-KRateW(24.0));
        make.bottom.equalTo(self.view.mas_bottom).offset(-GK_SAFEAREA_BTM - KRateW(33.0));
        make.height.mas_equalTo(KRateW(40.0));
    }];
    
    [self.selBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(KRateW(24.0));
        make.left.equalTo(self.saveBtn.mas_left);
        make.bottom.equalTo(self.saveBtn.mas_top).offset(-KRateW(22.0));
    }];
    
    [self.selTips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selBtn.mas_right).offset(KRateW(8.0));
        make.top.bottom.equalTo(self.selBtn);
    }];
    
    [self.editView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(GK_STATUSBAR_NAVBAR_HEIGHT);
        make.bottom.equalTo(self.selBtn.mas_top).offset(-KRateW(16.0));
    }];
}

- (UIButton *)saveBtn{
    if (_saveBtn) {
        return _saveBtn;
    }
    self.saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.saveBtn setTitleColor:KHexColor(@"#2D3132") forState:UIControlStateNormal];
    self.saveBtn.titleLabel.font = KRegularFont(16.0);
    [self.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    self.saveBtn.layer.cornerRadius = KRateW(20.0);
    self.saveBtn.layer.masksToBounds = YES;
    [self.saveBtn addTarget:self action:@selector(saveAddress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.saveBtn];
    
    return self.saveBtn;
}

- (UIButton *)selBtn{
    if (_selBtn) {
        return _selBtn;
    }
    self.selBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selBtn.selected = self.vm.isDefault;
    [self.selBtn setBackgroundImage:KImageMake(@"btn_normal") forState:UIControlStateNormal];
    [self.selBtn setBackgroundImage:KImageMake(@"btn_sel") forState:UIControlStateSelected];
    [self.selBtn addTarget:self action:@selector(setDefaultAddress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.selBtn];
    
    return self.selBtn;
}

- (UILabel *)selTips{
    if (_selTips) {
        return _selTips;
    }
    self.selTips = [UILabel new];
    self.selTips.text = @"设为默认地址";
    self.selTips.font = KRegularFont(14.0);
    self.selTips.textColor = KHexColor(@"#2D3132");
    [self.view addSubview:self.selTips];
    
    return self.selTips;
}

- (TSAddressEditView *)editView{
    if (_editView) {
        return _editView;
    }
    self.editView = [TSAddressEditView new];
    self.editView.controller = self;
    [self.view addSubview:self.editView];
    
    return self.editView;
}
@end
