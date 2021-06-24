//
//  AddressHeaderView.m
//  TCLPlus
//
//  Created by xl007 on 2020/11/2.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <Masonry/Masonry.h>

#import "AddressHeaderView.h"

#import "UIColor+Plugin.h"


@interface AddressHeaderView () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end


@implementation AddressHeaderView

- (instancetype)init {
    if (self = [super init]) {
        [self initLocationServices];
    }
    return self;
}

- (void)initLocationServices {
    if ([CLLocationManager locationServicesEnabled]) {
        [self.locationManager startUpdatingLocation]; //开始定位
    } else {
        self.locName.text = @"未开启定位服务";
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self addSubview:self.tipLab];
    [self addSubview:self.cancelBtn];
    [self addSubview:self.locView];
    [self.locView addSubview:self.locIcon];
    [self.locView addSubview:self.locName];

    [self.tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_equalTo(18);
        make.top.mas_equalTo(self.mas_top).mas_equalTo(16);
    }];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(56);
        make.top.mas_equalTo(self.mas_top).mas_equalTo(0);
        make.right.mas_equalTo(self.mas_right).mas_equalTo(0);
    }];

    [self.locView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(self.tipLab.mas_bottom);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.right.mas_equalTo(self.cancelBtn.mas_left);
    }];

    [self.locIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.locView).mas_equalTo(18);
        make.centerY.mas_equalTo(self.locView.mas_centerY);
    }];
    [self.locName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.locView).mas_equalTo(46);
        make.centerY.mas_equalTo(self.locView.mas_centerY);
    }];
}

#pragma mark - locationDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    //当前所在城市的坐标值
    CLLocation *currLocation = [locations lastObject];
    //    LOG_DEBUG(@"经度=%f 纬度=%f 高度=%f", currLocation.coordinate.latitude, currLocation.coordinate.longitude, currLocation.altitude);
    //根据经纬度反向地理编译出地址信息
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:currLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark = placemarks.firstObject;
        if (placemark) {
            NSString *countryCode = placemark.ISOcountryCode;
            NSString *country = placemark.country;
            NSLog(@"countryCode[%@]  country[%@]", countryCode, country);
            if ([countryCode isEqualToString:@"CN"] || [country isEqualToString:@"中国"]) {
                NSString *mstate = placemark.administrativeArea;
                NSString *mcity = placemark.locality;
                NSString *msubLocality = placemark.subLocality;

                NSMutableString *addressText = [[NSMutableString alloc] init];
                if ([mstate length] == 0 || [mstate isEqualToString:@"(null)"]) {
                    mstate = @"";
                } else {
                    [addressText appendFormat:@"%@", mstate];
                }
                if ([mcity length] == 0 || [mcity isEqualToString:@"(null)"]) {
                    mcity = @"";
                } else {
                    if (addressText.length > 0) {
                        [addressText appendFormat:@" %@", mcity];
                    } else {
                        [addressText appendFormat:@"%@", mcity];
                    }
                }
                if ([msubLocality length] == 0 || [msubLocality isEqualToString:@"(null)"]) {
                    msubLocality = @"";
                } else {
                    if (addressText.length > 0) {
                        [addressText appendFormat:@" %@", msubLocality];
                    } else {
                        [addressText appendFormat:@"%@", msubLocality];
                    }
                }
                self.locationError = nil;
                self.locDic = @{@"province": mstate, @"city": mcity, @"area": msubLocality, @"addressText": addressText, @"country": @"86"};
                self.locName.text = [NSString stringWithFormat:@"%@", addressText];
            } else {
                NSDictionary *userInfo = @{NSLocalizedDescriptionKey: @"暂不支持选取非中国区域"};
                self.locationError = [NSError errorWithDomain:@"" code:999 userInfo:userInfo];
                self.locDic = @{};
                self.locName.text = [NSString stringWithFormat:@"暂不支持选取非中国区域"];
            }
        } else {
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey: @"获取失败"};
            self.locationError = [NSError errorWithDomain:@"" code:999 userInfo:userInfo];
            self.locName.text = @"获取失败";
        }
    }];

    [self.locationManager stopUpdatingLocation];
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([error code] == kCLErrorDenied) {
        //访问被拒绝
    }
    if ([error code] == kCLErrorLocationUnknown) {
        //无法获取位置信息
    }
    self.locName.text = @"获取失败";
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey: @"获取失败"};
    self.locationError = [NSError errorWithDomain:@"" code:999 userInfo:userInfo];
}

- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 10.0f;
        [_locationManager requestWhenInUseAuthorization];
    }

    return _locationManager;
}

- (UILabel *)tipLab {
    if (!_tipLab) {
        _tipLab = [[UILabel alloc] init];
        [_tipLab setTextColor:[UIColor colorWithHexString:@"#2D3132"]];
        _tipLab.font = [UIFont systemFontOfSize:14];
        _tipLab.text = @"定位到的位置";
        _tipLab.alpha = 0.6;
    }
    return _tipLab;
}
- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn setImage:[UIImage imageNamed:@"addressClose"] forState:UIControlStateNormal];
    }
    return _cancelBtn;
}

- (UIImageView *)locIcon {
    if (!_locIcon) {
        _locIcon = [[UIImageView alloc] init];
        _locIcon.image = [UIImage imageNamed:@"mineAddress"];
    }
    return _locIcon;
}
- (UILabel *)locName {
    if (!_locName) {
        _locName = [[UILabel alloc] init];
        [_locName setTextColor:[UIColor colorWithHexString:@"#2D3132"]];
        _locName.font = [UIFont systemFontOfSize:14];
        _locName.text = @"";
    }
    return _locName;
}
- (UIView *)locView {
    if (!_locView) {
        _locView = [[UIView alloc] init];
    }
    return _locView;
}
@end
