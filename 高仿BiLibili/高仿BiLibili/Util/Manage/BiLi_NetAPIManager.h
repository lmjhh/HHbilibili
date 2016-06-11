//
//  BiLi_NetAPIManager.h
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/4/30.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


@interface BiLi_NetAPIManager : NSObject

+ (instancetype)sharedManager;


#pragma mark - home

//获取首页直播数据
- (void)request_DirectSeedingDataWithBlock:(void (^)(id data,NSError *error))block;
//获取首页推荐数据

//番剧
- (void)request_TheatreBannerDataAndNewTheatreWithBlock:(void (^)(id data,NSError *error))block;
- (void)request_TheatreDetailDataWithBlock:(NSString *) parm block:(void (^)(id data,NSError *error))block;
//获取番剧承包情况
- (void)request_VideoBPDataWithBlock:(NSString *)av_id block:(void (^)(id data,NSError *error))block;
//获取评论
- (void)request_VideoCommonDataWithBlock:(NSDictionary*)parm block:(void (^)(id data,NSError *error))block;

#pragma mark - live

//判断主播是否在直播
- (void)request_IsLiveWithBlock:(NSString *)mid dataBlock:(void (^)(id data,NSError *error))block;

//获取最热直播
- (void)request_MostPopularDataWithBlock:(NSInteger)index dataBlock:(void (^)(id data,NSError *error))block;
//获取最新直播
- (void)request_MostNewDataWithBlock:(NSInteger)index dataBlock:(void (^)(id data,NSError *error))block;


#pragma mark - Video


//播放视频相关
- (void)GetVideoWithParameter:(NSString*)parame completionHandler:(void(^)(id responseObj, NSError *error))block;

- (void)DownDanMuWithParameter:(NSString*)parame completionHandler:(void(^)(NSDictionary* responseObj, NSError *error))block;

@end
