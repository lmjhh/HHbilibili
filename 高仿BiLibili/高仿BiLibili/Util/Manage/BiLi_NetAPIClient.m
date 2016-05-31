//
//  BiLi_NetAPIClient.m
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/4/30.
//  Copyright © 2016年 黄人煌. All rights reserved.
//


#define kNetworkMethodName @[@"Get", @"Post", @"Put", @"Delete"]

#import "BiLi_NetAPIClient.h"


static BiLi_NetAPIClient *_sharedClient = nil;

@implementation BiLi_NetAPIClient

+ (BiLi_NetAPIClient *)sharedJsonClient{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[BiLi_NetAPIClient alloc] initWithBaseURL:[NSURL URLWithString: @"http://api.bilibili.com"]];
    });
    return _sharedClient;
    
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [self.requestSerializer setValue:url.absoluteString forHTTPHeaderField:@"Referer"];
    
    self.securityPolicy.allowInvalidCertificates = YES;
    
    return self;
}


- (void)requestJsonDataWithPath:(NSString *)filePath returnBlock:(void (^)(id, NSError *))block{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:filePath ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    if(data != nil) {        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        block(dict,nil);
    }
    
}

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
                       andBlock:(void (^)(id data, NSError *error))block{
    [self requestJsonDataWithPath:aPath withParams:params withMethodType:method autoShowError:YES andBlock:block];
}

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
                  autoShowError:(BOOL)autoShowError
                       andBlock:(void (^)(id data, NSError *error))block{
    if (!aPath || aPath.length <= 0) {
        return;
    }
    //log请求数据
    DebugLog(@"\n===========request===========\n%@\n%@:\n%@", kNetworkMethodName[method], aPath, params);
    aPath = [aPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //    发起请求
    switch (method) {
        case Get:{
            //所有 Get 请求，增加缓存机制
            NSMutableString *localPath = [aPath mutableCopy];
            if (params) {
                [localPath appendString:params.description];
            }
            [self GET:aPath parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                NSLog(@"%@",downloadProgress);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
           //这些代码用做判断传输过来的数据是否正确并且缓存数据的 暂时没做 先注释
//                id error = [self handleResponse:responseObject autoShowError:autoShowError];
//                if (error) {
//                    responseObject = [NSObject loadResponseWithPath:localPath];
//                    block(responseObject, error);
//                }else{
//                    if ([responseObject isKindOfClass:[NSDictionary class]]) {
//                        //判断数据是否符合预期，给出提示
//                        if ([responseObject[@"data"] isKindOfClass:[NSDictionary class]]) {
//                            if (responseObject[@"data"][@"too_many_files"]) {
//                                if (autoShowError) {
//                                    [NSObject showHudTipStr:@"文件太多，不能正常显示"];
//                                }
//                            }
//                        }
//                        [NSObject saveResponseData:responseObject toPath:localPath];
//                    }
//                    block(responseObject, nil);
//                }
//            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, error);
//                !autoShowError || [NSObject showError:error];
//                id responseObject = [NSObject loadResponseWithPath:localPath];
//                block(responseObject, error);
//            }];
                
                
                
                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                 block(responseObject, nil);
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
            break;}
        case Post:{
            [self POST:aPath parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                // 同上
//                id error = [self handleResponse:responseObject autoShowError:autoShowError];
//                if (error) {
//                    block(nil, error);
//                }else{
//                    block(responseObject, nil);
//                }
               
                block(responseObject, nil);
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, error);
//                !autoShowError || [NSObject showError:error];
                block(nil, error);

            }];
            break;}
        default:
        break;
    }
    
}


@end


