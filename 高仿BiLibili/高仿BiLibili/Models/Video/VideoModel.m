//
//  VideoModel.m
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/20.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import "VideoModel.h"

@implementation VideoModel
- (NSMutableArray<VideoDataModel *> *)durl{
    if (_durl == nil) {
        _durl = [NSMutableArray array];
    }
    return _durl;
}
@end

@implementation VideoDataModel


@end

@implementation CIDModel
+ (NSDictionary *)objectClassInArray{
    return @{@"list":[CIDDataModel class]};
}
@end

@implementation CIDDataModel


@end