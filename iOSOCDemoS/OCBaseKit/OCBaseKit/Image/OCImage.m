/**
 *  OCImage.m
 *
 *  Created by coder4869 on 4/22/16.
 *  Copyright © 2016 coder4869. All rights reserved.
 */

#import "OCImage.h"

#import <ImageIO/CGImageProperties.h>
#import <ImageIO/CGImageDestination.h>
#import <CoreFoundation/CFData.h>
#import <CoreFoundation/CFDictionary.h>


#pragma 从照片中读写 EXIF 信息, GPS
@implementation UIImage (EXIF_GPS)

/**
 *  给图片添加EXIF信息, 本方法添加的是GPS信息
 *
 *  @param image 要追加GPS信息的照片
 *  @param path  追加了GPS信息的照片保存路径
 *  @param loc   GPS位置信息
 */
+(UIImage*) addEXIFInfoToImage:(UIImage*)image savePath:(NSString*)path location:(CLLocation *)loc {
    
    if (loc == nil) {
        printf("%s : nil CLLocation\n", __FUNCTION__);
        return nil;
    }
    
    NSData *imgData = UIImageJPEGRepresentation(image, 1);
    
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)imgData, NULL);
    CFStringRef UTI = CGImageSourceGetType(source); //this is the type of image (e.g., public.jpeg)
    
    //get all the metadata in the image
    CFDictionaryRef metaDict = CGImageSourceCopyPropertiesAtIndex(source,0,NULL);
    
    CFMutableDictionaryRef mutable = CFDictionaryCreateMutableCopy(NULL, 0, metaDict);
    
    // Create formatted date
    NSTimeZone      *timeZone   = [NSTimeZone timeZoneWithName:@"UTC"];
    NSDateFormatter *formatter  = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"HH:mm:ss.SS"];
    
    // Create GPS Dictionary
    NSDictionary *gpsDict   = [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSNumber numberWithFloat:fabs(loc.coordinate.latitude)], kCGImagePropertyGPSLatitude
                               , ((loc.coordinate.latitude >= 0) ? @"N" : @"S"), kCGImagePropertyGPSLatitudeRef
                               , [NSNumber numberWithFloat:fabs(loc.coordinate.longitude)], kCGImagePropertyGPSLongitude
                               , ((loc.coordinate.longitude >= 0) ? @"E" : @"W"), kCGImagePropertyGPSLongitudeRef
                               , [formatter stringFromDate:[loc timestamp]], kCGImagePropertyGPSTimeStamp
                               , [NSNumber numberWithFloat:fabs(loc.altitude)], kCGImagePropertyGPSAltitude
                               , nil];
    
    // The gps info goes into the gps metadata part
    CFDictionarySetValue(mutable, kCGImagePropertyGPSDictionary, (__bridge void *)gpsDict);
    
    // Here just as an example im adding the attitude matrix in the exif comment metadata
    NSMutableDictionary *EXIFDictionary = (__bridge NSMutableDictionary*)CFDictionaryGetValue(mutable, kCGImagePropertyExifDictionary);
    
    [EXIFDictionary setValue:@"coder4869" forKey:(__bridge NSString *)kCGImagePropertyExifUserComment];
    
    CFDictionarySetValue(mutable, kCGImagePropertyExifDictionary, (__bridge void *)EXIFDictionary);
    
    //this will be the data CGImageDestinationRef will write into
    NSMutableData *dest_data = [NSMutableData data];
    
    CGImageDestinationRef destination = CGImageDestinationCreateWithData((__bridge CFMutableDataRef)dest_data,UTI,1,NULL);
    
    if(!destination) {
        printf("%s : Could not create image destination!\n", __FUNCTION__);
    }
    
    //add the image contained in the image source to the destination, overidding the old metadata with our modified metadata
    CGImageDestinationAddImageFromSource(destination,source,0, (CFDictionaryRef) mutable);
    
    //tell the destination to write the image data and metadata into our data object.
    //It will return false if something goes wrong
    BOOL success = NO;
    success = CGImageDestinationFinalize(destination);
    
    if(!success) {
        printf("%s : Could not create data from image destination!\n", __FUNCTION__);
    }
    
    [dest_data writeToFile:path atomically:YES];
    
    CFRelease(destination);
    CFRelease(source);
//   NSLog(@"%f, %f",loc.coordinate.longitude,loc.coordinate.latitude);
    
    return [UIImage imageWithData:dest_data];
}

/**
 *  从NSData类型的Image数据中读取GPS信息
 *
 *  @param imageData 包含GPS信息的Image的data
 *
 *  @return imageData中的GPS信息
 */
+(CLLocationCoordinate2D)readEXIFInfoFromImage:(NSData*)imageData {
    
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)imageData, NULL);
    
    //get all the metadata in the image
    CFDictionaryRef metaDict = CGImageSourceCopyPropertiesAtIndex(source,0,NULL);
    
    CFMutableDictionaryRef mutable = CFDictionaryCreateMutableCopy(NULL, 0, metaDict);
    
    NSDictionary *GPSDict = (__bridge NSDictionary*)CFDictionaryGetValue(mutable, kCGImagePropertyGPSDictionary);
    
    CGFloat latitude = [[GPSDict objectForKey:(NSString*)kCGImagePropertyGPSLatitude] floatValue] * ([[GPSDict objectForKey:(NSString*)kCGImagePropertyGPSLatitudeRef] isEqualToString:@"N"] ? 1:-1);
    
    CGFloat longitude = [[GPSDict objectForKey:(NSString*)kCGImagePropertyGPSLongitude] floatValue] * ([[GPSDict objectForKey:(NSString*)kCGImagePropertyGPSLongitudeRef] isEqualToString:@"E"] ? 1:-1);
    
    //  NSLog(@"longitude=%f, latitude=%f", longitude, latitude);
    
    return CLLocationCoordinate2DMake(latitude,longitude);
}

@end



@implementation UIImage (AddSubView)

/**
 *  向照片中添加附加文字提示信息, 如拍照时间、地点等
 *
 *  @param image   要追加信息的照片
 *  @param subView 要追加的文字提示信息
 *
 *  @return 追加了附加文字提示信息后的照片
 */
+(UIImage *)addSubViewToImage:(UIImage *)image subView:(UIView *)subView {
    UIImageView *iView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    iView.image = image;
    [iView addSubview:subView];
    
    UIGraphicsBeginImageContext(iView.bounds.size);
    [iView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *ChangedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return ChangedImage;
}

@end



@implementation UIImage (Orientation)

/**
 *  修正image方向, 并返回修正后的UIImage
 */
+ (UIImage *)fixOrientation:(UIImage*)image
{
    // No-op if the orientation is already correct
    if (image.imageOrientation == UIImageOrientationUp) return image;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (image.imageOrientation)
    {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, image.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, image.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
    }
    
    switch (image.imageOrientation)
    {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
    }
    
    CGImageRef imgRef = image.CGImage;
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, image.size.width, image.size.height,
                                             CGImageGetBitsPerComponent(imgRef), 0,
                                             CGImageGetColorSpace(imgRef),
                                             CGImageGetBitmapInfo(imgRef));
    CGContextConcatCTM(ctx, transform);
    switch (image.imageOrientation)
    {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0, 0, image.size.height, image.size.width), imgRef);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0, 0, image.size.width, image.size.height), imgRef);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    
    UIImage * img = [[UIImage alloc] initWithCGImage:cgimg];
    
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    
    return img;
}

@end



@implementation UIImage (Mirror)

/**
 *  生成图像镜像, 并返回转换结果
 */
+ (UIImage *) getMirroredImage:(UIImage *) srcImage
{
    CGRect rect = CGRectMake(0, 0, srcImage.size.width, srcImage.size.height); //创建矩形框
    UIGraphicsBeginImageContext(rect.size); //根据size大小创建一个基于位图的图形上下文
    CGContextRef currentContext = UIGraphicsGetCurrentContext(); //获取当前quartz 2d绘图环境
    CGContextClipToRect(currentContext, rect); //设置当前绘图环境到矩形框
    
    CGContextRotateCTM(currentContext, M_PI); //旋转180度
    CGContextTranslateCTM(currentContext, -rect.size.width, -rect.size.height); //平移, 这里是平移坐标系,跟平移图形是一个道理
    
    CGContextDrawImage(currentContext, rect, srcImage.CGImage); //绘图
    
    UIImage *flip = UIGraphicsGetImageFromCurrentImageContext(); //获得图片
    
    CGContextRelease(currentContext);
    
    return flip;
}

@end

