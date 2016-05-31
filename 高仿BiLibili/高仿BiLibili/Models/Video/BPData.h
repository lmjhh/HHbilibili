//
//  BPData.h
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/30.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BPList;

@interface BPData : NSObject

@property (nonatomic,strong) NSString * bp, *ep_bp, * ep_percent, * percent, *users;
@property (nonatomic,assign) BOOL mine;
@property (nonatomic,strong) NSArray<BPList *> *list;

@end

@interface BPList : NSObject

@property (nonatomic,strong) NSString *face,*hidden,*message,*rank,*uid,*uname;

@end