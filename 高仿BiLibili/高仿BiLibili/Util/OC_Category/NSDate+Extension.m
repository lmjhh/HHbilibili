//
//  NSDate+Extension.m
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/17.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (NSDate_Extension)

- (BOOL)isToday

{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    
    
    
    // 1.获得当前时间的年月日
    
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    
    
    // 2.获得self的年月日
    
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return
    
    (selfCmps.year == nowCmps.year) &&      //直接分别用当前对象和现在的时间进行比较，比较的属性就是年月日
    
    (selfCmps.month == nowCmps.month) &&
    
    (selfCmps.day == nowCmps.day);
    
}

- (NSString *)getToday{
    
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    fmt.dateFormat = @"HH";
    
    NSString *selfStr = [fmt stringFromDate:self];
    
    NSInteger selfHour = [selfStr integerValue];
    
    
    // 2.获得self的年月日

    if(selfHour < 3){
        return @"凌晨";
    }else if(selfHour <12){
        return @"上午";
    }else if(selfHour <19){
        return @"下午";
    }else {
        return @"晚上";
    }


    
}

//格式化日期

- (NSDate *)dateWithYMD

{
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *selfStr = [fmt stringFromDate:self];
    
    return [fmt dateFromString:selfStr];
    
}

                                    
 //计算日期差
                                    
- (NSDateComponents *)deltaFromNow
                                    
    {
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        
        int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        
        return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
        
    }

@end
