/**
 *  OCEncoding.m
 *
 *  Created by coder4869 on 1/8/16.
 *  Copyright © 2016 coder4869. All rights reserved.
 */

#import "OCEncoding.h"

@implementation OCEncoding

/**
 *  Unicode 转 iso-8859-1
 *
 *  @param src 要转换的 Unicode 编码串
 *
 *  @return 转换好的 iso-8859-1 字符串
 */
+ (const char *)UnicodeToISO88591:(NSString *)src
{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingISOLatin1);
    return [src cStringUsingEncoding:enc];
}

/**
 *  iso-8859-1 转 utf-8
 *
 *  @param src 要转换的 iso-8859-1 编码串
 *
 *  @return 转换好的 utf-8 字符串
 */
+ (NSString *)ISO88591ToUTF8:(NSString *)src
{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingISOLatin1);
    return [NSString stringWithUTF8String:[src cStringUsingEncoding:enc]];
}

@end



#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation OCEncoding (SHA)

/**
 *  SHA1 加密
 *
 *  @param string 待加密的字符串
 *
 *  @return  SHA加密后的数据, 指定类型错误时, 返回为nil
 */
+ (NSString *)SHA1Encoding:(NSString*)string
{
    if (!string) return nil;
    
    const char *cstr = [string cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:string.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (uint)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}
/**
 *  SHA224 加密
 *
 *  @param string 待加密的字符串
 *
 *  @return  SHA加密后的数据, 指定类型错误时, 返回为nil
 */
+ (NSString *)SHA224Encoding:(NSString*)string
{
    if (!string) return nil;
    
    const char *cstr = [string cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:string.length];
    
    uint8_t digest[CC_SHA224_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (uint)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA224_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA224_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}
/**
 *  SHA256 加密
 *
 *  @param string 待加密的字符串
 *
 *  @return  SHA加密后的数据, 指定类型错误时, 返回为nil
 */
+ (NSString *)SHA256Encoding:(NSString*)string
{
    if (!string) return nil;
    
    const char *cstr = [string cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:string.length];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (uint)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}
/**
 *  SHA384 加密
 *
 *  @param string 待加密的字符串
 *
 *  @return  SHA加密后的数据, 指定类型错误时, 返回为nil
 */
+ (NSString *)SHA384Encoding:(NSString*)string
{
    if (!string) return nil;
    
    const char *cstr = [string cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:string.length];
    
    uint8_t digest[CC_SHA384_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (uint)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA384_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA384_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}
/**
 *  SHA512 加密
 *
 *  @param string 待加密的字符串
 *
 *  @return  SHA加密后的数据, 指定类型错误时, 返回为nil
 */
+ (NSString *)SHA512Encoding:(NSString*)string
{
    if (!string) return nil;
    
    const char *cstr = [string cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:string.length];
    
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (uint)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA512_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

@end



@implementation OCEncoding (MD5)

/**
 *  对字符串数据进行MD5加密
 *
 *  @param text 待加密文本
 *
 *  @return 加密结果
 */
+ (NSString *)md5StringEncrypt:(NSString*)text
{
    const char *cStr = [text UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

/**
 *  对NSData数据进行MD5加密
 *
 *  @param text 待加密文本
 *
 *  @return 加密结果
 */
+ (NSString *)md5DataEncrypt:(NSData*)data
{
    unsigned char result[16];
    CC_MD5( data.bytes, (CC_LONG)data.length, result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end




#define gkey    @"16位长度的字符串"    //16位长度的字符串, 自行修改
#define gIv     @"0102030405060708"  //16位长度的字符串, 自行修改, 作为生成 AES128 编码的种子

@implementation OCEncoding (AES128)

/**
 *  AES128 CBC No padding 加密, 算法中iv的值采用与key相同的值
 *
 *  @param plainText 加密前的明文
 *  @param key       加密明文使用的密钥, 16位长度的字符串
 *
 *  @return 经过 Base64 编码后的密文
 */
+(NSString *)AES128Encrypt:(NSString *)plainText withKey:(NSString*)key
{
    if( ![self validKey:key]) {
        return nil;
    }
    
    char keyPtr[kCCKeySizeAES128+1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128+1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [key getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    
    int diff = kCCKeySizeAES128 - (dataLength % kCCKeySizeAES128);
    unsigned long newSize = 0;
    
    if(diff > 0) {
        newSize = dataLength + diff;
    }
    
    char dataPtr[newSize];
    memcpy(dataPtr, [data bytes], [data length]);
    for(int i = 0; i < diff; i++)
    {
        dataPtr[i + dataLength] = 0x0000;
    }
    
    size_t bufferSize = newSize + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    memset(buffer, 0, bufferSize);
    
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          0x0000, //0x0000: No padding,  kCCOptionPKCS7Padding
                                          keyPtr,
                                          kCCKeySizeAES128,
                                          ivPtr,
                                          dataPtr,
                                          sizeof(dataPtr),
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    if (cryptStatus == kCCSuccess)
    {
        NSData * resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        return [OCEncoding encode:resultData];
    }
    free(buffer);
    return nil;
}

/**
 *  AES128 CBC No padding 解密, 算法中iv的值采用与key相同的值
 *
 *  @param encryptText 经过 Base64 编码后的密文
 *  @param key       加密明文使用的密钥, 16位长度的字符串
 *
 *  @return 加密前的明文
 */
+(NSString *)AES128Decrypt:(NSString *)encryptText withKey:(NSString *)key
{
    if( ![self validKey:key]) {
        return nil;
    }
    
    char keyPtr[kCCKeySizeAES128 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128 + 1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [key getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSData *data = [OCEncoding decode:encryptText];
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          0x0000, //0x0000: No padding,  kCCOptionPKCS7Padding
                                          [key UTF8String],
                                          kCCBlockSizeAES128,
                                          [key UTF8String],
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    if (cryptStatus == kCCSuccess)
    {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        NSString *decoded=[[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
        return [self processDecodedString:decoded];
    }
    free(buffer);
    return nil;
}


+(NSString *)processDecodedString:(NSString *)decoded
{
    if( decoded==nil || decoded.length==0 ) return nil;

    const char *tmpStr=[decoded UTF8String];
    int i=0;
    
    while( tmpStr[i]!='\0' ) {
        i++;
    }
    NSString *final=[[NSString alloc]initWithBytes:tmpStr length:i encoding:NSUTF8StringEncoding];
    return final;
}

+(BOOL)validKey:(NSString*)key
{
    return ( key==nil || key.length !=16 ) ? NO : YES;
}

@end




@implementation OCEncoding (Base64)

#define ArrayLength(x) (sizeof(x)/sizeof(*(x)))

static char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
static char decodingTable[128];

+ (void)initialize {
    if (self == [OCEncoding class]) {
        memset(decodingTable, 0, ArrayLength(decodingTable));
        for (NSInteger i = 0; i < ArrayLength(encodingTable); i++)
            decodingTable[encodingTable[i]] = i;
    }
}

+ (NSString*)encode:(NSData*)data {
    return [self encode:(const uint8_t*) data.bytes length:data.length];
}

+ (NSString*)encode:(const uint8_t*)input length:(NSInteger)length
{
    [OCEncoding initialize];
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    for (NSInteger i = 0; i < length; i += 3) {
        NSInteger value = 0;
        for (NSInteger j = i; j < (i + 3); j++) {
            value <<= 8;
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger index = (i / 3) * 4;
        output[index + 0] =                    encodingTable[(value >> 18) & 0x3F];
        output[index + 1] =                     encodingTable[(value >> 12) & 0x3F];
        output[index + 2] = (i + 1) < length ? encodingTable[(value >> 6)  & 0x3F] : '=';
        output[index + 3] = (i + 2) < length ? encodingTable[(value >> 0)  & 0x3F] : '=';
    }
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}


+ (NSData*)decode:(NSString*)string {
    return [self decode:[string cStringUsingEncoding:NSASCIIStringEncoding] length:string.length];
}

+ (NSData*)decode:(const char*)string length:(NSInteger)inputLength
{
    if ((string == NULL) || (inputLength % 4 != 0)) {
        return nil;
    }
    
    [OCEncoding initialize];

    while (inputLength > 0 && string[inputLength - 1] == '=') {
        inputLength--;
    }
    
    NSInteger outputLength = inputLength * 3 / 4;
    NSMutableData* data = [NSMutableData dataWithLength:outputLength];
    uint8_t* output = data.mutableBytes;
    
    NSInteger inputPoint = 0;
    NSInteger outputPoint = 0;
    while (inputPoint < inputLength) {
        char i0 = string[inputPoint++];
        char i1 = string[inputPoint++];
        char i2 = inputPoint < inputLength ? string[inputPoint++] : 'A'; /* 'A' will decode to \0 */
        char i3 = inputPoint < inputLength ? string[inputPoint++] : 'A';
        
        output[outputPoint++] = (decodingTable[i0] << 2) | (decodingTable[i1] >> 4);
        if (outputPoint < outputLength) {
            output[outputPoint++] = ((decodingTable[i1] & 0xf) << 4) | (decodingTable[i2] >> 2);
        }
        if (outputPoint < outputLength) {
            output[outputPoint++] = ((decodingTable[i2] & 0x3) << 6) | decodingTable[i3];
        }
    }
    return data;
}

@end

