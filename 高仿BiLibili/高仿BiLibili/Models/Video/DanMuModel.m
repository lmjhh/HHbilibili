//
//  DanMuModel.m
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/20.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import "DanMuModel.h"

@implementation DanMuModel
+ (instancetype)modelWithParameter:(NSString*)parameter text:(NSString*)text{
    NSArray* strArr = [parameter componentsSeparatedByString:@","];
    DanMuModel* model = [[DanMuModel alloc] init];
    model.sendTime = @([strArr[0] integerValue]);
    model.style = @([strArr[1] intValue]);
    model.fontSize = @([strArr[2] floatValue] / 1.5);
    model.textColor = [strArr[3] integerValue];
    model.text = text;
    return model;
}
@end
