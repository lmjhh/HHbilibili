//
//  HomeData.h
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/5.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeData : NSObject

@property (nonatomic,strong) NSArray *banner,*entranceIcons,*partitions;

@end

@interface Banner : NSObject

@property (nonatomic,copy) NSString *title,*img,*remark,*link;

@end

@interface Entrance_icon : NSObject

@property (nonatomic,copy) NSString *src;
@property (nonatomic,assign) NSInteger height,width;

@end

@interface EntranceIcons : NSObject
@property (nonatomic,copy) NSString *id,*name;
@property (nonatomic,strong) Entrance_icon *entrance_icon;

@end


@interface Sub_icon : NSObject

@property (nonatomic,copy) NSString *src,*height,*width;

@end

@interface Partition : NSObject

@property (nonatomic,copy) NSString *id,*name,*area;
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,strong) Sub_icon *sub_icon;

@end


@interface Owner : NSObject

@property (nonatomic,copy) NSString *face,*mid,*name;

@end

@interface Cover : NSObject

@property (nonatomic,copy) NSString *src,*height,*width;

@end

@interface Lives : NSObject

@property (nonatomic,copy) NSString *title,*room_id,*online;
@property (nonatomic,strong) Cover *cover;
@property (nonatomic,strong) Owner *owner;

@end

@interface Partitions : NSObject

@property (nonatomic,strong) Partition *partition;
@property (nonatomic,strong) NSArray *lives;

@end
