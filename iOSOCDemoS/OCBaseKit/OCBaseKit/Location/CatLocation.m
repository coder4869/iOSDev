/**
 *  CatLocation.m
 *
 *  Created by coder4869 on 4/22/16.
 *  Copyright © 2016 coder4869. All rights reserved.
 */

#import "CatLocation.h"

#import "KDefines.h"

@interface CatLocation () 
@property(nonatomic, retain) CLLocationManager *locMgr; //位置管理器
@property(nonatomic, retain) CLGeocoder *clGeocoder;
@end

@implementation CatLocation

-(void)startLocation {
    if ([CLLocationManager locationServicesEnabled]) {
        [self.locMgr setDesiredAccuracy:kCLLocationAccuracyBestForNavigation]; //指定需要的精度级别
        [self.locMgr setDistanceFilter:kCLDistanceFilterNone]; //设置距离筛选器,设为任何移动
        if (KSYS_Version_8) {
            [self.locMgr requestAlwaysAuthorization];
        }
        [self.locMgr startUpdatingLocation]; //启动位置管理器
        if([self.locMgr location])
            [self.delegate catLocation:self didUpdateLocations:@[[self.locMgr location]]];
    }
    else {
        NSLog(@"Cannot Starting CLLocationManager");
    }
}

/**
 *  程序进入后台时的处理
 */
-(void)enterBackgroundLocation {
    if ([CLLocationManager significantLocationChangeMonitoringAvailable]) {
        // Stop normal location updates and start significant location change updates for battery efficiency.
        [self.locMgr stopUpdatingLocation];
        [self.locMgr startMonitoringSignificantLocationChanges];
    }
    else {
        NSLog(@"Significant location change monitoring is not available.");
    }
}

/**
 *  程序进入激活时的处理
 */
-(void)becomeActiveLocation {
    if ([CLLocationManager significantLocationChangeMonitoringAvailable]) {
        // Stop significant location updates and start normal location updates again since the app is in the forefront.
        [self.locMgr stopMonitoringSignificantLocationChanges];
        [self.locMgr startUpdatingLocation];
    }
    else {
        NSLog(@"Normal location change monitoring is not available.");
    }
}

-(void)stopsLocation {

}



#pragma mark - CLLocationManagerDelegate Methods

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    [self.delegate catLocation:self didUpdateLocations:locations];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
      NSLog(@"Location Error:%@", error);
}

//改变权限状态
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedAlways) { //允许定位
        NSLog(@"GPS Authorized");
    }
    else { //不允许定位
        NSLog(@"GPS Not Authorized, 请在设置中开启GPS定位权限");
    }
}


/**
 *  根据GPS坐标反编译地理位置信息
 *
 *  @param locationGps 待反编译的GPS坐标
 */
-(void)palceMarksWithCLLocation:(CLLocation*)locationGps
{
    if (self.clGeocoder == nil)
        self.clGeocoder = [[CLGeocoder alloc] init];
    
    [self.clGeocoder reverseGeocodeLocation:locationGps completionHandler:^(NSArray* placemarks, NSError* error)
     {
         MKPlacemark *placemark = [placemarks objectAtIndex:0];
         [self.delegate catLocation:self palcemark:placemark];
     }];
}

#pragma mark - setters and getters
-(CLLocationManager*)locMgr {
    if (!_locMgr) {
        _locMgr = [[CLLocationManager alloc] init];
        [_locMgr setDelegate:self];
    }
    return _locMgr;
}

@end
