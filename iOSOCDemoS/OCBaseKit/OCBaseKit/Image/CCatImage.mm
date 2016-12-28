/**
 *  CCatImage.mm
 *
 *  Created by coder4869 on 4/22/16.
 *  Copyright © 2016 coder4869. All rights reserved.
 */

#import "CCatImage.h"


@implementation UIImage (CvMat)

#define kBitsPerComponent (8)
#define kBitsPerPixel (32)
#define kPixelChannelCount (4)

/**
 *  将UIImage转化为grayChar, 并返回转换结果
 */
+ (unsigned char*)grayCharFromUIImage:(UIImage *)image
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGImageRef imgRef = image.CGImage;
    int width = (int)CGImageGetWidth(imgRef);
    int height = (int)CGImageGetHeight(imgRef);
    CGContextRef context = CGBitmapContextCreate (nil,
                                                  width,
                                                  height,
                                                  kBitsPerComponent,        //每个颜色值8bit
                                                  width*kPixelChannelCount, //每一行的像素点占用的字节数，每个像素点的ARGB四个通道各占8个bit
                                                  colorSpace,
                                                  kCGImageAlphaPremultipliedLast);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imgRef);
    unsigned char *bitmapData = (unsigned char *)CGBitmapContextGetData(context);
    
    unsigned char * gray = new unsigned char[width * height];
    
    if (bitmapData != NULL)
    {
        for (int i = 0; i < height; i++)
        {
            for(int j = 0; j < width; j++)
            {
                int r = bitmapData[(i * width + j) * 4 + 1];
                int g = bitmapData[(i * width + j) * 4 + 2];
                int b = bitmapData[(i * width + j) * 4 + 3];
                
                gray[i * width + j] = (r*306 + g*601 + b*117) >> 10;
            }
        }
    }
    
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    return gray;
}

/**
 *  将UIImage转化为rgbChar, 并返回转换结果
 */
+ (unsigned char*)rgbCharFromUIImage:(UIImage *)image
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGImageRef imgRef = image.CGImage;
    int width = (int)CGImageGetWidth(imgRef);
    int height = (int)CGImageGetHeight(imgRef);
    CGContextRef context = CGBitmapContextCreate (nil,
                                                  width,
                                                  height,
                                                  kBitsPerComponent,        //每个颜色值8bit
                                                  width*kPixelChannelCount, //每一行的像素点占用的字节数，每个像素点的ARGB四个通道各占8个bit
                                                  colorSpace,
                                                  kCGImageAlphaPremultipliedLast);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imgRef);
    unsigned char *bitmapData = (unsigned char *)CGBitmapContextGetData(context);
    
    unsigned char * rgb = new unsigned char[width * height*3];
    
    if (bitmapData != NULL)
    {
        for (int i = 0; i < height; i++)
        {
            for(int j = 0; j < width; j++)
            {
                rgb[(i * width + j) * 3] = bitmapData[(i * width + j) * 4 + 1];
                rgb[(i * width + j) * 3+1] = bitmapData[(i * width + j) * 4 + 2];
                rgb[(i * width + j) * 3+2] = bitmapData[(i * width + j) * 4 + 3];
            }
        }
    }
    
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    return rgb;
}

@end


