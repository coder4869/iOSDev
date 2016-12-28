/**
 *  OCImage.h
 *
 *  iOS 6.0+
 *
 *  Needed frameworks: MapKit.framework, ImageIO.framework, CoreFoundation.framework.
 *
 *  Created by coder4869 on 4/22/16.
 *  Copyright © 2016 coder4869. All rights reserved.
 */

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


#pragma 从照片中读写 EXIF 信息, GPS
@interface UIImage (EXIF_GPS)

/**
 *  给图片添加EXIF信息, 本方法添加的是GPS信息
 *
 *  @param image 要追加GPS信息的照片
 *  @param path  追加了GPS信息的照片保存路径
 *  @param loc   GPS位置信息
 */
+(UIImage*)addEXIFInfoToImage:(UIImage*)image savePath:(NSString*)path location:(CLLocation *)loc;

/**
 *  从NSData类型的Image数据中读取GPS信息
 *
 *  @param imageData 包含GPS信息的Image的data
 *
 *  @return imageData中的GPS信息
 */
+(CLLocationCoordinate2D)readEXIFInfoFromImage:(NSData*)imageData;

@end



@interface UIImage (AddSubView)

/**
 *  向照片中添加附加文字提示信息, 如拍照时间、地点等
 *
 *  @param image   要追加信息的照片
 *  @param subView 要追加的文字提示信息
 *
 *  @return 追加了附加文字提示信息后的照片
 */
+(UIImage *)addSubViewToImage:(UIImage *)image subView:(UIView *)subView;

@end



@interface UIImage (Orientation)

/**
 *  修正image方向, 并返回修正后的UIImage
 */
+ (UIImage *)fixOrientation:(UIImage*)image;

@end



@interface UIImage (Mirror)

/**
 *  生成图像镜像, 并返回转换结果
 */
+ (UIImage *) getMirroredImage:(UIImage *) srcImage;

@end
