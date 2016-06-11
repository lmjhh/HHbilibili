//
//  CommonModel.h
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/6/2.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LevelInfo;

@interface CommonModel : NSObject

@property (nonatomic, strong) NSArray* list,*hotList;
@property (nonatomic, assign) NSInteger results;

@end



@interface ReplyDataModel : NSObject
//头像
@property (nonatomic, strong)NSString* face;
//性别
@property (nonatomic, strong)NSString* sex;
//昵称
@property (nonatomic, strong)NSString* nick;
//发表时间
@property (nonatomic, strong)NSString* create_at;
//楼层
@property (nonatomic, assign)NSInteger lv;
//点赞数
@property (nonatomic, assign)NSInteger good;
//回复内容
@property (nonatomic, strong)NSString* msg;
//@property (nonatomic, strong)NSNumber* mid;
//@property (nonatomic, strong)NSNumber* ad_check;
//@property (nonatomic, strong)NSNumber* rank;
//@property (nonatomic, strong)NSNumber* bad;
@property (nonatomic, strong)LevelInfo* level_info;
//@property (nonatomic, strong)NSNumber* fbid;
@property (nonatomic, assign)NSInteger create;
//@property (nonatomic, strong)NSString* device;
@property (nonatomic, strong)NSNumber* reply_count;

@end

@interface LevelInfo : NSObject

@property (nonatomic,assign)NSInteger current_level,current_min,current_exp,next_exp;


@end
