/**
 *  CatLocation.h
 *
 *  Needed frameworks: MapKit.framework, CoreLocation.framework
 *
 *  iOS 8:
 *      使用CoreLocation前需要调用函数: 
 *          (1)始终允许访问位置信息: -(void)requestAlwaysAuthorization;
 *          (2)使用应用程序期间允许访问位置数据: -(void)requestWhenInUseAuthorization;
 *      Info.plist添加设置(键值为授权alert的描述,与上述方法对应):
 *          1.NSLocationAlwaysUsageDescription
 *          2.NSLocationWhenInUseUsageDescription
 *
 *  后台仍然进行GPS定位的设置: 
        1.在applicationDidEnterBackground方法调用enterBackgroundLocation;
        2.在applicationDidBecomeActive方法调用becomeActiveLocation;
        3.在plist添加“Required background modes”项, 为该项设置“App registers for location updates” item
 *
 *  Created by coder4869 on 4/22/16.
 *  Copyright © 2016 coder4869. All rights reserved.
 */

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@class CatLocation;
@protocol CatLocationDelegate <NSObject>

/**
 *  更新GPS坐标, locations为GPS坐标集合, [locations lastObject]为最新坐标
 */
-(void)catLocation:(CatLocation*)catLocation didUpdateLocations:(NSArray *)locations;

/**
 *  传递根据CatLocation类的 palceMarksWithCLLocation: 方法传入的 locationGps 解码得到的位置信息。
 */
-(void)catLocation:(CatLocation*)catLocation palcemark:(MKPlacemark*)placemark;

@end



@interface CatLocation : CLLocation <CLLocationManagerDelegate>

@property(nonatomic, retain) id <CatLocationDelegate> delegate;

-(void)startLocation;

/**
 *  程序进入后台时的处理
 */
-(void)enterBackgroundLocation;

/**
 *  程序进入激活时的处理
 */
-(void)becomeActiveLocation;

-(void)stopsLocation;

/**
 *  根据GPS坐标反编译地理位置信息
 *
 *  @param locationGps 待反编译的GPS坐标
 */
-(void)palceMarksWithCLLocation:(CLLocation*)locationGps;

@end
