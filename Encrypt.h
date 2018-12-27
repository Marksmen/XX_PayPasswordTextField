//
//  Encrypt.h
//  CoinStudy
//
//  Created by ZhongJuHuaDa on 2018/12/26.
//  Copyright © 2018 ZhongJuHuaDa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Encrypt : NSObject

//生成随机AES key
+ (NSString *)creatRandomString;
//AES 加密
+ (NSString *)encryptByAES128WithSource:(NSString *)source andKey:(NSString *)key;
//RSA 加密
+ (NSString *)encryptByRSAWithSource:(NSString *)source andPublicKey:(NSString *)publicKey;

@end

NS_ASSUME_NONNULL_END
