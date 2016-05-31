//
//  NSString+MD5.h
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/17.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5)
/**
 *  md5加密的字符串
 *
 *  @param str
 *
 *  @return
 */
+ (NSString *) md5:(NSString *) str;

@end
