//
//  Encrypt.m
//  CoinStudy
//
//  Created by ZhongJuHuaDa on 2018/12/26.
//  Copyright © 2018 ZhongJuHuaDa. All rights reserved.
//

#import "Encrypt.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "RSA.h"

#define IVP @"16-Bytes--String"

@implementation Encrypt



//生成随机Key
+ (NSString *)creatRandomString{
    NSMutableString * proviteKey = [[NSMutableString alloc] init];
    static int kNumber = 16;
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [proviteKey appendString:oneStr];
    }
    return proviteKey;
}

//
+ (NSString *)encryptByAES128WithSource:(NSString *)source andKey:(NSString *)key{
    NSData * data = [source dataUsingEncoding:NSUTF8StringEncoding];
    
    char keyPtr[kCCKeySizeAES128+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCKeySizeAES128+1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [IVP getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          ivPtr,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData * result = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        ///<2591d4dc bac3f2b9 8af43bcc 5d970041>
        if(result && result.length > 0)
        {
            NSString * outPut = [result base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
            return outPut;  //yQw/nSNbaLdR/7ukzhHWpA==
        }
    }
    free(buffer);
    return nil;
}

+ (NSString *)encryptByRSAWithSource:(NSString *)source andPublicKey:(NSString *)publicKey{
    NSString * rsaStr = nil;
    rsaStr = [RSA encryptString:source publicKey:publicKey];
    return rsaStr;
}



@end
