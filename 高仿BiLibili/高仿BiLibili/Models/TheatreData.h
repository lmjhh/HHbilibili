//
//  TheatreData.h
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/16.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeData.h"

@interface List : NSObject

@property (nonatomic,strong) NSString *cover,*last_time,*newest_ep_id,
*newest_ep_index,*season_id,*title,*total_count,*watchingCount;

@end


@interface LatestUpdate : NSObject

@property (nonatomic,strong) NSArray *list;
@property (nonatomic,strong) NSString *updateCount;

@end


@interface TheatreData : NSObject

@property (nonatomic,strong) NSArray *banners,*ends;
@property (nonatomic,strong) LatestUpdate *latestUpdate;

@end


