/*
*  KDefines.h
*
*  Created by coder4869 on 12/26/16.
*  Copyright © 2016 coder4869. All rights reserved.
*/

#import <UIKit/UIKit.h>

#ifndef KDefines_h
#define KDefines_h

//Color
#define UIColorFromRGB(r, g, b, a)  [UIColor colorWithRed:(double)r/255.0f green:(double)g/255.0f blue:(double)b/255.0f alpha:a]

#define KSYS_UUID  [[UIDevice currentDevice].identifierForVendor UUIDString]

//system Version
#define KSYS_Version      [[UIDevice currentDevice].systemVersion doubleValue]
#define KSYS_Version_6    (KSYS_Version<7.0 && KSYS_Version>=6.0)
#define KSYS_Version_7    (KSYS_Version<8.0 && KSYS_Version>=7.0)
#define KSYS_Version_8    (KSYS_Version<9.0 && KSYS_Version>=8.0)
#define KSYS_Version_9    (KSYS_Version<10.0 && KSYS_Version>=9.0)

//App Info
#define KAppInfoDic      [[NSBundle mainBundle] infoDictionary]
#define KAppName         [KAppInfoDic objectForKey:@"CFBundleDisplayName"]
#define KAppVersion      [KAppInfoDic objectForKey:@"CFBundleShortVersionString"]
#define KAppBuild         [KAppInfoDic objectForKey:@"CFBundleVersion"]

//Screen size
#define KScreenWidth   ([UIScreen mainScreen].bounds.size.width)
#define KScreenHeight  ([UIScreen mainScreen].bounds.size.height)

#define KScreenPich3_5   ((KScreenHeight-480)?NO:YES)   //iphone 4/4s
#define KScreenPich4_0   ((KScreenHeight-568)?NO:YES)   //iphone 5c/5/5s/se
#define KScreenPich4_7   ((KScreenWidth-375)?NO:YES)    //iphone 6/6s
#define KScreenPich5_5   ((KScreenWidth-414)?NO:YES)    //iphone plus

#endif /* KDefines_h */
