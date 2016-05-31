//
//  NSDate+Extension.h
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/17.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (NSDate_Extension)


- (BOOL)isToday;//判断是否为今天

- (BOOL)isYesterday;//是否为昨天

- (NSString *)getToday;

- (NSDate *)dateWithYMD;//格式化日期，返回yyyy-MM-dd

- (NSDateComponents *)deltaWithNow;//日期和当前日期的差的天数

@end

