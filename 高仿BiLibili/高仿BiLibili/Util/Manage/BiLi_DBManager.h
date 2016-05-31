//
//  BiLi_DBManager.h
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/13.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BiLi_DBManager : NSObject

+ (instancetype)sharedManager;

-(BOOL)createBiLi_DB;



@end
