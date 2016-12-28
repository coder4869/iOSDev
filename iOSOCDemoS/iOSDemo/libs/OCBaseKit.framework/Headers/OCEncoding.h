/**
 *  OCEncoding.h
 *
 *  Created by coder4869 on 1/8/16.
 *  Copyright © 2016 coder4869. All rights reserved.
 */

#import <Foundation/Foundation.h>


@interface OCEncoding : NSObject

/**
 *  Unicode 转 iso-8859-1
 *
 *  @param src 要转换的 Unicode 编码串
 *
 *  @return 转换好的 iso-8859-1 字符串
 */
+ (const char *)UnicodeToISO88591:(NSString *)src;

/**
 *  iso-8859-1 转 utf-8
 *
 *  @param src 要转换的 iso-8859-1 编码串
 *
 *  @return 转换好的 utf-8 字符串
 */
+ (NSString *)ISO88591ToUTF8:(NSString *)src;

@end




@interface OCEncoding (SHA)

/**
 *  SHA1 加密
 *
 *  @param string 待加密的字符串
 *
 *  @return  SHA加密后的数据, 指定类型错误时, 返回为nil
 */
+ (NSString *)SHA1Encoding:(NSString*)string;

/**
 *  SHA224 加密
 *
 *  @param string 待加密的字符串
 *
 *  @return  SHA加密后的数据, 指定类型错误时, 返回为nil
 */
+ (NSString *)SHA224Encoding:(NSString*)string;

/**
 *  SHA256 加密
 *
 *  @param string 待加密的字符串
 *
 *  @return  SHA加密后的数据, 指定类型错误时, 返回为nil
 */
+ (NSString *)SHA256Encoding:(NSString*)string;

/**
 *  SHA384 加密
 *
 *  @param string 待加密的字符串
 *
 *  @return  SHA加密后的数据, 指定类型错误时, 返回为nil
 */
+ (NSString *)SHA384Encoding:(NSString*)string;

/**
 *  SHA512 加密
 *
 *  @param string 待加密的字符串
 *
 *  @return  SHA加密后的数据, 指定类型错误时, 返回为nil
 */
+ (NSString *)SHA512Encoding:(NSString*)string;

@end




@interface OCEncoding (MD5)

/**
 *  对字符串数据进行MD5加密
 *
 *  @param text 待加密文本
 *
 *  @return 加密结果
 */
+ (NSString *)md5StringEncrypt:(NSString*)text;

/**
 *  对NSData数据进行MD5加密
 *
 *  @param data 待加密文本
 *
 *  @return 加密结果
 */
+ (NSString *)md5DataEncrypt:(NSData*)data;

@end




@interface OCEncoding (AES128)

/**
 *  AES128加密
 *
 *  @param plainText 被加密串
 *  @param key       加密密钥, 16位长度的字符串
 *
 *  @return 加密之后的结果
 */
+(NSString *)AES128Encrypt:(NSString *)plainText withKey:(NSString*)key;

/**
 *  AES128 CBC No padding 解密, 算法中iv的值采用与key相同的值
 *
 *  @param encryptText 经过 Base64 编码后的密文
 *  @param key       加密明文使用的密钥, 16位长度的字符串
 *
 *  @return 加密前的明文
 */
+(NSString *)AES128Decrypt:(NSString *)encryptText withKey:(NSString *)key;

@end




@interface OCEncoding (Base64)

+ (NSString*)encode:(const uint8_t*)input length:(NSInteger)length;

+ (NSString*)encode:(NSData*)data;

+ (NSData*)decode:(const char*)string length:(NSInteger)inputLength;

+ (NSData*)decode:(NSString*)string;

@end

