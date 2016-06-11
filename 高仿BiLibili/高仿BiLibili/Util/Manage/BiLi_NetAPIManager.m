//
//  BiLi_NetAPIManager.m
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/4/30.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import "BiLi_NetAPIManager.h"
#import "BiLi_NetAPIClient.h"
#import "UIKit+AFNetworking.h"
#import "XML2Dic.h"
#import "VideoModel.h"

@implementation BiLi_NetAPIManager

+ (BiLi_NetAPIManager *)sharedManager{
    static BiLi_NetAPIManager *shared_Manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred,^{
        shared_Manager = [[self alloc] init];
    });
    return shared_Manager;
}

- (void)request_DirectSeedingDataWithBlock:(void (^)(id, NSError *))block{
    
    [[BiLi_NetAPIClient sharedJsonClient] requestJsonDataWithPath:@"首页数据" returnBlock:^(id data, NSError *error) {
        
        id resultData = [data valueForKey:@"data"];
        
        if(resultData) {
            block(resultData,nil);
        }
        else {
            block(nil,error);
        }
        
    }];
    
}


- (void)request_IsLiveWithBlock:(NSString *)mid dataBlock:(void (^)(id data,NSError *error))block{
    
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:mid,@"mid", nil];
    
    [[BiLi_NetAPIClient sharedJsonClient] requestJsonDataWithPath:@"http://space.bilibili.com/ajax/live/getLive?" withParams:params withMethodType:Get andBlock:^(id data, NSError *error) {
        
        
        block(data,nil);
        
    }];
    
    
}

- (void)request_MostPopularDataWithBlock:(NSInteger)index dataBlock:(void (^)(id data,NSError *error))block{
    
    if(index>4){
        block(nil,nil);
        return ;
    }
    
    [[BiLi_NetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"最热直播%ld",(long)index] returnBlock:^(id data, NSError *error) {
        
        block(data,nil);
        
    }];
    
    
}
- (void)request_MostNewDataWithBlock:(NSInteger)index dataBlock:(void (^)(id data,NSError *error))block{
    
    if(index>4){
        block(nil,nil);
        return ;
    }
    
    [[BiLi_NetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"最新直播%ld",(long)index] returnBlock:^(id data, NSError *error) {
        
            block(data,nil);

    }];
}


- (void)request_TheatreBannerDataAndNewTheatreWithBlock:(void (^)(id, NSError *))block{
    
    [[BiLi_NetAPIClient sharedJsonClient] requestJsonDataWithPath:@"http://bangumi.bilibili.com/api/app_index_page_v2?access_key=244c7b5d240538e9276cd4a929afb32b&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3170&device=phone&platform=ios&sign=9350b7d8a9287379e3ae94526857bf15&ts=1463383505" withParams:nil withMethodType:Get andBlock:^(id data, NSError *error) {
        
        id result = [data valueForKey:@"result"];
        
        block(result,error);
        
    }];
    
}

- (void)request_TheatreDetailDataWithBlock:(NSString *) parm block:(void (^)(id data,NSError *error))block{
    
    NSString *URL = [NSString stringWithFormat:@"http://bangumi.bilibili.com/jsonp/seasoninfo/%@.ver?callback=episodeJsonCallback&_=1446863930820", parm];
    
    NSURLRequest* req = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    
    UIWebView* web = [[UIWebView alloc] init];
    NSProgress* progress = nil;
    [web loadRequest:req progress:&progress
             success:^NSString* _Nonnull(NSHTTPURLResponse* _Nonnull response, NSString* _Nonnull HTML) {
                 
                 if (HTML != nil) {
                     
                     
                     NSMutableString* str = [NSMutableString stringWithString:HTML];
                     
                     [str deleteCharactersInRange:NSMakeRange(0, 19)];
                     
                     [str deleteCharactersInRange:NSMakeRange(str.length - 2, 2)];
                     
                     if([str characterAtIndex:0] == '('){
                         [str deleteCharactersInRange:NSMakeRange(0, 1)];
                     }
                     
                     NSData* d = [str dataUsingEncoding:NSUTF8StringEncoding];
                     
                     NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:d options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
                     
                     NSLog(@"%@",str);
                     
                     NSDictionary* dictM = [dict valueForKey:@"result"];
                     
                     
                     block(dictM,nil);

                 }
                 return HTML;
             }
             failure:^(NSError* _Nonnull error){
             }];

    
    
}


- (void)request_VideoBPDataWithBlock:(NSString *)av_id block:(void (^)(id data,NSError *error))block{
    
    NSString *URL = [NSString stringWithFormat:@"http://www.bilibili.com/widget/ajaxGetBP?aid=%@",av_id];
    
    [[BiLi_NetAPIClient sharedJsonClient] requestJsonDataWithPath:URL withParams:nil withMethodType:Get andBlock:^(id data, NSError *error) {
      
        block(data,nil);
        
    }];
    
}

- (void)request_VideoCommonDataWithBlock:(NSDictionary*)parm block:(void (^)(id data,NSError *error))block{
    
    //http://api.bilibili.com/feedback?type=jsonp&ver=3&callback=jQuery172019889523880556226_1446769749937&mode=arc&aid=3118012&pagesize=20&page=1&_=1446769758188
    //aid pagesize page
    NSString*URL = [parm appendGetParameterWithBasePath:@"http://api.bilibili.com/feedback?type=jsonp&ver=3&callback=jQuery172019889523880556226_1446769749937&mode=arc&_=1446769758188&"];
    
    NSURLRequest* req = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    
    UIWebView* web = [[UIWebView alloc] init];
    NSProgress* progress = nil;
    [web loadRequest:req progress:&progress
             success:^NSString* _Nonnull(NSHTTPURLResponse* _Nonnull response, NSString* _Nonnull HTML) {
                 
                 if (HTML != nil) {
                     
                NSMutableString* dataStr = [NSMutableString stringWithString:HTML];
                     
                NSString* str = [dataStr subStringsWithRegularExpression:@"\\{.*\\}"].firstObject;
                     
                     NSDictionary* js = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves|NSJSONReadingAllowFragments error:nil];
                     
                     
                     block(js,nil);
                     
                     
                 }
                 return HTML;
             }
             failure:^(NSError* _Nonnull error){
    }];
    
}


- (void)GetVideoWithParameter:(NSString*)parame completionHandler:(void(^)(id responseObj, NSError *error))block{
    //aid
    //http://www.bilibilijj.com/Api/AvToCid/3203638 aid转cid用
    //aid cid
    //http://interface.bilibili.com/playurl?platform=android&_device=android&_hwid=831fc7511fa9aff5&_aid=3090561&_tid=0&_p=1&_down=0&cid=4855949&quality=3&otype=json&appkey=86385cdc024c0f6c&type=mp4&sign=7fed8a9b7b446de4369936b6c1c40c3f
     [self GetCIDWithParameter:parame completionHandler:^(id responseObj, NSError *error) {
        [self GetVideoPathWithCidData:responseObj completionHandler:^(id responseObj, NSError *error) {
            block(responseObj, error);
        }];
    }];
}

- (void)GetCIDWithParameter:(NSString*)parame completionHandler:(void(^)(id responseObj, NSError *error))block{
    NSString*path =  [@"http://www.bilibilijj.com/Api/AvToCid/" stringByAppendingString:parame];
    [[BiLi_NetAPIClient sharedJsonClient] requestJsonDataWithPath:path withParams:nil withMethodType:Get andBlock:^(id data, NSError *error) {
        
        block(data,error);
        
    }];

}


- (void)GetVideoPathWithCidData:(NSData*)data completionHandler:(void(^)(id responseObj, NSError *error))block{
    CIDModel* cidModel = [CIDModel mj_objectWithKeyValues:data];
    CIDDataModel* obj = cidModel.list.firstObject;
    [self GetVideoPathWithCid:obj.CID Aid:obj.AV title:obj.Title completionHandler:block];
}

- (void)GetVideoPathWithCid:(NSString*)cid Aid:(NSString*)aid title:(NSString*)title completionHandler:(void(^)(id responseObj, NSError *error))block{
    VideoModel* vModel = [[VideoModel alloc] init];
    
    NSString*vpath = [NSString stringWithFormat:@"http://interface.bilibili.com/playurl?platform=android&_device=android&_hwid=831fc7511fa9aff5&_tid=0&_p=1&_down=0&quality=3&otype=json&appkey=86385cdc024c0f6c&type=mp4&sign=7fed8a9b7b446de4369936b6c1c40c3f&_aid=%@&cid=%@", aid, cid];
    [[BiLi_NetAPIClient sharedJsonClient] requestJsonDataWithPath:vpath withParams:nil withMethodType:Get andBlock:^(id data, NSError *error) {
        
        id dic = data[@"durl"];
        VideoDataModel*dModel = [VideoDataModel mj_objectWithKeyValues:[dic firstObject]];
        dModel.cid = cid;
        dModel.title = title;
        [vModel.durl addObject: dModel];
        block(vModel, nil);
        
    }];
}

// 下载弹幕XML文档并解析成dictionary
- (void)DownDanMuWithParameter:(NSString*)parame completionHandler:(void(^)(NSDictionary* responseObj, NSError *error))block{
    //http://comment.bilibili.com/4937954.xml
    NSURL* URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://comment.bilibili.com/%@.xml", parame]];
    NSURLRequest* reqD = [NSURLRequest requestWithURL:URL];
    
    UIWebView* webD = [[UIWebView alloc] init];
    NSProgress* progress = nil;
    [webD loadRequest:reqD progress:&progress success:^NSString* _Nonnull(NSHTTPURLResponse* _Nonnull response, NSString* _Nonnull HTML) {
        
        if (HTML != nil) {
            id data = HTML;
            NSDictionary* dict = [XML2Dic dicWithData:data];
            block(dict,nil);
        }
        return HTML;
    }
    failure:^(NSError* _Nonnull error){
    }];

}


@end
