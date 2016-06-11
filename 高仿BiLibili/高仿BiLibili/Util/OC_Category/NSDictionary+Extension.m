//
//  NSDictionary+Extension.m
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/6/2.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import "NSDictionary+Extension.h"
#import "NSString+Extension.h"

@implementation NSDictionary (Extension)

- (NSString*)appendGetParameterWithBasePath:(NSString*)path{
    NSMutableString* basePath = [[NSMutableString alloc] initWithString:path];
    [self enumerateKeysAndObjectsUsingBlock:^(NSString*  _Nonnull key, NSString*  _Nonnull obj, BOOL * _Nonnull stop) {
        [basePath appendFormat:@"%@=%@&",key,obj];
    }];
    return [[basePath substringWithRange: NSMakeRange(0, basePath.length - 1)] copy];
}

- (NSString*)appendGetSortParameterWithBasePath:(NSString*)path{
    NSMutableString* basePath = [[NSMutableString alloc] initWithString:path];
    //排序后的keys
    NSArray* keysArr = [self allKeys];
    keysArr = [keysArr sortedArrayUsingComparator:^NSComparisonResult(NSString*  _Nonnull obj1, NSString*  _Nonnull obj2) {
        NSComparisonResult re = [obj1 compare: obj2];
        return re == NSOrderedDescending;
    }];
    
    [keysArr enumerateObjectsUsingBlock:^(NSString*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [basePath appendFormat:@"%@=%@&",obj,self[obj]];
    }];
    //去掉最后一个多余的&
    return [[basePath substringWithRange: NSMakeRange(0, basePath.length - 1)] copy];
}

- (NSString*)appendGetSortParameterWithSignWithBasePath:(NSString*)path{
    NSString* sortParamer = [self appendGetSortParameterWithBasePath: @""];
    //拼上sign
    sortParamer = [NSString stringWithFormat:@"%@%@&sign=%@",path,sortParamer,[NSString signStringWithString: sortParamer]];
    return sortParamer;
}


@end
