//
//  CMExtenstion.h
//  女性私人医生
//
//  Created by jongs zhong on 14-8-14.
//  Copyright (c) 2014年 Jongs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (MyExtensions)
+ (NSData*)gzipData:(NSData*)pUncompressedData;
+ (NSData *)ungzipData:(NSData *)compressedData;
@end
