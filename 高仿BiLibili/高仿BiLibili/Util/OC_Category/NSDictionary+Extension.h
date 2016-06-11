//
//  NSDictionary+Extension.h
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/6/2.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Extension)

/*
 *未排序的参数
 */
- (NSString*)appendGetParameterWithBasePath:(NSString*)path;
/*
 *已经排序的参数
 */
- (NSString*)appendGetSortParameterWithBasePath:(NSString*)path;
/*
 *已经排序的参数自动加上sign
 */
- (NSString*)appendGetSortParameterWithSignWithBasePath:(NSString*)path;

@end
