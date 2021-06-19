//
//  TSLocationManager.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/19.
//

#import "TSLocationManager.h"

@interface TSLocationManager()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locMan;
@property (nonatomic, copy) void(^locationFinished)(CLPlacemark *, NSError *);
@end

@implementation TSLocationManager

static TSLocationManager *manager;
+ (instancetype)defaultManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [TSLocationManager allocWithZone:nil];
    });
    
    return manager;
}

- (void (^)(void (^)(CLPlacemark *, NSError *)))startLocation{
    return ^(void(^finished)(CLPlacemark *, NSError *)){
         self.locationFinished = finished;

        if ([CLLocationManager locationServicesEnabled] == NO) return;
        self.locMan.delegate = self;
        [self.locMan startUpdatingLocation];
    };
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    [[CLGeocoder new] reverseGeocodeLocation:[locations lastObject] completionHandler:^(NSArray<CLPlacemark *> *placemarks, NSError *error){
        CLPlacemark *placemark = placemarks.count==0? nil:[placemarks lastObject];
        self.locationFinished(placemark, error);
        [manager stopUpdatingHeading];
    }];
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
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
    [self.locMan requestWhenInUseAuthorization];
    }
    return self.locMan;
}
@end

