/**
 *  CCatImage.h
 *
 *  Created by coder4869 on 4/22/16.
 *  Copyright © 2016 coder4869. All rights reserved.
 */

#import <UIKit/UIKit.h>

@interface UIImage (CvMat)

/**
 *  将UIImage转化为grayChar, 并返回转换结果
 */
+ (unsigned char*)grayCharFromUIImage:(UIImage *)image;

/**
 *  将UIImage转化为rgbChar, 并返回转换结果
 */
+ (unsigned char*)rgbCharFromUIImage:(UIImage *)image;

@end

