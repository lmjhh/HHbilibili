//
//  BiLi_DBManager.m
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/13.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import "BiLi_DBManager.h"
#import <sqlite3.h>



@implementation BiLi_DBManager

+ (instancetype)sharedManager{
    
    static BiLi_DBManager *shared_Manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared_Manager = [[self alloc] init];
    });
    return shared_Manager;
    
}

//-(BOOL)createBiLi_DB{
//    
//    
//    
//}



@end

