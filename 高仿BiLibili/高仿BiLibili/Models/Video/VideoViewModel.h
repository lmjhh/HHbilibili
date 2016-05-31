//
//  VideoViewModel.h
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/20.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import "VideoModel.h"
@interface VideoViewModel : NSObject


- (instancetype)initWithAid:(NSString*)aid;

- (NSDictionary*)videoDanMu;
- (NSURL*)videoURL;
- (NSString*)videoTitle;

- (void)refreshDataCompleteHandle:(void(^)(NSError *error))complete;
@end
