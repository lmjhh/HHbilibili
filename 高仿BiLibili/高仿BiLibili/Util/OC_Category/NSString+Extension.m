//
//  NSString+Extension.m
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/19.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (NSString *)calcCount{
    
    double count = self.doubleValue;
    if(count > 10000){
        
        return [NSString stringWithFormat:@"%.1lf万",count/10000];
        
    }
    
    return [NSString stringWithFormat:@"%.0lf",count];
    
}

@end
