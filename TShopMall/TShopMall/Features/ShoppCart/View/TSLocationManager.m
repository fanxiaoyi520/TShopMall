//
//  TSLocationManager.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/19.
//

#import "TSLocationManager.h"

@interface TSLocationManager()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locMan;
@property (nonatomic, copy) void(^locationFinished)(NSString *, NSError *);

@property (nonatomic, copy) NSString *lastLocatedAddress;
@end

@implementation TSLocationManager

+ (instancetype)defaultManager{
    static TSLocationManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[TSLocationManager alloc] init];
    });
    
    return manager;
}

+ (void)startLocation:(void (^)(NSString *, NSError *))finished{
    TSLocationManager *ma = [TSLocationManager defaultManager];
    ma.locationFinished = finished;
    if ([CLLocationManager locationServicesEnabled] == NO) return;
    if (@available(iOS 8.0, *)) {
        [ma.locMan requestWhenInUseAuthorization];
        [ma.locMan requestAlwaysAuthorization];
    }
    [ma.locMan startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    [[CLGeocoder new] reverseGeocodeLocation:[locations lastObject] completionHandler:^(NSArray<CLPlacemark *> *placemarks, NSError *error){
        CLPlacemark *placemark = placemarks.count==0? nil:[placemarks lastObject];
        NSString *provice = placemark.administrativeArea;
        NSString *city = placemark.locality;
        NSString *area = placemark.subLocality;
        NSString *street = placemark.thoroughfare;
        NSString *subStreet = placemark.subThoroughfare;
        NSString *address = [NSString stringWithFormat:@"%@%@%@%@%@", provice, city, area, street,subStreet];
        address = [address stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
        NSLog(@"定位位置: \n>>>>> %@ <<<<<\n", address);
        if (address.length == 0) {
            address = self.lastLocatedAddress;
        } else{
            self.lastLocatedAddress = address;
        }
        self.locationFinished(self.lastLocatedAddress, error);
        [manager stopUpdatingHeading];
    }];
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined://未授权
            break;
        case kCLAuthorizationStatusRestricted://访问受限
            break;
        case kCLAuthorizationStatusDenied:
            break;
        case kCLAuthorizationStatusAuthorizedAlways://获得后台授权
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:{//获得前台授权
            [self.locMan startUpdatingLocation];
            break;
        }
        default:
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    self.locationFinished(nil , error);
}

- (CLLocationManager *)locMan{
    if (_locMan) {
        return _locMan;
    }
    self.locMan = [CLLocationManager new];
    self.locMan.delegate = self;
    self.locMan.desiredAccuracy = kCLLocationAccuracyBest;  //系统自动帮你选择定位的最佳方式
    self.locMan.distanceFilter = 1;   //1米定位一次
    return self.locMan;
}
@end

