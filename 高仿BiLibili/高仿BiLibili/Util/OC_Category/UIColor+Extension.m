//
//  UIColor+Extension.m
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/2.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor(UIColor_Extension)

+ (UIColor *)colorWithCustom:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue{
    
    UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
    return color;
    
}

+ (UIColor *)colorWithCustomAndAlpha:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha{
    UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
    return color;
}
@end
