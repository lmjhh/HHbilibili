//
//  BiLi_NetAPIClient.h
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/4/30.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


typedef NS_ENUM(NSInteger,NetworkMethod){
    Get = 0,
    Post
};

@interface BiLi_NetAPIClient : AFHTTPSessionManager

+ (instancetype) sharedJsonClient;

//请求数据的方式
- (void)requestJsonDataWithPath:(NSString *) filePath
                    returnBlock:(void (^)(id data,NSError *error))block;


- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
                       andBlock:(void (^)(id data, NSError *error))block;

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
                  autoShowError:(BOOL)autoShowError
                       andBlock:(void (^)(id data, NSError *error))block;

@end
