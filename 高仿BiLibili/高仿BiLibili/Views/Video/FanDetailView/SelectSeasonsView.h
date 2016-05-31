//
//  SelectSeasonsView.h
//  高仿BiLibili
//
//  Created by 黄人煌 on 16/5/19.
//  Copyright © 2016年 黄人煌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FanData.h"

@interface SelectSeasonsView : UIView

- (instancetype) initWithFrameAndClick:(CGRect)frame focusIconClick:(void(^)(NSString* seasonId))focusIconClick;
- (void)setData:(NSArray *)data endTitle:(NSString *)endTitle endSeasonId:(NSString *)endSeasonId ;

@end
