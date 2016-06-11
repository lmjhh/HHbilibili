//
//  NSString+Extension.h
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/19.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

- (NSString *)calcCount;
//根据正则表达式返回对应子字符串
- (NSArray<NSString *>*)subStringsWithRegularExpression:(NSString*)regularExpression;
/*
 根据字典转成sign
 */
+ (NSString*)signStringWithDic:(NSDictionary*)dic;
/*
 根据字符串转成sign
 */
+ (NSString*)signStringWithString:(NSString*)str;


@end
