//
//  CommonModel.m
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/6/2.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import "CommonModel.h"

@implementation CommonModel

+ (NSDictionary*)objectClassInArray{
    return @{
             @"hotList" : [ReplyDataModel class],
             @"list":[ReplyDataModel class]
             };
}

@end

@implementation ReplyDataModel

//+ (NSDictionary*)objectClassInArray{
//    return @{
//             @"level_info" : [LevelInfo class],
//             };
//}

@end

@implementation LevelInfo


@end