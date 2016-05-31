//
//  FanData.h
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/18.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FanData : NSObject


@property (nonatomic,strong) NSString *allow_bp,*allow_download,*area,
*arealimit,*bangumi_id,*bangumi_title,*brief,*coins,*copyright,
*cover,*danmaku_count,*evaluate,*favorites,*is_finish,*newest_ep_id,
*newest_ep_index,*play_count,*pub_time,*season_id,*season_title,
*squareCover,*share_url,*title,*total_count,*viewRank,*watchingCount,
*weekday;
@property (nonatomic,strong) NSArray *actor,*episodes,*seasons,
*tag2s,*tags;

@end

@interface Episode : NSObject

@property (nonatomic,strong) NSString *av_id,*coins,*cover,*episode_id,
*index,*is_new,*is_webplay,*page,*update_time,*webplay_url;

@end

@interface Tag : NSObject

@property (nonatomic,strong) NSString *cover,*index,*orderType,
*style_id,*tag_id,*tag_name,*type;

@end

@interface Seasons : NSObject

@property (nonatomic,strong) NSString *bangumi_id,*cover,*is_finish,*newest_ep_id,*newest_ep_index,
*season_id,*title,*total_count;

@end



