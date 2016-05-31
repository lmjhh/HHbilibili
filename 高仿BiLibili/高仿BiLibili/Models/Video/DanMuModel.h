//
//  DanMuModel.h
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/20.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DanMuModel : NSObject
@property (nonatomic, strong) NSNumber* sendTime;
@property (nonatomic, strong) NSNumber* style;
@property (nonatomic, strong) NSNumber* fontSize;
@property (nonatomic, assign) NSInteger textColor;
@property (nonatomic, strong) NSString* text;

+ (instancetype)modelWithParameter:(NSString*)parameter text:(NSString*)text;
@end
